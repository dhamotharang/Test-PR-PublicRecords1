#stored('did_add_force','thor');
import business_header,business_header_ss,didville,DID_Add,header_slimsort,ut,watchdog,fair_isaac,mdr,header;

infile := file_aircraft_registration_in;

//To clean entire file
ut.CleanFields(infile, infile_cln);

bt_rec := record
  unsigned6 did := 0;
  unsigned2 did_score := 0;
  layout_aircraft_registration_in;
end;

bt_rec addDID(layout_aircraft_registration_in L):= transform
 self := l;
end;

infile_did := project(infile_cln,addDID(left));

//add src 
src_rec := record
	header_slimsort.Layout_Source;
	bt_rec;
end;

DID_Add.Mac_Set_Source_Code(infile_did, src_rec, MDR.sourceTools.src_Aircrafts, infile_did_src)

matchset := ['A'];//['A','P','D'];  removing phone for now cuz of skew

//DID file
DID_Add.MAC_Match_Flex(infile_did_src,matchset,junk,junk,fname,mname,
	lname,name_suffix,prim_range,prim_name,sec_range,
	zip,st,junk,
	did,src_rec,true,did_score, 
	75,infile_out,true,src)

outrec := layout_aircraft_registration_out;

outrec forthem(src_rec l) := transform
	self.DID_out 		:= if (l.did = 0,'',intformat(l.did, 12, 1));
	self.d_score 		:= intformat(l.did_score,3,1);
	self.best_ssn 	:= '';
	self.bdid_out 	:= '';
	self 						:= l;
end;
	
withdid 	:= project(infile_out, forthem(left));

dw 				:= watchdog.File_Best;

outrec getssn(dw L, withdid R) := transform
	self.best_ssn := if((l.did = 0 or l.ssn = '000000000' or l.ssn = ''),'',intformat((integer)L.ssn,9,1));
	self 					:= R;
end;

ssn_records := join(distribute(dw,hash((integer)did)),distribute(withdid(did_out != ''),hash((integer)did_out)),(integer)left.did = (integer)right.did_out,getssn(LEFT,RIGHT),right outer,local);

allrecs 		  := ssn_records + withdid(did_out = '');

//Souce_rec_id logic
Update_base	  := distribute(allrecs, hash64(lname, fname, mname, name_suffix, compname, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, v_city_name, st, zip,
																						did_out, name, serial_number, mfr_mdl_code, n_number, eng_mfr_mdl, year_mfr,
																						type_registrant,certification,type_aircraft,type_engine,status_code));

Previous_Base	:= distribute(faa.file_aircraft_registration_out, hash64(lname, fname, mname, name_suffix, compname, prim_range, prim_name, addr_suffix, predir, postdir, sec_range, v_city_name, st, zip,
																																				did_out, name, serial_number, mfr_mdl_code, n_number, eng_mfr_mdl, year_mfr,
																																				type_registrant, certification, type_aircraft, type_engine, status_code));
	
faa.layout_aircraft_registration_out	trans_recID(faa.layout_aircraft_registration_out l, recordof(faa.file_aircraft_registration_out) r):=transform
		self.source_rec_id := r.source_rec_id;
		self               := l;
end;
	
persistent_recID_join := join(Update_base,Previous_Base,
															trim(left.did_out,left,right)         						 =       trim(right.did_out,left,right) and
															trim(left.current_flag,left,right)         				 =       trim(right.current_flag,left,right) and
															trim(left.n_number,left,right)         						 =       trim(right.n_number,left,right) and
															trim(left.serial_number,left,right)         			 =       trim(right.serial_number,left,right) and
															trim(left.mfr_mdl_code,left,right)         				 =       trim(right.mfr_mdl_code,left,right) and
															trim(left.eng_mfr_mdl,left,right)         				 =       trim(right.eng_mfr_mdl,left,right) and
															trim(left.year_mfr,left,right)         						 =       trim(right.year_mfr,left,right) and
															trim(left.type_registrant,left,right)         		 =       trim(right.type_registrant,left,right) and
															trim(left.name,left,right)         						 		 =       trim(right.name,left,right) and
															trim(left.street,left,right)         						 	 =       trim(right.street,left,right) and
															trim(left.street2,left,right)         						 =       trim(right.street2,left,right) and
															trim(left.city,left,right)         						 		 =       trim(right.city,left,right) and
															trim(left.state,left,right)         						 	 =       trim(right.state,left,right) and
															trim(left.zip_code,left,right)         						 =       trim(right.zip_code,left,right) and
															trim(left.region,left,right)         							 =       trim(right.region,left,right) and
															trim(left.orig_county,left,right)         				 =       trim(right.orig_county,left,right) and
															trim(left.country,left,right)         						 =       trim(right.country,left,right) and
															trim(left.last_action_date,left,right)         		 =       trim(right.last_action_date,left,right) and
															trim(left.cert_issue_date,left,right)         		 =       trim(right.cert_issue_date,left,right) and
															trim(left.certification,left,right)         			 =       trim(right.certification,left,right) and
															trim(left.type_aircraft,left,right)         			 =       trim(right.type_aircraft,left,right) and
															trim(left.type_engine,left,right)         				 =       trim(right.type_engine,left,right) and
															trim(left.status_code,left,right)         				 =       trim(right.status_code,left,right) and
															trim(left.mode_s_code,left,right)         				 =       trim(right.mode_s_code,left,right) and
															trim(left.fract_owner,left,right)         				 =       trim(right.fract_owner,left,right) and
															trim(left.aircraft_mfr_name,left,right)         	 =       trim(right.aircraft_mfr_name,left,right) and
															trim(left.model_name,left,right)         					 =       trim(right.model_name,left,right) and
															trim(left.prim_range,left,right)         					 =       trim(right.prim_range,left,right) and
															trim(left.predir,left,right)         						   =       trim(right.predir,left,right) and
															trim(left.prim_name,left,right)         					 =       trim(right.prim_name,left,right) and
															trim(left.addr_suffix,left,right)         				 =       trim(right.addr_suffix,left,right) and
															trim(left.postdir,left,right)         						 =       trim(right.postdir,left,right) and
															trim(left.unit_desig,left,right)         					 =       trim(right.unit_desig,left,right) and
															trim(left.sec_range,left,right)         					 =       trim(right.sec_range,left,right) and
															trim(left.p_city_name,left,right)         				 =       trim(right.p_city_name,left,right) and
															trim(left.v_city_name,left,right)         				 =       trim(right.v_city_name,left,right) and
															trim(left.st,left,right)         						 			 =       trim(right.st,left,right) and
															trim(left.zip,left,right)         						 		 =       trim(right.zip,left,right) and
															trim(left.z4,left,right)         						 			 =       trim(right.z4,left,right) and
															trim(left.compname,left,right)         						 =       trim(right.compname,left,right),
							trans_recID(left,right),left outer,local)  ; 

