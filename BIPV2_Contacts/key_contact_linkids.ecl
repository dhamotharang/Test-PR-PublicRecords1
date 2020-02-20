import AutoStandardI;
import BIPV2;
import BIPV2_Build;
import tools;
import doxie;

export key_contact_linkids := module

	shared superfile_name := BIPV2_Build.keynames(, tools._Constants.IsDataland).contact_linkids.QA;
	shared emptyDs := dataset([], Layouts.contact_linkids.layoutOrigFile);

	// DEFINE THE INDEX - defaults to reading from superfile
	export Key(dataset(Layouts.contact_linkids.layoutOrigFile) ds = emptyDs, string fn = superfile_name) := function
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(ds, k, fn);
		return k;
	end;
  
	// -- ensure easy access to different logical and super versions of the key
	export keyvs(string pversion = '',boolean penvironment = tools._Constants.IsDataland) := tools.macf_FilesIndex('Key()' ,BIPV2_Build.keynames(pversion,penvironment).contact_linkids);
	export keybuilt       := keyvs().built      ;
	export keyQA          := keyvs().qa         ;
	export keyfather      := keyvs().father     ;
	export keygrandfather := keyvs().grandfather;
  
	 export kfetch_layout :={Key()};
	
  //DEFINE THE INDEX ACCESS
  export kFetch(
                  dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 			  
                  ,string1 Level = BIPV2.IDconstants.Fetch_Level_DotID
                  ,unsigned2 ScoreThreshold = 0
									,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
									,JoinLimit=25000
									,boolean includeDMI=false
                  ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
                  ) :=
  function
                  BIPV2.IDmacros.mac_IndexFetch(inputs, Key(), out, Level, JoinLimit);
									ds_restricted :=out(BIPV2.mod_sources.isPermitted(in_mod,includeDMI).bySource(source, vl_id) );							
									BIPV2_Suppression.mac_contacts(ds_restricted, ds_suppressed_clean, ds_suppressed_dirty)
									
                  BIPV2_Contacts.mac_check_access(ds_suppressed_clean, ds_suppressed_clean_out, mod_access);
                  return ds_suppressed_clean_out;
 
									
  end;

  
	//DEFINE THE INDEX ACCESS
  export kFetchMarketing(
                  dataset(BIPV2.IDlayouts.l_xlink_ids) inputs 			   
                  ,string1 Level = BIPV2.IDconstants.Fetch_Level_DotID
                  ,unsigned2 ScoreThreshold = 0
                  ,BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt)
                  ,JoinLimit=25000
                  ,boolean includeDMI=false
			   ,doxie.IDataAccess mod_access = MODULE (doxie.IDataAccess) END
                  ) :=
  function   
    kFetched := kfetch(inputs, Level, ScoreThreshold, in_mod, JoinLimit, includeDMI, mod_access);
		  allowCodeBmap := BIPV2.mod_Sources.code2bmap(BIPV2.mod_Sources.code.MARKETING_UNRESTRICTED);
			 marketingSuppressed := kFetched(BIPV2.mod_sources.src2bmap(source) & allowCodeBmap <> 0);    
    return marketingSuppressed;						
  end;
end;
