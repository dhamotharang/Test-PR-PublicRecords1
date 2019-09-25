export mac_best_records(
												did_stream,
												did_field,
												outfile,
												dppa_per,
												glb_per, 
												useNonBlankKey = 'false', 
												drm='', 
												marketing = 'false', 
												include_minors='\'\'', 
												bestlayout='doxie.layout_best',
												include_dod = false
												) := macro


IMPORT AutoStandardI, DeathV2_Services, Doxie, dx_BestRecords, dx_death_master, dx_header, 
       MDR, Suppress, ut;
#uniquename(death_params)
%death_params% := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
 
//If no minors_field value is set, use glb permission to determine if minors should be kept in record set.
#uniquename(minors_ok)
#if(include_minors != '')
	#if(include_minors = 'true')
			%minors_ok% := true;
	#else
			%minors_ok% := false;
	#end
#else
	%minors_ok% := ut.PermissionTools.glb.OKtoShowMinors;
#end

#uniquename(pre_glb_flag)
%pre_glb_flag% := doxie.DataRestriction.restrictPreGLB;
#uniquename(cnsmr_flag)
%cnsmr_flag% := ut.IndustryClass.Is_Knowx;
#uniquename(utility_flag)
%utility_flag% := Doxie.Compliance.isUtilityRestricted(ut.IndustryClass.Get());
#uniquename(filter_exp)
%filter_exp% := doxie.DataRestriction.isECHRestricted(drm);
#uniquename(filter_eq)
%filter_eq% := doxie.DataRestriction.isEQCHRestricted(drm);

// get appropriate best_records permission flag
#uniquename(perm_flag)
%perm_flag% := dx_BestRecords.Functions.get_perm_type(glb_per, useNonBlankKey, %utility_flag%, %pre_glb_flag%, 
	%filter_exp%, %filter_eq%, marketing, %cnsmr_flag%);


#uniquename(outf)
%outf% := dx_BestRecords.get(did_stream, did_field, %perm_flag%, bestlayout);

	
#uniquename(outfile_nominors)
%outfile_nominors% := join(%outf%, dx_header.key_minors_hash(),
														LEFT.did != 0 AND
														KEYED(hash32((UNSIGNED6)LEFT.did)=RIGHT.hash32_did) AND
		                  			KEYED(LEFT.did = RIGHT.did) AND 
														ut.age(right.dob) < 18,   //check age since a few will turn 18 between builds
														TRANSFORM(LEFT),
														LEFT ONLY);
#uniquename(outfile_watchDog_death)															 
%outfile_watchdog_death% := IF (%minors_ok%,%outf%,%outfile_nominors%);
#uniquename(clearDOD)
%outfile_watchdog_death% %clearDOD%(%outfile_watchdog_death% l) := transform
  self.dod := '';
  self := l;
end;

#uniquename(outfile_noDeath)															 
%outfile_noDeath% := project(%outfile_watchdog_death%, %clearDOD%(LEFT));

//use a DOD value from an un-restricted DeathMaster record
#uniquename(death_raw_recs)
%death_raw_recs% := dx_death_master.Append.byDid(%outfile_watchdog_death%, did, %death_params%);

//use a DOD value from an un-restricted DeathMaster record
#uniquename(fillDOD)			
%outfile_noDeath% %fillDOD%(%death_raw_recs% l) := transform
   self.dod := l.death.dod8;
   self.IsLimitedAccessDMF := (l.death.src = MDR.sourceTools.src_Death_Restricted);
	 self := L;
end;
#uniquename(outfile_death)
%outfile_death% := PROJECT(%death_raw_recs%,  %fillDOD%(LEFT));

outfile := IF (include_dod, %outfile_death%, %outfile_noDeath%); 
endmacro;
