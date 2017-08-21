import infousa;
export Proc_Build_Deadco_Boolean_Keys(string filedate) := function
	
	mdata := infousa.BWR_Build_DEDCO_Metadata(filedate) : success(output('Metadata build complete'));
	boolean_build := Infousa.BWR_Build_Deadco_Boolean(filedate) : success(output('Boolean Key build complete'));
	
	retval := sequential(mdata,boolean_build);
	
	return retval;
end;