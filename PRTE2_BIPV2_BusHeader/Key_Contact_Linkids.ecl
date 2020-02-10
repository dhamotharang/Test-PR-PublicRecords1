import AutoStandardI, BIPV2, tools,MDR,STD,_control;;

export Key_Contact_Linkids := 
module

  export dkeybuild      := Files().base.Contacts.built;
	
  shared dkeybuild1:= MDR.macGetGlobalSid(dkeybuild,'BIPV2','source','global_sid');  
	
	shared superfile_name := keynames().contact_linkids.QA;
  
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(dkeybuild1, k, superfile_name)
  export Key := k;
  
  // -- ensure easy access to different logical and super versions of the key
  export keyvs(string pversion = '',boolean penvironment = false) := tools.macf_FilesIndex('Key' ,keynames(pversion,penvironment).contact_linkids);
  export keybuilt       := keyvs().built      ;
  export keyQA          := keyvs().qa         ;
  export keyfather      := keyvs().father     ;
  export keygrandfather := keyvs().grandfather;
  
  //DEFINE THE INDEX ACCESS
  export kFetch(
                  dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 
                  ,string1 Level = BIPV2.IDconstants.Fetch_Level_DotID
                  ,unsigned2 ScoreThreshold = 0
									,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
									,JoinLimit=25000
									,boolean includeDMI=false
                  ) :=
		function
                  BIPV2.IDmacros.mac_IndexFetch(inputs, Key, out, Level, JoinLimit);
									ds_restricted :=out(BIPV2.mod_sources.isPermitted(in_mod,includeDMI).bySource(source, vl_id) );							
									BIPV2_Suppression.mac_contacts(ds_restricted, ds_suppressed_clean, ds_suppressed_dirty)
                  return ds_suppressed_clean;
									
		end;	
	end;