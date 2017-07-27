import	ExperianCred,Header,ut,TransUnionCred,Transunion_PTrak;

//**********************PROJECT EXPERIAN DATA****************************//
ENbase0:=distribute(ExperianCred.files.Base_File_Out(did > 0 and current_experian_pin = 1 and current_rec_flag = 1 and deceased_ind = 1),hash(did));
ds_ExpercianCred_srt		:=	sort(ENbase0,did, -date_last_seen, -social_security_number, -date_of_birth, local);
ds_ExpercianCred_dedup	:=	DEDUP(ds_ExpercianCred_srt,did,local);

Header.Layout_Did_Death_MasterV3	tStandardizeRecord(ExperianCred.Layouts.Layout_Out	l)	:=
transform
	self.did							:=	(STRING)intformat(l.did,12,1);
	self.did_score				:=	l.did_score_field;
	self.filedate					:=	(STRING)l.date_last_seen;
	self.rec_type					:=	''; 
	self.rec_type_orig		:=	'';
	self.ssn							:=	l.social_security_number;
	self.lname						:=	l.lname;
	self.name_suffix			:=	l.name_suffix;
	self.fname						:=	l.fname;
	self.mname						:=	l.mname;
	self.vorp_code				:=	'';
	self.dod8							:=	'';
	self.dob8							:=	l.date_of_birth;
	self.st_country_code	:=	'';
	self.zip_lastres			:=	l.zip;
	self.zip_lastpayment	:=	'';
	self.state						:=	l.st;
	self.fipscounty				:=	'';
	self.crlf							:=	'';
	self.state_death_id		:=	death_master.fn_fake_state_death_id((STRING)intformat(l.did,12,1),l.orig_lname,(STRING)l.date_last_seen);
	self.src							:=	'EN';
	self.GLB_flag					:=	'Y';
	self.state_death_flag := 'N';
	self.death_rec_src		:= 'EXP';
end;

standardized_ExpercianCred	:=	project(ds_ExpercianCred_dedup,tStandardizeRecord(left));

//**********************PROJECT TRANSUNIONCRED DATA****************************//
TNbase0:=distribute(transunioncred.files.Base(deceased_indicator = 'Y' and isupdating and isDelete=false and did  > 0 and iscurrent),hash(did));
ds_TransUnionCred_srt		:=	sort(TNbase0,did,-dt_last_seen, -clean_ssn, -clean_dob, local);
ds_TransUnionCred_dedup	:=	DEDUP(ds_TransUnionCred_srt,did,local);

Header.Layout_Did_Death_MasterV3	tStandardizeTransUnionRecord(TransunionCred.Layouts.base	l)	:=
transform
	self.did							:=	(STRING) intformat(l.did,12,1);
	self.did_score				:=	l.did_score;
	self.filedate					:=	(STRING)l.dt_last_seen;
	self.rec_type					:=	''; 
	self.rec_type_orig		:=	'';
	self.ssn							:=	l.clean_ssn;
	self.lname						:=	l.lname;
	self.name_suffix			:=	l.name_suffix;
	self.fname						:=	l.fname;
	self.mname						:=	l.mname;
	self.vorp_code				:=	'';
	self.dod8							:=	'';
	self.dob8							:=	if(l.clean_dob > 0, (STRING) l.clean_dob, '');
	self.st_country_code	:=	'';
	self.zip_lastres			:=	l.zip;
	self.zip_lastpayment	:=	'';
	self.state						:=	l.st;
	self.fipscounty				:=	'';
	self.crlf							:=	'';
	self.state_death_id		:=	death_master.fn_fake_state_death_id((STRING)intformat(l.did,12,1),l.last_name,(STRING)l.dt_vendor_last_reported);
	self.src							:=	'TN';
	self.GLB_flag					:=	'Y';
	self.state_death_flag := 'N';
	self.death_rec_src		:= 'TUN';
end;

standardized_TransUnionCred	:=	project(ds_TransUnionCred_dedup,tStandardizeTransUnionRecord(left));

//**********************PROJECT TUCS DATA****************************//
TSbase0:=distribute(Transunion_PTrak.File_Transunion_DID_Out(did>0 and is_current and DECEASEDINDICATOR = 'Y' ),hash(did));
ds_TransunionPTrak_srt	:=	sort(TSbase0,did,-dt_last_seen, -ssn_unformatted, -dob_no_conflict, -DECEASEDDATE, local);
ds_TransunionPTrak_dedup:=	DEDUP(ds_TransunionPTrak_srt,did,local);
 
