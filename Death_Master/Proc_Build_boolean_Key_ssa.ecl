export Proc_Build_boolean_Key_ssa(string filedate) := function
	metad := Death_Master.BWR_Build_Segment_Metadata_SSA(filedate) : success(output('Metadata complete'));
	kbuild := Death_Master.BWR_Build_DM_SSA(filedate) : success(output('Restricted Version Boolean key build complete'));

	retval := sequential(metad,kbuild);

	return retval;

end;