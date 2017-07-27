import ut, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, watchdog, business_header;

/* hashes fields used to did, bdid. only outputs records that have changes (new or update) */

export fnMapBaseAppends(dataset(recordof(inquiry_acclogs.fn_ProdHist().File)) Base_File = inquiry_acclogs.fn_ProdHist().File, boolean isFCRA = false, string pBuildDate = ut.getdate) := module

export FCRAtag := if(isFCRA, 'FCRA::', '');

/* !!!!!!!!!!!!!!!!! LAST CREATED FILE !!!!!!!!!!!!!!!!!!!!! */

export reappend_layout := RECORD
  unsigned8 person_q_id;
  string person_q_apssn;
  unsigned6 person_q_apdid;
  unsigned6 person_q_apdidold;
	
  unsigned8 bus_q_id;
  string bus_q_apfein;
  unsigned6 bus_q_apbdid;
  unsigned6 bus_q_apbdidold;
	
  unsigned8 bususer_q_id;
  string bususer_q_apssn;
  unsigned6 bususer_q_apdid;
  unsigned6 bususer_q_apdidold;
	boolean change;
 END;

 
export file := dataset('~thor_data400::out::inquiry_acclogs::'+FCRAtag+'reappend_records', reappend_layout, thor);

/* !!!!!!!!!!!!!!!!! CHECK UPDATES !!!!!!!!!!!!!!!!!!!!! */

export hversion := did_add.get_EnvVariable('header_file_version');
export bversion := did_add.get_EnvVariable('bheader_file_version');

export is_hversion_New := ut.IsNewProdHeaderVersion('inquiry_acclogs','header_file_version');
export is_bversion_New := ut.IsNewProdHeaderVersion('inquiry_acclogs','bheader_file_version');

export update_hversion := ut.PostDID_HeaderVer_Update('inquiry_acclogs','header_file_version');
export update_bversion := ut.PostDID_HeaderVer_Update('inquiry_acclogs','bheader_file_version');

export IQbuild_header_version := dataset(ut.foreign_prod + 'thor_data400::flag::inquiry_acclogs::'+FCRAtag+'prodheaderversion',{string10 prodheaderdate, string pkgvariable},thor)(pkgvariable = 'header_file_version')[1].prodheaderdate;
export IQbuild_bheader_version := dataset(ut.foreign_prod + 'thor_data400::flag::inquiry_acclogs::'+FCRAtag+'prodheaderversion',{string10 prodheaderdate, string pkgvariable},thor)(pkgvariable = 'bheader_file_version')[1].prodheaderdate;

/* !!!!!!!!!!!!!!!!! FIELD APPENDS !!!!!!!!!!!!!!!!!!!!! */

filtBaseFile := Base_File(
					/*person q*/		person_q.fname + person_q.mname + person_q.lname +
					/*bus q*/				bus_q.CName +
					/*bus user q*/	bususer_q.fname + bususer_q.mname + bususer_q.lname <> ''
													);

pTrim_Base_File := table(filtBaseFile, {
						unsigned8 person_q_id := hash64(person_q.title + person_q.fname + person_q.mname + person_q.lname + person_q.name_suffix + person_q.Work_Phone + person_q.Personal_Phone + person_q.DOB + person_q.SSN + person_q.prim_range + person_q.prim_name + person_q.sec_range + person_q.st + person_q.zip5),
						person_q_title := person_q.title,
						person_q_fname := person_q.fname,
						person_q_mname := person_q.mname,
						person_q_lname := person_q.lname,
						person_q_name_suffix := person_q.name_suffix,
						person_q_Work_Phone := person_q.Work_Phone,
						person_q_Personal_Phone := person_q.Personal_Phone,
						person_q_DOB := person_q.DOB,
						person_q_SSN := person_q.SSN,
						person_q_prim_range := person_q.prim_range,
						person_q_prim_name := person_q.prim_name,
						person_q_sec_range := person_q.sec_range,
						person_q_st := person_q.st,
						person_q_zip5 := person_q.zip5,
						person_q_apdidold := person_q.appended_adl;
						unsigned6 person_q_apdid := 0;
						string person_q_apssn := '';

						unsigned8 bus_q_id := hash64(bus_q.CName + bus_q.Company_Phone + bus_q.EIN + bus_q.prim_range + bus_q.prim_name + bus_q.sec_range + bus_q.st + bus_q.zip5),
						bus_q_CName := bus_q.CName,
						bus_q_Company_Phone := bus_q.Company_Phone,
						bus_q_EIN := bus_q.EIN,
						bus_q_prim_range := bus_q.prim_range,
						bus_q_prim_name := bus_q.prim_name,
						bus_q_sec_range := bus_q.sec_range,
						bus_q_st := bus_q.st,
						bus_q_zip5 := bus_q.zip5,
						bus_q_apbdidold := bus_q.appended_bdid;
						unsigned6 bus_q_apbdid := 0,
						string bus_q_apfein := '',
						
						unsigned8 bususer_q_id := hash64(bususer_q.title + bususer_q.fname + bususer_q.mname + bususer_q.lname + bususer_q.name_suffix + bususer_q.Personal_Phone + bususer_q.DOB + bususer_q.SSN + bususer_q.prim_range + bususer_q.prim_name + bususer_q.sec_range + bususer_q.st + bususer_q.zip5),
						bususer_q_title := bususer_q.title,
						bususer_q_fname := bususer_q.fname,
						bususer_q_mname := bususer_q.mname,
						bususer_q_lname := bususer_q.lname,
						bususer_q_name_suffix := bususer_q.name_suffix,
						bususer_q_Personal_Phone := bususer_q.Personal_Phone,
						bususer_q_DOB := bususer_q.DOB,
						bususer_q_SSN := bususer_q.SSN,
						bususer_q_prim_range := bususer_q.prim_range,
						bususer_q_prim_name := bususer_q.prim_name,
						bususer_q_sec_range := bususer_q.sec_range,
						bususer_q_st := bususer_q.st,
						bususer_q_zip5 := bususer_q.zip5,
						bususer_q_apdidold := bususer_q.appended_adl;
						unsigned6 bususer_q_apdid := 0;
						string bususer_q_apssn := ''});
						
