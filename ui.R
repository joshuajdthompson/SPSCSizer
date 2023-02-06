################################################################################
#                   Author: Joshua Thompson
#   O__  ----       Email:  joshuajamesdavidthompson@gmail.com
#  c/ /'_ ---
# (*) \(*) --
# ======================== Script  Information =================================
# PURPOSE: SPSC Sizing TOol for  Anne Arundel County
#
# PROJECT INFORMATION:
#   Name: SPSC Sizing TOol for  Anne Arundel County
#
# HISTORY:----
#   Date		        Remarks
#	-----------	   ---------------------------------------------------------------
#	 06/03/2022    Created script                                   JThompson (JT)
#===============================  Environment Setup  ===========================
#==========================================================================================


if(!require(shiny)){
  install.packages("shiny")
  library(shiny) #'*1.7.1* <---  shiny version
}

if(!require(gfonts)){
  install.packages("gfonts")
  library(gfonts) #'*0.1.3* <---  gfonts version
}

if(!require(stringr)){
  install.packages("stringr")
  library(stringr) #'*1.4.0* <---  stringr version
}

if(!require(tidyverse)){
  install.packages("tidyverse")
  library(tidyverse) #'*1.3.1* <---  tidyverse version
}

if(!require(magrittr)){
  install.packages("magrittr")
  library(magrittr) #'*2.0.2* <---  magrittr version
}

if(!require(tidyselect)){
  install.packages("tidyselect")
  library(tidyselect) #'*1.1.1* <---  tidyselect version
}

if(!require(wesanderson)){
  install.packages("wesanderson")
  library(wesanderson) #'*0.3.6* <---  wesanderson version
}

if(!require(leaflet)){
  install.packages("leaflet")
  library(leaflet) #'*2.0.4.1* <---  leaflet version
}

if(!require(ggtext)){
  install.packages("ggtext")
  library(ggtext) #'*'0.1.1'* <---  ggtext version
}

if(!require(sf)){
  install.packages("sf")
  library(sf) #'*'1.0.5'* <---  sf version
}

if(!require(sp)){
  install.packages("sp")
  library(sp) #'*'1.4.6'* <---  sp version
}

if(!require(DT)){
  install.packages("DT")
  library(DT) #'*'0.20'* <---  DT version
}

if(!require(rmapshaper)){
  install.packages("rmapshaper")
  library(rmapshaper) #'*'0.4.5'* <---  rmapshaper version
}

if(!require(shinycssloaders)){
  install.packages("shinycssloaders")
  library(shinycssloaders) #'*'1.0.05'* <---  shinycssloaders version
}

if(!require(waiter)){
  install.packages("waiter")
  library(waiter) #'*'0.2.5'* <---  waiter version
}

if(!require(Cairo)){
  install.packages("Cairo")
  library(Cairo) #'*'1.5.14'* <---  Cairo version
}

if(!require(leaflet.extras)){
  install.packages("leaflet.extras")
  library(leaflet.extras) #'*'1.0.0'* <---  leaflet.extras version
}

if(!require(tinytex)){
  install.packages("tinytex")
  library(tinytex) #'*'0.38'* <---  tinytex version
}

if(!require(rmarkdown)){
  install.packages("rmarkdown")
  library(rmarkdown) #'*'2.11'* <---  rmarkdown version
}

if(!require(gfonts)){
  install.packages("gfonts")
  library(gfonts) #'*'0.1.3'* <---  gfonts version
}

if(!require(shinyjs)){
  install.packages("shinyjs")
  library(shinyjs) #'*'2.1.0'* <---  shinyjs version
}

if(!require(shinyalert)){
  install.packages("shinyalert")
  library(shinyalert) #'*'3.0.0'* <---  shinyalert version
}

if(!require(shinyBS)){
  install.packages("shinyBS")
  library(shinyBS) #'*'0.61'* <---  shinyBS version
}




