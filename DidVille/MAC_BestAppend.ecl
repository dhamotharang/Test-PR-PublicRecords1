// infile is input
// supply is which best values you want back
// verify is a string with which verifications you want
// thresh_val is an integer such that, if a verify score is greater 
//			  than thresh_val, do NOT return the best info for that field.
// glb is a boolean, true = glb data returned
// outfile is your output file's name.
// Please be CAREFUL with the Clickdata flags otherwise you will break clickdata

export MAC_BestAppend(infile, 
                      supply,
											verify,
											thresh_val,
											glb_ok,
											outfile,
											marketing=false, 
                      fixed_DRM,
											glb_purpose_value=0,
											include_minors=true, 
											clickdata=false,
											UseNonBlankKey=false,
											appType,
											dppa_purpose_value=0,
											IndustryClass_val='\'UTILI\'', //we restrict it by default
											GetSSNBest = false
										) := MACRO
										
import didville, suppress, doxie, doxie_files, DeathV2_Services, AutoStandardI, SSNBest_Services,
       watchdog, did_add, header_slimsort, STD;

os(string i) := if (i='','',trim(i)+' ');
#uniquename(deathparams)
%deathparams% := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
// Bug: 53541. For some of the services we want to use the _nonblank key (so we return the maximum 
// number of first/last names). At the time of this change, watchdog.Key_Watchdog_marketing 
// does not have a nonblank key file.

MarketingKeyFileToUse  := watchdog.Key_Watchdog_marketing;
MarketingKeyFilePreGLBToUse  := watchdog.Key_Watchdog_marketing_V2;

NonGlbKeyFileToUse		 						:= Watchdog.Key_Watchdog_nonglb; 
NonGlbKeyFilePreGLBToUse		 			:= Watchdog.Key_Watchdog_nonglb_V2;
NonGlbKeyFileNonBlankToUse		 		:= Watchdog.Key_Watchdog_nonglb_nonblank;
NonGlbKeyFilePreGLBNonBlankToUse	:= Watchdog.Key_Watchdog_nonglb_nonblank_V2;
													
GlbKeyFileToUse         := watchdog.Key_Watchdog_glb;
GlbNonUtilKeyToUse			:= watchdog.Key_Watchdog_glb_nonutil;
GlbKeyFileNonBlankToUse := watchdog.Key_Watchdog_glb_nonblank;
GlbNonUtilNonBlankKeyToUse := watchdog.Key_Watchdog_GLB_nonutil_nonblank;

GlbNonExperianKeyFileToUse := watchdog.Key_Watchdog_GLB_nonExperian;
GlbNonExperianKeyFileNonBlankToUse := watchdog.Key_Watchdog_GLB_nonExperian_nonblank;

GlbNonEquifaxKeyFileToUse := watchdog.Key_Watchdog_GLB_nonEquifax;
GlbNonEquifaxKeyFileNonBlankToUse := watchdog.Key_Watchdog_GLB_nonEquifax_nonblank;

GlbNonExperianNonEquifaxKeyFileToUse := watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax;
GlbNonExperianNonEquifaxKeyFileNonBlankToUse := watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank;

