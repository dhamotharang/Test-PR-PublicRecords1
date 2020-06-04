 /*2016-04-24T19:10:38Z (jhuang_prod)
C:\Users\huangzx\AppData\Roaming\HPCC Systems\eclide\jhuang_prod\ProdThorBoca\Inquiry_AccLogs\fnMapBaseAppendsJennyNew\2016-04-24T19_10_38Z.ecl
*/
import ut,data_services, address, aid, lib_stringlib, address, did_add, Business_Header_SS, header_slimsort, watchdog, business_header;


/* hashes fields used to did, bdid. only outputs records that have changes (new or update) */
export fnMapBaseAppendsJennynew(boolean isFCRA = false,
																string version = ut.GetDate)  := module

Non_Batch_Base 						:= File_Inquiry_MBS(source<>'BATCH'); 

Batch_D2C_filtered_Base   := File_Inquiry_MBS(source='BATCH' and 
																							~(bus_intel.industry = 'DIRECT TO CONSUMER' and 
																								search_info.function_description in [
																								'ADDRBEST.BESTADDRESSBATCHSERVICE'
																								,'BATCHSERVICES.AKABATCHSERVICE'
																								,'BATCHSERVICES.DEATHBATCHSERVICE'
																								,'BATCHSERVICES.EMAILBATCHSERVICE'
																								,'BATCHSERVICES.PROPERTYBATCHSERVICE'
																								,'DIDVILLE.DIDBATCHSERVICERAW'
																								,'DIDVILLE.RANBESTINFOBATCHSERVICE'
																								,'PROGRESSIVEPHONE.PROGRESSIVEPHONEWITHFEEDBACKBATCHSERVICE']
																								)
																						);   
D2C_filtered_base := Non_Batch_Base + Batch_D2C_filtered_Base;

