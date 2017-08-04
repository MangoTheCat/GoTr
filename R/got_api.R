#' Retrieves books, characters or houses information from the anapioficeandfire API
#'
#' A book is a book that are already published or planned for future.
#' A Character is an individual within the Ice And Fire universe.
#' A House is a house branch within the Ice And Fire universe.
#'
#' @param type The endpoint type, one of books, characters or houses.
#'             Default to books if nothing is provided.
#' @param id The object index. Default is all unless an id is specified.
#' @param ... Additional parameters to pass on to \code{GET} such as query, path, etc.
#'            User can also filter by the parameters of interest like name of a character.
#' @author Mango Solutions
#' @return List with all parameters of that endpoint
#' @examples
#' \dontrun{
#'
#' # Retrieve books on page 1
#' books_page1 <- got_api(type = "books")
#'
#' # Retrieve books on page 1, change page size to 20. Default is 10.
#' booksAll <- got_api(type = "books", query = list(pageSize="20"))
#'
#' # Retrieve characters on page 3, change page size to 20.
#' characters_page_3 <- got_api(type = "characters", query = list(page = "3", pageSize="20"))
#'
#' # Retrieve character Jon Snow by id
#' jon_snow <- got_api(type = "characters", id = "583")
#'
#' # Retrieve character Jon Snow by name
#' jon_snow_by_name <- got_api(type = "characters", query = list(name = "Jon Snow"))
#'
#' # Retrieve house id 378
#' house378 <- got_api(type = "houses", id = 378)
#' }
#' @export
got_api <- function(type = c("books", "characters", "houses"), id = NULL, ...) {

  type <- match.arg(type)
  path <- paste("/api", type, id, sep = "/")
  url <- modify_url("https://anapioficeandfire.com", path = path)

  # Set up user agent
  ua <- user_agent("Gotr - https://github.com/mangothecat")

  # -------------------
  # Send a GET request
  resp <- GET(url, ua, ...)
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  # -------------------
  # Turn API errors into R errors
  if (http_error(resp)) {
    stop(
      sprintf(
        "anapioficeandfire API request failed [%s]\n%s\n<%s>",
        status_code(resp),
        parsed$message,
        parsed$documentation_url
      ),
      call. = FALSE
    )
  }

  # -------------------
  # Parse JSON object
  parsed <- jsonlite::fromJSON(content(resp, "text"), simplifyVector = FALSE)

  return(parsed)

}
