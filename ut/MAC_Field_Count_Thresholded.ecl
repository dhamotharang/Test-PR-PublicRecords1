/*  Comments:
Make multi-callable
*/
export MAC_Field_Count_Thresholded(infile,infield,thres,outname = '\'field_count\'',pct_wanted = 'false',hasoutputname = 'false', outputname = 'theoutput', outputtostats = 'false') := macro

//-- Record structure that will count the table by infield
#uniquename(give2)
%give2%(real8 a) := round(a * 100) / 100;

#uniquename(r_macro)
%r_macro% := record
  infield;
  extra := infield;
  integer cnt := count(group);
	#if(pct_wanted)
	  real pct := %give2%(100 * count(group) / count(infile));
	#end
  end;

//****** Push infile into table that groups by infield, 
//		 producing a count for each value using r_macro above
#uniquename(t_macro)
%t_macro% := table(infile,%r_macro%,infield,few);

//****** Output up to 5000 results to screen
#uniquename(ft)
%ft% := choosen(%t_macro%(cnt>=thres),50000);
/*
#uniquename(ftwiderec)
%ftwiderec% := record
	%ft%;
	string20 extra;
end;

#uniquename(makeftwiderec)
%ftwiderec% %makeftwiderec%(%ft% l) := transform
	self.extra := l.infield;
	self := l;
end;

#uniquename(ftwide)
%ftwide% := project(%ft%, %makeftwiderec%(left));
*/
#uniquename(tra)
ut.layout_stats_extend %tra%(%ft% l, integer c) := transform
	self.name := if(c = 1, 'Field Count: ' + outname + ' = ' + trim((string)l.extra),
	#if(pct_wanted)
	  'Field Count: ' + outname+ ' = ' + trim((string)l.extra) + ' pct');
	#else
	  '');
	#end
	self.value := if(c = 1, l.cnt,
	#if(pct_wanted)
	  l.pct);
	#else
	  0);
	#end
end;

#uniquename(norm)
%norm% := normalize(%ft%, 2, %tra%(left, counter));


#if(hasoutputname)
	outputname := parallel(output(%ft%, NAMED(outname))
	#if(outputtostats)
		,ut.fn_AddStatDS(dedup(%norm%(value > 0), all))
	#end
	);
#else
	output(%ft%, NAMED(outname));
#end

  endmacro;