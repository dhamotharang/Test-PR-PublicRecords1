import death_master,doxie,autokeyb2,AutoKeyI,AutoStandardI;

export Autokey_ids := 

FUNCTION

con := death_master.Constants('');
outrec := DeathV2_Services.layouts.search_ID;

//****** SEARCH THE AUTOKEYS
ds := Death_Master.file_searchautokey_ssa;
tempmod := module(project(AutoStandardI.GlobalModule(),AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := con.autokey_keyname_ssa;
	export string typestr := 'AK';
	export set of string1 get_skip_set := con.autokey_skip_set;
	export boolean workHard := con.workHard;
	export boolean noFail := con.search_noFail;
	export boolean useAllLookups := true;
end;
ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

//****** GRAB THE PAYLOAD KEY
AutokeyB2.mac_get_payload(ids,con.autokey_keyname_ssa,ds,outPL,did,zero)

//****** IDS DIRECTLY FROM THE PAYLOAD KEY
byak := project(outpl, outrec);

dups := byak;
		
// output(outpl, named('outpl'));
return dedup(sort(dups, state_death_id, if(isDeepDive,1,0)), state_death_id);

END;