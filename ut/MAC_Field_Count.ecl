export MAC_Field_Count(infile,infield,outname = '\'field_count\'',pct_wanted = 'false',hasoutputname = 'false', outputname = 'theoutput', outputtostats = 'false') := macro
#uniquename(mac_mf)
%mac_mf% := 0; // turn into a proper macro
ut.Mac_Field_Count_Thresholded(infile,infield,0,outname,pct_wanted,hasoutputname,outputname,outputtostats)
  endmacro;