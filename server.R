#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#


library(shiny)
library(leaflet)
library(data.table)
library(lubridate)
library(DT)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  d <- fread("/Volumes/Nifty/Cloudstation/_Uni/Master/actual/FS2018/R-NonTechnicalIntroduction/02_Exercises/data/demographics.csv")
  d[, JoinDate:=dmy(JoinDate, tz="UTC")]
  #zips <- as.matrix(d[1:10000, list(zip_longitude, zip_latitude, Gender)])
  
  d.shiny <- reactive({
    d[Gender %in% input$genderWidget & JoinDate >= input$date[1] & JoinDate <= input$date[2]]
  })

  # Define map and fill map with data points  
  output$mymap <- renderLeaflet({
    map <- leaflet();
    map <- addTiles(map); 
    map <- addMarkers(map, lng = d.shiny()[,zip_longitude], 
                      lat =d.shiny()[,zip_latitude], 
                      clusterOptions = markerClusterOptions());
    map <- setView(map, lat= 43, lng= -79, zoom = 4); # North America
  })
  
  # Table Output for Tab 
  output$mydata <- DT::renderDataTable(d.shiny())
  
  
})
