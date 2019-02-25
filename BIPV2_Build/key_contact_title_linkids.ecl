Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD;

EXPORT key_contact_title_linkids(string pVersion=(string) STD.Date.Today()) := module

  contactKey := BIPV2_Build.files().contact_linkids.built;
  build_date := (unsigned) STD.Str.Filter(pversion,'0123456789');
		shared contactTitles := BestContactTitle(contactKey, build_date).contact_title;

  shared contact_title_bipd_pst          :=   contactTitles : persist('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep');
  export contact_title_bipd_dst          :=   dataset('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep',{contactTitles},flat);
  
  export dkeybuild      := contact_title_bipd_pst;
	
  // DEFINE THE INDEX
  shared superfile_name := keynames(, tools._Constants.IsDataland).contact_title_linkids.QA;
  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, k, superfile_name)
  export Key := k;
  
  // -- ensure easy access to different logical and super versions of the key
  export keyvs(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key' ,keynames(pversion,penvironment).contact_title_linkids);
  export keybuilt       := keyvs().built      ;
  export keyQA          := keyvs().qa         ;
  export keyfather      := keyvs().father     ;
  export keygrandfather := keyvs().grandfather;
  
	 //export kfetch_layout :={Key};
	 shared restrict(ds, in_mod, permits, ds_src='', dnbWillMask=false, isDateFirstSeenExists=false) := functionmacro
		  ds_filt := ds(BIPV2.mod_sources.isPermitted(in_mod,dnbWillMask).byBmap(permits));
    return ds_filt;
  endmacro;
	
	
  export kFetch(
                dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 
               ,string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID
               ,unsigned2 ScoreThreshold = 0
               ,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
               ,JoinLimit=25000
               ,boolean includeDMI=false // called dnbWillMask in bip_Best and true for name/address/phone false for fein/url/incorpdate
               ) := function
    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, ds_fetched, Level, JoinLimit);														// kfetch 								 
								 
    {ds_fetched} apply_restrict(ds_fetched L) := transform
                   self.contact_title		:= L.contact_title(BIPV2.mod_sources.isPermitted(in_mod,includeDMI).byBmap(data_permits));
                  	self := L;
	                end;
	   ds_restricted := project(ds_fetched, apply_restrict(left));
    return ds_restricted;
  END;
  
end;
