; ***********************************
; *                                 *
; *   Routines de simulation JUNO   *
; *                                 *
; ***********************************
; S. Hess (9/2006), P. Zarka (10/2006), B. Cecconi (10/2006)


; ------------------------------------------------------------------------------------
  pro CALC_ORBITE, orb, rpd,p
; ------------------------------------------------------------------------------------
; orb = see PRO orb_obs_param__define in set_observer.pro
; p= see PRO JUNO_PARAMETERS__DEFINE
; angles in RADIANS !!!!!

  n_steps_orb = 3600
  step_orb = 2.*!pi/n_steps_orb

; rpd = radius, phi, dphi/dt
  rpd=fltarr(3,n_steps_orb)
; repere x=grand axe, y=petit axe, foyer=origine
  alpha=findgen(n_steps_orb)*step_orb + (*(orb)).initial_phase
  c = sqrt((*(orb)).semi_major_axis^2-(*(orb)).semi_minor_axis^2)

  x = (*(orb)).semi_major_axis*cos(alpha)+c
  y = (*(orb)).semi_minor_axis*sin(alpha)
  z = fltarr(n_steps_orb)
  
  ; Real ellipsis Equation:
  ; l = 1./sqrt((cos(alpha)/(*(orb)).semi_major_axis)^2+(sin(alpha)/(*(orb)).semi_minor_axis)^2)
  ; x = l*cos(alpha)+c.
  ; y = l*sin(alpha)
  ; z = fltarr(n_steps_orb)

; on passe en coordonnees spheriques dans le repere z=nord, x=longitude 0
  rtp = XYZ_TO_RTP(transpose([[x],[y],[z]]))
  rpd(0,*)=rtp(0,*)
; for i=0,3598 do if abs(phi(i)-phi(i+1)) gt 1. then phi(i+1)=phi(i+1)+2.*!pi
  rpd(1,*)=rtp(2,*)
  
  ;r=rtp(0,*)*71900000						; r en metres
  ;rpd(2,*)=sqrt(1.27E17*(2./r-1./( (*(orb)).semi_major_axis*71900000)))/r	; dphi/dt

  ; Calculation of dphi/dt:
  ; dphi/dt=v/r
  ; v(ellipsis)=sqrt(G*M*(2/r-1/a))
  ; dphi/dt=sqrt(GM/r^2*(2/r-1/a))
  ; dphi/dt(r in Rp)=sqrt(GM/RP^3*(2/r-1/a))*1/r
  
  rpd(2,*)=2.*!pi/(p. planet_param[0])*sqrt(2./rtp(0,*)-1./(*(orb)).semi_major_axis)/rtp(0,*)
  !p.multi=[0,1,2]
  ;plot,x,y,xran=[-(*(orb)).semi_major_axis*2.,(*(orb)).semi_major_axis*2.],$
  ;xtit='X (Rsat) -> sun',ytit='Y (Rsat)',tit='Orbite of the S/C',/iso,col=255
  device,decomp=0

return
end

