#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(shiny)
#library(shinydashboard)


library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Linear regression model: mpg knowing transmission"),
    
    # Sidebar to captures parameter to include in the linear model regression
    sidebarLayout(
        sidebarPanel(
            h3("Additional predictor selection for the model "),
            h4("Select to evaluate, intercept, residuals and adjusted R-squared numbers"),
            checkboxInput("IdWt", "Weight (1000 lbs)", FALSE),
            checkboxInput("IdQsec", "1/4 mile time", FALSE),
            checkboxInput("IdXsWtAm", "cross term of weigth and transmission", FALSE),
            textInput("FreeText", label = h4("Feel free to add your comments"), value = "") 
        ),
        
        
        # Show a plot of the generated distribution
        mainPanel(
            h3("This Shiny application intend to select various parameters in the linear regression model of mtcars data."),
            h4("for MT cars documentation you can refer to the help in R documentation (mtcars)"),
            plotOutput("plot"),
            em(strong(p("Selected parameter for linear regression determines a intercept of: "))),
            strong(textOutput("intercept")),
            hr(),
            em(strong(p("Selected parameter for linear regression determines a transmission coefficient of: "))),
            strong(textOutput("am")),
            hr(),
            em(strong(p("adjusted R-squared is: "))),
            strong(textOutput("reg")),
            hr(),
            em(strong(p("Additional comments:"))),
            strong(textOutput("value")),
            hr()         
        )
    )
))
