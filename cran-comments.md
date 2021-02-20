
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
  
  
  New submission
  Maintainer: 'Jakob Gepp <jakob.gepp@yahoo.de>'
  Version contains large components (0.3.0.9000)
  
      Status: 200
  The Title field should be in title case. Current version is:
  
  'creation of NEWS.md file'
  In title case that is:
  'Creation of NEWS.md File'
      From: inst/doc/NEWSMD-CREATION.html
  
  Possibly mis-spelled words in DESCRIPTION:
    URL: https://www.statworx.com/ (moved to https://www.statworx.com/de/)
    md (2:25, 5:67)
      Message: OK
    bulletpoints (5:41)
  Found the following (possibly) invalid URLs:

0 errors ✓ | 0 warnings ✓ | 1 note x