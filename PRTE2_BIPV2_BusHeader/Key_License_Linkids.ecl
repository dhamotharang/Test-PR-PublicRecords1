IMPORT BIPV2, BusReg, Data_Services, Doxie, MDR, AutoStandardI,tools;

EXPORT Key_License_Linkids := MODULE

   // DEFINE THE INDEX
	shared superfile_name		:= keynames().License_linkids.qa;

	shared Base				:= Files().base.License.built(license_number<>'' or
																									license_state<>''
																								 );
	
	BIPV2.IDmacros.mac_IndexWithXLinkIDs(Base, k, superfile_name)
	export Key := k;
  export keyvs(string pversion = '' ,boolean	pUseOtherEnvironment = false) := tools.macf_FilesIndex('Key' ,keynames(pversion,pUseOtherEnvironment).License_LinkIds);
  export keybuilt := keyvs().built;
  export keyfather := keyvs().father;
  export keygrandfather := keyvs().grandfather;


		// DEFINE THE INDEX ACCESS
		export KeyFetch(
				dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
				string1 Level = BIPV2.IDconstants.Fetch_Level_DotID, //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																														 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																														 //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
				unsigned2 ScoreThreshold = 0,											   //Applied at lowest leve of ID
				BIPV2.mod_sources.iParams in_mod=PROJECT(AutoStandardI.GlobalModule(),BIPV2.mod_sources.iParams,opt),
				JoinLimit = 25000

									) :=FUNCTION

				BIPV2.IDmacros.mac_IndexFetch(in_ds_withids, Key, out_fetch, Level, JoinLimit)
				ds_restricted := out_fetch(BIPV2.mod_sources.isPermitted(in_mod).bySource(source, ''));
				return ds_restricted;	
		end;

END;