typeof(infile) add_flds_marketing(infile le, MarketingKeyFileToUse ri,string options) := transform
  #if (not clickdata)
		self.best_phone := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_PHONE',1)=0 or ri.glb_phone = 'N','', ri.phone );
	#end
  self.best_ssn := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_SSN',1)=0 or ri.glb_ssn = 'N','', ri.ssn );
  //self.best_name := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','', os(ri.title)+os(ri.fname)+os(ri.mname)+os(ri.lname)+os(ri.NAME_suffix) );
  self.best_title := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.title);
  self.best_fname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.fname);
  self.best_mname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.mname);
  self.best_lname :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.lname);
  self.best_name_suffix := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.name_suffix);
  self.best_addr1 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.prim_range)+os(ri.predir)+os(ri.prim_name)+os(ri.suffix)+os(ri.postdir)+IF(Std.Str.EndsWith(ri.prim_name,os(ri.unit_desig)+os(ri.sec_range)),'',os(ri.unit_desig)+os(ri.sec_range)) );
  //self.best_addr2 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.city_name)+os(ri.st)+ri.zip+IF(ri.zip4<>'','-'+ri.zip4,'') );
  self.best_city :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.city_name);
  self.best_state := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.st);
  self.best_zip := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.zip);
  self.best_zip4 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.zip4);
  self.best_addr_date := if ( stringlib.stringfind(options,'BEST_ALL',1)= 0 and stringlib.stringfind(options,'BEST_ADDRESS_DATE',1) = 0 or ri.glb_address = 'N',0,ri.addr_dt_last_seen);
  #if(clickdata)
		self.best_prim_range := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.prim_range) );
		self.best_prim_name := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.prim_name) );
		self.best_sec_range := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.sec_range) );
		self.best_addr_date_first_seen := if ( stringlib.stringfind(options,'BEST_ALL',1)= 0 and stringlib.stringfind(options,'BEST_ADDRESS_DATE',1) = 0 or ri.glb_address = 'N',0,ri.addr_dt_first_seen);
	#end
  self.best_dob := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOB',1)=0 or ri.glb_dob = 'N','',if(ri.dob<0,'',(string8)ri.dob));
  self.best_dod := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOD',1)=0,'',ri.dod);
  self.verify_best_phone := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_PHONE',1)=0,255, did_add.phone_match_score(le.phone10,ri.phone));
  self.verify_best_ssn := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_SSN',1)=0 and stringlib.stringfind(verify,'FUZZY_SSN',1) = 0, 255,
						if (stringlib.stringfind(verify,'FUZZY_SSN',1) != 0, did_add.ssn_match_score(le.ssn, ri.ssn, true), did_add.ssn_match_score(le.ssn,ri.ssn)));
  self.verify_best_name := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_NAME',1)=0,255, did_add.name_match_score(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname));
  self.verify_best_address := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_ADDR',1)=0,255, did_add.Address_Match_Score(le.prim_range,le.prim_name,le.sec_range,le.z5,ri.prim_range,ri.prim_name,ri.sec_range,ri.zip) );
  self.verify_best_dob := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_DOB',1)=0,255,did_add.dob_match_score((integer)le.dob,(integer)ri.dob));
  self := le;
  end;
  

