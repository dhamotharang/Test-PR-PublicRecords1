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

IMPORT ut, watchdog, doxie_files, Infutor, DeathV2_Services, AutoStandardI;
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

#uniquename(filter_exp)
%filter_exp% := doxie.DataRestriction.isECHRestricted(drm);
#uniquename(filter_eq)
%filter_eq% := doxie.DataRestriction.isEQCHRestricted(drm);

#uniquename(fetched_glb)
doxie.MAC_fetch_watchdog(%fetched_glb%,did_stream,did_field,watchdog.Key_watchdog_glb_old,bestlayout);
#uniquename(fetched_glb_nonutil)
doxie.MAC_fetch_watchdog(%fetched_glb_nonutil%,did_stream,did_field,watchdog.Key_watchdog_glb_nonutil_old,bestlayout);
#uniquename(fetched_glb_nonutil_nonblank)
doxie.MAC_fetch_watchdog(%fetched_glb_nonutil_nonblank%,did_stream,did_field,watchdog.Key_watchdog_glb_nonutil_nonblank_old,bestlayout);
#uniquename(fetched_glb_nonexp)
doxie.MAC_fetch_watchdog(%fetched_glb_nonexp%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonExperian_old,bestlayout);
#uniquename(fetched_glb_noneq)
doxie.MAC_fetch_watchdog(%fetched_glb_noneq%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonEquifax_old,bestlayout); 
#uniquename(fetched_glb_nonexp_noneq)
doxie.MAC_fetch_watchdog(%fetched_glb_nonexp_noneq%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_old,bestlayout); 
#uniquename(fetched_glb_nonblank)
doxie.MAC_fetch_watchdog(%fetched_glb_nonblank%,did_stream,did_field,watchdog.key_watchdog_glb_nonblank_old,bestlayout);
#uniquename(fetched_glb_nonexp_nonblank)
doxie.MAC_fetch_watchdog(%fetched_glb_nonexp_nonblank%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonExperian_nonblank_old,bestlayout);
#uniquename(fetched_glb_noneq_nonblank)
doxie.MAC_fetch_watchdog(%fetched_glb_noneq_nonblank%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonEquifax_nonblank_old,bestlayout); 
#uniquename(fetched_glb_noexp_noneq_nonblank)
doxie.MAC_fetch_watchdog(%fetched_glb_noexp_noneq_nonblank%,did_stream,did_field,watchdog.Key_Watchdog_GLB_nonExperian_nonEquifax_nonblank_old,bestlayout); 
#uniquename(fetched_nonglb)
doxie.MAC_fetch_watchdog(%fetched_nonglb%,did_stream,did_field,watchdog.Key_Watchdog_nonglb_old,bestlayout);
#uniquename(fetched_pre_glb)
doxie.MAC_fetch_watchdog(%fetched_pre_glb%,did_stream,did_field,Watchdog.Key_Watchdog_nonglb_V2_old,bestlayout);
#uniquename(fetched_nonglb_nonblank)
doxie.MAC_fetch_watchdog(%fetched_nonglb_nonblank%,did_stream,did_field,watchdog.key_watchdog_nonglb_nonblank_old,bestlayout);
#uniquename(fetched_pre_glb_nonblank)
doxie.MAC_fetch_watchdog(%fetched_pre_glb_nonblank%,did_stream,did_field,Watchdog.key_watchdog_nonglb_nonblank_V2_old,bestlayout);
#uniquename(fetched_marketing)
doxie.MAC_fetch_watchdog(%fetched_marketing%,did_stream,did_field,watchdog.Key_watchdog_marketing_old,bestlayout);
#uniquename(fetched_pre_glb_marketing)
doxie.MAC_fetch_watchdog(%fetched_pre_glb_marketing%,did_stream,did_field,Watchdog.Key_Watchdog_marketing_V2_old,bestlayout);

#uniquename(fetched_cnsmr)
doxie.MAC_fetch_watchdog(%fetched_cnsmr%,did_stream,did_field,Infutor.key_infutor_best_did,bestlayout);

#uniquename(outf)
%outf% := 
	IF(marketing, IF(doxie.DataRestriction.restrictPreGLB, %fetched_pre_glb_marketing%,%fetched_marketing%),
	IF(ut.IndustryClass.Is_Knowx, %fetched_cnsmr%,
	IF(
		useNonBlankKey,
		IF(
			glb_per,
			MAP(ut.IndustryClass.Is_Utility => %fetched_glb_nonutil_nonblank%,
					%filter_exp% and %filter_eq% => %fetched_glb_noexp_noneq_nonblank%, 
					%filter_exp% => %Fetched_glb_nonexp_nonblank%,
					%filter_eq% => %fetched_glb_noneq_nonblank%,		
					%fetched_glb_nonblank%
					),
			IF (doxie.DataRestriction.restrictPreGLB,
				%fetched_pre_glb_nonblank%,
				%fetched_nonglb_nonblank%
				)
		),
		IF(
			glb_per,
			MAP(ut.IndustryClass.Is_Utility => %fetched_glb_nonutil%,
					%filter_exp% and %filter_eq% => %fetched_glb_nonexp_noneq%,
					%filter_exp% => %fetched_glb_nonexp%,
					%filter_eq% => %fetched_glb_noneq%,
					%fetched_glb%),
			IF(doxie.DataRestriction.restrictPreGLB,
				%fetched_pre_glb%,
				%fetched_nonglb%
			)
		)
	)));
	
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