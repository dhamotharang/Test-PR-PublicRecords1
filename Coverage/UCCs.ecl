/* W20080311-084049
UCC
*/

//orig_state from party file
//filing date from main file
//tmsid

//so, take the main file, cut down to tmsid and rmsid and filing date
//cut down party file to tmsid, rmsid and orig_state
//join the two, left outer(main on left), on tmsid and rmsid, pulling over the
//state.

dUccMain	:= uccv2.File_UCC_Main_Base	;

dUccMainSlim	:= table(dUccMain	, {filing_date, Filing_Jurisdiction	}, filing_date,Filing_Jurisdiction	);

layout_Coverage := 
record

	dUccMainSlim.Filing_Jurisdiction;
	unsigned4 cov_st_type		:= min(group	,(unsigned4)dUccMainSlim.filing_date	);
	unsigned4 cov_end_type	:= max(group	,(unsigned4)dUccMainSlim.filing_date	);

end;

dUccCoverages := table(dUccMainSlim((unsigned4)filing_date > 18000101), layout_Coverage, Filing_Jurisdiction,few);

output(dUccCoverages, named('UccCurrentCoverages'), all);