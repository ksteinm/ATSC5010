PRO atsc5010_Lab1b_solution, lwc_cdp, lwc_pvm, n_cdp, n_fssp, wwind
    ; written by Jeff Nivitanont, 2021.
    
    ;restore, './atsc5010_Lab1.idlsav'

    ind10 = dindgen(1001)/1001.*10.-5.
    ind25 = dindgen(2501)/2501.*10.-5.
    ;plot 1
    p1 = plot(ind10, lwc_pvm, color='green', name='PVM', dimensions=[1200, 900], layout=[1,3,1])
    p2 = plot(ind10, lwc_cdp, color='red', /overplot, name='CDP')
    p1.yrange = [0., 3.]
    p1.xrange = [-5., 5.]
    p1.title = 'Liquid water content'
    p1.xtitle = 'distance from cloud center'
    p1.ytitle = 'liquid water content (g $m^{-3}$)'
    l1 = legend(target=[p1, p2], position=[-3., max([lwc_pvm, lwc_cdp])], /data, /auto_text_color)
    ;plot 2
    p3 = plot(ind10, n_fssp, color='cyan', name='FSSP', layout=[1,3,2], /current)
    p4 = plot(ind10, n_cdp, color='red', name='CDP', /overplot)
    p3.xrange = [-5., 5.]
    p3.ytitle = 'number concentration'
    p3.xtitle = 'distance from cloud center'
    p3.title = 'Number concentration'
    l3 = legend(target=[p3, p4], position=[3., max([n_fssp, n_cdp])], /data, /auto_text_color)
    ;plot 3
    smoothed = smooth(wwind, 25) ;25 points/sec
    high = where(smoothed gt 12) ;get indices > 12
    below0 = replicate(!values.f_nan, 2501)
    below0[high] = smoothed[high]
    p5 = plot(ind25, wwind, color='red', layout=[1,3,3], /current)
    p6 = plot(ind25, smoothed, color='blue', /overplot, thick=2)
    p7 = plot(ind25, below0, color='green', /overplot, thick=3)
    p8 = plot(ind25, fltarr(2501), color='black', linestyle='--', thick=2, /overplot)
    p5.yrange = [-10., 20.]
    p5.xrange = [-5., 5]
    p5.title = 'Vertical velocity'
    p5.xtitle = 'distance from cloud center'
    p5.ytitle = 'vertical velocity'
    ;save plot
    p1.save, 'lab1b.png'

    ;more plots (LWC)
    figsize=[600, 600]
    pass = where((lwc_pvm gt 0.02) and (lwc_cdp gt 0.02))
    p9 = scatterplot(lwc_cdp[pass], lwc_pvm[pass], symbol='D', sym_color='red', sym_size=.7, /sym_filled, dimensions=figsize)
    prange = [0., 2.5]
    p9.yrange = prange
    p9.xrange = prange
    p10 = plot(prange, prange, color='k', thick=2, /overplot, name='Y=X')
    ;lsquares line
    fitted = linfit(lwc_cdp[pass], lwc_pvm[pass])
    y = fitted[0] + prange*fitted[1]
    p11 = plot(prange, y, color='red', thick=4, /overplot, name='Lsq.')
    rho = correlate(lwc_cdp[pass], lwc_pvm[pass])
    t1 = text(.2, .8, '$\rho$='+string(rho))
    p11.title = 'Liquid water content (g $m^{-3}$)'
    p11.ytitle = 'PVM'
    p11.xtitle = 'CDP'
    l11 = legend(target=[p10,p11], position=[.9, .3])
    p11.save, 'lab1b_lwc_pvm-cdp.png'

    ;more plots (# drops)
    figsize=[600, 600]
    pass = where((n_cdp gt 1.) and (n_fssp gt 1.))
    p12 = scatterplot(n_fssp[pass], n_cdp[pass], symbol='D', sym_color='red', sym_size=.7, /sym_filled, dimensions=figsize)
    prange = [0., 400.]
    p12.yrange = prange
    p12.xrange = prange
    p13 = plot(prange, prange, color='k', thick=2, /overplot, name='Y=X')
    ;lsquares line
    fitted = linfit(n_fssp[pass], n_cdp[pass])
    y = fitted[0] + prange*fitted[1] ;get y-coords
    p14 = plot(prange, y, color='red', thick=4, /overplot, name='Lsq.')
    rho = correlate(n_fssp[pass], n_cdp[pass])
    t1 = text(.2, .8, '$\rho$='+string(rho)) ;add text using device coords
    p14.title = 'Number concentration'
    p14.xtitle = 'FSSP'
    p14.ytitle = 'CDP'
    l14 = legend(target=[p13,p14], position=[.9, .3])
    p14.save, 'lab1b_nd_fssp-cdp.png'
RETURN
END
