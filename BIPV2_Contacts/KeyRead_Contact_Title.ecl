Import BIPV2, tools, AutoStandardI, InsuranceHeader_PostProcess, STD,doxie;
import BIPV2_Build;
import BIPV2_Contacts;

export KeyRead_Contact_Title(string pVersion=(string) STD.Date.Today()) := module

	shared useOtherEnv := tools._Constants.IsDataland or tools._Constants.IsAlpha_dev;
	shared emptyDs := dataset([], Layouts.ContactTitle.buildRec);

	// DEFINE THE INDEX
	shared superfile_name := BIPV2_Build.keynames(, useOtherEnv).contact_title_linkids.QA;
	export IndexDef(string filename = superfile_name, dataset(Layouts.ContactTitle.buildRec) ds = emptyDs)  := function
		BIPV2.IDmacros.mac_IndexWithXLinkIDs(ds, kLinkIds, filename);	
		return kLinkIds;
	end;

	export Key := IndexDef();
  
	// -- ensure easy access to different logical and super versions of the key
	export keyvs(string pversion = '',boolean penvironment = useOtherEnv) := tools.macf_FilesIndex('Key' ,BIPV2_Build.keynames(pversion,penvironment).contact_title_linkids);
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
		Layouts.contactTitle.linkids apply_restrict(ds_fetched L) := transform
			BIPV2_build.mac_check_access(L.contact_title, contact_title_out, mod_access, true, contact_did);
			self.is_suppressed := exists(contact_title_out(is_suppressed)) and not exists(contact_title_out(not is_suppressed));
			self.contact_title := 
				project(contact_title_out(not is_suppressed and BIPV2.mod_sources.isPermitted(in_mod,includeDMI).byBmap(data_permits)),
					Layouts.contactTitle.contact_title_layout);
			self := L;
		end;
		ds_restricted := project(ds_fetched, apply_restrict(left));
		return ds_restricted;
	end;

end;
