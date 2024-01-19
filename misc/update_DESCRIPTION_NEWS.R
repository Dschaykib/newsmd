# script to create the DESCRIPTION file

# Remove default DESC and NEWS.md
unlink("DESCRIPTION")
unlink("NEWS.md")

if (!requireNamespace("newsmd", quietly = TRUE)) {
  devtools::install_github("Dschaykib/newsmd")
  # install.packages("newsmd")
}

# update renv packages if needed
renv::clean()
renv::snapshot(prompt = TRUE)


# initial files -----------------------------------------------------------

# Create a new description object
my_desc <- desc::description$new("!new")
my_news <- newsmd::newsmd()

# Set your package name
my_desc$set("Package", "newsmd")
# Set license
my_desc$set("License", "MIT + file LICENSE")

# Remove some author fields
my_desc$del("Maintainer")
# Set the version
my_desc$set_version("0.0.0.9000")
# The title of your package
my_desc$set(Title = "Creation of NEWS.md File")
# The description of your package
my_desc$set(Description =
  paste0("Adding updates (version or bullet points) to the NEWS.md file."))
# The urls
my_desc$set("URL", "https://github.com/Dschaykib/newsmd")
my_desc$set("BugReports",
            "https://github.com/Dschaykib/newsmd/issues")

#Set authors
my_desc$set("Authors@R",
            paste0("person('Jakob', 'Gepp',",
                   "email = 'jakob.gepp@yahoo.de',",
                   "role = c('cre', 'aut'))"))

# set R version
my_desc$set_dep("R", type = desc::dep_types[2], version = ">= 3.3.3")

# set suggests
my_desc$set_dep("testthat", type = desc::dep_types[3], version = "*")

# set dependencies
my_desc$set_dep("R6", type = desc::dep_types[1])



# initial functions -------------------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())

my_news$add_bullet(c("adding newsmd for easier creation",
                     "adding circleci"))
my_news$add_subtitle("Bugfix")
my_news$add_bullet(
  paste0("print method only shows last version ",
         "(fix [issue #2](https://github.com/Dschaykib/newsmd/issues/2))"))


# changing travis setup and adding lintr ----------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
my_desc$set_dep("lintr", type = desc::dep_types[3], version = "*")

my_news$add_bullet(c("changing travis setup",
                     "adding lint checks"))
my_news$add_subtitle("Style")
my_news$add_bullet(paste0("changing initial message"))


# changing to GitHub action -----------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
# change R version dependency
# for more details, see: https://github.com/r-lib/devtools/issues/1742
my_desc$set_dep("R", type = desc::dep_types[2], version = ">= 3.3")

my_news$add_bullet(c("removing travis, appveyor and codecov yml",
                     "adding GitHub actions"))



# prepare for CRAN --------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
# add dependencies for vignette
my_desc$set_dep("knitr", type = desc::dep_types[3], version = "*")
my_desc$set_dep("rmarkdown", type = desc::dep_types[3], version = "*")
my_desc$set_dep("desc", type = desc::dep_types[3], version = "*")
my_desc$set(VignetteBuilder = "knitr")
my_desc$set(Language = "en-GB")

my_news$add_bullet(c("adding CRAN test and setup for release",
                     "change test setup from ubuntu 16.04 to 18.04"))



# CRAN release ------------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("first CRAN release"))


# Github PAT --------------------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("add GitHub PAT for testing"))
my_news$add_bullet(c("add renv setup for development"))



# Change testing schedule -------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("Change testing schedule to once per week"))


# add function get_version -------------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
# remove LazyData field, since it creates a NOTE and is not needed
my_desc$del("LazyData")
my_news$add_bullet(c("add get_version() to retrieve version from existing file",
                     "remove LazyData value in DESCRIPTION file"))


# add function get_version -------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("fix testing setup"))



# add function combine_dev ------------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("add function to combine dev version's points"))

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("fix format for initial NEWS.md line"))


# add function combine_dev ------------------------------------------------

my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())
my_news$add_bullet(c("add vulnerabilities scans with oyster"))
my_desc$set_dep("oysteR", type = desc::dep_types[3], version = "*")

# WIP ---------------------------------------------------------------------

# bump dev version
#my_desc$bump_version("dev")
#my_news$add_version(my_desc$get_version())
#my_news$add_bullet(c("current dev version"))



# get vulnerabilities -----------------------------------------------------

audit_renv <- oysteR::audit_renv_lock(dir = dirname(renv::paths$lockfile()))
vuls_num <- sum(audit_renv$no_of_vulnerabilities)
vuls_status <- ifelse(vuls_num == 0, "success", "red")

# save everything ---------------------------------------------------------

my_desc$set("Date", Sys.Date())
my_desc$write(file = "DESCRIPTION")
my_news$write(file = "NEWS.md")

# set CRAN version number in README
my_readme <- readLines("README.md")
my_readme[1] <- paste0(
  "# newsmd - ", my_desc$get_version(),
  " <img src=\"misc/news.png\" width=170 align=\"right\" />")
# set dev version number
my_readme <- gsub(pattern = "badge/Version-.*-success",
                  replacement = paste0("badge/Version-",
                                       my_desc$get_version(),
                                       "-success"),
                  x = my_readme)
# set vulnerabilities
vuls_idx <- grep(pattern = "\\| vulnerabilities \\|", x = my_readme)
my_readme[vuls_idx] <- paste0(
  "| vulnerabilities | - | ![vulnerabilities]",
  "(https://img.shields.io/badge/vulnerabilities-",
  vuls_num, "-", vuls_status, ") |"
)



writeLines(my_readme, "README.md")


# set pkg names
origin::originize_pkg()

# update documentation
roxygen2::roxygenise()
# tidy DESCRIPTON
usethis::use_tidy_description()

