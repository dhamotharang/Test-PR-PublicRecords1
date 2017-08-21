/*--METADATA('SampleFile', '~file::10.150.51.29::c$::import::foiacm.dta')*/
/*--METADATA('SampleFileRecordWidth', '286')*/
/*--METADATA('SampleFileType', 'Flat')*/
export foiacm_dta_layout := 
  record
	string9 CommitteeID;
	string90 CommitteeName;
	string38 TreasurerName;
	string34 Street1;
	string34 Street2;
	string18 City;
	string2 State;
	string5 Zip;
	string1 Designation;
	string1 Type;
	string3 Party;
	string1 FilingFrequency;
	string1 GroupCategory;
	string38 ConnectedName;
	string9 CandidateId;
	string2 eol;
  end;
