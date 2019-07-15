import ut, did_add, header_slimsort, didville, business_header_ss, business_header,watchdog,lib_stringlib,AID,idl_header,Address, BIPV2;

// Don't forget to update the Version Development attribute with the new build date
#workunit ('name', 'Build FLCrash Base Files');
// dont have historical raw address...
flc2v_did_in0 := flaccidents.infile_flcrash2v_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = ''); 
flc2v_did_in1 := project(flaccidents.infile_flcrash2v_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash2v}, self := left,self := [])); 

FLAccidents.aid_mAppdFields(flc2v_did_in0,vehicle_owner_address,vehicle_owner_st_city,vehicle_owner_st,vehicle_owner_zip,
dPreCleanf2v);

unsigned4 lAIDAppendFlags := AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;

AID.MacAppendFromRaw_2Line(dPreCleanf2v,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf2v,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf2v,flaccidents.aid_layouts.flcrash2v,outfAID2);

out :=  outfAID2 + flc2v_did_in1; 

flc2v_did_in := out(cname = '');

flc2v_did_rec := record
	unsigned6	temp_did := 0,
	unsigned1	temp_did_score := 0,
	flc2v_did_in,
	string8		dob_better := '',
end;

flc2v_did_rec flc2v_get_newdob(flc2v_did_in l) := transform
	self.dob_better := l.vehicle_owner_dob[5..8] + l.vehicle_owner_dob[1..4];
	self := l;
end; 

flc2v_did_prep := project(flc2v_did_in,flc2v_get_newdob(left));

////////////////////////////////////////////////////////////////////////////////////////
// Pass Vehicle Owner records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc2v_did_prep,fname,mname,lname,flc2v_did_ready);

//build flcrash2v did
matchset1 := ['D','A'];

did_add.mac_match_flex(flc2v_did_ready
						,matchset1
						,foo
						,dob_better
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,temp_did
						,flc2v_did_rec
						,true,temp_did_score,75
						,flc2v_did_file);
				   
flaccidents.aid_layouts.flcrash2v flc2v_get_didout(flc2v_did_file l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score;
	self.b_did := '';
	self.b_did_score := 0;
	self := l;
end;

flc2v_did_out := project(flc2v_did_file, flc2v_get_didout(left));

//build flcrash2v bdid
flc2v_bdid_in := out(cname<>'');	   

flc2v_bdid_rec := record
	unsigned6	temp_b_did := 0, 
    unsigned1	temp_b_did_score := 0,
	flc2v_bdid_in,
end;

flc2v_bdid_rec flc2v_bdid_init(flc2v_bdid_in l) := transform
	self := l;
end; 

flc2v_bdid_ready := project(flc2v_bdid_in,flc2v_bdid_init(left));				   
				   
b_matchset1 := ['A'];
										
Business_Header_SS.MAC_Add_BDID_Flex(																						
			 flc2v_bdid_ready									// Input Dataset													
			,b_matchset1                      // BDID Matchset what fields to match on  
			,cname      	                    // company_name	                          
			,prim_range		                    // prim_range		                          
			,prim_name		                    // prim_name		                          
			,zip					            				// zip5					                          
			,sec_range		                    // sec_range		                          
			,st   				                		// state				                          
			,foo				                			// phone				                          
			,foo                              // fein                                   
			,temp_b_did												// bdid												            
			,flc2v_bdid_rec                   // Output Layout                          
			,TRUE                             // output layout has bdid score field?                       
			,temp_b_did_score                 // bdid_score                             
			,flc2v_bdid_file                  // Output Dataset                         
	    ,                                 // score_threshold
	    ,     														// pFileVersion - default to use prod version of superfiles
	    ,                                 // pUseOtherEnvironment - default is to hit prod from dataland, and on prod hit prod.
	    ,BIPV2.xlink_version_set          // BIPV2 IDs	
	    ,                                 // URL
	    ,                                 // Email
	    ,p_city_name	                   	// City
	    ,fname                  		      // fname
      ,mname                	          // mname
	    ,lname                            // lname
			,                                 // contact_ssn
			,                                 // source - MDR.sourceTools
			,                                 // source_record_id
			,FALSE                            // src_matching_is_priority
      );                              				
                                   			
				   				   
flaccidents.aid_layouts.flcrash2v flc2v_bdid_getout(flc2v_bdid_file l) := transform
	self.ultid       := l.ultid;
  self.orgid       := l.orgid;
  self.seleid      := l.seleid;
  self.proxid      := l.proxid;
  self.powid       := l.powid;
  self.empid       := l.empid;
  self.dotid       := l.dotid;
  self.ultscore    := l.ultscore;
  self.orgscore    := l.orgscore;
  self.selescore   := l.selescore;
  self.proxscore   := l.proxscore;
  self.powscore    := l.powscore;
  self.empscore    := l.empscore;
  self.dotscore    := l.dotscore;
  self.ultweight   := l.ultweight;
  self.orgweight   := l.orgweight;
  self.seleweight  := l.seleweight;
  self.proxweight  := l.proxweight;
  self.powweight   := l.powweight;
  self.empweight   := l.empweight;
  self.dotweight   := l.dotweight;
	self.did         := '';
	self.did_score   := 0;
	self.b_did       := intformat(l.temp_b_did, 12, 1);
	self.b_did_score := l.temp_b_did_score; 
	self             := l;
end;

flc2v_bdid_out := project(flc2v_bdid_file, flc2v_bdid_getout(left));

outf2v := flc2v_did_out + flc2v_bdid_out;

//build flcrash4
flc4_raw := flaccidents.infile_flcrash4_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = '');
flc4_raw_addr := project(flaccidents.infile_flcrash4_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash4}, self := left,self := [])); 
FLAccidents.aid_mAppdFields(flc4_raw,driver_address,driver_st_city,driver_resident_state,driver_zip,dPreCleanf4);