// End of Souce_rec_id logic

bdid_rec := record
	faa.layout_aircraft_registration_out;
	unsigned6	bdid := 0;
	string2 source :='';
end;
 
bdid_rec trans_source(faa.layout_aircraft_registration_out l):=transform 
		self.source:=MDR.sourceTools.src_Aircrafts;
		self:=l;
end;

pre_for_bdid := project(persistent_recID_join,trans_source(left));

for_bdid 		 := pre_for_bdid(compname != '');

//append BDID 
business_header.MAC_Source_Match(for_bdid,wbdid_SourceMatch,
						false,bdid,
						false,MDR.sourceTools.src_Aircrafts,
						false,foo,
						compname,
						prim_range,prim_name,sec_range,zip,
						false,foo,
						false,foo);
							
myset := ['A'];	

Business_Header_SS.MAC_Add_BDID_Flex(
		 wbdid_SourceMatch					               // Input Dataset						
		,myset                                    // BDID Matchset           
		,compname        		             		     // company_name	              
		,prim_range		                          // prim_range		              
		,prim_name		                         // prim_name		              
		,zip 					                        // zip5					              
		,sec_range		                       // sec_range		              
		,st				                          // state				              
		,foo				                       // phone				              
		,foo                              // fein              
		,bdid											       // bdid												
		,bdid_rec	                      // Output Layout 
		,false                         // output layout has bdid score field?                       
		,foo                          // bdid_score                 
		,postbdid                    // Output Dataset   
		,														// deafult threscold
		,													 // use prod version of superfiles
		,													// default is to hit prod from dataland, and on prod hit prod.		
		,BIPV2.xlink_version_set // Create BIP Keys only
		,           						// Url
		,								       // Email
		,p_city_name					// City
		,fname							 // fname
		,mname							// mname
		,lname						 // lname
		 ,                 //	 ssn
		,source          //sourceField
		,source_rec_id  //persistent_rec_id
		,true          //if it is true -Call SourceMatch before Flex macro

);

outrec into_final(bdid_rec L) := transform
	self.bdid_out := if (L.bdid != 0, intformat(L.bdid,12,1),'');
	self 					:= L;
end;

outfinal_prebid := project(postbdid + pre_for_bdid(compname = ''),into_final(LEFT));

//Remove "true" duplicates
dmasteraddflag := dedup(sort(distribute((outfinal_prebid),hash(N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER)), 
															N_NUMBER,SERIAL_NUMBER, MFR_MDL_CODE, ENG_MFR_MDL, YEAR_MFR, TYPE_REGISTRANT, NAME, STREET, STREET2, CITY, STATE, ZIP_CODE, REGION, ORIG_COUNTY, COUNTRY, LAST_ACTION_DATE, CERT_ISSUE_DATE, CERTIFICATION, TYPE_AIRCRAFT, TYPE_ENGINE, STATUS_CODE, MODE_S_CODE, FRACT_OWNER, current_flag, -date_last_seen,local),
																record, all,local);
			

//Appending source_rec_id for new updates							
ut.MAC_Append_Rcid(dmasteraddflag,source_rec_id,Append_Rcid_file);

export  aircraft_registration_did_ssn := Append_Rcid_file : persist('persist::aircraft_temp_fix');
