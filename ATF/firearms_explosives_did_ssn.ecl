import BIPV2,DID_Add,ut,census_data,business_header_ss,mdr,header,TopBusiness_External;

export  firearms_explosives_did_ssn 
(
	 dataset(layout_firearms_explosives_in) pInfile		= file_firearms_explosives_in
) := 
function

infile := pInfile;

TempRec := record
	unsigned6	did := 0;
	unsigned1	score := 0;
	unsigned1	rec_code := 0;
	// 1=person1,License_Name,premise
	// 2=person1,License_Name,mail
	// 3=person1,Business_Name,premise
	// 4=person1,Business_Name,mail
	// 5=person2,License_Name,premise
	// 6=person2,License_Name,mail
	// 7=person2,Business_Name,premise
	// 8=person2,Business_Name,mail
	unsigned6 ubdid := 0;
	unsigned2 ubdid_score := 0;
  string11 trim_phone := '';
	qstring10 phone10;
	string2 src;
	qSTRING5  title;
	qSTRING20 fname;
	qSTRING20 mname;
	qSTRING20 lname;
	qSTRING5  suffix;
	qstring60 company_name;
	qSTRING10 prim_range;
	qSTRING2  predir;
	qSTRING28 prim_name;
	qSTRING4  addr_suffix;
	qSTRING2  postdir;
	qSTRING10 unit_desig;
	qSTRING8  sec_range;
	qSTRING25 p_city_name;
	qSTRING2  st;
	qSTRING5  z5;
	qSTRING4  zip4;
	string1 record_type;
  layout_firearms_explosives_out_bip;
end;

TempRec addDID(layout_firearms_explosives_in L):= transform
   license1_lname_is_null := L.license1_fname = '' AND L.license1_mname = '' AND L.license1_lname = 'NULL';
   license2_lname_is_null := L.license2_fname = '' AND L.license2_mname = '' AND L.license2_lname = 'NULL';

   self.license1_lname := IF(license1_lname_is_null, '', TRIM(L.license1_lname, LEFT, RIGHT));
   self.license2_lname := IF(license2_lname_is_null, '', TRIM(L.license2_lname, LEFT, RIGHT));
   self.license_number	:= TRIM(ut.fn_KeepPrintableChars(L.license_number),LEFT,RIGHT);
   self.Lic_Regn	:= TRIM(L.Lic_Regn,LEFT,RIGHT);
   self.orig_Lic_Dist	:= TRIM(L.orig_Lic_Dist,LEFT,RIGHT);
   self.Lic_Dist	:= TRIM(L.Lic_Dist,LEFT,RIGHT);
   self.Lic_Cnty	:= TRIM(L.Lic_Cnty,LEFT,RIGHT);
   self.Lic_Type	:= TRIM(L.Lic_Type,LEFT,RIGHT);
   self.Lic_Xprdte	:= TRIM(L.Lic_Xprdte,LEFT,RIGHT);
   self.Lic_Seqn	:= TRIM(L.Lic_Seqn,LEFT,RIGHT);
   self.License_Name	:= if(L.License_Name='NULL','',TRIM(L.License_Name,LEFT,RIGHT));
   self.Business_Name	:= if(L.Business_Name='NULL','',TRIM(L.Business_Name,LEFT,RIGHT));
   self.License1_cName	:= if(L.License1_cName='NULL','',TRIM(L.License1_cName,LEFT,RIGHT));
   self.Business_cName	:= if(L.Business_cName='NULL','',TRIM(L.Business_cName,LEFT,RIGHT));
   self.Premise_Street	:= TRIM(L.Premise_Street,LEFT,RIGHT);
   self.Premise_City	:= TRIM(L.Premise_City,LEFT,RIGHT);
   self.Premise_State	:= TRIM(L.Premise_State,LEFT,RIGHT);
   self.Premise_orig_Zip	:= TRIM(L.Premise_orig_Zip,LEFT,RIGHT);
   self.Mail_Street	:= TRIM(L.Mail_Street,LEFT,RIGHT);
   self.Mail_City	:= TRIM(L.Mail_City,LEFT,RIGHT);
   self.Mail_State	:= TRIM(L.Mail_State,LEFT,RIGHT);
   self.Mail_Zip_Code	:= TRIM(L.Mail_Zip_Code,LEFT,RIGHT);
   self.Voice_Phone	:= TRIM(L.Voice_Phone,LEFT,RIGHT);
   self.irs_region	:= TRIM(L.irs_region,LEFT,RIGHT);
	self.trim_phone := trim(l.Voice_Phone, all);
	self.source := if(l.record_type='F',MDR.sourceTools.src_Federal_Firearms,MDR.sourceTools.src_Federal_Explosives);
	self := l;
	self := [];