Header.Layout_Did_Death_MasterV3	tStandardizeTransUnionPTrackRecord(Transunion_PTrak.Layout_Transunion_Out.LayoutTransunionBaseOut	l)	:=
transform
	self.did							:=	(STRING) intformat(l.did,12,1);
	self.did_score				:=	l.did_score_field;
	self.filedate					:=	(STRING)l.dt_last_seen;
	self.rec_type					:=	''; 
	self.rec_type_orig		:=	'';
	self.ssn							:=	l.ssn_unformatted;
	self.lname						:=	l.lname;
	self.name_suffix			:=	l.name_suffix;
	self.fname						:=	l.fname;
	self.mname						:=	l.mname;
	self.vorp_code				:=	'';
	self.dod8							:=	(STRING) l.DECEASEDDATE;;
	self.dob8							:=	(STRING) l.dob_no_conflict;
	self.st_country_code	:=	'';
	self.zip_lastres			:=	l.zip;
	self.zip_lastpayment	:=	'';
	self.state						:=	l.st;
	self.fipscounty				:=	'';
	self.crlf							:=	'';
	self.state_death_id		:=	death_master.fn_fake_state_death_id((STRING)intformat(l.did,12,1),l.lname,(STRING)l.dt_last_seen);
	self.src							:=	'TS';
	self.GLB_flag					:=	'N';
	self.state_death_flag := 'N';
	self.death_rec_src		:= 'TCS';
end;

standardized_TransUnionCredPTrak	:=	project(ds_TransunionPTrak_dedup,tStandardizeTransUnionPTrackRecord(left));

en_tn_overlap := join(DISTRIBUTE(standardized_TransUnionCred,HASH(did)),
											DISTRIBUTE(standardized_ExpercianCred,HASH(did)),																			
											left.did = right.did,
											transform(Header.Layout_Did_Death_MasterV3, self := left),
											local);

// Use Ts data when overlapitn with another DID in EN or TN
TS_dist := DISTRIBUTE(standardized_TransUnionCredPTrak,HASH(did));
Header.Layout_Did_Death_MasterV3 Filter_BaseFile_Rec(Header.Layout_Did_Death_MasterV3 L
										,Header.Layout_Did_Death_MasterV3 R) := TRANSFORM
	SELF := 	if((unsigned)R.did > 0, R, L);
END;

Filter_BaseFile_RecJoin := JOIN(en_tn_overlap,
					TS_dist,
					LEFT.did =  RIGHT.did,
					Filter_BaseFile_Rec(LEFT,RIGHT),LEFT OUTER,local);	

//temp reformat dob, did, and ssn to be able to run Mac_Dodgy_SSN_and_DOB_suppression
temp_layout := record
Header.Layout_Did_Death_MasterV3 and not[did, ssn];
integer4 dob;
unsigned6 did;
qstring9 ssn;
end;

temp_Filter_BaseFile_RecJoin := project(Filter_BaseFile_RecJoin, transform(temp_layout, 
																																						self.dob := (integer4) left.dob8, 
																																						self.did := (unsigned6) left.did,
																																					  self.ssn := (qstring9) left.ssn,
																																						self := left));

//Use Mac_Dodgy_SSN_and_DOB_suppression to remove conflicting ssns and dobs 

h:=header.file_headers;

Mac_Dodgy_SSN_and_DOB_suppression(h,temp_Filter_BaseFile_RecJoin, ['TN', 'EN', 'TS'], ofile)

//reformat back to DM format
Filter_BaseFile_RecJoin_r := project(ofile,
																		 transform(Header.Layout_Did_Death_MasterV3,
																							 self.dob8 := if(left.dob > 0,(STRING) left.dob, ''),
																							 self.did := (STRING) intformat(left.did,12,1),
																							 self.ssn := left.ssn,
																							 self := left));

 ds_srt		:=	sort(DISTRIBUTE(Filter_BaseFile_RecJoin_r,hash(did)),did,-src,local);
 ds_dedup	:=	DEDUP(ds_srt,did,local);

export	fn_AddExperian_toDeathMaster	:=	ds_dedup;