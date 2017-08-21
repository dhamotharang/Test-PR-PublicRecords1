filterDIDs := FCRA.File_flag; //dataset('~thor_data400::base::override::fcra::qa::flag',fcra.Layout_override_flag,flat)(did <> '' and flag_file_id not in FCRA.Suppress_Flag_File_ID);


// convert from input csv layout to fixed layout
inpcrds := dataset('~thor_data400::base::override::fcra::qa::pcr',fcra.layout_override_pcr_in,csv(separator('\t'),quote('\"'),terminator('\r\n')),opt);

fcra.Layout_Override_PCR proj_recs(inpcrds l) := transform
	self.did_score := '0';
	self.ssn_app := '0';
	self := l;
end;

pcrds := project(inpcrds,proj_recs(left));
////

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

filtered := kf(consumer_statement_flag<>'' OR
						dispute_flag<>'' OR 
						security_freeze<>'' OR
						security_alert<>'' OR
						negative_alert<>'' OR
						id_theft_flag<>'');

r :=
RECORD
	string13 UID;
	string8 date_created;
	string8 dt_first_seen;
	string8 dt_last_seen;
	string12 did;
	string1 consumer_statement_flag;
	string20 fname;
	string20 mname;
	string20 lname;
	string5 name_suffix;
	string9 ssn;
	string8 dob;
	string1 dispute_flag;
	string1 security_freeze;
	string6 security_freeze_PIN;
	string1 security_alert;
	string1 negative_alert;
	string1 id_theft_flag;
	string1 insuff_inqry_data;
	string3 did_score;
END;

export PCR_for_FCRA := dedup(sort(PROJECT(filtered,r), did, ssn, -date_created, -UID), did, ssn);