# script to create the DESCRIPTION file

# Remove default DESC and NEWS.md
unlink("DESCRIPTION")
unlink("NEWS.md")


# initial files -----------------------------------------------------------

# Create a new description object
my_desc <- desc::description$new("!new")
my_news <- newsmd()

# Set your package name
my_desc$set("Package", "newsmd")
# Set license
my_desc$set("License", "MIT + file LICENSE")

# Remove some author fields
my_desc$del("Maintainer")
# Set the version
my_desc$set_version("0.0.0.9000")
# The title of your package
my_desc$set(Title = "Creation of NEWS.md file")
# The description of your package
my_desc$set(Description =
  paste0("Adding updates (version or bulletpoints) to the NEWS.md file."))
# The urls
my_desc$set("URL", "https://github.com/Dschaykib/newsmd")
my_desc$set("BugReports",
            "https://github.com/Dschaykib/newsmd/issues")

#Set authors
my_desc$set("Authors@R", "person('Jakob', 'Gepp', email = 'jakob.gepp@yahoo.de', role = c('cre', 'aut'))")

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
  paste0("print method only shows last verion ",
         "(fix [issue #2](https://github.com/Dschaykib/newsmd/issues/2))"))


# changing travis setup and adding lintr ----------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
my_desc$set_dep("lintr", type = desc::dep_types[3], version = "*")

my_news$add_bullet(c("changing travis setup",
                     "adding lintr"))
my_news$add_subtitle("Style")
my_news$add_bullet(paste0("changing inital message"))


# changing to github action -----------------------------------------------

my_desc$bump_version("minor")
my_news$add_version(my_desc$get_version())
# change R version dependency
# for more details, see: https://github.com/r-lib/devtools/issues/1742
my_desc$set_dep("R", type = desc::dep_types[2], version = ">= 3.3")

my_news$add_bullet(c("removing travis, appveyor and codecov yml",
                     "adding github actions"))



# prepare for CRAN --------------------------------------------------------

my_desc$bump_version("dev")
my_news$add_version(my_desc$get_version())
# add dependencies for vignette
my_desc$set_dep("knitr", type = desc::dep_types[3], version = "*")
my_desc$set_dep("rmarkdown", type = desc::dep_types[3], version = "*")
my_desc$set_dep("desc", type = desc::dep_types[3], version = "*")
my_desc$set(VignetteBuilder = "knitr")

my_news$add_bullet(c("adding CRAN test and setup for release",
                     "change test setup from ubuntu 16.04 to 18.04"))


# save everything ---------------------------------------------------------

my_desc$set("Date", Sys.Date())
my_desc$write(file = "DESCRIPTION")
my_news$write(file = "NEWS.md")

# set version number in README
my_readme <- readLines("README.md")
my_readme[1] <- paste0("# newsmd - ", my_desc$get_version(),
                       " <img src=\"misc/news.png\" width=170 align=\"right\" />")
writeLines(my_readme, "README.md")
