export getTimeZone(ds,phone_field,timezone_field,outf) := MACRO


import risk_indicators;

outf :=join(ds,Risk_Indicators.Key_Telcordia_tds,keyed(left.phone_field[1..3]=right.npa) and
				keyed(left.phone_field[4..6]=right.nxx),
				transform(recordof(ds),
				self.timezone_field := if((right.npa='' and right.nxx = '') or length(trim(left.phone_field,all))<>10,
				left.timezone_field, ut.timeZone_Convert((unsigned1) right.timezone,right.state)),
				self := left
				),left outer,keep(1));
	
ENDMACRO;