typeof(infile) add_flds_nonglb(infile le, NonGlbKeyFileToUse ri,string options) := transform
  #if (not clickdata)
		self.best_phone := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_PHONE',1)=0 or ri.glb_phone = 'N','', ri.phone );
	#end
  self.best_ssn := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_SSN',1)=0 or ri.glb_ssn = 'N','', ri.ssn );
  //self.best_name := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','', os(ri.title)+os(ri.fname)+os(ri.mname)+os(ri.lname)+os(ri.NAME_suffix) );
  self.best_title := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.title);
  self.best_fname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.fname);
  self.best_mname := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.mname);
  self.best_lname :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.lname);
  self.best_name_suffix := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_NAME',1)=0 or ri.glb_name = 'N','',ri.name_suffix);
  self.best_addr1 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.prim_range)+os(ri.predir)+os(ri.prim_name)+os(ri.suffix)+os(ri.postdir)+IF(Std.Str.EndsWith(ri.prim_name,os(ri.unit_desig)+os(ri.sec_range)),'',os(ri.unit_desig)+os(ri.sec_range)) );
  //self.best_addr2 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','', os(ri.city_name)+os(ri.st)+ri.zip+IF(ri.zip4<>'','-'+ri.zip4,'') );
  self.best_city :=if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.city_name);
  self.best_state := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.st);
  self.best_zip := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.zip);
  self.best_zip4 := if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_ADDR',1)=0 or ri.glb_address = 'N','',ri.zip4);
  self.best_addr_date := if ( stringlib.stringfind(options,'BEST_ALL',1)= 0 and stringlib.stringfind(options,'BEST_ADDRESS_DATE',1) = 0 or ri.glb_address = 'N',0,ri.addr_dt_last_seen);
  #if(clickdata)
		self.best_addr_date_first_seen := if ( stringlib.stringfind(options,'BEST_ALL',1)= 0 and stringlib.stringfind(options,'BEST_ADDRESS_DATE',1) = 0 or ri.glb_address = 'N',0,ri.addr_dt_first_seen);
	#end
  self.best_dob := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOB',1)=0 or ri.glb_dob = 'N','',if(ri.dob<0,'',(string8)ri.dob));
  self.best_dod := (string8)if ( stringlib.stringfind(options,'BEST_ALL',1)=0 and stringlib.stringfind(options,'BEST_DOD',1)=0,'',ri.dod);
  self.verify_best_phone := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_PHONE',1)=0,255, did_add.phone_match_score(le.phone10,ri.phone));
  self.verify_best_ssn := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_SSN',1)=0 and stringlib.stringfind(verify,'FUZZY_SSN',1) = 0, 255,
						if (stringlib.stringfind(verify,'FUZZY_SSN',1) != 0, did_add.ssn_match_score(le.ssn, ri.ssn, true), did_add.ssn_match_score(le.ssn,ri.ssn)));
  self.verify_best_name := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_NAME',1)=0,255, did_add.name_match_score(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname));
  self.verify_best_address := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_ADDR',1)=0,255, did_add.Address_Match_Score(le.prim_range,le.prim_name,le.sec_range,le.z5,ri.prim_range,ri.prim_name,ri.sec_range,ri.zip) );
  self.verify_best_dob := if ( stringlib.stringfind(verify,'BEST_ALL',1)=0 and stringlib.stringfind(verify,'BEST_DOB',1)=0,255,did_add.dob_match_score((integer)le.dob,(integer)ri.dob));
  self := le;
  end;

  DidVille.MAC_BestAppendAddFieldsGlb(outfi1,infile,GlbKeyFileToUse,supply,verify);
	DidVille.MAC_BestAppendAddFieldsGlb(outfinonutil, infile, GlbNonUtilKeyToUse, supply, verify);
  DidVille.MAC_BestAppendAddFieldsGlb(outfi1nb, infile, GLBKeyFileNonBlankToUse, supply, verify);	
	DidVille.MAC_BestAppendAddFieldsGlb(outfinonutilnb, infile, GLBNonUtilNonBlankKeyToUse, supply, verify);
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1nexp,infile,GlbNonExperianKeyFileToUse,supply,verify);	
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1nexpnb, infile, GlbNonExperianKeyFileNonBlankToUse, supply, verify);		
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1neq,infile,GlbNonEquifaxKeyFileToUse,supply,verify);	
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1neqnb, infile, GlbNonEquifaxKeyFileNonBlankToUse, supply, verify);
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1nexpneq,infile,GlbNonExperianNonEquifaxKeyFileToUse,supply,verify);	
	DidVille.MAC_BestAppendAddFieldsGlb(outfi1nexpneqnb, infile, GlbNonExperianNonEquifaxKeyFileNonBlankToUse, supply, verify);	  

	outfi1m := join(infile,MarketingKeyFileToUse,left.did != 0 AND left.did=right.did,add_flds_marketing(left,right,supply),left outer, KEEP (1));
  outfi1mpglb := join(infile,MarketingKeyFilePreGLBToUse,left.did != 0 AND left.did=right.did,add_flds_marketing(left,right,supply),left outer, KEEP (1));
	
	outfi2 := join(infile,NonGlbKeyFileToUse,left.did != 0 AND left.did=right.did,add_flds_nonglb(left,right,supply),left outer, KEEP (1));
	outfi2PreGlb := join(infile,NonGlbKeyFilePreGLBToUse,left.did != 0 AND left.did=right.did,add_flds_nonglb(left,right,supply),left outer, KEEP (1));
  outfi2NonBlank := join(infile,NonGlbKeyFileNonBlankToUse,left.did != 0 AND left.did=right.did,add_flds_nonglb(left,right,supply),left outer, KEEP (1));
	outfi2PreGlbNonBlank := join(infile,NonGlbKeyFilePreGLBNonBlankToUse,left.did != 0 AND left.did=right.did,add_flds_nonglb(left,right,supply),left outer, KEEP (1));
	
	filter_exp 	:= doxie.DataRestriction.isECHRestricted(fixed_DRM);
	filter_eq 	:= doxie.DataRestriction.isEQCHRestricted(fixed_DRM);
  is_utility 	:= IndustryClass_val = ut.IndustryClass.UTILI_IC;
	
  outfi := IF(marketing, IF(Doxie.DataRestriction.restrictPreGLB, UNGROUP(outfi1mpglb), UNGROUP(outfi1m)),
					 MAP(
							 UseNonBlankKey	and glb_ok and 												is_utility 	=> UNGROUP(outfinonutilnb),
																	glb_ok and 												is_utility 	=> UNGROUP(outfinonutil),						 
						   UseNonBlankKey and glb_ok and filter_exp and filter_eq						=> UNGROUP(outfi1nexpneqnb),	
																	glb_ok and filter_exp and filter_eq 				 	=> UNGROUP(outfi1nexpneq),		
							 UseNonBlankKey and glb_ok and filter_exp 												=> UNGROUP(outfi1nexpnb),
																	glb_ok and filter_exp 												=> UNGROUP(outfi1nexp),
							 UseNonBlankKey and glb_ok and filter_eq 													=> UNGROUP(outfi1neqnb),
																	glb_ok and filter_eq 													=> UNGROUP(outfi1neq),
							 UseNonBlankKey	and glb_ok 																				=> UNGROUP(outfi1nb),
																	glb_ok 																				=> UNGROUP(outfi1),							 
							 IF(UseNonBlankKey, IF(Doxie.DataRestriction.restrictPreGLB, UNGROUP(outfi2PreGlbNonBlank), UNGROUP(outfi2NonBlank)),
								IF(Doxie.DataRestriction.restrictPreGLB, UNGROUP(outfi2PreGlb), UNGROUP(outfi2)))));
			 
