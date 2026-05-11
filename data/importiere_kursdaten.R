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

kursplan <- "https://docs.google.com/spreadsheets/d/1rDDyRpUsBo0JIy3PWotdQtDwml0P9mASy-GGr5iKbPU/edit?gid=0#gid=0"

read_sheet(ss = kursplan) |> 
    mutate(titel = case_when(
        is.na(link) == FALSE ~  paste0("[", titel, "](", link, ")"),
        TRUE ~ titel
    )) |>
    write_csv(here::here("data/tbl-00-rstatszh-kursplan.csv"))

## learning objectives  ------------------------------

lernziele <- "https://docs.google.com/spreadsheets/d/1lOoaUvQWignPAp1v5tkwRzsnv16RyAUjsZMbzodIuPY/edit?gid=0#gid=0"

read_sheet(ss = lernziele,  n_max = 37) |> 
    write_csv(here::here("data/tbl-01-rstatszh-lernziele.csv"))

## abschlussprojekt

abschlussprojekt <- "https://docs.google.com/spreadsheets/d/1rUfwhHVWzkGWQTW-VKxEhHRGgtRg893ijbkHHqiJ4YY/edit?gid=0#gid=0"

read_sheet(ss = abschlussprojekt) |> 
    write_csv(here::here("data/tbl-02-rstatszh-abschlussprojekt.csv"))