AID.MacAppendFromRaw_2Line(dPreCleanf4,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf4,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf4,flaccidents.aid_layouts.flcrash4,outAid4);

outpredid4 := flc4_raw_addr+ outAid4 : independent; 
flc4_did_rec := record
	unsigned6	temp_did := 0,
	unsigned1	temp_did_score := 0,
	outAid4,
	string8		dob_better,
end;

flc4_did_rec flc4_getdid(outpredid4 l) := transform
	self.dob_better := l.driver_dob[5..8] + l.driver_dob[1..4];
	self := l;
end; 

flc4_prep := project(outpredid4,flc4_getdid(left));
////////////////////////////////////////////////////////////////////////////////////////
// Pass Driver records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc4_prep,fname,mname,lname,flc4_ready);

matchset2 := ['D','A','P'];

did_add.mac_match_flex(flc4_ready
						,matchset2
						,foo
						,dob_better
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,driver_phone_nbr
						,temp_did
						,flc4_did_rec
						,true, temp_did_score, 75
						,flc4_didfile);
				   
flaccidents.aid_layouts.flcrash4 flc4_getout(flc4_didfile l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score; 
	self := l;
end;

outf4 := project(flc4_didfile, flc4_getout(left));

//build flcrash5
flc5_raw := flaccidents.infile_flcrash5_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = '');
flc5_raw_addr := project(flaccidents.infile_flcrash5_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash5}, self := left,self := [])); 
FLAccidents.aid_mAppdFields(flc5_raw,passenger_address,passenger_st_city,passenger_state,passenger_zip,dPreCleanf5);

AID.MacAppendFromRaw_2Line(dPreCleanf5,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf5,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf5,flaccidents.aid_layouts.flcrash5,outAID5);
outpredid5 := flc5_raw_addr+ outAid5 : independent; 
flc5_did_rec := record
	unsigned6	temp_did := 0,
	unsigned1	temp_did_score := 0,
				outAID5,
end;

flc5_did_rec flc5_getdid(outpredid5 l) := transform
	self := l;
end; 

flc5_prep := project(outpredid5,flc5_getdid(left));

////////////////////////////////////////////////////////////////////////////////////////
// Pass Passenger records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc5_prep,fname,mname,lname,flc5_ready);
matchset3 := ['A'];

did_add.mac_match_flex(flc5_ready
						,matchset3
						,foo
						,foo
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,temp_did
						,flc5_did_rec
						,true, temp_did_score, 75
						,flc5_didfile);

flaccidents.aid_layouts.flcrash5 flc5_getout(flc5_didfile l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score;
	self := l;
end;

outf5 := project(flc5_didfile, flc5_getout(left));


//build flcrash6
flc6_raw := flaccidents.infile_flcrash6_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = '');
flc6_raw_addr := project(flaccidents.infile_flcrash6_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash6}, self := left,self := [])); 


FLAccidents.aid_mAppdFields(flc6_raw,ped_address,ped_st_city,ped_state,ped_zip,dPreCleanf6);

AID.MacAppendFromRaw_2Line(dPreCleanf6,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf6,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf6,flaccidents.aid_layouts.flcrash6,outAID6);
 outpredid6 := flc6_raw_addr+ outAid6 : independent; 

flc6_did_rec := record
	unsigned6	temp_did := 0,
	unsigned1	temp_did_score := 0,
				outAID6,
	string8		dob_better,
end;

flc6_did_rec flc6_getdid(outpredid6 l) := transform
	self.dob_better := l.ded_dob[5..8] + l.ded_dob[1..4];
	self := l;
end; 

