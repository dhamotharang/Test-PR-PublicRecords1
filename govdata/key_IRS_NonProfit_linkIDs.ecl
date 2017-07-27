IMPORT BIPV2, doxie, VersionControl;

EXPORT key_IRS_NonProfit_linkIDs := MODULE
	LinkID_Layout := record
		govdata.Layouts_IRS_NonProfit.Base_AID -[exempt_org_status_code];
	end;

	shared  base_recs 					:= project(govdata.File_IRS_NonProfit_Base_AID,transform(LinkID_Layout,self := left));
	export  out_superfile_Name  := govdata.keynames(,VersionControl._Flags.IsDataland).IRS_NonprofitLinkIDs.qa; //linkid Key Super FileName
	
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_superfile_Name);
  export Key := out_key;
	
	//DEFINE THE INDEX ACCESS
	export kFetch2(
		dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		joinLimit = 25000,
		unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
								) :=FUNCTION

		BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out_fetch, Level, joinLimit, JoinType);
		return out_fetch;	
	END;
	
	// Depricated version of the above kFetch2
	export KeyFetch(
		dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
		string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	//The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																												 //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																												//Should be enumerated or something?  at least need constants defined somewhere if you keep string1
		unsigned2 ScoreThreshold = 0,											 //Applied at lowest leve of ID
		JoinLimit = 25000
								) :=FUNCTION

		inputs_for2 := project(in_ds_withids, BIPV2.IDlayouts.l_xlink_ids2);
		f2 := kFetch2(inputs_for2, Level, ScoreThreshold, JoinLimit);
		return project(f2, recordof(Key));
	END;

END;