end;

infile_seq0 := project(infile,addDID(left));
ut.MAC_Sequence_Records(infile_seq0,seq,infile_seq);

TempRec norm(TempRec L, integer C) := transform
	self.rec_code	:= c;
//this is so that if we only have one name all records get the same name - easier to dedup :)
	self.fname 	:= map(c in [1,2,3,4] =>
												if(l.license1_fname<>'',l.license1_fname, l.license2_fname)
												,if(l.license2_fname<>'',l.license2_fname, l.license1_fname)
												);
	self.mname 	:= map(c in [1,2,3,4] =>
												if(l.license1_mname<>'',l.license1_mname, l.license2_mname)
												,if(l.license2_mname<>'',l.license2_mname, l.license1_mname)
												);
	self.lname 	:= map(c in [1,2,3,4] =>
												if(l.license1_lname<>'',l.license1_lname, l.license2_lname)
												,if(l.license2_lname<>'',l.license2_lname, l.license1_lname)
												);
	self.suffix 	:= map(c in [1,2,3,4] =>
												if(l.license1_name_suffix<>'',l.license1_name_suffix, l.license2_name_suffix)
												,if(l.license2_name_suffix<>'',l.license2_name_suffix, l.license1_name_suffix)
												);
	self.company_name 	:= map(c in [1,2,5,6] =>
														if(l.license1_cname<>'',l.license1_cname, l.business_cname)
														,if(l.business_cname<>'',l.business_cname, l.license1_cname)
														);
	self.prim_range := map(c in [2,4,6,8] =>
														if(l.mail_prim_range<>'',l.mail_prim_range, l.premise_prim_range)
														,if(l.premise_prim_range<>'',l.premise_prim_range, l.mail_prim_range)
														);
	self.predir := map(c in [2,4,6,8] =>
														if(l.mail_predir<>'',l.mail_predir, l.premise_predir)
														,if(l.premise_predir<>'',l.premise_predir, l.mail_predir)
												);
	self.prim_name := map(c in [2,4,6,8] =>
														if(l.mail_prim_name<>'',l.mail_prim_name, l.premise_prim_name)
														,if(l.premise_prim_name<>'',l.premise_prim_name, l.mail_prim_name)
												);
	self.addr_suffix := map(c in [2,4,6,8] =>
														if(l.mail_suffix<>'',l.mail_suffix, l.premise_suffix)
														,if(l.premise_suffix<>'',l.premise_suffix, l.mail_suffix)
														);
	self.postdir := map(c in [2,4,6,8] =>
														if(l.mail_postdir<>'',l.mail_postdir, l.premise_postdir)
														,if(l.premise_postdir<>'',l.premise_postdir, l.mail_postdir)
														);
	self.unit_desig := map(c in [2,4,6,8] =>
														if(l.mail_unit_desig<>'',l.mail_unit_desig, l.premise_unit_desig)
														,if(l.premise_unit_desig<>'',l.premise_unit_desig, l.mail_unit_desig)
														);
	self.sec_range := map(c in [2,4,6,8] =>
														if(l.mail_sec_range<>'',l.mail_sec_range, l.premise_sec_range)
														,if(l.premise_sec_range<>'',l.premise_sec_range, l.mail_sec_range)
														);
	self.p_city_name := map(c in [2,4,6,8] =>
														if(l.mail_p_city_name<>'',l.mail_p_city_name, l.premise_p_city_name)
														,if(l.premise_p_city_name<>'',l.premise_p_city_name, l.mail_p_city_name)
														);
	self.st := map(c in [2,4,6,8] =>
														if(l.mail_state<>'',l.mail_state, l.premise_State)
														,if(l.premise_State<>'',l.premise_State, l.mail_state)
														);
	self.z5 := map(c in [2,4,6,8] =>
														if(l.mail_zip<>'',l.mail_zip, l.premise_zip)
														,if(l.premise_zip<>'',l.premise_zip, l.mail_zip)
														);
	self.phone10 := stringlib.StringFilter(trim(l.Voice_Phone), '0123456789');
	self.src := l.source;
	self := L;
	self := [];
end;

in_ready := normalize(infile_seq,8,norm(LEFT,COUNTER));//((fname<>'' and lname<>'') or company_name<>'');

matchset := ['A','P'];

DID_Add.MAC_Match_Flex(in_ready,matchset,junk,junk,fname,mname,
	lname,suffix,prim_range,prim_name,sec_range,
	z5,st,phone10,
	did,TempRec,true,score, 
	75,out1_src,true,src)
	
//remove source