Trim_Base_File := dedup(sort(distribute(pTrim_Base_File, hash(bususer_q_id, bus_q_id, person_q_id)), bususer_q_id, bus_q_id, person_q_id, local), bususer_q_id, bus_q_id, person_q_id, local);

/////////////////DID and SSN//////////////////////////////////////////////////////////////////////////////////////////

did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(Trim_Base_File(person_q_fname <> '' and person_q_lname <> ''), did_match_set,
						person_q_ssn, person_q_dob, person_q_fname, person_q_mname, person_q_lname, person_q_name_suffix,
						person_q_prim_range, person_q_prim_name, person_q_sec_range, person_q_zip5, person_q_st, person_q_personal_phone,
						person_q_apdid, recordof(Trim_Base_File),false,'',
						75, person_q_apdid_file);

did_add.MAC_Match_Flex(Trim_Base_File(bususer_q_fname <> '' and bususer_q_lname <> ''), did_match_set,
						bususer_q_ssn, bususer_q_dob, bususer_q_fname, bususer_q_mname, bususer_q_lname, bususer_q_name_suffix,
						bususer_q_prim_range, bususer_q_prim_name, bususer_q_sec_range, bususer_q_zip5, bususer_q_st, bususer_q_personal_phone,
						bususer_q_apdid, recordof(Trim_Base_File),false,'',
						75, bususer_q_apdid_file);
						
bususer_q_apdid_ready := person_q_apdid_file + bususer_q_apdid_file + 
												 Trim_Base_File(~(bususer_q_fname <> '' and bususer_q_lname <> '') and ~(person_q_fname <> '' and person_q_lname <> ''));

/* //Append SSN  */

inSSNp := bususer_q_apdid_ready(person_q_apdid > 0);
inSSNbu := bususer_q_apdid_ready(bususer_q_apdid > 0);

did_add.MAC_Add_SSN_By_DID(inSSNp, person_q_apdid, person_q_apssn, out_ssn1, false);
did_add.MAC_Add_SSN_By_DID(inSSNbu, bususer_q_apdid, bususer_q_apssn, out_ssn2, false);

file_did_ssn := out_ssn1 + out_ssn2 +  bususer_q_apdid_ready(person_q_apdid + bususer_q_apdid = 0);

/////////////////BDID and FEIN//////////////////////////////////////////////////////////////////////////////////////////

file_pre_bdid_append := file_did_ssn(bus_q_cname <> '');

bdid_match_set := ['A','P','F'];  

Business_Header_SS.MAC_Match_Flex(file_pre_bdid_append, bdid_match_set,
									bus_q_cname,
									bus_q_prim_range, bus_q_prim_name, bus_q_zip5, bus_q_sec_range, bus_q_st, bus_q_company_phone, bus_q_ein,
									bus_q_apbdid, recordof(Trim_Base_File), 
									false, '', bus_q_apdid_file);

file_did_ssn_bdid := bus_q_apdid_file + file_did_ssn(bus_q_cname = '');

/* Append Fein */

inFEIN := file_did_ssn_bdid(bus_q_apbdid > 0);

Business_Header_SS.MAC_Add_FEIN_By_BDID(inFEIN, bus_q_apbdid, bus_q_apfein, outFEIN)

concat_all := outFEIN + file_did_ssn_bdid(bus_q_apbdid = 0);

