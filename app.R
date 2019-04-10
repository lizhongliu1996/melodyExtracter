library(shiny)
library(shinyWidgets)
library(melodyExtracter)
options(shiny.maxRequestSize=60*1024^2)

ui <- fluidPage(

  setBackgroundImage(src = "https://images7.alphacoders.com/319/319933.jpg"),

  h1("This is a shiny webpage to get rid of the vocal of a song"),
  p("Please upload the wav file you want to remove the melody"),

  # App title ----
  titlePanel("Uploading wav Files"),

  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput(
        inputId = "song",
        label = "Choose WAV File",
        multiple = FALSE,
        accept = c(".wav"),
        buttonLabel = "Browse...",
        placeholder = "No file selected"
      ), # end of input wav

      checkboxInput(
        inputId = "compensate",
        label = "Add low freq compensate",
        value = FALSE
      ) , # end compensate part

      sliderInput(
        inputId = "keyChange",
        label = "semitones you want to change",
        min = -12,
        max = +12,
        value = 0
       ),# end keychange part

      submitButton("confirm", icon("confirm"))

      # actionButton(inputId = "ray", label = "test")

      ), #end of Sidebar panel

    # Main panel for downloading outputs ----
      mainPanel(
         tableOutput("contents"),

      # Output: Data file ----
         downloadButton(
            outputId = "downloadData",
            label = "Download"
         )#end of download

        )#end of mainpanel

  ) #end of sidebar layout
)# end of ui

  # Define server logic to read selected file ----
server <- function(input, output, session) {

      songLoad <- reactive({
         req(input$song)
         input$song
      })

      advanced <- reactive({
        req(input$compensate)
        input$compensate
      })

      key <- reactive({
        req(input$keyChange)
        input$keyChange
      })


      output$downloadData <- downloadHandler(
            filename = function() {
              paste0("novocal", Sys.Date(), ".wav")
            },
            content = function(file) {
              melodyExtractor(
                songLoadPath = as.character(songLoad()[4]),
                songSavePath = file,
                compensate = FALSE,
                keyChange = +2
              )
            }
          )

     output$info <- renderText("your song is be processed, hit download button
                               to download song without melody")


} # end of server

shinyApp(ui, server)

