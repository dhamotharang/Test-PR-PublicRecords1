Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD,doxie;
import BIPV2_Contacts;

EXPORT key_contact_title_linkids(string pVersion=(string) STD.Date.Today()) := module

  //Using the index instead of base file (BIPV2_Build.files().contact_linkids.built) because of Roxie compile problems 
  contactKey := project(pull(BIPV2_Contacts.key_contact_linkids.keyvs(,false).built), BIPV2_Contacts.layouts.contact_linkids.layoutOrigFile);
	 
  build_date := (unsigned) STD.Str.Filter(pversion,'0123456789');
	 shared contactTitles := BestContactTitle(contactKey, build_date).contact_title;

  shared contact_title_bipd_pst          :=   contactTitles : persist('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep');
  export contact_title_bipd_dst          :=   dataset('~persist::BIPV2_Build::key_contact_title_linkids.ds_prep',{contactTitles},flat);
  
  export dkeybuild      := contact_title_bipd_pst;
	
  // DEFINE THE INDEX
  shared superfile_name := keynames(, tools._Constants.IsDataland).contact_title_linkids.QA;
  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild, k, superfile_name)
  export Key := k;

   export contact_title_layout := RECORD
      unsigned8 contact_title_rank;
      unsigned2 data_permits;
      unsigned6 contact_did;
      string50 contact_job_title_derived;
      unsigned4 global_sid;
      unsigned8 record_sid;
   end;

   export finalLayout := RECORD
     unsigned6 ultid;
     unsigned6 orgid;
     unsigned6 seleid;
     unsigned6 proxid;
     unsigned4 global_sid;
     unsigned8 record_sid;
		 BIPV2.IDlayouts.l_xlink_ids2.uniqueId;
     DATASET(contact_title_layout) contact_title;
     boolean is_suppressed;
   end;
	 
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
			,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
               ) := function							 
    BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, ds_fetched, Level, JoinLimit, JoinType);								 
    finalLayout apply_restrict(ds_fetched L) := transform
		     BIPV2_build.mac_check_access(L.contact_title, contact_title_out, mod_access,true,contact_did);
				 self.is_suppressed   := exists(contact_title_out(is_suppressed)) and not exists(contact_title_out(not is_suppressed));
         self.contact_title		:= project(contact_title_out(not is_suppressed and BIPV2.mod_sources.isPermitted(in_mod,includeDMI).byBmap(data_permits)), contact_title_layout);                  	self := L;
	   end;
		 
	   ds_restricted := project(ds_fetched, apply_restrict(left));
        return ds_restricted;
  END;
  
END;
