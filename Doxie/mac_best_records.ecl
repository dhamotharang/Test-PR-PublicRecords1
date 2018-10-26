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

IMPORT ut, dx_BestRecords, doxie_files, DeathV2_Services, AutoStandardI;
#uniquename(deathparams)
%deathparams% := DeathV2_Services.IParam.GetDeathRestrictions(AutoStandardI.GlobalModule());
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
%utility_flag% := ut.IndustryClass.Is_Utility;
#uniquename(filter_exp)
%filter_exp% := doxie.DataRestriction.isECHRestricted(drm);
#uniquename(filter_eq)
%filter_eq% := doxie.DataRestriction.isEQCHRestricted(drm);

// get appropriate best_records permission flag
#uniquename(perm_flag)
%perm_flag% := dx_BestRecords.fn_get_perm_type(glb_per, useNonBlankKey, %utility_flag%, %pre_glb_flag%, 
	%filter_exp%, %filter_eq%, marketing, %cnsmr_flag%);

#uniquename(outf)
%outf% := project(dx_BestRecords.get(did_stream, did_field, %perm_flag%), 
	transform(bestlayout, self := left._best));
	
#uniquename(outfile_nominors)
%outfile_nominors% := join(%outf%, doxie_files.key_minors_hash,
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
#uniquename(fillDOD)			
%outfile_noDeath% %fillDOD%(%outfile_noDeath% l, doxie.key_death_masterV2_ssa_DID r) := transform
   self.dod := r.dod8;
	 self := L;
end;
#uniquename(outfile_Death)
// since only dod8 is taken
%outfile_death% := join(%outfile_watchdog_death%,doxie.key_death_masterV2_ssa_DID,
															keyed(left.did = right.l_did)  and
															not DeathV2_Services.functions.Restricted(right.src, right.glb_flag, glb_per, %deathparams%),
															%fillDOD%(LEFT,RIGHT),left outer, KEEP(1), LIMIT (0));

outfile := IF (include_dod, %outfile_death%, %outfile_noDeath%); 

endmacro;