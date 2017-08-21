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