flc6_prep := project(outpredid6,flc6_getdid(left));
////////////////////////////////////////////////////////////////////////////////////////
// Pass Pedestrian records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc6_prep,fname,mname,lname,flc6_ready);
did_add.mac_match_flex(flc6_ready
						,matchset1
						,foo
						,dob_better
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,temp_did
						,flc6_did_rec
						,true, temp_did_score, 75
						,flc6_didfile);
				   
flaccidents.aid_layouts.flcrash6 flc6_getout(flc6_didfile l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score; 
	self := l;
end;

outf6 := project(flc6_didfile, flc6_getout(left));

//build flcrash7 did
flc7_did_in0 := flaccidents.infile_flcrash7_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = '');
flc7_raw_addr := project(flaccidents.infile_flcrash7_v2(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash7}, self := left,self := [])); 


FLAccidents.aid_mAppdFields(flc7_did_in0,prop_owner_address,prop_owner_st_city,prop_owner_state,prop_owner_zip,dPreCleanf7);

AID.MacAppendFromRaw_2Line(dPreCleanf7,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf7,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf7,flaccidents.aid_layouts.flcrash7,outAID7);
 outpredid7 := flc7_raw_addr+ outAid7 : independent; 

flc7_did_in := outpredid7(cname = '');

flc7_did_rec := record
	unsigned6 temp_did := 0,
	unsigned1 temp_did_score := 0,
	outAID7,
end;

flc7_did_rec flc7_did_init(flc7_did_in l) := transform
	self := l;
end; 

flc7_did_prep := project(flc7_did_in,flc7_did_init(left));
////////////////////////////////////////////////////////////////////////////////////////
// Pass Property owner records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc7_did_prep,fname,mname,lname,flc7_did_ready);
did_add.mac_match_flex(flc7_did_ready
						,matchset3
						,foo
						,foo
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,temp_did
						,flc7_did_rec
						,true, temp_did_score, 75
						,flc7_did_file);
				   
flaccidents.aid_layouts.flcrash7 flc7_get_didout(flc7_did_file l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score; 
	self.b_did := '';
	self.b_did_score := 0;
	self := l;
end;

flc7_did_out := project(flc7_did_file, flc7_get_didout(left));

//build flcrash7 bdid
flc7_bdid_in := outpredid7(cname <> '');			   

flc7_bdid_rec := record
  BIPV2.IDlayouts.l_xlink_ids       ;	//Added for BIP project		
	unsigned6 temp_b_did := 0, 
	unsigned1 temp_b_did_score := 0,
	FLAccidents.Layout_temp.flcrash7,
end;

flaccidents.aid_layouts.flcrash7 flc7_bdid_init(flc7_bdid_in l) := transform
	self := l;
end; 

flc7_bdid_ready := project(flc7_bdid_in,flc7_bdid_init(left));				   
									
Business_Header_SS.MAC_Add_BDID_Flex(																						
			 flc7_bdid_ready									// Input Dataset													
			,b_matchset1                      // BDID Matchset what fields to match on  
			,cname      	                    // company_name	                          
			,prim_range		                    // prim_range		                          
			,prim_name		                    // prim_name		                          
			,zip					            				// zip5					                          
			,sec_range		                    // sec_range		                          
			,st   				                		// state				                          
			,foo				                			// phone				                          
			,foo                              // fein                                   
			,temp_b_did												// bdid												            
			,flc7_bdid_rec                    // Output Layout                          
			,TRUE                             // output layout has bdid score field?                       
			,temp_b_did_score                 // bdid_score                             
			,flc7_bdid_file                   // Output Dataset                         
	    ,                                 // score_threshold
	    ,     														// pFileVersion - default to use prod version of superfiles
	    ,                                 // pUseOtherEnvironment - default is to hit prod from dataland, and on prod hit prod.
	    ,BIPV2.xlink_version_set          // BIPV2 IDs	
	    ,                                 // URL
	    ,                                 // Email
	    ,p_city_name	                   	// City
	    ,fname                  		      // fname
      ,mname                	          // mname
	    ,lname                            // lname
  		,                                 // contact_ssn
			,                                 // source - MDR.sourceTools
			,                                 // source_record_id
			,FALSE                            // src_matching_is_priority
      );                              							   				   
										 
flaccidents.aid_layouts.flcrash7 flc7_bdid_getout(flc7_bdid_file l) := transform
  self.ultid       := l.ultid;
  self.orgid       := l.orgid;
  self.seleid      := l.seleid;
  self.proxid      := l.proxid;
  self.powid       := l.powid;
  self.empid       := l.empid;
  self.dotid       := l.dotid;
  self.ultscore    := l.ultscore;
  self.orgscore    := l.orgscore;
  self.selescore   := l.selescore;
  self.proxscore   := l.proxscore;
  self.powscore    := l.powscore;
  self.empscore    := l.empscore;
  self.dotscore    := l.dotscore;
  self.ultweight   := l.ultweight;
  self.orgweight   := l.orgweight;
  self.seleweight  := l.seleweight;
  self.proxweight  := l.proxweight;
  self.powweight   := l.powweight;
  self.empweight   := l.empweight;
  self.dotweight   := l.dotweight;	
	self.did         := '';
	self.did_score   := 0;
	self.b_did       := intformat(l.temp_b_did, 12, 1);
	self.b_did_score := l.temp_b_did_score; 
	self             := l;
end;

flc7_bdid_out := project(flc7_bdid_file, flc7_bdid_getout(left));

outf7 := flc7_did_out + flc7_bdid_out;

//build flcrash9 did
flc9_did_in0 := flaccidents.infile_flcrash9(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) = '');
flc9_raw_addr := project(flaccidents.infile_flcrash9(stringlib.stringcleanspaces(prim_range+' '+prim_name+' '+sec_range +' '+v_city_name+' '+st) <> ''),transform({flaccidents.aid_layouts.flcrash9}, self := left,self := [])); 

