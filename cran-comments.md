
## Second subission

Added functionality to retrieve an existing version within a NEWS.md file.

The note does not occour when checking with devtools::check_win_devel(). Therefore, I decided to submit the package anyway.

## Test environments

* local MacOS Catalina, R 4.0.5
* tested with GitHub actions for R 3.5, R 3.6, R 4.0 on
  - Ubuntu 18.04.5 LTS
  - macOS
  - Windows
* rhub::check_for_cran()
  - R-hub windows-x86_64-devel (r-devel)
  - R-hub ubuntu-gcc-release (r-release)
  - R-hub fedora-clang-devel (r-devel)

## R CMD check results

> On windows-x86_64-devel (r-devel)
  checking for detritus in the temp directory ... NOTE
  Found the following files/directories:
    'lastMiKTeXException'

0 errors ✓ | 0 warnings ✓ | 1 note x



## Initial submission notes

This is a new package that creates a NEWS.md file. Similar to the desc package for the DESCRIPTION file, R6 objects are used to add context to the NEWS.md file.
The Note is for a new submission. The mentioned misspelled word is the suffix of a markdown file ".md".

- desc package: https://cran.r-project.org/web/packages/desc/index.html


## Test environments

* local MacOS Catalina, R 4.0.2
* tested with GitHub actions for R 3.5, R 3.6, R 4.0 on
  - Ubuntu 18.04.5 LTS
  - macOS
  - Windows
* rhub::check_for_cran()
  - R-hub windows-x86_64-devel (r-devel)
  - R-hub ubuntu-gcc-release (r-release)
  - R-hub fedora-clang-devel (r-devel)


## R CMD check results

> On windows-x86_64-devel (r-devel), ubuntu-gcc-release (r-release), fedora-clang-devel (r-devel)
  checking CRAN incoming feasibility ... NOTE
  
  Maintainer: 'Jakob Gepp <jakob.gepp@yahoo.de>'
  
  Possibly mis-spelled words in DESCRIPTION:
    md (2:25, 11:10)
  New submission

0 errors ✓ | 0 warnings ✓ | 1 note x