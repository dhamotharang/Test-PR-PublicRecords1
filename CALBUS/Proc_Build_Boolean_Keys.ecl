export Proc_Build_Boolean_Keys(string filedate) := function

mdata := calbus.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata Build compelete'));
boolean_build := calbus.BWR_Build_Calbus_Boolean(filedate) : success(output('Boolean Build complete'));

retval := sequential(mdata,boolean_build);
	
return retval;
	
end;