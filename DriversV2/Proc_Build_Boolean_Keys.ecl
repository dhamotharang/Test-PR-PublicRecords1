export Proc_Build_Boolean_Keys (string filedate) := function

mdata := Driversv2.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata Build Complete'));

boolean_build := Driversv2.BWR_DLV2_Boolean(filedate) : success(output('Boolean Build Complete'));

retval := sequential(mdata, boolean_build);

return retval;
					
end;
