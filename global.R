library(shiny)
library(tidyverse)
library(stringr)
library(DT)
library(bslib)
library(shinyWidgets)
library(lubridate)
library(plotly)
library(vistime)

event_name_v <- c() %>% as.character()
event_group_v <- c() %>% as.character()
start_date_v <- c() %>% as.Date()
end_date_v <- c() %>% as.Date()
selectedColor_v <- c() %>% as.character()
schedule_d <- data.frame()

colorChoices <- c(
  "#0d6efd" = "青",
  "#6610f2"= "インディゴ",
  "#6f42c1"= "紫",
  "#d63384" = "ピンク",
  "#dc3545" = "赤",
  "#df7e14" = "オレンジ",
  "#ffc107" = "黄",
  "#198754"  = "緑",
  "#20c997" = "緑茶",
  "#0dcaf0" = "シアン",
  "#adb5bd" = "灰"
)