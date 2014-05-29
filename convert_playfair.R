library("stringr")
library("dplyr")
library("reshape2")

FILE <- "Playfair 1801 - Sheet1.csv"

makelat <- function(x) {}

fill_na <- function(x, fill = 0) {
    x[is.na(x)] <- fill
    x
}

sterling_str2num <- function(x) {
    y <- str_match(as.character(x),
                   "(([0-9]+)[Ll])?(([0-9]+)[Ss])?(([0-9]+)[Dd])?")
    y <- (fill_na(as.numeric(y[ , 3]))
          + fill_na((1 / 12) * as.numeric(y[ , 5]))
          + fill_na((1 / 240) * as.numeric(y[ , 7])))
    y[y == 0] <- NA
    y
}

degrees2num <- function(x) {
    print(x)
    y <- str_match(as.character(x),
                   "([0-9]+)[Dd](([0-9]+)[Mm])?(([0-9]+)[Ss])?\\s+([NSEWnsew])")
                   ## "([0-9]+)[Dd](([0-9]+)[Mm])?(([0-9]+)[Ss])?\\s+[EW])")
    y2 <- (as.numeric(y[ , 2])
          + fill_na((1 / 60) * as.numeric(y[ , 4]))
          + fill_na((1 / 360) * as.numeric(y[ , 6])))
    y2 <- y2 *  (1 - 2 * (tolower(y[ , 6]) %in% c("s", "w")))
    y2[y2 == 0] <- NA
    y2
}


.data <- read.csv(FILE, stringsAsFactors = FALSE)
.data <- select(.data, -description)
.data <-
    melt(.data,
         id.vars = "variable",
         variable.name = "country",
         value.name = "value")
.data <- dcast(.data, country ~ variable)
.data <- mutate(.data,
                country = gsub("\\.", " ", as.character(country)),
                acres = as.numeric(acres),
                capital_lat = degrees2num(capital_lat),
                capital_long = degrees2num(capital_long),
                center_lat = degrees2num(center_lat),
                center_long = degrees2num(center_long),
                clergy = as.integer(clergy),
                clergy_expense = as.integer(clergy_expense),
                cultivated_acres = as.integer(cultivated_acres),
                divisions = as.integer(divisions),
                exports = as.integer(exports),
                great_divisions_number = as.integer(great_divisions_number),
                imports = as.integer(imports),
                interest_rate = as.numeric(interest_rate),
                land_forces_peace = as.integer(land_forces_peace),
                land_forces_war = as.integer(land_forces_war),
                merchant_tonnage = as.integer(merchant_tonnage),
                miles_sq = as.integer(miles_sq),
                page = as.integer(page),
                parishes = as.integer(parishes),
                poor_maintenance = as.integer(poor_maintenance),
                pop_capital = as.integer(pop_capital),
                pop_density_acres = as.numeric(pop_density_acres),
                pop_density_miles = as.numeric(pop_density_acres),
                population = as.integer(population),
                public_debt = as.integer(public_debt),
                revenue = as.integer(revenue),
                revenues_clergy = as.integer(revenues_clergy),
                sea_coast = as.numeric(sea_coast),
                seamen_peace = as.integer(seamen_peace),
                seamen_war = as.integer(seamen_war),
                ships = as.integer(ships),
                ships_frigates = as.integer(ships_frigates),
                ships_frigates_etc = as.integer(ships_frigates_etc),
                ships_gallies = as.integer(ships_gallies),
                ships_galliots = as.integer(ships_galliots),
                ships_of_the_line = as.integer(ships_of_the_line),
                small_divisions = as.integer(small_divisions),
                taxes_per_capita = sterling_str2num(taxes_per_capita))



