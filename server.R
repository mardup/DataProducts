#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library (tidyverse)
library(sjPlot)
## DATA LOAD AND PREPARING DATA
data(mtcars)
 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # from the mtcars help page
  mtcars2 <- mtcars %>% select(mpg,am,wt,qsec,cyl,vs) 
  mtcars2 <- within(mtcars2, {
    am <- factor(am, labels = c("automatic", "manual"))
    vs <- factor(vs, labels = c("V", "S"))
    cyl  <- ordered(cyl)
  })
  
  reg1 <- {(lm(mpg ~ am + wt + qsec + wt:am, data=mtcars2[,]))}
  reg2 <- {(lm(mpg ~ am + wt + qsec , data=mtcars2[,]))} 
  reg3 <- {(lm(mpg ~ am + wt + wt:am , data=mtcars2[,]))} 
  reg4 <- {(lm(mpg ~ am + wt , data=mtcars2[,]))}
  reg5 <- {(lm(mpg ~ am + qsec + wt:am, data=mtcars2[,]))}
  reg6 <- {(lm(mpg ~ am + qsec , data=mtcars2[,]))} 
  reg7 <- {(lm(mpg ~ am + wt:am , data=mtcars2[,]))} 
  reg8 <- {(lm(mpg ~ am , data=mtcars2[,]))}

  
  output$plot <- renderPlot({
    if (input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg1
    } else if (input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg2
    } else if (input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg3 
    } else if (input$IdWt & !input$IdQsec & !input$IdXsWtAm) {
      reg <- reg4
    } else if (!input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg5
    } else if (!input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg6
    } else if (!input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg7
    } else {
      reg <- reg8
    }
    
    plot(reg)
  })
  output$intercept <- renderText({
    if (input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg1
    } else if (input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg2
    } else if (input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg3 
    } else if (input$IdWt & !input$IdQsec & !input$IdXsWtAm) {
      reg <- reg4
    } else if (!input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg5
    } else if (!input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg6
    } else if (!input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg7
    } else {
      reg <- reg8
    }
    reg$coefficients['(Intercept)']
  })
  output$am <- renderText({
    if (input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg1
    } else if (input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg2
    } else if (input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg3 
    } else if (input$IdWt & !input$IdQsec & !input$IdXsWtAm) {
      reg <- reg4
    } else if (!input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg5
    } else if (!input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg6
    } else if (!input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg7
    } else {
      reg <- reg8
    }
    reg$coefficients['ammanual']
  })
  
  output$reg <- renderText({
    if (input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg1
    } else if (input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg2
    } else if (input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg3 
    } else if (input$IdWt & !input$IdQsec & !input$IdXsWtAm) {
      reg <- reg4
    } else if (!input$IdWt & input$IdQsec & input$IdXsWtAm) {
      reg <- reg5
    } else if (!input$IdWt & input$IdQsec & !input$IdXsWtAm) {
      reg <- reg6
    } else if (!input$IdWt & !input$IdQsec & input$IdXsWtAm) {
      reg <- reg7
    } else {
      reg <- reg8
    }
    summary(reg)$adj.r.squared
  })
  
  output$value <- renderPrint({ input$FreeText })
  
 
})
