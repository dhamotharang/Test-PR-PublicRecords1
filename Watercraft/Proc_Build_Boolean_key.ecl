export Proc_Build_Boolean_key(string filedate) := function

mdata := Watercraft.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata Build complete'));

boolean_build := Watercraft.BWR_Build_Watercraft(filedate) : success(output('Boolean build compelte'));

//sequential(Watercraft.BWR_Build_Segment_Metadata(filedate),
	//									Watercraft.BWR_Build_Watercraft(filedate));

retval := sequential(mdata,boolean_build);

return retval;
										
										
end;