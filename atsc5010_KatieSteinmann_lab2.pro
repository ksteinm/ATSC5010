; Katie Steinmann
; Lab 2
; ATSC 5010 - Physical Meteorology
; September 21, 2021

; Tim and Morgan helped me with the Read_Sounding function 
; Part 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Create a function to read in the sounding data
FUNCTION Read_Sounding, File ; The file name must be provided when the function is called
  Data = READ_CSV(File) ; Reads the CSV file containing the sounding information
  RETURN, Data ; The function returns the data from the sounding
END

; Part 1 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; Create a procedure
PRO atsc5010_KatieSteinmann_lab2
  ; Part 3 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Call the phycon procedure
  phycon ; Calls the procedure phycon, which is a file provided by Jeff containing meteorological constants
  ; Part 2 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Create pressure, temperature, and height variables
  File = DIALOG_PICKFILE(FILTER='*.csv') ; Finds the correct CSV file
  Variables = Read_Sounding(File) ; Calls the function that reads in the data from the sounding file
  ; Tim helped me read in the variables
  Pressure = DOUBLE(Variables.Field02) ; in hPa, Creates a variable pressure from the 2nd data column from the sounding file
  Temperature = DOUBLE(Variables.Field03) ; in degrees C, Creates a variable temperature from the 3rd data column from the sounding file
  Height = Double(Variables.Field09) ; in meters, Creates a variable height from the 9th data column from the sounding file
  
  ; Part 4 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Find the height of each layer assuming an isothermal atmosphere
  Size = N_ELEMENTS(Pressure) ; Finding the size of the variables
  P_O = Pressure[0] ; Setting the initial pressure to the first element in the pressure array
  Z_O = Height[0] ; Setting the initial height to the first element in the height array
  T = Temperature[0] + 273.15 ; Setting the initial temperature to the first element in the temperature array, Converting temperature into Kelvin
  Calc_Height_Iso = DBLARR(Size) ; Creating an array for the calculated height
  
  ; Chris and August helped me with this for loop
  ; Start of the for loop -------------------------------------------------------
  FOR I=0,Size-1 DO BEGIN
    Calc_Height_Iso[I] = Z_O + ((!Rd * T) / !Grav) * (ALOG(P_O/Pressure[I])) ; Calculation provided in the lab, Height = the initial height + (R*Temp)/Gravity * ln(initial pressure/current pressure)
  END
  ; End of the for loop ----------------------------------------------------------
  
  ; Part 5 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Find the height of each layer using an expilict model
  Calc_Height_Ex = DBLARR(Size) ; Creating an array for the calculated height
  
  ; Chris and August helped me with this for loop
  ; Start of for loop -------------------------------------------------
  FOR I=0, Size-1 DO BEGIN
    ; Start of if statement ---------------------------------------
    IF (I EQ 0) THEN BEGIN
      Calc_Height_Ex[I] = Height[I] ; The calculated height is equal to the measured height for the first element
    ENDIF ELSE BEGIN
    T1 = Temperature[I-1] + 273.15 ; Converting temperature into Kelvin
    T2 = Temperature[I] + 273.15 ; Converting temperature into Kelvin
    T_Avg = (T1 + T2) / 2 ; Calculating the average temperature
    P_Avg = (Pressure[I-1] + Pressure[I]) / 2; Calculating the average pressure
    Calc_Height_Ex[I] = Calc_Height_Ex[I-1] + (((!Rd / !Grav) * T_Avg) * (1 / P_Avg) * (Pressure[I-1] - Pressure[I])); Calculation provided in the lab
    ENDELSE
    ; End if statement -------------------------------------------------------------------------------------------------
  ENDFOR
  ; End for loop -----------------------------------------------------------------------------------------
  
  ; Part 6 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Plot the computed isothermal height with the measured pressure
  Calc_Height_Iso_Km = Calc_Height_Iso / 1000 ; Converting the computed height into Km
  Calc_Height_Ex_Km = Calc_Height_Ex / 1000 ; Converting the computed height into Km
  p1 = plot(Pressure, Calc_Height_Iso_Km, COLOR = 'red', name='Isothermal', dimensions=[1200, 900], XRANGE=[1000,0], XTITLE='Pressure (mb)', XTICKFONT_SIZE=12, YTITLE='Height (Km)', YTICKFONT_SIZE=12, TITLE='Computed Height', FONT_SIZE=12)
  
  ; Part 7 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Plot the computed explicit height with the measured pressure
  p2 = plot(Pressure, Calc_Height_Ex_Km, COLOR='blue', LINESTYLE='--', NAME='Explicit', /overplot)
  L1 = LEGEND(TARGET=[p1,p2], POSITION=[200,25], /DATA, /AUTO_TEXT_COLOR, FONT_SIZE=12)
  
  ; Part 8 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Plot the computed isothermal and explicit heights with the measured height
  Height_Km = Height / 1000
  p3 = plot(Height_Km, Calc_Height_Iso_Km, COLOR='red', name='Isothermal', DIMENSIONS=[1200,900], XTITLE='Measured Height (Km)', XTICKFONT_SIZE=12, YTITLE='Computed Height (Km)', YTICKFONT_SIZE=12, TITLE='Computed vs. Measured Height', FONT_SIZE=12)
  p4 = plot(Height_Km, Calc_Height_Ex_Km, COLOR='blue', LINESTYLE='--', THICK=2, NAME='Explicit', /OVERPLOT)
  L2 = LEGEND(TARGET=[p3,p4], POSITION=[10,25], /DATA, /AUTO_TEXT_COLOR, FONT_SIZE=12)
  
  ; Part 9 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ; Plot the difference between the computed heights and the measured heights with the measured heights
  Iso_Dif = Calc_Height_Iso_Km - Height_Km ; Calculating the difference between the computed isothermal height and the measured height
  Ex_Dif = Calc_Height_Ex_Km - Height_Km ; Calculating the difference between the computed explicit height and the measured height
  p5 = plot(Height_Km, Iso_Dif, COLOR='red', NAME='Isothermal', DIMENSIONS=[1200,900], XTITLE='Measured Height (Km)', XTICKFONT_SIZE=12, YTITLE='Computed Height Minus Measured Height (Km)', YTICKFONT_SIZE = 12, TITLE='Defference Between Computed Height and Measured Height', FONT_SIZE=12)
  p6 = plot(Height_Km, Ex_Dif, COLOR='blue', LINESTYLE='--', NAME='Explicit', /OVERPLOT)
  L3 = LEGEND(TARGET=[p5,p6], POSITION=[10,4], /DATA, /AUTO_TEXT_COLOR, FONT_SIZE=12)
END
