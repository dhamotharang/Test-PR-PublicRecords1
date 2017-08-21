irsbase	:= IRS5500.File_IRS5500_Base(bdid != 0);
irsfather := DATASET('~thor_data400::BASE::IRS5500_father',irs5500.Layout_IRS5500_AID,THOR);

newrecs := join(
	 distribute(irsbase, bdid)
	,distribute(irsfather, bdid)
	,left.bdid = right.bdid
	,transform(recordof(irsbase), self := left)
	,left only
	,local
);

export SampleRecsQA := Sequential(output(enth(sort(newrecs, -bdid), 200), named('NewIrs5500Recs')),
														output(count(newrecs), named('CountNewIrs5500Recs')));