; Katie Steinmann
; Lab 3
; ATSC 5010 - Physical Meteorology
; October 4, 2021


PRO atsc5010_KatieSteinmann_lab3
; Part 2 =============================================================================================
  ; Creating a 1-D array for temperature values between -30 degrees C and +30 degrees C by 0.1 degrees C
  T = [-30: 30: 0.1]
  ; Creating a double precision array
  Temperature = DOUBLE(T)
  ; Converting temperature units into Kelvin for the equation
  ; Temperature (in Kelvin) = Temperature (in degrees C) + 273.15
  Kelvin = Temperature + 273.154
  ; Creating a 1-D array for pressure values between 200mb and 1000 mb by 1 mb
  P = [200:1000:1]
  ; Creating a double precision array
  Pressure = DOUBLE(P)
  ; Converting pressure units from hPa to Pa for the equation
  ; Pressure (in Pa) = Pressure (in hPa) * 100
  Pascal = Pressure * 100
  
  ; Part 3 ===================================================================================================
  ; Creating a double precision 2-D variable for the theta data that is equal to the number of elements of temperature array (first dimension) and the number of elements in the pressure array (second dimension)
  Theta = DBLARR(N_ELEMENTS(Temperature), N_ELEMENTS(Pressure))
  ; K is a constant that represents R/Cp for dry air
  ; This information was found in the class textbook on page 262
  ; K is unitless
  K = 0.2854
  ; Creating a constant variable for the initial pressure in Pa
  P_o = 100000
  ; For loop to calculate potential temperature
  ; Goes through all the elements in the temperature array
  FOR i = 0, N_ELEMENTS(Kelvin)-1 DO BEGIN
    ; Goes through all the elements in the pressure array
    FOR j = 0, N_ELEMENTS(Pascal)-1 DO BEGIN
      ; Calculates potential temperature
      ; Potential temperature (in Kelvin) = Temperature (in Kelvin) * [Initial pressure (in Pa) / Pressure(in Pa)]^ K
      Theta[i,j]= Kelvin[i]*((P_o/Pascal[j])^k)
    ENDFOR
  ENDFOR
  
  ; Part 4
  ; Creating an array specify the number of levels needed for the plot
  Level = abs((470-250)/10)
  ; Creating an array the specify the contour labels
  ContourLabel = [260:460:20]
  ; Plot
  ; Brandon Lopez helped me with part of the plotting
  p1 = CONTOUR(/YLOG, Theta, Temperature, Pressure, MAX_VALUE=470, MIN_VALUE=250, N_LEVELS=[Level], C_LABEL_SHOW= [0, 1, 0, 1], COLOR='green', DIMENSIONS=[800,900], XRANGE=[-30,30], XTITLE='$Temperature (\deg C)$', XTICKFONT_SIZE = 12, XTICKINTERVAL=10, XGRIDSTYLE=[1,100], XTICKLEN=1, XSUBTICKLEN=0.01, XMAJOR=7, XMINOR=1, YRANGE=[1000,200], YTICKVALUES=[1000, 900, 800, 700, 600, 500, 400, 300, 200], YTITLE='Pressure (mb)', YTICKFONT_SIZE=12, YGRIDSTYLE=[1,100], YTICKLEN=1, YSUBTICKLEN=0.01, TITLE = 'ATSC 5010 Steinmann, Lab 3: Emagram', FONT_SIZE=12)
  ; I did have trouble including the 250 potential temperature contour and the 470 potential contour
  ; When I tried to include them, the contour lines were not correct.
END