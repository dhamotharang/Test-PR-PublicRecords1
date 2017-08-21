import autokeyb,autokeyb2,doxie,doxie_raw,business_header,doxie_cbrs,corp2,roxieKeyBuild;

export autokey_ids(boolean workhard = false, boolean nofail =false, boolean NoDeepDives = false) := 
FUNCTION

doxie.MAC_Header_Field_Declare()


outrec := MFind_services.Layout_Search_IDs;

//****** SEARCH THE AUTOKEYS
t :='~thor_data400::key::mfind::autokey::';
//t := '~thor_data400::key::mfind::qa::autokey::';
ds := dataset([],MFind_Services.Layout_Autokey);
typestr :='BC';
ids := autokeyb2.get_IDs(t,typestr,['P','S','B'],workHard,noFail);

//****** GRAB THE PAYLOAD KEY AND THE DIDS/BDIDS FROM THE AUTOKEYS
MFind_services.mac_get_payload_ids(ids,t,ds,outpl,did,typestr,, newdids)


//***** DIDs  (DOUBLE CALL OK HERE BECAUSE ONLY ONE WILL ACTUALLY BE PASSING IN RECORDS)
newbydid := MFind_services.MFind_raw. get_Vids_from_dids(newdids);


//***** FOR DEEP DIVES
DeepDives    := project(newbydid, transform(outrec, self.isDeepDive := true, self := left));


//****** IDS DIRECTLY FROM THE PAYLOAD KEY
byak := project(outpl, transform(outrec,self.vid := trim(left.trim_vid,all),self := left));

boolean includeDeepDive := not NoDeepDives;

dups := byak +  
	    if(includeDeepDive, deepDives);
		
return dedup(sort(dups, Vid, if(isDeepDive,1,0)), Vid);

END;