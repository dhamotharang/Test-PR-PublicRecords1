export Proc_Build_boolean_Key(string filedate) := function
	metad := Death_Master.BWR_Build_Segment_Metadata(filedate) : success(output('Metadata complete'));
	kbuild := Death_Master.BWR_Build_DM(filedate) : success(output('key build complete'));

	retval := sequential(metad,kbuild);

	return retval;

end;