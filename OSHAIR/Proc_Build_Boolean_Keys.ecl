export Proc_Build_Boolean_Keys(string filedate) := function

mdata := Oshair.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata Build complete'));

boolean_build := Oshair.BWR_Oshair_Build_Boolean(filedate) : success(output('Boolean Build complete'));

retval := sequential(mdata,boolean_build);
																										
return retval;

end;