import AVM_V2, ln_property, ut,Scrubs_AVM;

// now that the AVM build is accepting a history date, 
// the first 8 bytes of the filedate passed into this Proc must be a valid date
export Proc_Build_File_and_Keys(string filedate) := function
	
// step1: build the AVM
	current_avm := AVM_V2.File_AVM(filedate[1..8]);
	avm_with_history := AVM_V2.File_AVM_Hist(current_avm);
	ut.mac_sf_buildprocess(avm_with_history, '~thor_data400::base::avm_v2', build_avm, 2,, true);

// step2: build the AVM comps	
	comps := avm_v2.File_Hedonic_Comps('', filedate[1..8]);
	ut.mac_sf_buildprocess(comps, '~thor_data400::base::avm_v2_comps', build_avm_comps, 2,, true);

// step3: build the AVM medians		
	current_medians := AVM_V2.File_AVM_Medians(current_avm, filedate[1..8]);
	medians_with_history := AVM_V2.File_AVM_Medians_Hist(ungroup(current_medians));
	ut.mac_sf_buildprocess(medians_with_history, '~thor_data400::base::avm_v2_medians', build_avm_medians, 2,, true);
	
// step4: build the AVM keys	
// step5: build strata
   out_strata_stats := AVM_V2.out_AVM_Strata_Population(filedate);

	do_all := sequential(build_avm, build_avm_comps, build_avm_medians, AVM_V2.buildkeys(filedate),out_strata_stats,Scrubs_AVM.fnRunScrubs(filedate,''));

return do_all;

end;