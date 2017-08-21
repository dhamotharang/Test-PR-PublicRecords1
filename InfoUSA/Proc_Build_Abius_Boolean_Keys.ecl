import infousa;
export Proc_Build_Abius_Boolean_Keys(string filedate) := function
	
	mdata := Infousa.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata build complete'));
	boolean_build := Infousa.BWR_Build_ABIUS_Boolean(filedate) : success(output('Boolean Key build complete'));
	
	retval := sequential(mdata,boolean_build);
	
	return retval;
end;