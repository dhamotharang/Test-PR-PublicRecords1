import AutokeyB2,doxie,liensv2, AutoKeyI, AutoStandardI;

export Autokey_ids (boolean workHard = true,boolean noFail = false, boolean isMoxie = false,
                   boolean includeDeepDive=true, boolean isFCRA = false, 
									 LiensV2_Services.IParam.ak_params in_mod = module(project(AutoStandardI.GlobalModule(isFCRA),LiensV2_Services.IParam.ak_params,opt))end ) := FUNCTION
//****** SEARCH THE AUTOKEYS
outrec := LiensV2_Services.layout_search_IDs;
t := if(isFCRA, liensv2.str_autokeyname_fcra, LiensV2.str_AutokeyName);
ds := liensv2.file_SearchAutokey(dataset([],LiensV2.Layout_liens_party));
typestr := 'BC';
tempmod := module(project(in_mod,AutoKeyI.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t;
	export string typestr := ^.typestr;
	export set of string1 get_skip_set := [];
	export boolean workHard := ^.workHard;
	export boolean noFail := ^.noFail;
	export boolean useAllLookups := true;
end;
ids := AutoKeyI.AutoKeyStandardFetch(tempmod).ids;

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
AutokeyB2.mac_get_payload_ids(ids,t,ds,outpl,intdid,intbdid, typestr,, newdids, newbdids, olddids, oldbdids)

//***** DIDs  (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
newbydid := liensv2_services.liens_raw.get_rmsids_from_dids(newdids, isMoxie);

//***** BDIDs (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
newbybdid := liensv2_services.liens_raw.get_rmsids_from_bdids(newbdids,, isMoxie);

//***** FOR DEEP DIVES
DeepDives    := project(newbydid + newbybdid, transform(outrec, self.isDeepDive := true, self := left));
// output(ids, named('ids'));
// output(outpl, named('outpl'));
// output(dids, named('dids'));
// output(bdids, named('bdids'));

//****** IDS DIRECTLY FROM THE PAYLOAD KEY
byak := project(outpl, outrec);

dups := byak + 
	    if(includeDeepDive, deepDives);
		
return dedup(sort(dups, tmsid, rmsid, if(isDeepDive,1,0)), tmsid, rmsid);
END;