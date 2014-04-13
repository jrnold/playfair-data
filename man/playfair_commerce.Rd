\name{playfair_commerce}
\alias{playfair_commerce}
\title{Imports and Exports of European Countries 1700-1780}
\format{A \code{data.frame} with 196 obs of 7 variables:
\describe{
\item{\code{plate}}{The number of the plate in which the data appears}
\item{\code{country}}{The title of the plate in which the data appears}
\item{\code{page}}{The number of the page on which the data can be found}
\item{\code{year}}{Year}
\item{\code{exports}}{Value of exports in thousands pounds}
\item{\code{imports}}{Value of imports in thousands pounds}
\item{\code{balance}}{Difference in exports and imports in thousands pounds}
}}
\source{
Playfair, William. The commercial, political, and
parliamentary atlas, Which represents at a single view, by
means of copper plate charts, the most important public
accounts of revenues, expenditures, debts, and commerce of
England. By William Playfair. To which are added charts of
the revenues and debts of Ireland, done in the same manner,
by James Corry, Esq. The second edition, improved. London,
M,DCC,LXXXVII. [1787]. Eighteenth Century Collections
Online. Gale. 26 Jan. 2014.
}
\description{
Data on imports, exports, and trade balances of European
countries 1700-1780 used in William Playfair's line graphs.
}
\examples{
library("ggplot2")
library("reshape2")
library("plyr")
data("playfair_commerce")
commerce <-
    ddply(melt(playfair_commerce, id.vars = c("year", "country"), measure.vars = c("exports", "imports")),
          c("country", "variable"),
          function(x) {
              interp <- as.data.frame(spline(x$year, x$value,
                                             xout = seq(min(x$year), max(x$year), 1)))
              data.frame(year = interp[ , 1], value = interp[ , 2])
          })
 ggplot(subset(commerce, country == "England"), aes(x = year, y = value, colour = variable)) + geom_line()
}

