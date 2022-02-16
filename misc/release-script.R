# - renv install ("rhub")
# - renv install ("goodpractice")
# - renv install ("devtools")
# - renv install ("remotes")
# - renv install ("spelling")
# - renv install ("jumpingrivers/inteRgrate")
# - renv install ("r-lib/revdepcheck")


.rs.restartR()
source("misc/update_DESCRIPTION_NEWS.R")
rm(list = ls())
.rs.restartR()

# Update your R, Rstudio and all dependent R packages
# (R and Rstudio has to be updated manually
devtools::install_deps()

# Write tests and check if your own tests work
devtools::test()
devtools::test_coverage()

# Check your examples in your manuals
# unless you set your examples to \dontrun{} or \donttest{})
devtools::run_examples()

# Local R CMD check
devtools::check()

#Check win-builder (devtools::check_win_devel()) 	x 	x
#Update your manuals
devtools::document()

# Update your NEWS file
# Update DESCRIPTION (e.g. version number)
# Spell check
devtools::spell_check()

# Run goodpractice check
goodpractice::gp()

# check R pkg
inteRgrate::check_pkg()

# Check if code adheres to standards
lintr::lint_package(exclusions = list("misc/"))

# Check if your description is tidy
inteRgrate::check_tidy_description()

# Check if file names are correct
inteRgrate::check_r_filenames()

# Check if .gitignore contains standard files
inteRgrate::check_gitignore()


# Check package dependencies
revdepcheck::revdep_check()
# reset and remove revdep files
revdepcheck::revdep_reset()

# Update cran-comments.md
devtools::check()

# check win devel
devtools::check_win_devel()

# Check for CRAN specific requirements using rhub and save it in the results
# objects
results <- rhub::check_for_cran()

# Get the summary of your results
# takes a while to get
results$cran_summary()



# RELEASE -----------------------------------------------------------------

# starts a set of questions to prepare for release and submits at the end
devtools::release()
