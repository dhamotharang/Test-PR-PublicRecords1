import ut;

// outhead := distribute(header.didtrack_ds_apply_joinrule,hash(did));

boolean temp_v_start_fresh := false : stored('DIDTrack_StartFresh');

// Selects the current DIDTrack file if we're not starting new, otherwise,
// opts to project the current header file into DIDTrack form.
ds_didtrack :=
	if(
		temp_v_start_fresh,
		header.didtrack_ds_initial,
		header.didtrack_ds_file);

ds_joinrule1 := header.With_Did.mod_pass1.mod_DR0.combined;
ds_dodgy		 := header.With_Did.dodgies1;
ds_joinrule2 := header.With_Did.mod_pass2.mod_DR0.combined;

ds_didtrack1 := Header.didtrack_fn_apply_joinrule	(ds_didtrack,  ds_joinrule1,  in_ver_sub := 1);
ds_didtrack2 := Header.didtrack_fn_apply_dodgy		(ds_didtrack1, ds_dodgy, 			in_ver_sub := 2);
ds_didtrack3 := Header.didtrack_fn_apply_joinrule	(ds_didtrack2, ds_joinrule2,  in_ver_sub := 3);


ut.MAC_SF_BuildProcess(ds_didtrack3,'~thor_data400::base::didtrack',didtrack_out,,,true);

export Proc_DidTrack := didtrack_out;