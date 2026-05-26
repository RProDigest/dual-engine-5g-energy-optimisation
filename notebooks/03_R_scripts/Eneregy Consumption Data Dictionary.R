# ============================================================
# Energy Consumption Data Dictionary Table
# APA-friendly Word export using flextable + officer
# Source: Zindi (2023)
# ============================================================

# Install packages if needed
# install.packages(c("dplyr", "tibble", "flextable", "officer"))

library(dplyr)
library(tibble)
library(flextable)
library(officer)

# ------------------------------------------------------------
# 1. Create the data dictionary table
# ------------------------------------------------------------

ec_dictionary <- tribble(
  ~Label,   ~Description,
  "Time",   "Date and time at which the measurement was collected",
  "BS",     "Name of the base station",
  "Energy", "Energy consumption measurement"
)

# ------------------------------------------------------------
# 2. Format the table for Word
# ------------------------------------------------------------

ec_dictionary_flex <- flextable(ec_dictionary) %>%
  theme_booktabs() %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 12, part = "all") %>%
  bold(part = "header") %>%
  align(align = "left", part = "all") %>%
  valign(valign = "top", part = "all") %>%
  width(j = "Label", width = 1.4) %>%
  width(j = "Description", width = 5.3) %>%
  padding(padding.top = 6, padding.bottom = 6, part = "all") %>%
  autofit()

# ------------------------------------------------------------
# 3. Create the Word document
# ------------------------------------------------------------

doc <- read_docx() %>%
  body_add_par("Table X", style = "Normal") %>%
  body_add_par("Energy Consumption Data Dictionary", style = "Normal") %>%
  body_add_flextable(ec_dictionary_flex) %>%
  body_add_par(
    "Note. The table summarises the hour-level energy consumption specifications contained in the energy consumption dataset, including the total energy consumption of base stations. Source: Zindi (2023).",
    style = "Normal"
  )

# ------------------------------------------------------------
# 4. Export to Word
# ------------------------------------------------------------

print(doc, target = "ec_dictionary_table.docx")

