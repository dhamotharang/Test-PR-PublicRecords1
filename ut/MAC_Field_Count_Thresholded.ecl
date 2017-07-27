/*  Comments:
Make multi-callable
*/
export MAC_Field_Count_Thresholded(infile,infield,thres,outname = '\'field_count\'',pct_wanted = 'false',hasoutputname = 'false', outputname = 'theoutput') := macro

//-- Record structure that will count the table by infield
#uniquename(give2)
%give2%(real8 a) := round(a * 100) / 100;

#uniquename(r_macro)
%r_macro% := record
  infield;
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
#if(hasoutputname)
	outputname := output(choosen(%t_macro%(cnt>=thres),50000), NAMED(outname));
#else
	output(choosen(%t_macro%(cnt>=thres),50000), NAMED(outname));
#end

  endmacro;