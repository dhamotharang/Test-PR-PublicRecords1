filterDIDs := dataset('~thor_data400::base::override::fcra::qa::flag',fcra.Layout_override_flag,flat)
				(did <> '' and flag_file_id in FCRA.Suppress_Flag_File_ID);

did_rec := record
	string12 did;
end;

did_rec getdids(filterDIDs l) := transform
	self.did := l.did;
end;

did_out := project(filterDIDs,getDIDs(left));

pcrds := dataset('~thor_data400::base::override::fcra::qa::pcr',fcra.layout_override_pcr,flat);

fcra.layout_override_pcr join_recs(pcrds l,did_out r) := transform
	self := l;
end;


kf := join(pcrds,did_out,left.did = right.did,join_recs(left,right),left only);

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

export PCR_for_FCRA := PROJECT(filtered,r);