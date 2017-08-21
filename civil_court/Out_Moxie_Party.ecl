import civil_court,lib_stringlib;

df_Civil_Party_Aid := dataset('~thor_data400::in::civ_court::20071210::fl_brevard_party_aid', civil_court.aid_layouts, flat);

base := civil_court.aid_proc_build_base + df_Civil_Party_Aid; 	//use for roxie - base includes AID

//project back to moxie layout
civil_court.Layout_Moxie_Party trecs(base L) := transform
self := L;
end;
moxierecs := project(base,trecs(left));

export out_moxie_party := 
	parallel(
	output(moxierecs,,civil_court.Name_Moxie_Party_Dev,__compressed__,overwrite),

	output(base,,'~thor_200::base::civil_party_aid_'+civil_court.Version_Development,__compressed__,overwrite)
	);
