
basename = 'lte05800-4.50-0.0.PHOENIX-ACES-AGSS-COND-2011-HiRes'
readit,basename+'.txt',x,f,sep=','
nx = n_elements(x)
xstr = string(x,format='(e0.15)')

readit,'ctioextinct.dat',ex,em

exmag = interp_1d(ex,em,x,/extrapolate)

!p.multi=[0,1,2]

plot,x,exmag
oplot,ex,em,psym=7,color=fsc_color('red')

airmass = [0.0d, 1.0d, 1.5d, 2.0d, 8.0d]
colors = ['white', 'yellow', 'orange', 'red', 'darkred']
nair = n_elements(airmass)

plot,x,f
for i=0,nair-1 do begin
	ai = airmass[i]
	label = string(ai,format='(f0.1)')
	;emag = exmag*ai
	;eflux = 10.0d^(-0.4d * emag)
	;outflux = f*eflux
	outflux = f*10.0d^(-0.4d * exmag * ai)
	oplot,x,outflux,color=fsc_color(colors[i])

	outfile = basename + '-AM=' + label + '.txt'
	outstr = string(outflux,format='(e0.15)')
	openw,lun,outfile,/get_lun
	for j=0,nx-1 do printf,lun,xstr[j]+','+outstr[j]
	free_lun,lun

endfor

end