typeof(infile) strip_thresh(infile le) := transform
  #if (not clickdata)
		self.best_phone := IF( thresh_val > 0 and le.verify_best_phone <> 255 and le.verify_best_phone > thresh_val, '', le.best_phone );
	#end
  self.best_ssn := IF( thresh_val > 0 and le.verify_best_ssn <> 255 and le.verify_best_ssn > thresh_val, '', le.best_ssn );
  self.best_title := IF( thresh_val > 0 and le.verify_best_name <> 255 and le.verify_best_name > thresh_val, '', le.best_title );
  self.best_fname := IF( thresh_val > 0 and le.verify_best_name <> 255 and le.verify_best_name > thresh_val, '', le.best_fname );
  self.best_mname := IF( thresh_val > 0 and le.verify_best_name <> 255 and le.verify_best_name > thresh_val, '', le.best_mname );
  self.best_lname := IF( thresh_val > 0 and le.verify_best_name <> 255 and le.verify_best_name > thresh_val, '', le.best_lname );
  self.best_name_suffix := IF( thresh_val > 0 and le.verify_best_name <> 255 and le.verify_best_name > thresh_val, '', le.best_name_suffix );
  self.best_addr1 := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, '', le.best_addr1 );
  self.best_city := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, '', le.best_city );
  self.best_state := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, '', le.best_state );
  self.best_zip := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, '', le.best_zip );
  self.best_zip4 := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, '', le.best_zip4 );
  self.best_addr_date := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, 0,le.best_addr_date );
  #if(clickdata)
		self.best_addr_date_first_seen := IF( thresh_val > 0 and le.verify_best_address <> 255 and le.verify_best_address > thresh_val, 0,le.best_addr_date_first_seen );
	#end
  self.best_dob := IF( thresh_val > 0 and le.verify_best_dob <> 255 and le.verify_best_dob > thresh_val, '', le.best_dob );
  self := le;
  end;
  
  outfile_strip_thresh := project(outfi,strip_thresh(left));

