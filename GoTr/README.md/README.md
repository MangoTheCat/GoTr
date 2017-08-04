# GoTr
R wrapper for An API of Ice And Fire

[An API of Ice And Fire](https://anapioficeandfire.com/) is the world's greatest source for quantified and structured data from the universe of Ice and Fire (and the HBO series Game of Thrones). Current available resources cover Books, Characters and Houses. This package pulls data in JSON format and parse them to R list objects.

## Installation
Installation from github requires the devtools package to be installed.

```R
# Install GoTr from github
devtools::install_github("MangoTheCat/GoTr")
```
## Usage

```R
library(GoTr)

# Retrieve books on page 1  
books_page1 <- got_api(type = "books")

# Retrieve books on page 1, change page size to 20. Default is 10.
booksAll <- got_api(type = "books", query = list(pageSize="20"))

# Retrieve characters on page 3, change page size to 20. 
characters_page_3 <- got_api(type = "characters", query = list(page = "3", pageSize="20"))

# Retrieve character Jon Snow by id
jon_snow <- got_api(type = "characters", id = "583")

# Retrieve character Jon Snow by name
jon_snow_by_name <- got_api(type = "characters", query = list(name = "Jon Snow"))

# Retrieve house id 378
house378 <- got_api(type = "houses", id = 378)
```
