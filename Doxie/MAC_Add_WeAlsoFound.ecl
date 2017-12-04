export MAC_Add_WeAlsoFound(inputs, outputs, in_glb, in_dppa, str_out=false, enableNationalAccidents=false, enableExtraAccidents=false) :=
MACRO

import doxie, WatercraftV2_Services, Email_Data, paw_services, Prof_LicenseV2,
       FLAccidents_eCrash, Accident_Services, Relationship,std,ut,D2C;
			 Relationship.mac_read_application_type();

// phones+ counts have to be done outside of transform, since macro declares IMPORTs, 
// which is not allowed within the transform on non-OSS platform
integer GetPhonesPlusCount (unsigned6 udid, integer glb, integer dppa, string industry_class, string drm) := function

	
  doxie.MAC_Get_GLB_DPPA_PhonesPlus (dataset ([{udid}], doxie.layout_references), 
                                     phplus_key, true, true, glb, dppa, industry_class,
                                     ,,,,drm,
                                     true); // skip penalizing;

  // Need to apply the same deduping / filtering as in doxie.phone_noreconn_search.
	// Same filter is used in doxie.phone_noreconn_search so a change in either file necessitates keeping
	// the filters on phonerecs attribute below in sync with logic in doxie.phone_noreconn_search.
  // activeflag='' means "exclude current Gong".
  phone_recs := dedup (phplus_key (activeflag=''), phone, 
                       if(lname<>'',lname, listed_name), fname, prim_range, prim_name, zip, ALL);
  return count(CHOOSEN (phone_recs, 255));
end;

inputs tra(inputs l) := transform
	
	udid := (unsigned6)l.did;
	
	comp_prop_count := doxie.Fn_comp_prop_count(udid,,,,ln_branded_value,probation_override_value);
	veh_cnt := doxie.Fn_veh_count(udid,dateval,dppa_purpose,glb_purpose,ln_branded_value,probation_override_value);
	dl_cnt := doxie.Fn_dl_count(udid,dateval,dppa_purpose,glb_purpose,ln_branded_value,probation_override_value);
	Relationship.Layout_GetRelationship.DIDs_layout prep_did() := transform
		SELF.did := udid;
		SELF := [];
	END;
	did_rec := DATASET ([prep_did()]);	
	all_assoct := Relationship.proc_GetRelationship(
												DID_ds := did_rec,
												RelativeFlag := TRUE,
												AssociateFlag := TRUE,
												AllFlag := FALSE,
												TransactionalOnlyFlag := FALSE,
												MaxCount := 510,
												doSkip := TRUE,
												HighConfidenceRelatives := HighConfidenceRelatives_Value,
												HighConfidenceAssociates:= HighConfidenceAssociates_Value,
												RelLookbackMonths := RelLookbackMonths_Value).result;
	
 	rel_count   := count(CHOOSEN(all_assoct (isRelative),255));
	assoc_count := count(CHOOSEN(all_assoct (~isRelative),255));
	
	tmpproflicenseList := CHOOSEN(Prof_LicenseV2.Key_Proflic_Did ()(keyed(did=udid)),255);		
	
	PlList := PROJECT(tmpproflicenseList, TRANSFORM({RECORDOF(LEFT);STRING20 TmpLicenseNumber;},		           								 
	             // first remove only leading 0's in string and then remove '-' chars in any place
							 // in the string as well.
							 tmp1 := REGEXREPLACE('^[0]*', trim(left.Orig_license_number, left, right), ''); 
		           SELF.TmpLicenseNumber :=  std.str.FindReplace(tmp1,'-','');								  								 
							 SELF := LEFT;
							 ));
	SlimPlList := DEDUP(SORT(PlList, did, tmpLicenseNumber, source_st),
		                        did, tmpLicenseNumber, source_st);      														
	slim_countPL := PROJECT(SlimPlList, TRANSFORM(recordof(Prof_LicenseV2.Key_Proflic_Did()),
		                       SELF := LEFT));
		                
	// end new code
	
	prof_count := count(slim_countPL); //choosen done on attr above so ok here.	
	
	paw_count := paw_services.PAW_Raw.getPAWcount(udid,in_glb,in_dppa,255);
	vess_count := count(CHOOSEN(dedup(sort(WatercraftV2_Services.WatercraftV2_raw.Report_View.by_did(dataset([{udid}],Doxie.layout_references)),
								watercraft_key,state_origin),watercraft_key,state_origin),255));

	accidents := JOIN(CHOOSEN(FLAccidents_eCrash.Key_eCrashV2_did(KEYED(l_did=udid)),ut.limits.ACCIDENTS_PER_DID),
										FLAccidents_eCrash.Key_eCrash2v,
										LEFT.accident_nbr=RIGHT.l_acc_nbr,LEFT OUTER,KEEP(1),LIMIT(0)); 
	accidentNbrs := DEDUP(SORT(accidents,accident_nbr,report_code),accident_nbr,report_code);
	FLAccident_count := COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.FLAccident_source),255));
	NtlAccident_count := IF(enableNationalAccidents,COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.NtlAccident_source),255)),0);
	eCrashAccident_count := IF(enableExtraAccidents,COUNT(CHOOSEN(accidentNbrs(report_code IN Accident_Services.Constants.eCrashAccident_source),255)),0);
  phonesplus_count := GetPhonesPlusCount (udid, in_glb, in_dppa, industry_class_value, doxie.DataRestriction.fixed_DRM);

	email_count := if(
											exists(Email_Data.Key_Did(keyed(udid=did) and 
															~( industry_class_value = ut.IndustryClass.Knowx_IC and email_src in D2C.Constants.EmailRestrictedSources )
																																		  )),1,0);
	self.comp_prop_count := (comp_prop_count);
	self.veh_cnt :=  (veh_cnt);
	self.dl_cnt  :=  (dl_cnt);
	SELF.rel_count := (rel_count);
	SELF.assoc_count := (assoc_count);
	SELF.prof_count := (prof_count);
	SELF.paw_count := (paw_count);
	SELF.vess_count := (vess_count);
	SELF.email_count := (email_count);
  SELF.phonesplus_count := (phonesplus_count);
	SELF.accident_count := FLAccident_count+NtlAccident_count+eCrashAccident_count;
	self := l;

end;

// calculated for the first row only on purpose: otherwise same (heavy) processing will be executed multiple times
outputs := PROJECT(choosen(inputs,1), tra(LEFT))&inputs[2..];

endmacro;