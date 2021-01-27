IMPORT Overrides,_Control,iesp;

EXPORT American_Student_Override_Findings(DATASET(Override_Layouts.Layout_Get_Orphans) orphansIn, STRING filedate) :=  FUNCTION

orphans_ds := orphansIn;

OUTPUT(SORT(orphans_ds,did),NAMED('orphans_List'));

overrides.mac_orphans_evaluate(American_Student_new,'STUDENT',orphans_ds,dsout_student,,did,key,,,,fname,lname,prim_range,prim_name, z5);

OUTPUT(dsout_student,NAMED('evaluated_students'));

//qc
overrides_did_set := SET(orphans_ds, (unsigned)did);
payload_did_set := SET(dsout_student, (unsigned)did_payload);

overrided_by_did := overrides.Keys.american_student_new(did IN overrides_did_set);
payload_by_did := overrides.payload_keys.american_student_new(did IN payload_did_set + overrides_did_set);
OUTPUT(payload_by_did,NAMED('payload_by_did'));

student_overrides_keys_ds := Project(overrided_by_did, Transform(fcra.Layout_Override_Student_New or {string version},
																						self.version := 'student_overrides_keys',
																						self := left));
																						
student_payload_keys_ds := Project(payload_by_did, Transform(fcra.Layout_Override_Student_New or {string version},
																						self.version := 'student_payload_keys',
																						self.flag_file_id := '';
                                            self := left));

cmbstudents := sort(student_overrides_keys_ds + student_payload_keys_ds, RECORD);
OUTPUT(cmbstudents,NAMED('cmbstudents'));


RecordOf(cmbstudents) xform(cmbstudents l) := Transform
	self.version := 'both';
	self := l;
End;	

cmbstudents_dist := distribute(cmbstudents, HASH32(key,did));

combined_sorted := sort(cmbstudents_dist,key,did,local);

rolled := Rollup(combined_sorted, xform(left), key,did,local);

Output(rolled(version='both'), named('Both_Overrides_Payload'));

Output(SORT(rolled(version='student_overrides_keys'),did), named('student_overrides_Only'));

Output(SORT(rolled(version='student_payload_keys'),did), named('student_payload_keys_Only'));	

overrides_students := rolled(version='student_overrides_keys');
payload_qc := rolled(version='student_payload_keys');

sorted_overrides := sort(overrides_students,key,did, ssn);

deduped_overrides:= DEDUP(sorted_overrides,key,did,ssn);

sorted_payload_qc := sort(payload_qc,key,did, ssn);

deduped_sorted_payload_qc:= DEDUP(sorted_payload_qc,key,did, ssn);

diff_layout := record
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
End;

diff_layout xform_diff(payload_qc l,overrides_students  r) := Transform
	self.payload_did := l.did;
	self.overrides_did := r.did;
	self.l_version := l.version;
	self.r_version := r.version;
	self.l_key := l.key;
	self.r_key := r.key;
	self.l_ssn  := l.ssn;
	self.r_ssn  := r.ssn;
	//KEY FIELDS
	self.l_Name     := l.first_Name;
	self.l_lastName := l.last_name;
	self.r_Name     := r.first_Name;;
	self.r_lastName := r.last_name;;
	self.l_dob      := l.dob_formatted;
	self.r_dob      := r.dob_formatted;
	self.l_zip5     := l.z5;
	self.r_zip5     := r.z5;
	
	//key=pid fields
	self.l_FULL_NAME := l.FULL_NAME;
  self.r_FULL_NAME :=r.FULL_NAME;	
	self.l_zip       :=l.zip;
	self.r_zip       :=r.zip;
  self.l_addr      :=Std.Str.CleanSpaces(l.Address_1 + ' ' + l.Address_2);
	self.r_addr      :=Std.Str.CleanSpaces(r.Address_1 + ' ' + r.Address_2);
	self.l_addr1     :=l.Address_1; 
	self.r_addr1     :=r.Address_1;
	self.l_addr2     :=l.Address_2; 
	self.r_addr2     :=r.Address_2;
	self.l_LN_COLLEGE_NAME :=l.LN_COLLEGE_NAME;
	self.r_LN_COLLEGE_NAME :=r.LN_COLLEGE_NAME;
	self.l_COLLEGE_MAJOR   :=l.COLLEGE_MAJOR;
	self.r_COLLEGE_MAJOR   :=l.COLLEGE_MAJOR;
	self.l_telephone       :=l.telephone;
	self.r_telephone       := r.telephone;
	
	self.diff := ROWDIFF(L,R);
End;

matched_dids := join(deduped_sorted_payload_qc,deduped_overrides, left.did = right.did and left.key != right.key,xform_diff(left,right));	

matched_keys := join(deduped_sorted_payload_qc,deduped_overrides, left.did != right.did and left.key = right.key,xform_diff(left,right));	

combined_output := matched_dids + matched_keys;

orphan_layout := record
	deduped_overrides;
	string diff;
End;


orphan_layout orphan_xform(combined_output  l, deduped_overrides r) := Transform
	self.diff := l.diff;
	self :=r;
End;

true_orphans := join(combined_output,deduped_overrides, left.payload_did = right.did,orphan_xform(left,right),RIGHT ONLY);
															 
output(matched_dids, named('matched_dids'));
output(matched_keys, named('matched_keys'));
output(true_orphans, named('true_orphans'));

payload := overrides.payload_keys.american_student_new();
							 
result := join(payload,true_orphans, left.full_name=right.full_name and left.date_first_seen=right.date_first_seen);
output(result, named('payload'));			

