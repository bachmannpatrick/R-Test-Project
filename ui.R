#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
library(leaflet)
library(data.table)
library(shinythemes)
library(lubridate)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  theme = shinytheme("simplex"),
  # Application title
  titlePanel("Customer map"),
  
  sidebarLayout(position = "left",
                sidebarPanel("Inputs",
                  checkboxGroupInput("genderWidget",
                      label ="Gender Choice", 
                      choices = list("Male" = "m",
                                     "Female" = "f",
                                    "Alien" = "alien"),
                      selected = c("f","m", "alien")
                      ),
                  sliderInput("date",
                      label = "Dates:",
                      min = dmy("01.01.1965"),
                      max = dmy("31.12.2011"),
                      value=c(dmy("01.01.1965"), dmy("31.12.2011"))
                      )),
                mainPanel(
                  tabsetPanel(
                    tabPanel("Map", leafletOutput("mymap", height = "800px")),
                    tabPanel("Data", DT::dataTableOutput('mydata'))
                )
  ))
))