filterDIDs := FCRA.File_flag; //dataset('~thor_data400::base::override::fcra::qa::flag',fcra.Layout_override_flag,flat)
				//(did <> '' and flag_file_id not in FCRA.Suppress_Flag_File_ID);


// convert from input csv layout to fixed layout
inpcrds := dataset('~thor_data400::base::override::fcra::qa::pcr',fcra.layout_override_pcr_in,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

fcra.Layout_Override_PCR proj_recs(inpcrds l) := transform
	self.did_score := '0';
	self.ssn_app := '0';
	self := l;
end;

pcrds := project(inpcrds,proj_recs(left));
//////

fcra.layout_override_pcr join_recs(pcrds l,filterDIDs r) := transform
	self.did := trim(intformat((integer)l.did,12,0),left,right);
	self.consumer_statement_flag := if(l.consumer_statement_flag = 'Y','1',
										if(l.consumer_statement_flag = 'N','0',
												l.consumer_statement_flag));
	self.dispute_flag := if(l.dispute_flag = 'Y','1',
										if(l.dispute_flag = 'N','0',
												l.dispute_flag));
self.security_freeze := if(l.security_freeze = 'Y','1',
										if(l.security_freeze = 'N','0',
												l.security_freeze));
	self.security_alert := if(l.security_alert = 'Y','1',
										if(l.security_alert = 'N','0',
												l.security_alert));											
	self.negative_alert := if(l.negative_alert = 'Y','1',
										if(l.negative_alert = 'N','0',
												l.negative_alert));
	self.id_theft_flag := if(l.id_theft_flag = 'Y','1',
										if(l.id_theft_flag = 'N','0',
												l.id_theft_flag));
	self := l;
end;


kf := join(pcrds,filterDIDs,
				(integer)left.did = 
					(integer)right.did,
					join_recs(left,right),left outer)(did not in FCRA.Suppress_DID);

export Pii_for_FCRA := dedup(sort(PROJECT (kf, layout_override_pii),did, ssn, -date_created, -UID),did, ssn);