typeof(infile) strip_minors(infile le, doxie_files.key_minors_hash re) := transform
  #if (not clickdata)
		self.best_phone := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_phone);
	#end
  self.best_ssn := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_ssn);
  self.best_title := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_title);
  self.best_fname := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_fname);
  self.best_mname := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_mname);
  self.best_lname := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_lname);
  self.best_name_suffix := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_name_suffix);
  self.best_addr1 := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_addr1);
  self.best_city := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_city);
  self.best_state := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_state);
  self.best_zip := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_zip);
  self.best_zip4 := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_zip4);
  self.best_addr_date := IF(glb_purpose_value<>2 and re.did <>0, 0,le.best_addr_date);
  #if(clickdata)
		self.best_addr_date_first_seen := IF(glb_purpose_value<>2 and re.did <>0, 0,le.best_addr_date_first_seen);
	#end
  self.best_dob := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_dob);
	self.best_dod := IF(glb_purpose_value<>2 and re.did <>0, '', le.best_dod);
  self := le;
  end;
  
  outfile_strip_minors := join(outfile_strip_thresh, doxie_files.key_minors_hash,
                               left.did != 0 and
														   keyed(hash32((unsigned6)left.did)=right.hash32_did) and
		                  			   keyed(left.did = right.did) and	//at build time, key contains only minors
					                     ut.Age(right.dob) < 18,	     //check age since a few will turn 18 between builds
					                     strip_minors(left, right), left outer, keep(1));

 
//Start of include for DOD from deathmaster if it is needed meaning they are requesting BEST_ALL or BEST_DOD.
//Default behavior is that the best_dod is cleared...since we no longer want to use the watchdog DOD value.
	#uniquename(outfile_watchDog_death)															 
	%outfile_watchdog_death% :=  if(include_minors, outfile_strip_thresh, outfile_strip_minors);
	#uniquename(clearDOD)
	%outfile_watchdog_death% %clearDOD%(%outfile_watchdog_death% l) := transform
		self.best_dod := '';
		self := l;
	end;
	#uniquename(outfile_noDeath)															 
	%outfile_noDeath% := project(%outfile_watchdog_death%, %clearDOD%(LEFT));
	// use a DOD value from an un-restricted DeathMaster record
	#uniquename(fillDOD)			
	%outfile_noDeath% %fillDOD%(%outfile_noDeath% l, doxie.key_death_masterV2_ssa_DID r) := transform
		 self.best_dod := r.dod8;
		 self := L;
	end;
	#uniquename(outfile_Death)
	%outfile_death% := join(%outfile_noDeath%,doxie.key_death_masterV2_ssa_DID,
																keyed(left.did = right.l_did)  and
																not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_ok, %deathparams%),
																%fillDOD%(LEFT,RIGHT),left outer, KEEP(1), LIMIT(0));
  //determine whether we need to join to the deathmaster data for the DOD value
  include_DOD := if ( stringlib.stringfind(supply,'BEST_ALL',1)=0 and stringlib.stringfind(supply,'BEST_DOD',1)=0, FALSE, TRUE);

	outfile1 := IF (include_dod, %outfile_death%, %outfile_noDeath%); 
