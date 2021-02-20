# newsmd - 0.3.0.9000 <img src="misc/news.png" width=170 align="right" />

| branch        | master | dev  |
| ------------- | ------ | ---- |
| R CMD check   | [![master-branch](https://github.com/Dschaykib/newsmd/workflows/R-CMD-check-fix/badge.svg?branch=master)](https://github.com/Dschaykib/newsmd/actions?query=workflow%3AR-CMD-check-fix+branch%3Amaster) | [![dev-branch](https://github.com/Dschaykib/newsmd/workflows/R-CMD-check-fix/badge.svg?branch=dev)](https://github.com/Dschaykib/newsmd/actions?query=workflow%3AR-CMD-check-fix+branch%3Adev) |
| test coverage | [![master-test-coverage](https://img.shields.io/codecov/c/github/Dschaykib/newsmd/master.svg)](https://codecov.io/gh/Dschaykib/newsmd/branch/master) | [![dev-test-coverage](https://img.shields.io/codecov/c/github/Dschaykib/newsmd/dev.svg)](https://codecov.io/gh/Dschaykib/newsmd/branch/dev) |
| lints         | [![master-lints](https://github.com/Dschaykib/newsmd/workflows/lints/badge.svg?branch=master)](https://github.com/Dschaykib/newsmd/actions?query=workflow%3Alints+branch%3Amaster) | [![dev-lints](https://github.com/Dschaykib/newsmd/workflows/lints/badge.svg?branch=dev)](https://github.com/Dschaykib/newsmd/actions?query=workflow%3Alints+branch%3Adev) |

----

A package to create and update the `NEWS.md` file.

## Installation

``` R
# install.packages("devtools")
devtools::install_github("Dschaykib/newsmd")
library(newsmd)
```


## Usage of `newsmd`

The main part of the package is the `news` object, which is an R6 class object and contains the text for the `NEWS.md` file. You can add versions, subtitles and bullet points to it via the objects' methods.

### Initialise a new object

To initialise a new object you can use two different ways:

```R
my_news <- news$new()
my_news <- newsmd()
```

The default text contains markdown code and looks like this:

```
## version 0.0.0.9000

---

### NEWS.md setup

- added NEWS.md creation with newsmd
```

### Adding a the next version

With `add_version` you can update the version number.

```R
my_news$add_version("0.0.1")
```

### Adding a new subtitle

With `add_subtitle` you can add a new subtitle, where the follwoing bullet points will be under.

```R
my_news$add_subtitle("Bugfixes")
```

### Adding more bullets

With `add_bullet` you can add more bullet points to the latest version and latest subtitle. 

```R
my_news$add_bullet(c("this is point 1", "this is point 2"))
```

### Getting the whole text

After these fews changes, let's see how the file looks. The `get_text`  method will return each single line of the file. Alternatively you can just use `print(my_news)`.

```R
my_news$get_text()
```

```
 [1] "## version 0.0.1"        
 [2] ""                        
 [3] "---"                     
 [4] ""                        
 [5] ""                        
 [6] "### Bugfixes"            
 [7] ""                        
 [8] "- this is point 1"       
 [9] "- this is point 2"       
[10] ""                        
[11] ""                        
[12] "## version 0.0.0.9000"   
[13] ""                        
[14] "---"                     
[15] ""                        
[16] "### NEWS.md setup"       
[17] ""                        
[18] "- added NEWS.md creation with newsmd"
[19] "" 
```

### Writing the NEWS.md file

At last, with `write` you can save all your changes into the `NEWS.md` file.

```R
my_news$write()
```



## Combination with the `desc` package

The goal of this package was to update the `NEWS.md` file in addition to the `DESCRIPTION` file. To optimize the workflow I suggest the `desc` package. For example instead of manually defining the version number, you can use `desc_bump_version()` and `get_version()` of the `desc` package:

```R
my_desc$bump_version("patch")
my_news$add_version(my_desc$get_version())

my_news$add_bullet("added automated creation for DESCRIPTION and NEWS.md")
```

The full example script I used for this package's NEWS file, can be found [here](https://github.com/Dschaykib/newsmd/blob/master/misc/update_DESCRIPTION_NEWS.R).