TempRec forthem(TempRec l) := transform
	self.DID_out := if (l.did = 0,'',intformat(l.did, 12, 1));
	self.d_score := intformat(l.score,3,1);
	self:=l
end;
	
withdid := project(out1_src,forthem(LEFT));

did_add.MAC_Add_SSN_By_DID(withdid,did,best_ssn,ssn_records);

TempRec get_county_name(TempRec l,Census_data.File_Fips2County R) := transform
	self.premise_fips_county_name := R.county_name;
	self := l;
end;

final_did_out := join(ssn_records,Census_data.File_Fips2County,left.premise_fips_county = right.county_fips and
				left.premise_state = right.state_code,get_county_name(LEFT,RIGHT),left outer, lookup);

Address.Mac_Is_Business(final_did_out,company_name,atf_with_nametype,dodedup := false);

atf_Entity 		:= atf_with_nametype(company_name != '');
atf_nonEntity := atf_with_nametype(company_name  = '');

// keep only the business records
atf_bus 	:= atf_Entity(nameType  = 'B');
atf_other := atf_Entity(nameType != 'B');

// now do the exact source match to bus headers
Business_Header.MAC_Source_Match(atf_bus, atf_bus_BDID_Init,
                        FALSE, ubdid,
                        true, src,
                        TRUE, license_number,
                        company_name,
                        prim_range, prim_name, sec_range, z5,
                        TRUE, phone10,
                        FALSE, ein,
				    TRUE, license_number);

// Then do a standard BDID match for the records which did not BDID,
// since the ATF file may be newer than the Business Headers
BDID_Matchset := ['A', 'P'];

atf_bus_BDID_Match := atf_bus_BDID_Init(ubdid <> 0);
atf_bus_BDID_NoMatch := atf_bus_BDID_Init(ubdid = 0);

//add score to matches of 100 percent
TempRec  add_bdidscore(atf_bus_BDID_Match l) := transform
self.ubdid_score := 100;
self := L;
end;

atf_bus_BDID_Match_score := project(atf_bus_BDID_Match, add_bdidscore(left))
													+ project(atf_bus_BDID_NoMatch, TempRec);

//match nomatches using macro
Business_Header_SS.MAC_Add_BDID_Flex(atf_bus_BDID_Match_score  // Input Dataset
                                     ,BDID_Matchset           // BDID Matchset
                                     ,company_name            // company_name
                                     ,prim_range              // prim_range
																		 ,prim_name               // prim_name
																		 ,z5                      // zip5
                                     ,sec_range               // sec_range
																		 ,st                      // state
                                     ,phone10                 // phone
																		 ,ein                     // fein
                                     ,ubdid                    // bdid
																		 ,TempRec       // Output Layout
                                     ,true                    // output layout has bdid score field?
																		 ,ubdid_score              // bdid_score
                                     ,atf_bus_BDID_Rematch    // Output Dataset   
	                                   ,												// deafult threscold
	                                   ,											  // use prod version of superfiles
                                     ,												// default is to hit prod from dataland, and on prod hit prod.		
	                                   ,BIPV2.xlink_version_set // Create BIP Keys only
	                                   ,           					   	// Url
	                                   ,								        // Email
	                                   ,p_city_name			    		// City
	                                   ,fname         		      // fname
                                     ,mname         	      	// mname
	                                   ,lname         	        // lname
  																	 ,                        // contact_ssn
																		 ,                        // source - MDR.sourceTools
																		 ,                        // source_record_id
																		 ,FALSE                   // src_matching_is_priority
                                     );

atf_bus_BDID_All := atf_bus_BDID_Rematch
									+ project(atf_other, TempRec)
									+ project(atf_nonEntity, TempRec);

TempRec matchback(TempRec l) := transform
	self.bdid := if (l.ubdid = 0,'',intformat(l.ubdid, 12, 1));
	self.bdid_score := intformat(l.ubdid_score,3,1);
	self := L;
end;
	
final_out := project(atf_bus_BDID_All,matchback(LEFT));

