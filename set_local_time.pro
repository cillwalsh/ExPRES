; ***********************************
; *                                 *
; *   Routines de simulation JUNO   *
; *                                 *
; ***********************************
; S. Hess (9/2006), P. Zarka (10/2006), B. Cecconi (10/2006)


; ------------------------------------------------------------------------------------
  pro SET_LOCAL_TIME, longitude=t1, inclination=t2, parameters=p
; ------------------------------------------------------------------------------------

  p.local_time=[t1,t2]

return
end
