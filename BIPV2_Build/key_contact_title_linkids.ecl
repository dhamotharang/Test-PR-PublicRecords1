Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD;

EXPORT key_contact_title_linkids(string pVersion=(string) STD.Date.Today()) := module

  //Using the index instead of base file (BIPV2_Build.files().contact_linkids.built) because of Roxie compile problems 
	 contactKey := project(pull(BIPV2_Build.key_contact_linkids.keyvs(,false).built), recordof(key_contact_linkids.dkeybuild));
	 
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
 
	 export kFetch2(
                dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs 
               ,string1 Level = BIPV2.IDconstants.Fetch_Level_ProxID
               ,unsigned2 ScoreThreshold = 0
               ,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
               ,boolean includeDMI=false
							        ,JoinLimit=25000
							        ,unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
               ) := function							 
    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, JoinLimit, JoinType);								 
    {ds_fetched} apply_restrict(ds_fetched L) := transform
                   self.contact_title		:= L.contact_title(BIPV2.mod_sources.isPermitted(in_mod,includeDMI).byBmap(data_permits));
                  	self := L;
	                end;
	   ds_restricted := project(ds_fetched, apply_restrict(left));
    return ds_restricted;
  END;

END;