base_file_before_usa_filter:=project(D2C_filtered_base(
                       ~(mbs.company_id = '1446154' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201303' and '201304') and //TEMPORARY
											 ~(mbs.company_id = '1590195' and search_info.product_code = '1' and search_info.function_description = 'RISKINDICATORS.FLEXIDBATCHSERVICE' and search_info.datetime[..6] between '201304' and '201304') and //TEMPORARY
											 ~((mbs.company_id = '1534586' or mbs.global_company_id = '16952912') and search_info.function_description = 'FRAUDPOINT' and search_info.datetime[..6] between '201301' and '201302') and //TEMPORARY
 											 ~(mbs.company_id = '1015303' and search_info.datetime[..8] between '20160121' and '20160908') and
											  ~inquiry_acclogs.fnTranslations.is_SubMarketFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_IndustryFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_VerticalFilter(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Disable_Observation(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_Internal(allow_flags.allowflags) and
												~inquiry_acclogs.fnTranslations.is_AdditionalHealthcare(allow_flags.allowflags) and
												~search_info.function_description[1..4] ='FCRA' and
												~search_info.function_description[1..8]='RISKVIEW' AND
											 mbs.company_id + mbs.global_company_id <> ''),Inquiry_AccLogs.Layout.Common_ThorAdditions_non_FCRA);

// Apply USA filter
File_MBS 					:= Inquiry_AccLogs.File_MBS.File;
NonBatch_Base    	:= base_file_before_usa_filter(source not in ['BATCHR3','BATCH']);
Batch_Base    		:= base_file_before_usa_filter(source in ['BATCHR3','BATCH']);

jnByProd		 	:= join(NonBatch_Base, FILE_MBS, 
										 left.search_info.product_code   = right.product_id and                    
										 left.mbs.company_id = right.company_id, 
										 left outer, lookup);	

jnSubAccd    	:= join(project(jnByProd(sub_acct_id = ''), recordof(NonBatch_Base)), File_MBS,  
											 trim(left.mbs.global_company_id,all) = trim(right.gc_id,all),
												left outer, lookup);						

NonBatch_Base_MBS				:= jnByProd(sub_acct_id <> '') + jnSubAccd;

Batch_Base_MBS		    	:= join(Batch_Base, FILE_MBS,  
													 trim(left.mbs.global_company_id,all) = trim(right.gc_id,all),
														left outer, lookup);						

Full_Base_MBS   := NonBatch_Base_MBS + Batch_Base_MBS;

USA_Base_MBS       := Full_Base_MBS(country = 'UNITED STATES');

USA_Base := project(USA_Base_MBS, Inquiry_AccLogs.Layout.Common_ThorAdditions_non_FCRA);

//////////////////////////////////////////////////////////

export Base_File := USA_Base;

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
export file := dataset(data_services.foreign_prod+'thor_data400::out::inquiry_acclogs::reappend_records', reappend_layout, thor);

/* !!!!!!!!!!!!!!!!! CHECK UPDATES - Roxie SCOps having issue - Cause WU to crash !!!!!!!!!!!!!!!!!!!!! */

// export hversion := did_add.get_EnvVariable('header_file_version');
// export bversion := did_add.get_EnvVariable('bheader_file_version');

// export is_hversion_New := ut.IsNewProdHeaderVersion('inquiry_acclogs','header_file_version');
// export is_bversion_New := ut.IsNewProdHeaderVersion('inquiry_acclogs','bheader_file_version');

// export update_hversion := ut.PostDID_HeaderVer_Update('inquiry_acclogs','header_file_version');
// export update_bversion := ut.PostDID_HeaderVer_Update('inquiry_acclogs','bheader_file_version');

// export IQbuild_header_version := dataset(ut.foreign_prod + 'thor_data400::flag::inquiry_acclogs::'+FCRAtag+'prodheaderversion',{string10 prodheaderdate, string pkgvariable},thor)(pkgvariable = 'header_file_version')[1].prodheaderdate;
// export IQbuild_bheader_version := dataset(ut.foreign_prod + 'thor_data400::flag::inquiry_acclogs::'+FCRAtag+'prodheaderversion',{string10 prodheaderdate, string pkgvariable},thor)(pkgvariable = 'bheader_file_version')[1].prodheaderdate;

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

prev_reappend_version_filenf	:= nothor(fileservices.superfilecontents(data_services.foreign_prod+'thor_data400::out::inquiry_acclogs::reappend_records')[1].name);
prev_reappend_version_filef 	:= nothor(fileservices.superfilecontents(data_services.foreign_prod+'thor_data400::out::inquiry_acclogs::fcra::reappend_records')[1].name);
prev_reappend_version_file 		:= if(isFCRA,prev_reappend_version_filef,prev_reappend_version_filenf);
prev_reappend_version 				:= prev_reappend_version_file[stringlib.stringfind(prev_reappend_version_file, '::', 3) + 2..stringlib.stringfind(prev_reappend_version_file, '::', 4) -1];

header_date := did_add.get_EnvVariable('header_file_version');

buildDate := version;


export buildFile := if(header_date >= prev_reappend_version,
					sequential(
						output(output_for_remote_read,,'~thor_data400::out::inquiry_acclogs::' + version + '::'+FCRAtag+'reappend_records',__compressed__, overwrite);
						nothor(fileservices.promotesuperfilelist(['~thor_data400::out::inquiry_acclogs::'+FCRAtag+'reappend_records',
																							 '~thor_data400::out::inquiry_acclogs::'+FCRAtag+'reappend_records::delete'],
																							 '~thor_data400::out::inquiry_acclogs::' + version + '::'+FCRAtag+'reappend_records', true))));
						// update_bversion, update_hversion);			

s(string inT) := (unsigned)stringlib.stringfind(inT, '::', 6) + 2;
e(string inT) := (unsigned)stringlib.stringfind(inT, '_', 3) - 1;

hist := nothor(fileservices.superfilecontents('~thor_data400::out::inquiry_tracking::weekly_historical')[1].name);
shared hist_version:= hist[s(hist)..e(hist)];				
				keeplist := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
				
			 
empty_hash := hash64(' ');  // data fields to append IDs are empty

HashBaseFile :=project(base_file, 
														transform({unsigned8 person_q_id, unsigned8 bus_q_id, unsigned8 bususer_q_id, 
																			 integer8 seqcnt := 0, integer8 daysbetween := 0, boolean m2flag := false,
																			 recordof(base_file)},
															self.person_q_id := hash64(left.person_q.title + left.person_q.fname + left.person_q.mname + left.person_q.lname + left.person_q.name_suffix + left.person_q.Work_Phone + left.person_q.Personal_Phone + left.person_q.DOB + left.person_q.SSN + left.person_q.prim_range + left.person_q.prim_name + left.person_q.sec_range + left.person_q.st + left.person_q.zip5),
															self.bus_q_id := hash64(left.bus_q.CName + left.bus_q.Company_Phone + left.bus_q.EIN + left.bus_q.prim_range + left.bus_q.prim_name + left.bus_q.sec_range + left.bus_q.st + left.bus_q.zip5),
															self.bususer_q_id := hash64(left.bususer_q.title + left.bususer_q.fname + left.bususer_q.mname + left.bususer_q.lname + left.bususer_q.name_suffix + left.bususer_q.Personal_Phone + left.bususer_q.DOB + left.bususer_q.SSN + left.bususer_q.prim_range + left.bususer_q.prim_name + left.bususer_q.sec_range + left.bususer_q.st + left.bususer_q.zip5),
																	
															self.search_info.datetime		:= Inquiry_AccLogs.fncleanfunctions.tTimeAdded(left.search_info.datetime);
															self.search_info.function_description	:= Inquiry_AccLogs.fncleanfunctions.fnCleanUp(left.search_info.function_description);
															self.mbs.company_id 				:= '';
															self.mbs.global_company_id 	:= '';
															SELF.Search_info.start_monitor	:= if(left.bus_intel.use<>'' and SELF.search_info.datetime[..8] <> '', SELF.search_info.datetime[..8], left.search_info.start_monitor);
															SELF.Search_info.stop_monitor	:= if(left.bus_intel.use<>'' and SELF.search_info.datetime[..8] <> '', SELF.search_info.datetime[..8], left.search_info.stop_monitor);
															self.bus_intel.sub_market := if(left.bus_intel.sub_market='CARD','CARDS',left.bus_intel.sub_market);
															self := left));

dHashBaseFile := distribute(HashBaseFile(bus_intel.use <> ''), 
																hash(bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id));
																
gsHashBaseFile := sort(dHashBaseFile, 
												bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id ,search_info.datetime[..8], local);

iHashBaseFile := iterate(gsHashBaseFile, transform({recordof(gsHashBaseFile)},
												fDaysBetween(string dt_l, string dt_r) := ut.DaysApart(dt_l, dt_r);
												matches := left.bus_intel.industry = right.bus_intel.industry and
																		left.bus_intel.sub_market = right.bus_intel.sub_market and
																		left.bus_intel.vertical = right.bus_intel.vertical and
																		left.bus_INTEL.USE = right.bus_INTEL.USE and
																		left.allow_flags.allowflags = right.allow_flags.allowflags and
																		left.search_info.product_code = right.search_info.product_code and
																		left.search_info.method = right.search_info.method and
																		left.search_info.function_description = right.search_info.function_description and
																		left.bususer_q_id = right.bususer_q_id and
																		left.person_q_id = right.person_q_id and
																		left.bus_q_id = right.bus_q_id;
 
												self.DaysBetween 		:= fDaysBetween(if(~matches, right.search_info.datetime[..8], left.search_info.datetime[..8]), right.search_info.datetime[..8]);
												self.M2flag 				:= self.DaysBetween > 60 or ~matches; //greater than 2 months or new record
												self.seqcnt					:= map(~matches => 1, self.M2flag => counter, left.seqcnt);
												self.search_info.start_monitor	:= map(self.M2flag => right.search_info.start_monitor[..8], (string)ut.Min2((integer)left.search_info.start_monitor[..8],(integer) right.search_info.start_monitor[..8]));
												self.search_info.stop_monitor		:= map(self.M2flag => right.search_info.stop_monitor[..8], (string)ut.max2((integer)left.search_info.stop_monitor[..8],(integer) right.search_info.stop_monitor[..8]));
												self := right), local);

ddHashBaseFile := dedup(iHashBaseFile, bus_intel.industry, bus_intel.sub_market, bus_intel.vertical, bus_INTEL.USE, allow_flags.allowflags, search_info.product_code, search_info.method, search_info.function_description, bususer_q_id, person_q_id, bus_q_id, seqcnt, right, local);
Correct_Function_Descriptions := 
						join((HashBaseFile(bus_intel.use = '') + ddHashBaseFile), dedup(File_Function_Description_Rollups,rollup_string,all),
									right.rollup_string = stringlib.stringfilter(left.search_info.function_description, keeplist),
									transform({recordof(ddHashBaseFile)},
										self.search_info.function_description := if(right.rollup_string <> '', right.selected_version, left.search_info.function_description);
										self := left), lookup, left outer);
rolledHashBaseFile := dedup(sort(distribute(Correct_Function_Descriptions,Hash(person_q.lname, person_q.fname, search_info.product_code, search_info.transaction_type, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description)),
															person_q.lname, person_q.fname, search_info.product_code, search_info.transaction_type, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local),
															person_q.lname, person_q.fname, search_info.product_code, search_info.transaction_type, search_info.transaction_id, search_info.login_history_id, search_info.datetime, search_info.sequence_number, search_info.function_description, local);
			
rdyHashBaseFile := distribute(rolledHashBaseFile(bususer_q_id <> empty_hash or person_q_id <> empty_hash or bus_q_id <> empty_hash), 
												hash(bususer_q_id, person_q_id, bus_q_id));

dFile := distribute(File, hash(bususer_q_id, person_q_id, bus_q_id));

JoinIDedToHashedBase := join(rdyHashBaseFile, dFile,
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

shared concat_all := JoinIDedToHashedBase + rolledHashBaseFile(person_q_id = empty_hash and bus_q_id = empty_hash and bususer_q_id = empty_hash);

history_filename_new := '~thor_data400::out::inquiry::'+hist_version+'::mbs::append_previous::'+version+'_reappend':INDEPENDENT;
 
outMBSBaseAppend :=project(concat_all, recordof(base_file ));



export AppendNewIDs := sequential(
												output(outMBSBaseAppend,,'~'+history_filename_new, __compressed__, overwrite);
												fileservices.promotesuperfilelist(['~thor_data400::out::inquiry_tracking::weekly_historical',
																													 '~thor_data400::out::inquiry_tracking::weekly_historical_father'],
																													 '~'+history_filename_new, true));

export AppendNewIDs_FCRA := concat_all;

export Do_Appends := sequential(buildFile, AppendNewIDs);


end;