output_for_remote_read := project(concat_all, 
																transform(reappend_layout,
																					self.change := map(left.bus_q_apbdid <> left.bus_q_apbdidold => true,
																														 left.bususer_q_apdid <> left.bususer_q_apdidold => true,
																														 left.person_q_apdid <> left.person_q_apdidold => true,
																														 false);
																					self := left))(change); // only output records with changes

// output_for_remote_read := dedup(sort(dOutput_for_remote_read, bususer_q_id, person_q_id, bus_q_id, local), bususer_q_id, person_q_id, bus_q_id, local);

buildDate := if(pBuildDate = '', ut.GetDate, pBuildDate);

export buildFile := 
					sequential(
						output(output_for_remote_read,,'~thor_data400::out::inquiry_acclogs::' + buildDate + '::'+FCRAtag+'reappend_records',__compressed__, overwrite);
						fileservices.promotesuperfilelist(['~thor_data400::out::inquiry_acclogs::'+FCRAtag+'reappend_records',
																							 '~thor_data400::out::inquiry_acclogs::'+FCRAtag+'reappend_records::delete'],
																							 '~thor_data400::out::inquiry_acclogs::' + buildDate + '::'+FCRAtag+'reappend_records', true);
						update_bversion, update_hversion);			

empty_hash := 14695981039346656037; // data fields to append IDs are empty

HashBaseFile :=project(base_file, 
// export HashBaseFile := distribute(project(choosen(inquiry_acclogs.fn_ProdHist().File(person_q.appended_adl > 0), 10000), 
														transform({unsigned8 person_q_id, unsigned8 bus_q_id, unsigned8 bususer_q_id, recordof(base_file)},
															self.person_q_id := hash64(left.person_q.title + left.person_q.fname + left.person_q.mname + left.person_q.lname + left.person_q.name_suffix + left.person_q.Work_Phone + left.person_q.Personal_Phone + left.person_q.DOB + left.person_q.SSN + left.person_q.prim_range + left.person_q.prim_name + left.person_q.sec_range + left.person_q.st + left.person_q.zip5),
															self.bus_q_id := hash64(left.bus_q.CName + left.bus_q.Company_Phone + left.bus_q.EIN + left.bus_q.prim_range + left.bus_q.prim_name + left.bus_q.sec_range + left.bus_q.st + left.bus_q.zip5),
															self.bususer_q_id := hash64(left.bususer_q.title + left.bususer_q.fname + left.bususer_q.mname + left.bususer_q.lname + left.bususer_q.name_suffix + left.bususer_q.Personal_Phone + left.bususer_q.DOB + left.bususer_q.SSN + left.bususer_q.prim_range + left.bususer_q.prim_name + left.bususer_q.sec_range + left.bususer_q.st + left.bususer_q.zip5),
															self := left));

dHashBaseFile := distribute(HashBaseFile(bususer_q_id <> empty_hash or person_q_id <> empty_hash or bus_q_id <> empty_hash), 
																hash(bususer_q_id, person_q_id, bus_q_id));

dFile := distribute(File, hash(bususer_q_id, person_q_id, bus_q_id));



JoinIDedToHashedBase := join(dHashBaseFile, dFile,
															left.person_q_id = right.person_q_id and
															left.bus_q_id = right.bus_q_id and
															left.bususer_q_id = right.bususer_q_id,
															transform(recordof(HashBaseFile),
																	self.person_q.appended_adl := if(right.person_q_id > 0, right.person_q_apdid, left.person_q.appended_adl);
																	self.person_q.appended_ssn := if(right.person_q_id > 0, right.person_q_apssn, left.person_q.appended_ssn);
																	self.bususer_q.appended_adl := if(right.person_q_id > 0, right.bususer_q_apdid, left.bususer_q.appended_adl);
																	self.bususer_q.appended_ssn := if(right.person_q_id > 0, right.bususer_q_apssn, left.bususer_q.appended_ssn);
																	self.bus_q.appended_bdid := if(right.person_q_id > 0, right.bus_q_apbdid, left.bus_q.appended_bdid);
																	self.bus_q.appended_ein := if(right.person_q_id > 0, right.bus_q_apfein, left.bus_q.appended_ein);
																	self := left), left outer, local, keep(1));

concat_all := JoinIDedToHashedBase + HashBaseFile(person_q_id = empty_hash and bus_q_id = empty_hash and bususer_q_id = empty_hash);

history_filename_old := fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name;
history_filename_new := history_filename_old+'::'+ut.GetDate+'_reappend';

export AppendNewIDs := sequential(
									output(project(concat_all, recordof(base_file)),,'~'+history_filename_new, __compressed__, overwrite, cluster('thor400_92'));
									fileservices.promotesuperfilelist(['~thor_data400::out::inquiry_tracking::weekly_historical',
																										 '~thor_data400::out::inquiry_tracking::weekly_historical_father'],
																										 '~'+history_filename_new, true)
									);


export Do_Appends := sequential(buildFile, AppendNewIDs);


end;