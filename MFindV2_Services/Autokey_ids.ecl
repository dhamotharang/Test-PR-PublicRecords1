import autokeyb,autokeyb2,doxie,doxie_raw,business_header,doxie_cbrs,corp2,roxieKeyBuild,autokeyi,AutoStandardI;

export autokey_ids(boolean workhard = false, boolean nofail =false, boolean NoDeepDives = false) := 
FUNCTION

doxie.MAC_Header_Field_Declare()


outrec := MFindV2_Services.Layout_Search_IDs;

//****** SEARCH THE AUTOKEYS
t :='~thor_data400::key::mfind::autokey::';
//t := '~thor_data400::key::mfind::qa::autokey::';
ds := dataset([],MFindV2_Services.Layout_Autokey);
typestr :='BC';
tempmod := module(project(AutoStandardI.GlobalModule(),autokeyi.AutoKeyStandardFetchArgumentInterface,opt))
	export string autokey_keyname_root := t;
	export string typestr := ^.typestr;
	export set of string1 get_skip_set := ['P','S','B'];
	export boolean workHard := ^.workHard;
	export boolean noFail := ^.noFail;
	export boolean useAllLookups := true;
end;
ids := autokeyi.AutoKeyStandardFetch(tempmod).ids;

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
MFindV2_Services.mac_get_payload_ids(ids,t,ds,outpl,did,typestr,, newdids)


//***** DIDs  (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
newbydid := MFindV2_Services.MFind_raw. get_Vids_from_dids(newdids);


//***** FOR DEEP DIVES
DeepDives    := project(newbydid, transform(outrec, self.isDeepDive := true, self := left));


//****** IDS DIRECTLY FROM THE PAYLOAD KEY
byak := project(outpl, transform(outrec,self.vid := trim(left.trim_vid,all),self := left));

boolean includeDeepDive := not NoDeepDives;

dups := byak +  
	    if(includeDeepDive, deepDives);
		
return dedup(sort(dups, Vid, if(isDeepDive,1,0)), Vid);

END;