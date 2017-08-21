import Inquiry_AccLogs;

export Logs_Preprocess(

	 dataset(layouts.input.sprayed			)	pInputfile	= Files().input.logs_thor.using
	,dataset(Inquiry_Acclogs.Layout_MBS	)	pMBSFile		= Inquiry_AccLogs.File_MBS.File

) :=
function
	
	// Filter MBS file down to records with permission to use
	dMBSFile_filt := _Filters.MBS_File(pMBSFile);
	
	//filter Input file using MBS filtered file, keeping records that have permission
	djoin2MBS := join(
		 dMBSFile_filt
		,pInputfile
		,trim(left.gc_id) = trim(right.gcid)
		,transform(
			layouts.input.sprayed
			,self := right
		)
	);
	
	// Filter Input file to only records can use, blank out customer fields
	djoin2MBS_filt := _Filters.Input_file(djoin2MBS);

	return djoin2MBS_filt;
	
end;