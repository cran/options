## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(options)

## ----custom_envvar_name-------------------------------------------------------
define_option(
  "volume",
  default = "shout",
  desc = "Print output in uppercase ('shout') or lowercase ('whisper')",
  option_name = "volume",
  envvar_name = "VOL"
)

twist_and <- function(what = opt("volume")) {
  lyric <- paste(
    "Well, shake it up, baby, now (Shake it up, baby)",
    "Twist and shout (Twist and shout)",
    sep = "\n"
  )

  cat(if (what == "shout") toupper(lyric) else tolower(lyric), "\n")
}

## ----custom_envvar_ex---------------------------------------------------------
twist_and()  # by default, "shout"

## ----custom_envvar_val, error = TRUE------------------------------------------
Sys.setenv(VOL = "whisper")

twist_and()  # picks up our environment variable, "whisper"

## ----envvar_name_convention---------------------------------------------------
set_envvar_name_fn(function(package, name) {
  gsub("[^A-Z0-9]", "_", toupper(paste0(package, "_", name)))
})

## ---- echo = FALSE------------------------------------------------------------
Sys.unsetenv("VOL")

## ----redefine_option----------------------------------------------------------
define_options(
  "Print output in uppercase ('shout') or lowercase ('whisper')",
  volume = "shout"
)

## ---- echo = FALSE------------------------------------------------------------
Sys.unsetenv("VOL")

## ----define_envvar_fn---------------------------------------------------------
define_option(
  "volume",
  default = TRUE,
  desc = "Print output in uppercase (TRUE) or lowercase (FALSE)",
  envvar_fn = envvar_is_true()
)

## ---- echo = FALSE------------------------------------------------------------
Sys.unsetenv("VOL")

## ----define_envvar_fn_2-------------------------------------------------------
define_option(
  "volume",
  default = 1,
  desc = paste0(
    "Print output in uppercase (shout) or lowercase (whisper), or any ",
    "number from 1-10 for random uppercasing"
  ),
  envvar_name = "VOL",
  envvar_fn = function(raw, ...) {
    choice_of_nums <- envvar_choice_of(1:11)
    switch(raw, shout = 10, whisper = 1, choice_of_nums(raw))
  }
)

## ----twist_and_eleven---------------------------------------------------------
twist_and_shout <- function(vol = opt("volume")) {
  lyric <- c(
    "Well, shake it up, baby, now (Shake it up, baby)",
    "Twist and shout (Twist and shout)"
  )

  # handle case where volume knob is broken
  if (is.null(vol)) stop("someone turned off the stereo")

  # randomly uppercase characters to match volume
  lyric <- strsplit(tolower(lyric), "")
  lyric <- lapply(lyric, function(line) {
    char_sample <- runif(nchar(line)) < (vol - 1) / 9
    line[char_sample] <- toupper(line[char_sample])
    paste0(line, collapse = "")
  })

  # in case someone turns it up to 11
  if (vol == 11) lyric <- gsub("(\\s*\\(|\\))", "!!!\\1", lyric)

  cat(paste(lyric, collapse = "\n"), "\n")
}

## -----------------------------------------------------------------------------
Sys.setenv(VOL = "whisper")
twist_and_shout()

## -----------------------------------------------------------------------------
Sys.setenv(VOL = 5)
twist_and_shout()

## -----------------------------------------------------------------------------
Sys.setenv(VOL = "shout")
twist_and_shout()

## -----------------------------------------------------------------------------
Sys.setenv(VOL = 11)
twist_and_shout()

## ---- error = TRUE------------------------------------------------------------
Sys.setenv(VOL = "off")  # parsed as NULL
twist_and_shout()

