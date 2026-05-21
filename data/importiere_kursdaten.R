# header ------------------------------------------------------------------

# Dieses Skript greift auf die als Google Sheets gespeicherten Tabellen zu, 
# die Daten für den Vorschlag enthalten. Google Sheets werden manuell bearbeitet 
# und die Daten werden dann von hier aus gelesen und lokal als CSVs gespeichert.

# library -------------------------------------------------------------------

library(googlesheets4)
library(readr)
library(dplyr)

# authentication -----------------------------------------------------------

gs4_auth(cache = ".secrets", email = Sys.getenv("GOOGLE_EMAIL"))

## course schedule  --------------------------------------------------

kursplan <- "https://docs.google.com/spreadsheets/d/1fXnhz1MO-C019BDQfoxqSDAc76YXJi-3AqjnLVCDmp8/edit?gid=0#gid=0"

read_sheet(ss = kursplan) |> 
    mutate(titel = case_when(
        is.na(link) == FALSE ~  paste0("[", titel, "](", link, ")"),
        TRUE ~ titel
    )) |>
    write_csv(here::here("data/tbl-00-rstatszh-kursplan.csv"))

## learning objectives  ------------------------------

lernziele <- "https://docs.google.com/spreadsheets/d/1a2zE0VmyakXmfQTLuMf7AzPxMZBc_Pexr6Bin0GoSZg/edit?gid=0#gid=0"

read_sheet(ss = lernziele,  n_max = 37) |> 
    write_csv(here::here("data/tbl-01-rstatszh-lernziele.csv"))

## abschlussprojekt

abschlussprojekt <- "https://docs.google.com/spreadsheets/d/1xmyR6yJjE8Mxzhc9JMyXrxRbs0I8vbZjFBFZ7i9mrSc/edit?gid=0#gid=0"

read_sheet(ss = abschlussprojekt) |> 
    write_csv(here::here("data/tbl-02-rstatszh-abschlussprojekt.csv"))