FLAccidents.aid_mAppdFields(flc9_did_in0,witness_address,witness_st_city,witness_state,witness_zip,dPreCleanf9);

AID.MacAppendFromRaw_2Line(dPreCleanf9,
Append_Prep_Address1, Append_Prep_AddressLast, rawaid,
dCleanf9,
lAIDAppendFlags
);


FLAccidents.aid_ParseCleanAddress(dCleanf9,flaccidents.aid_layouts.flcrash9,outAID9);
outpredid9 := flc9_raw_addr+ outAid9 : independent;

flc9_did_in := outpredid9(cname = '');

flc9_did_rec := record
	unsigned6 temp_did := 0,
	unsigned1 temp_did_score := 0,
	outAID9,
end;

flc9_did_rec flc9_did_init(flc9_did_in l) := transform
	self := l;
end; 

flc9_did_prep := project(flc9_did_in,flc9_did_init(left));
////////////////////////////////////////////////////////////////////////////////////////
// Pass witness records to Name Flip Macro to enhance linking
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_flipnames(flc9_did_prep,fname,mname,lname,flc9_did_ready);
did_add.mac_match_flex(flc9_did_ready
						,matchset3
						,foo
						,foo
						,fname
						,mname
						,lname
						,suffix
						,prim_range
						,prim_name
						,sec_range
						,zip
						,st
						,foo
						,temp_did
						,flc9_did_rec
						,true, temp_did_score, 75
						,flc9_did_file);
				   
flaccidents.aid_layouts.flcrash9 flc9_get_didout(flc9_did_file l) := transform
	self.did := intformat(l.temp_did, 12, 1);
	self.did_score := l.temp_did_score; 
	self.b_did := '';
	self.b_did_score := 0;
	self := l;
end;

outf9 := project(flc9_did_file, flc9_get_didout(left));

////////////////////////////////////////////////////////////////////////////////////////
// Output Files
////////////////////////////////////////////////////////////////////////////////////////
ut.mac_sf_buildprocess(flaccidents.infile_flcrash0_v2, '~thor_data400::base::flcrash0', build_flc0,2,,true); 
ut.mac_sf_buildprocess(flaccidents.infile_flcrash1, '~thor_data400::base::flcrash1', build_flc1, 2,,true);
ut.mac_sf_buildprocess(outf2v, '~thor_data400::base::flcrash2v', build_flc2v, 2,,true);
ut.mac_sf_buildprocess(flaccidents.infile_flcrash3v_v2, '~thor_data400::base::flcrash3v', build_flc3v, 2,,true);
ut.mac_sf_buildprocess(outf4, '~thor_data400::base::flcrash4', build_flc4, 2,,true);
ut.mac_sf_buildprocess(outf5, '~thor_data400::base::flcrash5', build_flc5, 2,,true);
ut.mac_sf_buildprocess(outf6, '~thor_data400::base::flcrash6', build_flc6, 2,,true);
ut.mac_sf_buildprocess(outf7, '~thor_data400::base::flcrash7', build_flc7, 2,,true);
ut.mac_sf_buildprocess(flaccidents.infile_flcrash8, '~thor_data400::base::flcrash8', build_flc8, 2,,true);
ut.mac_sf_buildprocess(outf9, '~thor_data400::base::flcrash9', build_flc9, 2,,true);

												
export flcrash_buildfile :=
				sequential(
										parallel(build_flc0
														,build_flc1
														,build_flc3v
														,build_flc8),
										sequential(
										      build_flc2v
													,build_flc4
													,build_flc5
													,build_flc6
													,build_flc7
													,build_flc9)
										);