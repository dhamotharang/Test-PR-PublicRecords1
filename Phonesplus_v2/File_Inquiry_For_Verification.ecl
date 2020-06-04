import didville, inquiry_acclogs, ut, did_Add, std;
vToday := (STRING8)Std.Date.Today();

inq_file  := pull(inquiry_acclogs.Key_Inquiry_DID
				(person_q.fname <> '' and person_q.lname <> ''
					and person_q.personal_phone <> '' 
					and search_info.datetime[1..4] between ut.date_math(vToday, -365)[..4] and vToday[..4]
				    and regexreplace('[^A-Z]',stringlib.stringtouppercase(search_info.function_description),  '') in
					['FRAUDPOINT','INSTANTID','INSTANTIDFRAUDDEFENDERSEARCH','INSTANTIDMODELSEARCH','RISKINDICATORSINSTANTIDBATCH']));

Trim_Base_File := dedup(sort(distribute(table(inq_file, {
						person_q_title := person_q.title,
						person_q_fname := person_q.fname,
						person_q_mname := person_q.mname,
						person_q_lname := person_q.lname,
						person_q_name_suffix := person_q.name_suffix,
						person_q_Personal_Phone := person_q.Personal_Phone,
						person_q_DOB := person_q.DOB,
						person_q_SSN := person_q.SSN,
						person_q_prim_range := person_q.prim_range,
						person_q_prim_name := person_q.prim_name,
						person_q_sec_range := person_q.sec_range,
						person_q_st := person_q.st,
						person_q_zip5 := person_q.zip5,
						unsigned6 person_q_apdid := 0;
						string person_q_apssn := '';
						bus_intel.vertical;
						bus_intel.industry;
						search_info.function_description,
						search_info.method,
						datetime := search_info.datetime[1..8]}), hash(person_q_Personal_Phone)), 
					person_q_Personal_Phone, -datetime, local), person_q_Personal_Phone, local);

//inq := dataset ('~out::inquiry_acclogs::phone_validation_input_1yr', inq_ly, thor)(length(trim(person_q_personal_phone, all)) = 10 and person_q_apdid > 0);
//-----Did file
did_match_set := ['A','D','S','P','4','Z'];

did_add.MAC_Match_Flex(Trim_Base_File, did_match_set,
						person_q_ssn, person_q_dob, person_q_fname, person_q_mname, person_q_lname, person_q_name_suffix,
						person_q_prim_range, person_q_prim_name, person_q_sec_range, person_q_zip5, person_q_st, person_q_personal_phone,
						person_q_apdid, recordof(Trim_Base_File),false,'',
						75, person_q_apdid_file);
//----Append HHID						
hh_id_rec := record
recordof(person_q_apdid_file);
unsigned did;
unsigned hhid := 0;
end;

inq_r := project(person_q_apdid_file, transform(hh_id_rec, self.did := left.person_q_apdid, self := left));

didville.MAC_HHID_Append(     		inq_r, 
									'HHID_NAMES', 
									Append_HHID);


export File_Inquiry_For_Verification := Append_HHID : persist('~out::inquiry_acclogs::phone_validation_input_1yr_hhid');