# user interface
ui = fluidPage(id = 'fP',
               #palanquin
               use_font("palanquin", "www/css/palanquin.css"),
               useShinyjs(),
               useWaiter(),
               useHostess(),
               waiterShowOnLoad(
                 color = "#9cb6db",
                 hostess_loader(
                   "loader", 
                   preset = "bubble",
                   stroke_color = "#16478e",
                   text_color = "black",
                   class = "label-center",
                   center_page = TRUE
                 )
               ),#tags$style("body {background-color:#9ec7b4;}"), 
               
               tags$head(HTML("<title>SPSC Sizing Tool</title> <link rel='icon' type='image/gif/png' href='logo.png'>"),
                         tags$style(HTML(
                           "
              .shiny-notification {position:fixed;top: calc(25%);left: calc(10%);}             
              .nav-tabs {font-size: 18px} 
              .navbar{background-color: #16478e !important; padding-left: 20px; margin-left:-20px; padding-right: 15px; margin-right:-15px;padding-top: 20px; margin-top:-20px;}
              .navbar-default .navbar-brand:hover {color: blue;}
              .navbar { background-color: gray;}
              .navbar-default .navbar-nav > li > a {color:white;}
              .navbar-default .navbar-nav > .active > a,
              .navbar-default .navbar-nav > .active > a:focus,
              .navbar-default .navbar-nav > .active > a:hover {color: white;background-color: #9cb6db;}
              .navbar-default .navbar-nav > li > a:hover {color: #000000;background-color:#9cb6db;text-decoration:underline;}
              .butt{background-color:#505250; color:#FFFFFF; border-color:#080808;}
              .btn-file{background-color:#505250; color:#FFFFFF; border-color:#080808;}
              .form-control.shiny-bound-input {margin-top:7.5px;}
              #rifq100H.form-control.shiny-bound-input {background-color:#f0e6af;}
              #rifq100desDepth.form-control.shiny-bound-input {background-color:#f0e6af;}
              #rifq100D50.form-control.shiny-bound-input {background-color:#f0e6af;}
              #rifq100Pd.form-control.shiny-bound-input {background-color:#f0e6af;}
              /*#rifq100WDR.form-control.shiny-bound-input {background-color:#f0e6af;}*/
              #rifq100Man.form-control.shiny-bound-input {background-color:#f0e6af;}
              #rifq100slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq100DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10W.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10L.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10H.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10D50.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10Pd.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10WDR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10Man.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10RUW.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq10DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2W.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2L.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2H.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2D50.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2Pd.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2WDR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2Man.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2RUW.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #rifq2DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100D50.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100Man.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100RUW.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq100DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10W.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10L.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10H.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10D50.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10Pd.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10Man.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10RUW.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq10DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2W.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2L.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2H.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2D50.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2Pd.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2Man.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2slope.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2RUW.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2TWaD.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2flowA.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2HR.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2Fr.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2ImaxVel.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #casq2DATW4.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #scDq100desFlow.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #scDHupstreamGrade.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #scDTWupstreamGrade.form-control.shiny-bound-input {background-color:#d0d2d9;}
              #scDKcoeff.form-control.shiny-bound-input {background-color:#d0d2d9;}
              input[type=number] {-moz-appearance:textfield;}
              input[type=number]::{-moz-appearance:textfield;}
              input[type=number]::-webkit-outer-spin-button,input[type=number]::-webkit-inner-spin-button {-webkit-appearance: none;
                    margin: 0;}
              .shiny-input-radiogroup label {
                display: inline-block;
                font-weight: bold;
                text-align: center;
            }
            .shiny-input-radiogroup label input[type='radio'] {
                display: block;
                margin: 2em auto;
            }
              "
                         ))),
               titlePanel(
                 fluidRow(style = "background-color:#16478e; padding-top: 20px; margin-top:-20px; padding-bottom: 20px; margin-bottom:-20px",
                          column(9,h4(("Step Pool Stormwater Conveyance Sizing Tool for Anne Arundel County"),style="font-size:26px;font-style:normal; font-weight: 400; color:#FFFFFF;"),
                                 p("Note: this tool is provided 'as is' without warranty of any kind, either expressed, implied, or statutory.  The user assumes the entire risk as to the quality and performance of the data from this tool.  
                                   Report is generated using user-developed and user-entered data.  Anne Arundel County makes no claims as to the validity or accuracy of the data used to develop this report or results detailed in the report",style="font-size:11.5px;font-style:italic;color:#FFFFFF;"),
                                 p("SPSC Sizer v.0.1.0, 02/03/2023",style="font-size:11.5px;font-style:italic;color:#FFFFFF;"),
                                 p("The user assumes the entire risk as to quality and performance of the data from this tool.",style="font-size:11.5px;font-style:italic;color:#FFFFFF;"),
                                 actionButton(inputId = "info1", label = "",icon = icon("info", lib = "font-awesome"),
                                                style = "background-color:#505250; color:#FFFFFF; border-color:#080808"),
                                 a(actionButton(inputId = "email1", label = "   Contact ",icon = icon("envelope", lib = "font-awesome"),
                                                style = "background-color:#505250; color:#FFFFFF; border-color:#080808"),href="mailto:bwpr_app_support@aacounty.org"),
                                 a(actionButton(inputId = "github1", label = "",icon = icon("github", lib = "font-awesome"),
                                                style = "background-color:#505250; color:#FFFFFF; border-color:#080808"),href="https://github.com/joshuajdthompson",target="_blank")),
                          column(3, tags$a(img(src='BWPR_LogoVersion2.png', align = "right",height = 279*0.55, width = 558*0.55, style="padding: 0px")))
                          #div(style="margin-bottom:10px")
                 )),
               navbarPage("",

                          ##===========================================================================================================================#
                          ##===========================================================================================================================#
                          ## #######################################  Riffle Sizing ####################################################################
                          ##===========================================================================================================================#
                          ##===========================================================================================================================#             
                          
                          tabPanel("Riffle Sizing",icon=icon("ruler-horizontal"),#,
                                   wellPanel(style = "background-color: #9cb6db; border: 1px solid black; padding-left: 15px; margin-left:-15px; padding-right: 15px; margin-right:-15px; padding-top: 10px; margin-top:-10px",
                                             fluidRow(tags$head(
                                               tags$style(type="text/css", "label.control-label, .selectize-control.single{ display: table-cell; text-align: left; vertical-align: middle; } .form-group { display: table-row;}")
                                             ),
                                             column(6,
                                                    column(12,
                                                           h4(strong("Riffle Weir Sizing"),style="font-size:20px;font-style:normal; font-weight: 400; color: black"),  
                                                           br(), #actionButton("genSize", "Generate Riffle Weir Sizing",class="butt"), br(), br(),
                                                           h4(strong("Site Name:"),style="font-size:14px;font-style:normal; font-weight: 400; color: black"),
                                                           column(4,textInput("rifreportName", "")), column(8,downloadButton("rifReport", "Download Riffle Report",class="butt")), br(), br(), br(),
                                                           h4(HTML("<b>Are you an advanced designer? (An advanced designer may customize to site specific design by entering values in orange cells)</b>"),style="font-size:16px;font-style:normal; font-weight: 400; color: black; text-align:left;"), br(), radioButtons("userEnteredDataRiff", "", choices = c("Yes", "No"), selected = "No",inline=T), br(), #Are you an advanced designer? (An advanced designer may change \nto customize to site specific design)
                                                    ),
                                                    column(6, style="padding-left: 7.5px; margin-left:-15px;",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("100"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("rifq100desFlow", "Design Flow (cfs)", width = NULL,value = 0, step = "any"),
                                                           numericInput("rifq100W", "Width (ft)", width = NULL,value = 10, step = "any"),
                                                           numericInput("rifq100L", "L, Length (ft)", width = NULL,value = 10, step = "any"),
                                                           numericInput("rifq100H", "H, Height (ft)", width = NULL,value = 1, step = "any"),
                                                           numericInput("rifq100desDepth", "Design Depth of flow (ft)", width = NULL,value = 0.67,step = "any"),
                                                           numericInput("rifq100D50", "D50 (in)", width = NULL,value = 6, step = "any"),
                                                           numericInput("rifq100Pd", HTML(paste0("<b>","P",tags$sub("D"), ", Parabolic Depth (ft)","</b>")), width = NULL,value = 0.67,step = "any"),
                                                           numericInput("rifq100WDR", HTML(paste0("<b>","Width Depth Ratio (W/P",tags$sub("D"),")","</b>")), width = NULL,value = 15, step = "any"),
                                                           numericInput("rifq100Man", "Manning's n Value", width = NULL,value = 0.056, step = "any"),
                                                           numericInput("rifq100slope", "Slope (ft/ft)", width = NULL,value = 10, step = "any"),
                                                           numericInput("rifq100RUW", "Rock Unit Weight (lbs/cf)", width = NULL,value = 165, step = "any"),
                                                           numericInput("rifq100TWaD", "Top Width at Depth", width = NULL,value = 10, step = "any"),
                                                           numericInput("rifq100flowA", "Flow area (sf)", width = NULL,value = 4.4, step = "any"),
                                                           numericInput("rifq100HR", "Hydraulic Radius", width = NULL,value = 0.44, step = "any"),
                                                           numericInput("rifq100Fr", "Froude", width = NULL,value = 1.05, step = "any"),
                                                           numericInput("rifq100ImaxVel", "Isbash Maximum Velocity (ft/s)", width = NULL,value = 6.26, step = "any"),
                                                           numericInput("rifq100DATW4", "Depth ('A') at TW/4 offset from centerline ", width = NULL,value = 0.5, step = "any")),
                                                    column(3,style="padding-left: 7.5px; margin-left:-15px;",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("10"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("rifq10desFlow", "", width ='100%',value = 0, step = "any"),
                                                           numericInput("rifq10W", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq10L", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq10H", "", width ='100%',value = 1, step = "any"),
                                                           numericInput("rifq10desDepth", "", width ='100%',value = 0.667, step = "any"),
                                                           numericInput("rifq10D50", "", width ='100%',value = 6, step = "any"),
                                                           numericInput("rifq10Pd", "", width ='100%',value = 0.667, step = "any"),
                                                           numericInput("rifq10WDR", "", width ='100%',value = 15, step = "any"),
                                                           numericInput("rifq10Man", "", width ='100%',value = 0.056, step = "any"),
                                                           numericInput("rifq10slope", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq10RUW", "", width ='100%',value = 165, step = "any"),
                                                           numericInput("rifq10TWaD", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq10flowA", "", width ='100%',value = 4.4, step = "any"),
                                                           numericInput("rifq10HR", "", width ='100%',value = 0.44, step = "any"),
                                                           numericInput("rifq10Fr", "", width ='100%',value = 1.05, step = "any"),
                                                           numericInput("rifq10ImaxVel", "", width ='100%',value = 6.26, step = "any"),
                                                           numericInput("rifq10DATW4", "", width ='100%',value = 0.5, step = "any")),
                                                    column(3,style="padding-left: 7.5px; margin-left:-15px",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("2"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("rifq2desFlow", "", width ='100%',value = 0, step = "any"),
                                                           numericInput("rifq2W", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq2L", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq2H", "", width ='100%',value = 1, step = "any"),
                                                           numericInput("rifq2desDepth", "", width ='100%',value = 0.667, step = "any"),
                                                           numericInput("rifq2D50", "", width ='100%',value = 6, step = "any"),
                                                           numericInput("rifq2Pd", "", width ='100%',value = 0.667, step = "any"),
                                                           numericInput("rifq2WDR", "", width ='100%',value = 15.0, step = "any"),
                                                           numericInput("rifq2Man", "", width ='100%',value = 0.056, step = "any"),
                                                           numericInput("rifq2slope", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq2RUW", "", width ='100%',value = 165, step = "any"),
                                                           numericInput("rifq2TWaD", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("rifq2flowA", "", width ='100%',value = 4.4, step = "any"),
                                                           numericInput("rifq2HR", "", width ='100%',value = 0.44, step = "any"),
                                                           numericInput("rifq2Fr", "", width ='100%',value = 1.05, step = "any"),
                                                           numericInput("rifq2ImaxVel", "", width ='100%',value = 6.26, step = "any"),
                                                           numericInput("rifq2DATW4", "", width ='100%',value = 0.5, step = "any"))
                                             ),
                                             
                                             column(6,actionButton("help_riff", "Guidance",class="butt"), br(),br(),br(),
                                                    wellPanel(style = "background-color: #cddffa; border: 1px solid black; padding-left: 10px; margin-left:-10px; padding-right: 10px; margin-right:-10px; padding-top: 10px; margin-top:-10px",h4(strong("Sizing Results"),style="font-size:20px;font-style:normal; font-weight: 400; color: black"), 
                                                              br(), DTOutput("riff_output")%>% withSpinner(color="black"),br(),DTOutput("riff_output2")%>% withSpinner(color="black"))))
                                   ), 
                                   # popup messages - riffle size
                                   bsTooltip(id = "rifq100desFlow", 
                                             title = "Input the calculated design flow for 100-year flow."),
                                   bsTooltip(id = "rifq10desFlow", 
                                             title = "Input the calculated design flow for 10-year flow."),
                                   bsTooltip(id = "rifq2desFlow", 
                                             title = "Input the calculated design flow for 2-year flow."),
                                   bsTooltip(id = "rifq100W", 
                                             title = "10 feet is the minimum riffle width and is the recommended starting value.",trigger = "hover"),
                                   bsTooltip(id = "rifq100L", 
                                             title = "10 feet is the minimum riffle length and is the recommended starting value."),
                                   bsTooltip(id = "rifq100H", 
                                             title = "Please update value! The recommended standard riffle height is 1 foot. However, if site specific conditions necessitate a different height, the designer may choose a value between 0-1.5 feet."),
                                   bsTooltip(id = "rifq100desDepth", 
                                             title = "Please update value! For Q100, it is recommended to keep initial design depth = Parabolic Depth to minimize depth of section. Designer may lower design depth if design flow is exceeded at minimum riffle dimensions."),
                                   bsTooltip(id = "rifq100D50", 
                                             title = "Please update value! The default value is automatically populated with the recommended value for D50 for the given design discharge."),
                                   bsTooltip(id = "rifq100Pd", 
                                             title = "Please update value! To simplify sizing and encourage compliant structures, this template links parabolic depth to the minmum allowable Width Depth Ratio. Designers should plan to re-evaluate parabolic depth based on site-specific needs. Parabolic depths exceeding 2.0 feet, are discouraged by the County, especially at the minimum width depth ratio. See note in Riffle Sizing Guidance."),
                                   bsTooltip(id = "rifq100WDR", 
                                             title = "A ratio of 10 is the minimum allowable width depth ratio and is set as the initial value for prelminary sizing. However, the designer is encouraged to consider a higher width depth ratio when site conditions allow (e.g., when the site accomodates width without major disturbance to natural resources). When conditions allow, designers are encouraged to select a width depth ratio of up to 20. See note in Riffle Sizing Guidance."),
                                   bsTooltip(id = "rifq100Man", 
                                             title = "Please update value!"),
                                   bsTooltip(id = "rifq100RUW", 
                                             title = "Typically for granite: 165 lbs/cf, for ferricrete (sandstone) 145 lbs/cf)"),
                                   bsTooltip(id = "rifq2desDepth", 
                                             title = "Once design is complete for Q100, update this depth to calculate appropriate flow for Q2."),
                                   bsTooltip(id = "rifq10desDepth", 
                                             title = "Once design is complete for Q100, update this depth to calculate appropriate flow for Q10."),
                                   bsTooltip(id = "rifreportName", 
                                             title = "Please a site name if downloading a Riffle Weir Size report.  Reports can be appended to any stormwater design reports.")
                          ),
                          
                          
                          ##===========================================================================================================================#
                          ##===========================================================================================================================#
                          ## #######################################  Cascade Sizing  ##################################################################
                          ##===========================================================================================================================#
                          ##===========================================================================================================================#              
                          
                          tabPanel("Cascade Sizing",icon=icon("ruler-vertical"),#,
                                   wellPanel(style = "background-color: #9cb6db; border: 1px solid black; padding-left: 15px; margin-left:-15px; padding-right: 15px; margin-right:-15px; padding-top: 10px; margin-top:-10px",
                                             fluidRow(tags$head(
                                               tags$style(type="text/css", "label.control-label, .selectize-control.single{ display: table-cell; text-align: left; vertical-align: middle; } .form-group { display: table-row;}")
                                             ),
                                             column(6,
                                                    column(12,
                                                           h4(strong("Cascade Weir Sizing"),style="font-size:20px;font-style:normal; font-weight: 400; color: black"),
                                                           br(),
                                                           h4(strong("Site Name:"),style="font-size:14px;font-style:normal; font-weight: 400; color: black"),
                                                           column(4,textInput("casreportName", "")), column(8,downloadButton("casReport", "Download Cascade Report",class="butt")),br(), br(), br(),
                                                           h4(HTML("<b>Do you have permission from BWPR to increase cascade height beyond the maximum allowable?</b>"),style="font-size:16px;font-style:normal; font-weight: 400; color: black; text-align:left;"), br(), radioButtons("casHeightincrease", "", choices = c("Yes", "No"), selected = "No",inline=T), br(), 
                                                    ), 
                                                    column(6, style="padding-left: 7.5px; margin-left:-15px;",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("100"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("casq100desFlow", "Design Flow (cfs)", width = NULL,value = 0, step = "any"),
                                                           numericInput("casq100W", "Width (ft)", width = NULL,value = 10, step = "any"),
                                                           numericInput("casq100L", "L, Length (ft)", width = NULL,value = 6, step = "any"),
                                                           numericInput("casq100H", "H, Height (ft)", width = NULL,value = 3, step = "any",max = 6),
                                                           numericInput("casq100desDepth", "Design Depth of flow (ft)", width = NULL,value = 0.80, step = "any"),
                                                           numericInput("casq100D50", "D50 (in)", width = NULL,value = 30, step = "any"),
                                                           numericInput("casq100Pd", HTML(paste0("<b>","P",tags$sub("D"), ", Parabolic Depth (ft)","</b>")), width = NULL,value = 2, step = "any"),
                                                           numericInput("casq100Man", "Manning's n Value", width = NULL,value = 0.05, step = "any"),
                                                           numericInput("casq100slope", "Slope (ft/ft)", width = NULL,value = 0.5, step = "any"),
                                                           numericInput("casq100RUW", "Rock Unit Weight (lbs/cf)", width = NULL,value = 165, step = "any"),
                                                           numericInput("casq100TWaD", "Top Width at Depth", width = NULL,value = 6.3, step = "any"),
                                                           numericInput("casq100flowA", "Flow area (sf)", width = NULL,value = 3.4, step = "any"),
                                                           numericInput("casq100HR", "Hydraulic Radius", width = NULL,value = 0.51, step = "any"),
                                                           numericInput("casq100Fr", "Froude", width = NULL,value = 2.66, step = "any"),
                                                           numericInput("casq100ImaxVel", "Isbash Maximum Velocity (ft/s)", width = NULL,value = 13.99, step = "any"),
                                                           numericInput("casq100DATW4", "Depth ('A') at TW/4 offset from centerline ", width = NULL,value = 1.5, step = "any")),
                                                    column(3,style="padding-left: 7.5px; margin-left:-15px;",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("10"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("casq10desFlow", "", width ='100%',value = 0, step = "any"),
                                                           numericInput("casq10W", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("casq10L", "", width ='100%',value = 6, step = "any"),
                                                           numericInput("casq10H", "", width ='100%',value = 3, step = "any"),
                                                           numericInput("casq10desDepth", "", width ='100%',value = 0.80, step = "any"),
                                                           numericInput("casq10D50", "", width ='100%',value = 30, step = "any"),
                                                           numericInput("casq10Pd", "", width ='100%',value = 2, step = "any"),
                                                           numericInput("casq10Man", "", width ='100%',value = 0.050, step = "any"),
                                                           numericInput("casq10slope", "", width ='100%',value = 0.5, step = "any"),
                                                           numericInput("casq10RUW", "", width ='100%',value = 165, step = "any"),
                                                           numericInput("casq10TWaD", "", width ='100%',value = 6.3, step = "any"),
                                                           numericInput("casq10flowA", "", width ='100%',value = 3.4, step = "any"),
                                                           numericInput("casq10HR", "", width ='100%',value = 0.51, step = "any"),
                                                           numericInput("casq10Fr", "", width ='100%',value = 2.66, step = "any"),
                                                           numericInput("casq10ImaxVel", "", width ='100%',value = 13.99, step = "any"),
                                                           numericInput("casq10DATW4", "", width ='100%',value = 1.5, step = "any")),
                                                    column(3,style="padding-left: 7.5px; margin-left:-15px",
                                                           h4(HTML(paste0("<b>","Q",tags$sub("2"),"</b>")),style="font-size:20px;font-style:normal; font-weight: 400; color: black; text-align:right;"),br(),
                                                           numericInput("casq2desFlow", "", width ='100%',value = 0, step = "any"),
                                                           numericInput("casq2W", "", width ='100%',value = 10, step = "any"),
                                                           numericInput("casq2L", "", width ='100%',value = 6, step = "any"),
                                                           numericInput("casq2H", "", width ='100%',value = 3, step = "any"),
                                                           numericInput("casq2desDepth", "", width ='100%',value = 0.8, step = "any"),
                                                           numericInput("casq2D50", "", width ='100%',value = 30, step = "any"),
                                                           numericInput("casq2Pd", "", width ='100%',value = 2, step = "any"),
                                                           numericInput("casq2Man", "", width ='100%',value = 0.050, step = "any"),
                                                           numericInput("casq2slope", "", width ='100%',value = 0.5, step = "any"),
                                                           numericInput("casq2RUW", "", width ='100%',value = 165, step = "any"),
                                                           numericInput("casq2TWaD", "", width ='100%',value = 6.3, step = "any"),
                                                           numericInput("casq2flowA", "", width ='100%',value = 3.4, step = "any"),
                                                           numericInput("casq2HR", "", width ='100%',value = 0.51, step = "any"),
                                                           numericInput("casq2Fr", "", width ='100%',value = 2.66, step = "any"),
                                                           numericInput("casq2ImaxVel", "", width ='100%',value = 13.99, step = "any"),
                                                           numericInput("casq2DATW4", "", width ='100%',value = 1.5, step = "any")), 
                                                    column(12,
                                                           br(),
                                                           h4(strong("Scour Depth Sizing - pools downstream of cascades"),style="font-size:20px;font-style:normal; font-weight: 400; color: black"), br()
                                                    ),
                                                    column(11, style="padding-left: 7.5px; margin-left:-15px;",
                                                           numericInput("scDq100desFlow", HTML(paste0("<b>","Q",tags$sub("100"), ", cfs","</b>")), width = NULL,value = 0, step = "any"),
                                                           numericInput("scDPoolMaxDepthFt", "Pool Max Depth (ft)", width = NULL,value = 1.5, step = "any"),
                                                           numericInput("scDHupstreamGrade", "H, Height of upstream grade control structure (ft)", width = NULL,value = 3, step = "any"),
                                                           numericInput("scDTWupstreamGrade", "TW, Top width of the upstream grade control structure (ft)  ", width = NULL,value = 10, step = "any"),
                                                           numericInput("scDtydownstructure", HTML(paste0("<b>","y, depth of Q",tags$sub("100"), " in downstream/receiving structure","</b>")), width = NULL,value = 0, step = "any"),
                                                           numericInput("scDKcoeff", "K, coefficient", width = NULL,value = 1.32, step = "any")
                                                    )
                                             ),
                                             
                                             column(6,actionButton("help_cas", "Guidance",class="butt"), br(),br(),br(),
                                                    wellPanel(style = "background-color: #cddffa; border: 1px solid black; padding-left: 10px; margin-left:-10px; padding-right: 10px; margin-right:-10px; padding-top: 10px; margin-top:-10px",h4(strong("Sizing Results"),style="font-size:20px;font-style:normal; font-weight: 400; color: black"), 
                                                              br(), DTOutput("cas_output")%>% withSpinner(color="black"),br(),DTOutput("cas_output2")%>% withSpinner(color="black"))))
                                   ),
                                   
                                   # popup messages - weir size
                                   bsTooltip(id = "casq100desFlow", 
                                             title = "Input the calculated design flow for 100-year flow."),
                                   bsTooltip(id = "casq10desFlow", 
                                             title = "Input the calculated design flow for 10-year flow."),
                                   bsTooltip(id = "casq2desFlow", 
                                             title = "Input the calculated design flow for 2-year flow."),
                                   bsTooltip(id = "casq100W", 
                                             title = "It is recommended that that the designer set top width equal to calculated standard 1-foot top width (calculated using Riffle Sizing sheet). The minimum width is 10 feet.",trigger = "hover"),
                                   bsTooltip(id = "casq100H", 
                                             title = "Cascade height should be between 2-5 feet. The maximum height is 5.0 feet.",trigger = "hover"),
                                   bsTooltip(id = "casq100desDepth", 
                                             title = "Calibrate deisgn depth of flow so that caclulated flow equals the desired design flow."),
                                   bsTooltip(id = "casq10desDepth", 
                                             title = "Once design is complete for Q100, update this depth to calculate appropriate flow for Q10."),
                                   bsTooltip(id = "casq2desDepth", 
                                             title = "Once design is complete for Q100, update this depth to calculate appropriate flow for Q2."),
                                   bsTooltip(id = "casq100Pd", 
                                             title = "Set parabolic depth equal to the greater of 2 feet OR the calculated parabolic depth for a standard 1-foot riffle."),
                                   bsTooltip(id = "casreportName", 
                                             title = "Please a site name if downloading a Cascade Weir Size report.  Reports can be appended to any stormwater design reports.")
                                   
                                   #
                                   
                          )  
               )
)







