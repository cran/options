## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----defining_options---------------------------------------------------------
# options::define_options(
#   "This is an example of how a package author would document their internally
#   used options. This option could make the package default to executing
#   quietly.",
#   quiet = TRUE,
# 
#   "Multiple options can be defined, providing default values if a global option
#   or environment variable isn't set.",
#   second_example = FALSE,
# 
#   "Default values are lazily evaluated, so you are free to use package functions
#   without worrying about build-time evaluation order",
#   lazy_example = fn_not_defined_until_later()
# )

## ----defining_an_option-------------------------------------------------------
# options::define_option(
#   option = "concrete_example",
#   default = TRUE,
#   desc = paste0(
#     "Or, if you prefer a more concrete constructor you can define each option ",
#     "explicitly."
#   ),
#   option_name = "mypackage_concrete", # define custom option names
#   envvar_name = "MYPACKAGE_CONCRETE", # and custom environment variable names
#   envvar_fn = envvar_is_true()        # and use helpers to handle envvar parsing
# )

## ----as_roxygen_docs----------------------------------------------------------
# #' @eval options::as_roxygen_docs()
# NULL

## ----as_params----------------------------------------------------------------
# #' @eval options::as_params()
# #' @name options_params
# #'
# NULL
# 
# #' Count to Three
# #'
# #' @inheritParams option_params
# #'
# count_to_three <- function(quiet = opt("quiet")) {
#   for (i in 1:3) if (!quiet) cat(i, "\n")
# }

## ----as_params_renamed--------------------------------------------------------
# #' Hello World!
# #'
# #' @eval options::as_params("silent" = "quiet")
# #'
# hello <- function(who, silent = opt("quiet")) {
#   cat(paste0("Hello, ", who, "!"), "\n")
# }

## ----set_name_fn--------------------------------------------------------------
# options::set_option_name_fn(function(package, name) {
#   tolower(paste0(package, ".", name))
# })
# 
# options::set_envvar_name_fn(function(package, name) {
#   gsub("[^A-Z0-9]", "_", toupper(paste0(package, "_", name)))
# })