//Add raw record ID using hash on non-LN generated fields
final_out_id	:= project(final_out, transform(TempRec,
					self.persistent_record_id	:= HASH64(
																				left.rec_code,
																				trim(left.license_number,left,right),
																				trim(left.Lic_Regn,left,right),
																				trim(left.Lic_Dist,left,right),
																				trim(left.Lic_Cnty,left,right),
																				trim(left.Lic_Type,left,right),
																				trim(left.Lic_Xprdte,left,right),
																				trim(left.License_Name,left,right),
																				trim(left.Business_Name,left,right),
																				trim(left.Premise_Street,left,right),
																				trim(left.Premise_City,left,right),
																				trim(left.Premise_State,left,right),
																				trim(left.Premise_orig_Zip,left,right),
																				trim(left.Mail_Street,left,right),
																				trim(left.Mail_City,left,right),
																				trim(left.Mail_State,left,right), 
																				trim(left.Mail_Zip_Code,left,right),
																				trim(left.Voice_Phone,left,right),
																				trim(left.license1_fname,left,right),
																				trim(left.license1_mname,left,right),
																				trim(left.license1_lname,left,right),
																				trim(left.license1_name_suffix,left,right),
																				trim(left.license1_cname,left,right),
																				trim(left.license2_fname,left,right),
																				trim(left.license2_mname,left,right),
																				trim(left.license2_lname,left,right),
																				trim(left.license2_name_suffix,left,right),
																				trim(left.license2_cname,left,right),
																				trim(left.business_cname,left,right)
																				)
																				, self := left))
																				:persist('~thor400_data::persist::final_out_id')
																				; 
d:=distribute(final_out_id,seq);

noid := dedup(sort(d(did=0,ubdid=0),seq,rec_code,local),seq,local);

with_did_p1 := d(did>0,rec_code<5);
with_did_dedup_p1
							:= dedup(
										sort(
													with_did_p1,seq,-score,rec_code
												,local)
														,seq
													,local);
with_did_p2 := d(did>0,rec_code>4);
with_did_dedup_p2
							:= dedup(
										sort(
													with_did_p2,seq,-score,rec_code
												,local)
														,seq
													,local);

with_bdid_b1 := d(ubdid>0,rec_code in [3,4,7,8]);
with_bdid_dedup_b1
							:= dedup(
										sort(
													with_bdid_b1,seq,-ubdid_score,if(ubdid_score=0,999999999999,ubdid),rec_code
												,local)
														,seq
													,local);
with_bdid_b2 := d(ubdid>0,rec_code in [1,2,5,6]);
with_bdid_dedup_b2
							:= dedup(
										sort(
													with_bdid_b2,seq,-ubdid_score,if(ubdid_score=0,999999999999,ubdid),rec_code
												,local)
														,seq
													,local);

ds0 := with_did_dedup_p1 + with_did_dedup_p2 + with_bdid_dedup_b1 + with_bdid_dedup_b2;
ds:=dedup(sort(distribute(ds0,seq),seq,rec_code,local),record,except rec_code,persistent_record_id,local);

j:=join(ds,noid
				,left.seq=right.seq
				,transform(right)
				,right only
				,local
				);

final0 := sort(distribute(ds+j,hash(license_number))
																					,did
																					,bdid
																					,license_number
																					,Lic_Regn
																					,Lic_Dist
																					,Lic_Cnty
																					,Lic_Type
																					,Lic_Xprdte
																					,License_Name
																					,Business_Name
																					,Premise_Street
																					,Premise_City
																					,Premise_State
																					,Premise_orig_Zip
																					,Mail_Street
																					,Mail_City
																					,Mail_State 
																					,Mail_Zip_Code
																					,Voice_Phone
																					,local);

TempRec rollem(TempRec l, TempRec r) := transform
	self.date_first_seen := (string)ut.min2((unsigned)l.date_first_seen,(unsigned)r.date_first_seen);
	self.date_last_seen  := (string)ut.max2((unsigned)l.date_last_seen, (unsigned)r.date_last_seen);
	self := L;
end;

final1 := rollup(final0,rollem(left,right)
																			,did
																			,bdid
																			,license_number
																			,Lic_Regn
																			,Lic_Dist
																			,Lic_Cnty
																			,Lic_Type
																			,Lic_Xprdte
																			,License_Name
																			,Business_Name
																			,Premise_Street
																			,Premise_City
																			,Premise_State
																			,Premise_orig_Zip
																			,Mail_Street
																			,Mail_City
																			,Mail_State 
																			,Mail_Zip_Code
																			,Voice_Phone
																			,local);
// final1(seq=439369);

final2:=distribute(final1,persistent_record_id);
dups:=table(final2,{persistent_record_id,cnt:=count(group)},persistent_record_id,local)(cnt>1);

final_unq:=join(final2,dups
				,left.persistent_record_id=right.persistent_record_id
				,transform(left)
				,left only
				,local
				);

final_dups:=join(final2,dups
				,left.persistent_record_id=right.persistent_record_id
				,transform(left)
				,local
				);

final_dups_srtd:=sort(final_dups,license_number,-did_out,-bdid,rec_code,local);
final_dups_ddpd:=dedup(final_dups_srtd,license_number,local);

final:=sort(project(distribute(final_unq+final_dups_ddpd,seq),transform(atf.layout_firearms_explosives_out_bip, self := left)),seq, local);

return final;
 
end;