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
#	 04/10/2022    Created script                                   JThompson (JT)
#  02/06/2022    Edited download handler                          JT
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

if(!require(shinyjs)){
  install.packages("shinyjs")
  library(shinyjs) #'*'2.1.0'* <---  shinyjs version
}

if(!require(shinyalert)){
  install.packages("shinyalert")
  library(shinyalert) #'*'3.0.0'* <---  shinyalert version
}


if(!require(shinyvalidate)){
  install.packages("shinyvalidate")
  library(shinyvalidate) #'*'0.1.2'* <---  shinyvalidate version
}



server <- function(input, output, session){
  hostess <- Hostess$new("loader")
  
  
  
  Sys.sleep(1)
  
  for(i in 1:10){
    Sys.sleep(runif(1) / 2)
    hostess$set(i * 10)
  }
  waiter_hide()
  #a6a6a6
  observeEvent(input$help_riff, {
    shinyalert(title = "Guidance",   " <div>
<p style='font-family:palanquin;font-size:16px;font-style:normal; font-weight: 600;color: #545252;'>This section includes a step-by-step process for sizing a standard one-foot riffle weir (as defined in Section 3.1.1 Riffle Weirs). The 1-foot riffle height is the preferred typical riffle height.</p>
<br>
<p style='font-family:palanquin;font-size:16px;font-style:normal; font-weight: 400;color: #545252; text-align: left'>
<br>
<b>Note:</b> the proposed solution represents <b>minimum</b> allowable riffle dimensions. Designers are stongly encouraged to customize results to site-specific dimensions. In general, the County prefers a width-depth ratio greater than 10 when site conditions allow. Parabolic depths exceeding 2.0 feet are discouraged as excessively high berms may be required to tie-in structures. The designer may likewise modify structures dimensions to reduce stone size.
<br><br>
<b>1.</b> Start with an initial riffle top width of 10 feet and riffle length of 10 feet. Set the width depth ratio to 10. To simplify sizing, the County recommends setting the design depth equal to the parabolic depth throughout this process. These initial values are the minimum riffle dimensions.
<br>
<b>2.</b> Compare the Q<sub>100</sub> to the recommended riffle mix table (Table 1). Select the corresponding riffle mix D<sub>50</sub>.
<br>
<b>3.</b> Review the results:
<br>
<b>&ensp;3a.</b> If the channel exceeds required capacity, reduce the design depth below the parabolic depth until equal to the design flow/Q<sub>100</sub>.
<br>
<b>&ensp;3b.</b> If the channel does not have adequate flow capacity, proceed to Step 4.
<br>
<b>&ensp;3c.</b> If the channel has adequate capacity, but velocity exceeds the maximum allowable velocity, proceed to Step 5.
<br>
<b>&ensp;3d.</b> If the channel has adequate capacity, and velocity is within the allowable range, proceed to Step 6. 
<br>
<b>4.</b> Increase the channel top width until the channel has adequate flow capacity.
<br>
<b>&ensp;4a.</b> If the channel has adequate capacity, but velocity exceeds maximum allowable velocity, proceed to Step 5.
<br>
<b>&ensp;4b.</b> If the channel has adequate capacity, and velocity is within the allowable range, proceed to Step 6.
<br>
<b>5.</b> If the channel exceeds the allowable velocity, increase the riffle length until velocity is in the allowable range. Typically, this creates a corresponding reduction in channel capacity requiring iterative calibration:
<br>
<b>&ensp;5a.</b> If the channel does not have adequate flow capacity, return to Step 4.
<br>
<b>&ensp;5b.</b> If the channel has adequate capacity, and velocity is within the allowable range, proceed to Step 6.
<br>
<b>6.</b> Check the channel performance against the 2- and 10-year discharge by altering the design depth and calibrating the calculated flow to Q<sub>2</sub> and Q<sub>10</sub>. Note that for these events, the design depth will be less than the parabolic depth. 
<br>
<b>7.</b> The designer may now make any modifications necessary to ensure the design is acceptable for the site specific 2-, 10- and 100-year goals.
<br><br>
The calculated dimensions are a valid riffle weir solution. The designer should evaluate the proposed dimensions against the site constraints. The designer may further refine and optimize the riffle height, parabolic depth, top width, and riffle length to match site constraints. The designer is encouraged to maintain standard one-foot riffle weir dimensions for all riffle weirs within a specified reach. As needed, the designer may size additional riffle weirs to conform to site conditions.</p>
  ", type = "info", showCancelButton = TRUE, closeOnClickOutside = TRUE, size = "l", html = TRUE)
  })
  
  
  observeEvent(input$help_cas, {
    shinyalert(title = "Guidance",   " <div>
<p style='font-family:palanquin;font-size:16px;font-style:normal; font-weight: 600;color: #545252;'>This section includes a step-by-step process for sizing cascades.</p>
<br>
<p style='font-family:palanquin;font-size:16px;font-style:normal; font-weight: 400;color: #545252; text-align: left'>
<br>
<b>1.</b> The designer should choose initial design dimensions:
<br>
<b>&ensp;1a.</b> Select a desired cascade height, H.
<br>
<b>&ensp;1b.</b> Set top width equal to the standard one-foot riffle weir top-width (as calculated in Section 3.5.2.1).
<br>
<b>&ensp;1c.</b> Set parabolic depth, P<sub>D</sub>.
<br>
<b>&ensp;i.</b> Parabolic depth shall be a minimum of two feet.
<br>
<b>&ensp;ii.</b> If the calculated standard one-foot riffle weir parabolic depth is greater than two-feet, match cascade weir parabolic depth to the standard one-foot riffle weir parabolic depth.
<br>
<b>&ensp;1d.</b> The initial cascade length should be set to the minimum length, based on the maximum allowable cascade slope (50 percent) for the selected structure height (e.g., if the designer chooses a H of 5.0 feet, the designer should start with a length of 10.0 feet).
<br>
<b>&ensp;1e.</b> Set Manning's n value to 0.05.
<br>
<b>&ensp;1f.</b> Set D<sub>50</sub>  to 30 inches (2.5 feet).
<br>
<b>2.</b> Calibrate the design depth of flow so that calculated flow equals the desired design flow (Q<sub>100</sub>). Do not modify parabolic depth. Depth of flow will be lower than the section parabolic depth.
<br>
<b>3.</b> Review the results:
<br>
<b>&ensp;3a.</b> If velocity is within the maximum allowable velocity, proceed to Step 4.
<br>
<b>&ensp;3b.</b> If velocity is above the maximum allowable range, increase the length of structure until velocity is below the maximum allowable velocity. Return to Step 2.
<br>
<b>4.</b> Check the channel performance against the 2- and 10-year discharge by altering the design depth and calibrating to Q<sub>2</sub>  and Q<sub>10</sub>. The designer should make any modifications as necessary to ensure the design is acceptable for the site specific 2-, 10- and 100-year goals.
<br><br>
The calculated dimensions are a valid cascade weir solution. The designer should evaluate the proposed dimensions against the site constraints. The designer may further refine and optimize the top width, height, parabolic depth, and cascade length to meet the needs unique to their proposed site. The designer may proceed to size additional cascade weirs (of different dimensions) as necessary to complete the proposed design.
</p>
  ", type = "info", showCancelButton = TRUE, closeOnClickOutside = TRUE, size = "l", html = TRUE)
  })
  
  
  observeEvent(input$info1, {
    shinyalert(title = "Version History",   " <div>
<p style='font-family:palanquin;font-size:16px;font-style:normal; font-weight: 400;color: #545252; text-align: left'>
<b>4/10/22</b> - Created app.
<br><br>
<b>02/03/23</b> - Edited guidance for cascade height and added warning message.
<br>
  ", type = "info", showCancelButton = TRUE, closeOnClickOutside = TRUE, size = "l", html = TRUE)
  })
  
  
  values <- reactiveValues()
  
  
  # set Q100 fields that shouldn't be edited to be in a disabled state
  
  disable('rifq100H')
  disable('rifq100desDepth')
  disable('rifq100D50')
  disable('rifq100Pd')
  disable('rifq100Man')
  disable('rifq100slope')
  disable("rifq100TWaD")
  disable("rifq100flowA")
  disable("rifq100HR")
  disable("rifq100Fr")
  disable("rifq100ImaxVel")
  disable("rifq100DATW4")
  disable("rifq10W")
  disable("rifq10L")
  disable("rifq10H")
  disable("rifq10D50")
  disable("rifq10Pd")
  disable("rifq10WDR")
  disable("rifq10Man")
  disable("rifq10slope")
  disable("rifq10RUW")
  disable("rifq10TWaD")
  disable("rifq10flowA")
  disable("rifq10HR")
  disable("rifq10Fr")
  disable("rifq10ImaxVel")
  disable("rifq10DATW4")
  disable("rifq2W")
  disable("rifq2L")
  disable("rifq2H")
  disable("rifq2D50")
  disable("rifq2Pd")
  disable("rifq2WDR")
  disable("rifq2Man")
  disable("rifq2slope")
  disable("rifq2RUW")
  disable("rifq2TWaD")
  disable("rifq2flowA")
  disable("rifq2HR")
  disable("rifq2Fr")
  disable("rifq2ImaxVel")
  disable("rifq2DATW4")
  disable("casq100D50")
  disable("casq100Man")
  disable("casq100slope")
  disable("casq100RUW")
  disable("casq100TWaD")
  disable("casq100flowA")
  disable("casq100HR")
  disable("casq100Fr")
  disable("casq100ImaxVel")
  disable("casq100DATW4")
  disable("casq10W")
  disable("casq10L")
  disable("casq10H")
  disable("casq10D50")
  disable("casq10Pd")
  disable("casq10Man")
  disable("casq10slope")
  disable("casq10RUW")
  disable("casq10TWaD")
  disable("casq10flowA")
  disable("casq10HR")
  disable("casq10Fr")
  disable("casq10ImaxVel")
  disable("casq10DATW4")
  disable("casq2W")
  disable("casq2L")
  disable("casq2H")
  disable("casq2D50")
  disable("casq2Pd")
  disable("casq2Man")
  disable("casq2slope")
  disable("casq2RUW")
  disable("casq2TWaD")
  disable("casq2flowA")
  disable("casq2HR")
  disable("casq2Fr")
  disable("casq2ImaxVel")
  disable("casq2DATW4")
  disable("scDq100desFlow")
  disable("scDHupstreamGrade")
  disable("scDTWupstreamGrade")
  disable("scDKcoeff")
  
  
  
  # look at yes/no for advanced design for riffle sizing
  observeEvent(input$userEnteredDataRiff, {
    if (input$userEnteredDataRiff == "Yes") {
      enable("rifq100H")
      enable("rifq100desDepth")
      enable("rifq100D50")
      enable("rifq100Pd")
      enable("rifq100Man")
    } else {
      disable('rifq100H')
      disable('rifq100desDepth')
      disable('rifq100Pd')
      disable('rifq100Man')
    }
  })
  
  
  ##===========================================================================================================================#
  ##===========================================================================================================================#
  ## #######################################  Input Validator ##################################################################
  ##===========================================================================================================================#
  ##===========================================================================================================================#             
  
  iv <- InputValidator$new()

  iv$add_rule("casq100H", function(value) {
    if (value > 5 &  input$casHeightincrease == "No") {
      print("TRUE")
      message = "Height must be equal to or less than 5 ft"
    }
  })
  
  observeEvent(input$casq100H, {
    if (iv$is_valid()) {
    } else {
      showNotification(
        duration = 20,
        closeButton = TRUE,
        ui = "Height must be equal to or less than 5 ft unless you have permission from BWPR to increase it.",
        type = "error"
      )
    }
  })
 
  
  
  #observeEvent(input$genSize, {
  observe({
    
    #===========================================================
    #----------------------------------------------------------#
    ##################### Riffle Sizing ########################
    #----------------------------------------------------------#
    #===========================================================
    
    # update numbers in table Q100
    # if user values are not entered
    if (input$userEnteredDataRiff == "No") {
      
      
      
      updateNumericInput(session, "rifq100Pd", value = signif(input$rifq100W/input$rifq100WDR,3))
      updateNumericInput(session, "rifq100desDepth", value = input$rifq100Pd)
      
      updateNumericInput(session, "rifq100D50", value = ifelse(input$rifq100desFlow <= 15, 6,
                                                               ifelse(input$rifq100desFlow <= 125, 9,  
                                                                      ifelse(input$rifq100desFlow <= 500, 12, 
                                                                             ifelse(input$rifq100desFlow <= 1500, 18,
                                                                                    ifelse(input$rifq100desFlow <= 2000, 24, NA_real_))))))
      
      updateNumericInput(session, "rifq100Man", value = signif(input$rifq100desDepth^(1/6)/(21.6*log10(input$rifq100desDepth/(input$rifq100D50/12))+14),3))
      
      updateNumericInput(session, "rifq100slope",value = signif(input$rifq100H/input$rifq100L,3))
      updateNumericInput(session, "rifq100TWaD",value = input$rifq100W/(input$rifq100Pd/input$rifq100desDepth)^0.5)
      updateNumericInput(session, "rifq100flowA",value = signif(2/3*input$rifq100desDepth*input$rifq100TWaD,3))
      updateNumericInput(session, "rifq100HR", value = signif(2*input$rifq100TWaD^2*input$rifq100desDepth/(3*input$rifq100TWaD^2+8*input$rifq100desDepth^2),3))
      values$rifq100calcFlwDesDepth <-1.49/input$rifq100Man*input$rifq100flowA*input$rifq100HR^(2/3)*input$rifq100slope^0.5 
      values$rifq100calcVel <- values$rifq100calcFlwDesDepth/input$rifq100flowA
      updateNumericInput(session, "rifq100Fr",value = signif(values$rifq100calcVel/sqrt(32.2*input$rifq100desDepth),3))
      updateNumericInput(session, "rifq100ImaxVel",value = signif(ifelse(input$rifq100Fr<=1,1.2*(2*32.2*(input$rifq100RUW-62.4)/(62.4))^0.5*(input$rifq100D50/12)^0.5,0.86*(2*32.2*(input$rifq100RUW-62.4)/(62.4))^0.5*(input$rifq100D50/12)^0.5),3))
      updateNumericInput(session, "rifq100DATW4",value = 3/4*input$rifq100Pd)
      
    } else {
      
      updateNumericInput(session, "rifq100slope",value = signif(input$rifq100H/input$rifq100L,3))
      updateNumericInput(session, "rifq100TWaD",value = signif(input$rifq100W/(input$rifq100Pd/input$rifq100desDepth)^0.5,3))
      updateNumericInput(session, "rifq100flowA",value = signif(2/3*input$rifq100desDepth*input$rifq100TWaD,3))
      updateNumericInput(session, "rifq100HR", value = signif(2*input$rifq100TWaD^2*input$rifq100desDepth/(3*input$rifq100TWaD^2+8*input$rifq100desDepth^2),3))
      values$rifq100calcFlwDesDepth <-1.49/input$rifq100Man*input$rifq100flowA*input$rifq100HR^(2/3)*input$rifq100slope^0.5 
      values$rifq100calcVel <- values$rifq100calcFlwDesDepth/input$rifq100flowA
      updateNumericInput(session, "rifq100Fr",value = signif(values$rifq100calcVel/sqrt(32.2*input$rifq100desDepth),3))
      updateNumericInput(session, "rifq100ImaxVel",value = signif(ifelse(input$rifq100Fr<=1,1.2*(2*32.2*(input$rifq100RUW-62.4)/(62.4))^0.5*(input$rifq100D50/12)^0.5,0.86*(2*32.2*(input$rifq100RUW-62.4)/(62.4))^0.5*(input$rifq100D50/12)^0.5),3))
      updateNumericInput(session, "rifq100DATW4",value = 3/4*input$rifq100Pd)
      
    }
    
    # update numbers in table Q10
    updateNumericInput(session, "rifq10W", value = input$rifq100W)
    updateNumericInput(session, "rifq10L", value = input$rifq100L)
    updateNumericInput(session, "rifq10H", value = input$rifq100H)
    updateNumericInput(session, "rifq10D50", value = input$rifq100D50)
    updateNumericInput(session, "rifq10Pd", value = input$rifq100Pd) 
    updateNumericInput(session, "rifq10WDR", value = signif(input$rifq10W/input$rifq10Pd,3))
    updateNumericInput(session, "rifq10Man", value = signif(input$rifq10desDepth^(1/6)/(21.6*log10(input$rifq10desDepth/(input$rifq10D50/12))+14),3))
    updateNumericInput(session, "rifq10slope", value = signif(input$rifq10H/input$rifq10L,3)) 
    updateNumericInput(session, "rifq10RUW", value = input$rifq100RUW)
    updateNumericInput(session, "rifq10TWaD", value = signif(input$rifq10W/(input$rifq10Pd/input$rifq10desDepth)^0.5,3))
    updateNumericInput(session, "rifq10flowA", value = signif(2/3*input$rifq10desDepth*input$rifq10TWaD,3))
    updateNumericInput(session, "rifq10HR", value = signif(2*input$rifq10TWaD^2*input$rifq10desDepth/(3*input$rifq10TWaD^2+8*input$rifq10desDepth^2),3))
    values$rifq10calcFlwDesDepth <-1.49/input$rifq10Man*input$rifq10flowA*input$rifq10HR^(2/3)*input$rifq10slope^0.5
    values$rifq10calcVel <- values$rifq10calcFlwDesDepth/input$rifq10flowA
    updateNumericInput(session, "rifq10Fr", value = signif(values$rifq10calcVel/sqrt(32.2*input$rifq10desDepth),3))
    updateNumericInput(session, "rifq10ImaxVel", value = signif(ifelse(input$rifq10Fr<=1,1.2*(2*32.2*(input$rifq10RUW-62.4)/(62.4))^0.5*(input$rifq10D50/12)^0.5,0.86*(2*32.2*(input$rifq10RUW-62.4)/(62.4))^0.5*(input$rifq10D50/12)^0.5),3))
    updateNumericInput(session, "rifq10DATW4", value = 3/4*input$rifq10Pd)
    
    # update numbers in table Q2
    updateNumericInput(session, "rifq2W", value = input$rifq100W)
    updateNumericInput(session, "rifq2L", value = input$rifq100L)
    updateNumericInput(session, "rifq2H", value = input$rifq100H)
    updateNumericInput(session, "rifq2D50", value = input$rifq100D50)
    updateNumericInput(session, "rifq2Pd", value = input$rifq100Pd) 
    updateNumericInput(session, "rifq2WDR", value = signif(input$rifq2W/input$rifq2Pd,3))
    updateNumericInput(session, "rifq2Man", value = signif(input$rifq2desDepth^(1/6)/(21.6*log10(input$rifq2desDepth/(input$rifq2D50/12))+14),3))
    updateNumericInput(session, "rifq2slope", value = signif(input$rifq2H/input$rifq2L,3)) 
    updateNumericInput(session, "rifq2RUW", value = input$rifq100RUW)
    updateNumericInput(session, "rifq2TWaD", value = signif(input$rifq2W/(input$rifq2Pd/input$rifq2desDepth)^0.5,3))
    updateNumericInput(session, "rifq2flowA", value = signif(2/3*input$rifq2desDepth*input$rifq2TWaD,3))
    updateNumericInput(session, "rifq2HR", value = signif(2*input$rifq2TWaD^2*input$rifq2desDepth/(3*input$rifq2TWaD^2+8*input$rifq2desDepth^2),3))
    values$rifq2calcFlwDesDepth <-1.49/input$rifq2Man*input$rifq2flowA*input$rifq2HR^(2/3)*input$rifq2slope^0.5
    values$rifq2calcVel <- values$rifq2calcFlwDesDepth/input$rifq2flowA
    updateNumericInput(session, "rifq2Fr", value = signif(values$rifq2calcVel/sqrt(32.2*input$rifq2desDepth),3))
    updateNumericInput(session, "rifq2ImaxVel", value = signif(ifelse(input$rifq2Fr<=1,1.2*(2*32.2*(input$rifq2RUW-62.4)/(62.4))^0.5*(input$rifq2D50/12)^0.5,0.86*(2*32.2*(input$rifq2RUW-62.4)/(62.4))^0.5*(input$rifq2D50/12)^0.5),3))
    updateNumericInput(session, "rifq2DATW4", value = 3/4*input$rifq2Pd)
    
    values$rifq100adeqConveyance <- ifelse(values$rifq100calcFlwDesDepth>=input$rifq100desFlow,"Yes", "No")
    values$rifq100prVelLessMaxVel <- ifelse(values$rifq10calcVel<input$rifq10ImaxVel,"Yes", "No")
    values$rifq10adeqConveyance <- ifelse(values$rifq100calcFlwDesDepth>=input$rifq100desFlow,"Yes", "No")
    values$rifq10prVelLessMaxVel <- ifelse(values$rifq10calcVel<input$rifq10ImaxVel,"Yes", "No")
    values$rifq2adeqConveyance <- ifelse(values$rifq2calcFlwDesDepth>=input$rifq2desFlow,"Yes", "No")
    values$rifq2prVelLessMaxVel <- ifelse(values$rifq2calcVel<input$rifq2ImaxVel,"Yes", "No")
    
    
    #===========================================================
    #----------------------------------------------------------#
    ##################### Cascade Sizing #######################
    #----------------------------------------------------------#
    #===========================================================
    
    updateNumericInput(session, "casq100slope", value = signif(input$casq100H/input$casq100L,3))
    updateNumericInput(session, "casq100TWaD", value = signif(input$casq100W/(input$casq100Pd/input$casq100desDepth)^0.5,3))
    updateNumericInput(session, "casq100flowA", value = signif(2/3*input$casq100desDepth*input$casq100TWaD,3))
    updateNumericInput(session, "casq100HR", value = signif(2*input$casq100TWaD^2*input$casq100desDepth/(3*input$casq100TWaD^2+8*input$casq100desDepth^2),3))
    values$casq100calcFlwDesDepth <-1.49/input$casq100Man*input$casq100flowA*input$casq100HR^(2/3)*input$casq100slope^0.5
    values$casq100calcVel <- values$casq100calcFlwDesDepth/input$casq100flowA
    updateNumericInput(session, "casq100Fr", value = signif(values$casq100calcVel/sqrt(32.2*input$casq100desDepth),3))
    updateNumericInput(session, "casq100ImaxVel",value = signif(ifelse(input$casq100Fr<=1,1.2*(2*32.2*(input$casq100RUW-62.4)/(62.4))^0.5*(input$casq100D50/12)^0.5,0.86*(2*32.2*(input$casq100RUW-62.4)/(62.4))^0.5*(input$casq100D50/12)^0.5),3))
    updateNumericInput(session, "casq100DATW4",value = 3/4*input$casq100Pd)
    updateNumericInput(session, "casq10W",value = input$casq100W)
    updateNumericInput(session, "casq10L",value = input$casq100L)
    updateNumericInput(session, "casq10H",value = input$casq100H)
    updateNumericInput(session, "casq10Pd",value = input$casq100Pd)
    updateNumericInput(session, "casq10slope", value = signif(input$casq10H/input$casq10L,3))
    updateNumericInput(session, "casq10TWaD", value = signif(input$casq10W/(input$casq10Pd/input$casq10desDepth)^0.5,3))
    updateNumericInput(session, "casq10flowA", value = signif(2/3*input$casq10desDepth*input$casq10TWaD,3))
    updateNumericInput(session, "casq10HR", value = signif(2*input$casq10TWaD^2*input$casq10desDepth/(3*input$casq10TWaD^2+8*input$casq10desDepth^2),3))
    values$casq10calcFlwDesDepth <-1.49/input$casq10Man*input$casq10flowA*input$casq10HR^(2/3)*input$casq10slope^0.5
    values$casq10calcVel <- values$casq10calcFlwDesDepth/input$casq10flowA
    updateNumericInput(session, "casq10Fr", value = signif(values$casq10calcVel/sqrt(32.2*input$casq10desDepth),3))
    updateNumericInput(session, "casq10ImaxVel",value = signif(ifelse(input$casq10Fr<=1,1.2*(2*32.2*(input$casq10RUW-62.4)/(62.4))^0.5*(input$casq10D50/12)^0.5,0.86*(2*32.2*(input$casq10RUW-62.4)/(62.4))^0.5*(input$casq10D50/12)^0.5),3))
    updateNumericInput(session, "casq10DATW4",value = 3/4*input$casq10Pd)
    updateNumericInput(session, "casq2W",value = input$casq100W)
    updateNumericInput(session, "casq2L",value = input$casq100L)
    updateNumericInput(session, "casq2H",value = input$casq100H)
    updateNumericInput(session, "casq2Pd",value = input$casq100Pd)
    updateNumericInput(session, "casq2slope", value = signif(input$casq2H/input$casq2L,3))
    updateNumericInput(session, "casq2TWaD", value = signif(input$casq2W/(input$casq2Pd/input$casq2desDepth)^0.5,3))
    updateNumericInput(session, "casq2flowA", value = signif(2/3*input$casq2desDepth*input$casq2TWaD,3))
    updateNumericInput(session, "casq2HR",value = signif(2*input$casq2TWaD^2*input$casq2desDepth/(3*input$casq2TWaD^2+8*input$casq2desDepth^2),3))
    values$casq2calcFlwDesDepth <-1.49/input$casq2Man*input$casq2flowA*input$casq2HR^(2/3)*input$casq2slope^0.5
    values$casq2calcVel <- values$casq2calcFlwDesDepth/input$casq2flowA
    updateNumericInput(session, "casq2Fr", value = signif(values$casq2calcVel/sqrt(32.2*input$casq2desDepth),3))
    updateNumericInput(session, "casq2ImaxVel",value = signif(ifelse(input$casq2Fr<=1,1.2*(2*32.2*(input$casq2RUW-62.4)/(62.4))^0.5*(input$casq2D50/12)^0.5,0.86*(2*32.2*(input$casq2RUW-62.4)/(62.4))^0.5*(input$casq2D50/12)^0.5),3))
    updateNumericInput(session, "casq2DATW4",value = 3/4*input$casq2Pd)
    updateNumericInput(session, "scDq100desFlow",value = input$casq100desFlow)
    updateNumericInput(session, "scDHupstreamGrade",value = input$casq100H)
    updateNumericInput(session, "scDTWupstreamGrade",value = input$casq100W)
    values$casscourDepth <- input$scDKcoeff*input$scDHupstreamGrade^0.225*(input$scDq100desFlow/input$scDTWupstreamGrade)^0.54-input$scDtydownstructure
    values$caspotscourpoolBot <- values$casscourDepth-input$scDPoolMaxDepthFt
    values$casminFootBoulder <- ifelse(values$caspotscourpoolBot<2,2,values$caspotscourpoolBot+1)
    values$casq100adeqConveyance <- ifelse(values$casq100calcFlwDesDepth>=input$casq100desFlow,"Yes", "No")
    values$casq100prVelLessMaxVel <- ifelse(values$casq10calcVel<input$casq10ImaxVel,"Yes", "No")
    values$casq10adeqConveyance <- ifelse(values$casq100calcFlwDesDepth>=input$casq100desFlow,"Yes", "No")
    values$casq10prVelLessMaxVel <- ifelse(values$casq10calcVel<input$casq10ImaxVel,"Yes", "No")
    values$casq2adeqConveyance <- ifelse(values$casq2calcFlwDesDepth>=input$casq2desFlow,"Yes", "No")
    values$casq2prVelLessMaxVel <- ifelse(values$casq2calcVel<input$casq2ImaxVel,"Yes", "No")
    values$casq100slopecheck <- ifelse(values$casq2calcVel<input$casq2ImaxVel,"Yes", "No")
    values$casq10slopecheck <- ""
    values$casq2slopecheck <- ""
  })
  
  riff_table <- reactive({
    riff_table <- tibble("Value" = c("Calculated Flow at Design Depth (cfs)", "Calculated Velocity (ft/s)", "Does the proposed section provide adequate conveyance?", "Is the proposed velocity less than the maximum allowable velocity?"),
                         "Q100" = c(round(values$rifq100calcFlwDesDepth,2),round(values$rifq100calcVel,2),values$rifq100adeqConveyance,values$rifq100prVelLessMaxVel),
                         "Q10" = c(round(values$rifq10calcFlwDesDepth,2),round(values$rifq10calcVel,2),values$rifq10adeqConveyance,values$rifq10prVelLessMaxVel),
                         "Q2" = c(round(values$rifq2calcFlwDesDepth,2),round(values$rifq2calcVel,2),values$rifq2adeqConveyance,values$rifq2prVelLessMaxVel)) %>%  
      mutate(Q100_col = 0,
             Q10_col = 0,
             Q2_col = 0)
    
    riff_table[1,"Q100_col"] <- ifelse(values$rifq100calcFlwDesDepth >= input$rifq100desFlow, 1,2)   
    riff_table[1,"Q10_col"] <- ifelse(values$rifq10calcFlwDesDepth >= input$rifq10desFlow, 1,2) 
    riff_table[1,"Q2_col"] <- ifelse(values$rifq2calcFlwDesDepth >= input$rifq2desFlow, 1,2) 
    
    riff_table[2,"Q100_col"] <- ifelse(values$rifq100calcVel <= input$rifq100ImaxVel, 1,2) 
    riff_table[2,"Q10_col"] <- ifelse(values$rifq10calcVel <= input$rifq10ImaxVel, 1,2) 
    riff_table[2,"Q2_col"] <- ifelse(values$rifq2calcVel <= input$rifq2ImaxVel, 1,2) 
    
    riff_table[3,"Q100_col"] <- ifelse(values$rifq100adeqConveyance == "Yes", 1,2) 
    riff_table[3,"Q10_col"] <- ifelse(values$rifq10adeqConveyance == "Yes", 1,2) 
    riff_table[3,"Q2_col"] <- ifelse(values$rifq2adeqConveyance == "Yes", 1,2) 
    
    riff_table[4,"Q100_col"] <- ifelse(values$rifq100prVelLessMaxVel == "Yes", 1,2) 
    riff_table[4,"Q10_col"] <- ifelse(values$rifq10prVelLessMaxVel == "Yes", 1,2) 
    riff_table[4,"Q2_col"] <- ifelse(values$rifq2prVelLessMaxVel == "Yes", 1,2) 
    
    return(riff_table)
    print(riff_table)
  })
  
  
  output$riff_output<-renderDataTable({
    datatable(riff_table(), selection = 'none', options = list(dom='t',ordering=FALSE, searching = FALSE,initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'font-size': '20px'});",
      "}"), columnDefs = list(list(targets = c(4,5,6), visible = FALSE))), colnames = c("", "Q<sub>100</sub>","Q<sub>10</sub>","Q<sub>2</sub>"), rownames=FALSE, escape = FALSE)%>%
      formatStyle(columns = "Q100",
                  valueColumns = "Q100_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))%>%
      formatStyle(columns = "Q10",
                  valueColumns = "Q10_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))%>%
      formatStyle(columns = "Q2",
                  valueColumns = "Q2_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))   
  })
  
  
  riff_table2 <- reactive({
    riff_table2 <- tibble("Value" = c("Width Depth Ratio note:", "Parabolic Depth note:"),
                          "Result" = c(ifelse(input$rifq100WDR<=10,"W/D <= 10, Note: Designers are encouraged to customize results to site specific dimensions. In general, the County prefers a width-depth ratio greater than 10 when site conditions allow.", "Width-Depth ratio is greater than 10 (recommended)."),
                                       ifelse(input$rifq100Pd>2,"PD>2.0, Note: Designers are strongly encouraged to customize results to site specific dimensions. Parabolic depths exceeding 2.0 feet are discouraged as excessively high berms may be required to tie-in structures. Consider increasing W/D ratio.","Parabolic depth is less than 2 feet (recommended)."))) %>%  
      mutate(col = 0)
    
    riff_table2[1,"col"] <- ifelse(input$rifq100WDR<=10, 2,1)   
    riff_table2[2,"col"] <- ifelse(input$rifq100Pd>2, 2,1) 
    
    
    return(riff_table2)
    print(riff_table2)
  })
  
  
  output$riff_output2<-renderDataTable({
    datatable(riff_table2(), selection = 'none', options = list(dom='t',ordering=FALSE, searching = FALSE,initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'font-size': '20px'});",
      "}"),columnDefs = list(list(targets = c(2), visible = FALSE))),
      colnames = c("","",""), rownames=FALSE, escape = FALSE)%>%
      formatStyle(columns = "Result",
                  valueColumns = "col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))
    
  })
  
  cas_table <- reactive({
    cas_table <- tibble("Value" = c("Calculated Flow at Design Depth (cfs)", "Calculated Velocity (ft/s)", "Does the proposed section provide adequate conveyance?", "Is the proposed velocity less than the maximum allowable velocity?", "Does the proposed cascade have a slope of <= 0.5 ft/ft?"),
                        "Q100" = c(round(values$casq100calcFlwDesDepth,2),round(values$casq100calcVel,2),values$casq100adeqConveyance,values$casq100prVelLessMaxVel,values$casq100slopecheck),
                        "Q10" = c(round(values$casq10calcFlwDesDepth,2),round(values$casq10calcVel,2),values$casq10adeqConveyance,values$casq10prVelLessMaxVel,values$casq10slopecheck),
                        "Q2" = c(round(values$casq2calcFlwDesDepth,2),round(values$casq2calcVel,2),values$casq2adeqConveyance,values$casq2prVelLessMaxVel,values$casq2slopecheck)) %>%  
      mutate(Q100_col = 0,
             Q10_col = 0,
             Q2_col = 0)
    
    cas_table[1,"Q100_col"] <- ifelse(values$casq100calcFlwDesDepth >= input$casq100desFlow, 1,2)   
    cas_table[1,"Q10_col"] <- ifelse(values$casq10calcFlwDesDepth >= input$casq10desFlow, 1,2) 
    cas_table[1,"Q2_col"] <- ifelse(values$casq2calcFlwDesDepth >= input$casq2desFlow, 1,2) 
    
    cas_table[2,"Q100_col"] <- ifelse(values$casq100calcVel <= input$casq100ImaxVel, 1,2) 
    cas_table[2,"Q10_col"] <- ifelse(values$casq10calcVel <= input$casq10ImaxVel, 1,2) 
    cas_table[2,"Q2_col"] <- ifelse(values$casq2calcVel <= input$casq2ImaxVel, 1,2) 
    
    cas_table[3,"Q100_col"] <- ifelse(values$casq100adeqConveyance == "Yes", 1,2) 
    cas_table[3,"Q10_col"] <- ifelse(values$casq10adeqConveyance == "Yes", 1,2) 
    cas_table[3,"Q2_col"] <- ifelse(values$casq2adeqConveyance == "Yes", 1,2) 
    
    cas_table[4,"Q100_col"] <- ifelse(values$casq100prVelLessMaxVel == "Yes", 1,2) 
    cas_table[4,"Q10_col"] <- ifelse(values$casq10prVelLessMaxVel == "Yes", 1,2) 
    cas_table[4,"Q2_col"] <- ifelse(values$casq2prVelLessMaxVel == "Yes", 1,2) 
    
    cas_table[5,"Q100_col"] <- ifelse(values$casq100slopecheck == "Yes", 1,2) 
    cas_table[5,"Q10_col"] <- 0 
    cas_table[5,"Q2_col"] <- 0 
    
    return(cas_table)
    print(cas_table)
  })
  
  
  output$cas_output<-renderDataTable({
    datatable(cas_table(), selection = 'none', options = list(dom='t',ordering=FALSE, searching = FALSE,initComplete = JS(
      "function(settings, json) {",
      "$(this.api().table().header()).css({'font-size': '20px'});",
      "}"), columnDefs = list(list(targets = c(4,5,6), visible = FALSE))), colnames = c("", "Q<sub>100</sub>","Q<sub>10</sub>","Q<sub>2</sub>"), rownames=FALSE, escape = FALSE)%>%
      formatStyle(columns = "Q100",
                  valueColumns = "Q100_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))%>%
      formatStyle(columns = "Q10",
                  valueColumns = "Q10_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))%>%
      formatStyle(columns = "Q2",
                  valueColumns = "Q2_col",
                  backgroundColor = styleEqual(levels = c(0,1,2), values = c(NA,"#b1e0ba","#e0b1b1")))   
  })
  
  
  cas_table2 <- reactive({
    cas_table2 <- tibble("Value" = c("P<sub>d</sub>, Calculated scour depth, ft", "Potential depth of scour below design pool bottom, ft", "Minimum footer boulder depth below pool bottom, ft"),
                         "Result" = c(values$casscourDepth,
                                      values$caspotscourpoolBot,
                                      values$casminFootBoulder)) 
    
    return(cas_table2)
    print(cas_table2)
  })
  
  
  output$cas_output2<-renderDataTable({
    datatable(cas_table2(), selection = 'none', options = list(dom='t',ordering=FALSE, searching = FALSE),
              colnames = c("",""), rownames=FALSE, escape = FALSE)
  })
  
  
  riff_tableOutput1 <- reactive({
    
    riff_tableOutput1 <- tibble(
      "Value"=c("Design Flow (cfs)","Width (ft)","L, Length (ft)","H, Height (ft)","Design Depth of flow (ft)",
                "D50 (in)",paste0("<b>","P",tags$sub("D"), ", Parabolic Depth (ft)","</b>"), 
                paste0("<b>","Width Depth Ratio (W/P",tags$sub("D"),")","</b>"),"Manning's n Value",
                "Slope (ft/ft)","Rock Unit Weight (lbs/cf)","Top Width at Depth","Flow area (sf)",
                "Hydraulic Radius","Froude Number","Isbash Maximum Velocity (ft/s)","Depth ('A') at TW/4 offset from centerline"),
      "Q100"=c(input$rifq100desFlow,input$rifq100W,input$rifq100L,input$rifq100H,
               input$rifq100desDepth,input$rifq100D50,input$rifq100Pd,input$rifq100WDR,
               input$rifq100Man,input$rifq100slope,input$rifq100RUW,input$rifq100TWaD,
               input$rifq100flowA,input$rifq100HR,input$rifq100Fr,input$rifq100ImaxVel,input$rifq100DATW4),
      "Q10"=c(input$rifq10desFlow,input$rifq10W,input$rifq10L,input$rifq10H,input$rifq10desDepth,
              input$rifq10D50,input$rifq10Pd,input$rifq10WDR,input$rifq10Man,input$rifq10slope,
              input$rifq10RUW,input$rifq10TWaD,input$rifq10flowA,input$rifq10HR,input$rifq10Fr,
              input$rifq10ImaxVel,input$rifq10DATW4),
      "Q2"=c(input$rifq2desFlow,input$rifq2W,input$rifq2L,input$rifq2H,input$rifq2desDepth,
             input$rifq2D50,input$rifq2Pd,input$rifq2WDR,input$rifq2Man,input$rifq2slope,
             input$rifq2RUW,input$rifq2TWaD,input$rifq2flowA,input$rifq2HR,input$rifq2Fr,
             input$rifq2ImaxVel,input$rifq2DATW4)
    )
    return(riff_tableOutput1)
    
  })
  
  riff_tableOutput2 <- reactive({
    riff_tableOutput2 <- tibble("Value" = c("Calculated Flow at Design Depth (cfs)", "Calculated Velocity (ft/s)", "Does the proposed section provide adequate conveyance?", "Is the proposed velocity less than the maximum allowable velocity?"),
                                "Q100" = c(round(values$rifq100calcFlwDesDepth,2),round(values$rifq100calcVel,2),values$rifq100adeqConveyance,values$rifq100prVelLessMaxVel),
                                "Q10" = c(round(values$rifq10calcFlwDesDepth,2),round(values$rifq10calcVel,2),values$rifq10adeqConveyance,values$rifq10prVelLessMaxVel),
                                "Q2" = c(round(values$rifq2calcFlwDesDepth,2),round(values$rifq2calcVel,2),values$rifq2adeqConveyance,values$rifq2prVelLessMaxVel))  

    return(riff_tableOutput2)
    
  })
  
  riff_tableOutput3 <- reactive({
    
    riff_tableOutput3 <- tibble("Value" = c("Width Depth Ratio note:", "Parabolic Depth note:"),
                                "Result" = c(ifelse(input$rifq100WDR<=10,"W/D <= 10, Note: Designers are encouraged to customize results to site specific dimensions. In general, the County prefers a width-depth ratio greater than 10 when site conditions allow.", "Width-Depth ratio is greater than 10 (recommended)."),
                                             ifelse(input$rifq100Pd>2,"PD>2.0, Note: Designers are strongly encouraged to customize results to site specific dimensions. Parabolic depths exceeding 2.0 feet are discouraged as excessively high berms may be required to tie-in structures. Consider increasing W/D ratio.","Parabolic depth is less than 2 feet (recommended).")))  
    return(riff_tableOutput3)
    
  })
  
  
  
  
  cas_tableOutput1 <- reactive({
    
    cas_tableOutput1 <- tibble(
      "Value"=c("Design Flow (cfs)","Width (ft)","L, Length (ft)","H, Height (ft)","Design Depth of flow (ft)",
                "D50 (in)",paste0("<b>","P",tags$sub("D"), ", Parabolic Depth (ft)","</b>"), "Manning's n Value",
                "Slope (ft/ft)","Rock Unit Weight (lbs/cf)","Top Width at Depth","Flow area (sf)","Hydraulic Radius",
                "Froude Number","Isbash Maximum Velocity (ft/s)","Depth ('A') at TW/4 offset from centerline"),
      "Q100"=c(input$casq100desFlow,input$casq100W,input$casq100L,input$casq100H,input$casq100desDepth,
               input$casq100D50,input$casq100Pd,input$casq100Man,input$casq100slope,input$casq100RUW,
               input$casq100TWaD,input$casq100flowA,input$casq100HR,input$casq100Fr,input$casq100ImaxVel,input$casq100DATW4),
      "Q10"=c(input$casq10desFlow,input$casq10W,input$casq10L,input$casq10H,input$casq10desDepth,input$casq10D50,
              input$casq10Pd,input$casq10Man,input$casq10slope,input$casq10RUW,input$casq10TWaD,input$casq10flowA,
              input$casq10HR,input$casq10Fr,input$casq10ImaxVel,input$casq10DATW4),
      "Q2"=c(input$casq2desFlow,input$casq2W,input$casq2L,input$casq2H,input$casq2desDepth,input$casq2D50,
             input$casq2Pd,input$casq2Man,input$casq2slope,input$casq2RUW,input$casq2TWaD,
             input$casq2flowA,input$casq2HR,input$casq2Fr,input$casq2ImaxVel,input$casq2DATW4)
    )
    
    return(cas_tableOutput1)
    
  })
  
  cas_tableOutput2 <- reactive({
    
    cas_tableOutput2 <- tibble(
      "Value"=c(paste0("<b>","Q",tags$sub("100"), ", cfs","</b>"), "Pool Max Depth (ft)", "H, Height of upstream grade control structure (ft)","TW, Top width of the upstream grade control structure (ft)", 
                paste0("<b>","y, depth of Q",tags$sub("100"), " in downstream/receiving structure","</b>"), "K, coefficient"),
      "Scour Values"=c(input$scDq100desFlow,input$scDPoolMaxDepthFt,input$scDHupstreamGrade,
                       input$scDTWupstreamGrade,input$scDtydownstructure,input$scDKcoeff)
    )
    return(cas_tableOutput2)
    
  })
  
  cas_tableOutput3 <- reactive({
    
    cas_tableOutput3 <- tibble("Value" = c("Calculated Flow at Design Depth (cfs)", "Calculated Velocity (ft/s)", "Does the proposed section provide adequate conveyance?", "Is the proposed velocity less than the maximum allowable velocity?", "Does the proposed cascade have a slope of <= 0.5 ft/ft?"),
                               "Q100" = c(round(values$casq100calcFlwDesDepth,2),round(values$casq100calcVel,2),values$casq100adeqConveyance,values$casq100prVelLessMaxVel,values$casq100slopecheck),
                               "Q10" = c(round(values$casq10calcFlwDesDepth,2),round(values$casq10calcVel,2),values$casq10adeqConveyance,values$casq10prVelLessMaxVel,values$casq10slopecheck),
                               "Q2" = c(round(values$casq2calcFlwDesDepth,2),round(values$casq2calcVel,2),values$casq2adeqConveyance,values$casq2prVelLessMaxVel,values$casq2slopecheck))
    return(cas_tableOutput3)
    
  })
  
  cas_tableOutput4 <- reactive({
    
    cas_tableOutput4 <- tibble("Value" = c("P<sub>d</sub>, Calculated scour depth, ft", "Potential depth of scour below design pool bottom, ft", "Minimum footer boulder depth below pool bottom, ft"),
                               "Result" = c(values$casscourDepth,
                                            values$caspotscourpoolBot,
                                            values$casminFootBoulder)) 
    return(cas_tableOutput4)
    
  })
  
  #================================
  # ------------ Download Report 
  #================================ 
  
  #output$rifReport <- downloadHandler(
  #  # name pdf output here
  #  filename = function() {
  #    paste(paste0('SPSCRiffleSizingReport_',Sys.Date()), sep = '.', PDF = 'pdf')
  #  },
  #  content = function(file) {
  #    tempReport <- file.path(tempdir(), "rifflereport.Rmd")
  #    tempimage <- file.path(tempdir(), "bwpr_logo_aarivers.jpg")
  #    file.copy("rifflereport.Rmd", tempReport, overwrite = TRUE)
  #    file.copy("bwpr_logo_aarivers.jpg", tempimage, overwrite = TRUE)
  #    # Set up parameters to pass to Rmd document
  #    params <- list(sitename=input$rifreportName,
  #                   tab1=riff_tableOutput1(),
  #                   tab2=riff_tableOutput2(),
  #                   tab3=riff_tableOutput3())
  #    
  #    # Knit the document, passing in the `params` list
  #    rmarkdown::render(tempReport, output_file = file,
  #                      params = params,
  #                      envir = new.env(parent = globalenv(),pdf_document())
  #    )
  #  }
  #)
  
  output$rifReport <- downloadHandler(
    filename = function() {
      paste(paste0('SPSCRiffleSizingReport_',Sys.Date()), sep = '.', PDF = 'pdf')
    },
    
    content = function(file) {
      src <- normalizePath('rifflereport.Rmd')
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'rifflereport.Rmd', overwrite = TRUE)
      #Set up parameters to pass to Rmd document
      param <- list(sitename=input$rifreportName,
                     tab1=riff_tableOutput1(),
                     tab2=riff_tableOutput2(),
                     tab3=riff_tableOutput3())
      
      out <- render('rifflereport.Rmd', params = param,pdf_document())
      file.rename(out, file)
    }
  )
  
  output$casReport <- downloadHandler(
    filename = function() {
      paste(paste0('SPSCCascadeSizingReport_',Sys.Date()), sep = '.', PDF = 'pdf')
    },
    
    content = function(file) {
      src <- normalizePath('cascadereport.Rmd')
      
      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'cascadereport.Rmd', overwrite = TRUE)
      #Set up parameters to pass to Rmd document
      param <- list(sitename=input$casreportName,
                    tab1=cas_tableOutput1(),
                    tab2=cas_tableOutput2(),
                    tab3=cas_tableOutput3(),
                    tab4=cas_tableOutput4())
      
      out <- render('cascadereport.Rmd', param = param,pdf_document())
      file.rename(out, file)
    }
  )
  
  #output$casReport <- downloadHandler(
  #  # name pdf output here
  #  filename = function() {
  #    paste(paste0('SPSCCascadeSizingReport_',Sys.Date()), sep = '.', PDF = 'pdf')
  #  },
  #  content = function(file) {
  #    tempReport <- file.path(tempdir(), "cascadereport.Rmd")
  #    tempimage <- file.path(tempdir(), "bwpr_logo_aarivers.jpg")
  #    file.copy("cascadereport.Rmd", tempReport, overwrite = TRUE)
  #    file.copy("bwpr_logo_aarivers.jpg", tempimage, overwrite = TRUE)
  #    # Set up parameters to pass to Rmd document
  #    params <- list(sitename=input$casreportName,
  #                   tab1=cas_tableOutput1(),
  #                   tab2=cas_tableOutput2(),
  #                   tab3=cas_tableOutput3(),
  #                   tab4=cas_tableOutput4())
  #    
  #    # Knit the document, passing in the `params` list
  #    rmarkdown::render(tempReport, output_file = file,
  #                      params = params,
  #                      envir = new.env(parent = globalenv(),pdf_document())
  #    )
  #  }
  #)
  
  
}