//end of include for DOD from deathmaster
  midrec := record
		infile;
		boolean 	ismatch;
		integer4	freq;
	end;

	midrec get_max_ssn(outfile1 L, header_slimsort.key_did_Ssn R) := transform
		self.max_ssn := R.ssn;
		self.ismatch := if (((integer)L.ssn)%10000 = (integer)R.ssn4 and self.max_ssn != '',true,false);
		self.freq := R.freq;
		self := l;
	end;

	mid1 := join(outfile1,header_slimsort.key_did_Ssn,left.did = right.did,get_max_ssn(LEFT,RIGHT),left outer);

	midrec get_max_ssn_ng(outfile1 L, header_slimsort.key_did_Ssn_nonglb R) := transform
		self.max_ssn := R.ssn;
		self.ismatch := if (((integer)L.ssn)%10000 = (integer)R.ssn4 and self.max_ssn != '',true,false);
		self.freq := R.freq;
		self := l;
	end;

	mid1b := join(outfile1,header_slimsort.key_did_Ssn_nonglb,left.did = right.did,get_max_ssn_ng(LEFT,RIGHT),left outer);

	mid2 := dedup(sort(if (glb_ok,mid1,mid1b),did,-ismatch,-freq),seq,did);

	typeof(infile) into_orig(mid2 L) := transform
		self := l;
	end;

	mid3 := project(mid2,into_orig(LEFT));

  outfile_ := if (stringlib.stringfind(supply,'MAX_SSN',1) = 0,outfile1,mid3);
	
	didville.Mac_Common_Field_Declare();
	// TODO: only ssn_mask_value is taken, and it'd be better to take it from global module, since it is called above anyway

  // need just a few things, so no projecting
  mod_access := MODULE (doxie.IDataAccess)
    EXPORT unsigned1 glb := glb_purpose_value;
    EXPORT unsigned1 dppa := dppa_purpose_value;
    EXPORT string DataRestrictionMask := fixed_DRM;
    EXPORT string5 industry_class := IndustryClass_val;
		EXPORT string32 application_type := appType;
		EXPORT string ssn_mask := ssn_mask_value;
    EXPORT dl_mask := dl_mask_val;
		// input include_minors -- is it include only or dppa as well?
  END;

	ssnBestParams := SSNBest_Services.IParams.setSSNBestParams(mod_access
																														 ,include_minors
																														 ,suppress_and_mask_:=FALSE); //since suppression and masking is done below
																										
	//we hit the BestSSN key to get the 'best ssn' - this will return the same SSN 'most' of the time
  with_bestSSNs := SSNBest_Services.Functions.fetchSSNs_generic(outfile_,ssnBestParams,best_ssn,did,fromADL:=true);
																										 
  outfile_2 := if(GetSSNBest, with_bestSSNs, outfile_);
	
	//**** Pull by DID and by both SSN fields
	Suppress.MAC_Suppress(outfile_2,outfile_pulled_DID,mod_access.application_type,Suppress.Constants.LinkTypes.DID,did);
	Suppress.MAC_Suppress(outfile_pulled_DID,outfile_pulled_SSN,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,best_ssn);
	Suppress.MAC_Suppress(outfile_pulled_SSN,outfile_pulled_MAX,mod_access.application_type,Suppress.Constants.LinkTypes.SSN,max_ssn);

	//**** Mask
	suppress.MAC_Mask(outfile_pulled_MAX,	outfile_masked,	best_ssn,	nodl,true,false);
	suppress.MAC_Mask(outfile_masked,			outfile_masked2,max_ssn,	nodl,true,false);
	
	//investigate why the join below is duplicating some of the rows..
	
	//**** If pulled, we need to still return a record of inputs, so join back and keep RHS if not pulled
	outfile := 
	join(
		infile,
		outfile_masked2,
		left.did = right.did and 
		left.seq = right.seq,
		transform(
			recordof(infile),
			self := if(right.did > 0, right, left)
		),
		grouped,
		left outer
	);

  ENDMACRO;