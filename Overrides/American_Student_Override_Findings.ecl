IMPORT Overrides,_Control,iesp,fcra,Std;

EXPORT American_Student_Override_Findings(DATASET(Override_Layouts.Layout_Get_Orphans) orphansIn, STRING filedate) :=  FUNCTION

	orphans_ds := orphansIn;
	//OUTPUT(SORT(orphans_ds,did),NAMED('orphans_List'));

	orphan_did_set := SET(orphans_ds, (UNSIGNED)did);
	//Output(orphan_did_set);

	overrided_by_did := PULL(overrides.Keys.american_student_new(did IN orphan_did_set));
	
	payload_by_did := PULL(overrides.payload_keys.american_student_new(did IN orphan_did_set));
	
	
	student_overrides_keys_ds := PROJECT(overrided_by_did, TRANSFORM(fcra.Layout_Override_Student_New OR {STRING version},
																						SELF.version := 'student_overrides_keys',
																						SELF := LEFT));
																						
	student_payload_keys_ds := PROJECT(payload_by_did, TRANSFORM(fcra.Layout_Override_Student_New OR {STRING version},
																						SELF.version := 'student_payload_keys',
																						SELF.flag_file_id := '';
                                            SELF := LEFT));

	cmbstudents := SORT(student_overrides_keys_ds + student_payload_keys_ds, RECORD);
	
	RECORDOF(cmbstudents) xform(cmbstudents l) := TRANSFORM
		SELF.version := 'both';
		SELF := l;
	END;	

	cmbstudents_dist := DISTRIBUTE(cmbstudents, HASH32(key,did));

	combined_sorted := SORT(cmbstudents_dist,key,did,LOCAL);

	rolled := ROLLUP(combined_sorted, xform(left), key,did,LOCAL);

	overrides_students := rolled(version='student_overrides_keys');
	payload_qc := rolled(version='student_payload_keys');

	sorted_overrides := SORT(overrides_students,key,did, ssn);

	deduped_overrides:= DEDUP(sorted_overrides,key,did,ssn);

	sorted_payload_qc := SORT(payload_qc,key,did, ssn);

	deduped_sorted_payload_qc:= DEDUP(sorted_payload_qc,key,did, ssn);

	diff_layout := RECORD
		//overrides_students.did;
		INTEGER payload_did;
		INTEGER overrides_did;
		STRING l_version;
		STRING r_version;
		INTEGER l_key;
		INTEGER r_key;
		STRING  l_ssn;
		STRING  r_ssn;
		//KEY FIELDS
		STRING l_lastName;	
		STRING r_lastName;	
		STRING l_Name;
		STRING r_Name;
		STRING l_dob;
		STRING r_dob;
		STRING l_zip5;
		STRING r_zip5;
	
		//key=pid fields
		STRING l_FULL_NAME;
		STRING r_FULL_NAME;	
		STRING l_zip;
		STRING r_zip;
		STRING l_addr;	
		STRING r_addr;
		STRING l_addr1;	
		STRING r_addr1;
		STRING l_addr2;	
		STRING r_addr2;
		STRING l_LN_COLLEGE_NAME;
		STRING r_LN_COLLEGE_NAME;
		STRING l_COLLEGE_MAJOR;
		STRING r_COLLEGE_MAJOR;
		STRING l_telephone;
		STRING r_telephone;
	
		STRING diff;
	END;

	diff_layout xform_diff(payload_qc l,overrides_students  r) := TRANSFORM
		SELF.payload_did := l.did;
		SELF.overrides_did := r.did;
		SELF.l_version := l.version;
		SELF.r_version := r.version;
		SELF.l_key := l.key;
		SELF.r_key := r.key;
		SELF.l_ssn  := l.ssn;
		SELF.r_ssn  := r.ssn;
		//KEY FIELDS
		SELF.l_Name     := l.first_Name;
		SELF.l_lastName := l.last_name;
		SELF.r_Name     := r.first_Name;;
		SELF.r_lastName := r.last_name;;
		SELF.l_dob      := l.dob_formatted;
		SELF.r_dob      := r.dob_formatted;
		SELF.l_zip5     := l.z5;
		SELF.r_zip5     := r.z5;
	
		//key=pid fields
		SELF.l_FULL_NAME := l.FULL_NAME;
		SELF.r_FULL_NAME :=r.FULL_NAME;	
		SELF.l_zip       :=l.zip;
		SELF.r_zip       :=r.zip;
		SELF.l_addr      :=Std.Str.CleanSpaces(l.Address_1 + ' ' + l.Address_2);
		SELF.r_addr      :=Std.Str.CleanSpaces(r.Address_1 + ' ' + r.Address_2);
		SELF.l_addr1     :=l.Address_1; 
		SELF.r_addr1     :=r.Address_1;
		SELF.l_addr2     :=l.Address_2; 
		SELF.r_addr2     :=r.Address_2;
		SELF.l_LN_COLLEGE_NAME :=l.LN_COLLEGE_NAME;
		SELF.r_LN_COLLEGE_NAME :=r.LN_COLLEGE_NAME;
		SELF.l_COLLEGE_MAJOR   :=l.COLLEGE_MAJOR;
		SELF.r_COLLEGE_MAJOR   :=l.COLLEGE_MAJOR;
		SELF.l_telephone       :=l.telephone;
		SELF.r_telephone       := r.telephone;
	
		SELF.diff := ROWDIFF(L,R);
	END;

	matched_dids := JOIN(deduped_sorted_payload_qc,deduped_overrides, LEFT.did = RIGHT.did AND LEFT.key != RIGHT.key,xform_diff(LEFT,RIGHT));	

	matched_keys := JOIN(deduped_sorted_payload_qc,deduped_overrides, LEFT.did != RIGHT.did AND LEFT.key = RIGHT.key,xform_diff(LEFT,RIGHT));	

	
	combined_output := matched_dids + matched_keys;
	
	File_Override_Orphans.orphan_rec orphan_xform(combined_output  l, deduped_overrides r) := TRANSFORM
		SELF.datagroup := overrides.Constants.getfileid(overrides.Constants.STUDENT);
		SELF.did := (STRING)r.did;
		SELF.recid := (STRING) r.key;
		SELF.flag_file_ID := r.flag_file_id;
		SELF :=r;
	END;

	 true_orphans := JOIN(combined_output,deduped_overrides, LEFT.payload_did = RIGHT.did,orphan_xform(LEFT,RIGHT),RIGHT ONLY);
															 
	 output(true_orphans, named('true_orphans_astudent'));

	 #IF(overrides.Constants.GROWTH_CHECK_CALL)
		build_stats := IF (COUNT(true_orphans) > 0, GrowthCheck(Constants.STUDENT).BuildStats(filedate, true_orphans));
		build_stats; // this forces the call
        		
		stats_alerts :=  GrowthCheck(Constants.STUDENT).StatsAlerts;
	
		sent_email := IF (stats_alerts, FileServices.sendemail(EmailNotification.orphan_alert_list
												, 'American Student Override True Orphans COUNT is higher than threshold count ' +  overrides.Constants.GetStatsThreshold(Constants.STUDENT) 
												, 'WU#: '+ workunit + '-' + failmessage));
	
		result_orphans := IF(~stats_alerts,true_orphans);
		RETURN WHEN (result_orphans, sent_email);
	#ELSE
		RETURN true_orphans;
	#END
	
END;		
