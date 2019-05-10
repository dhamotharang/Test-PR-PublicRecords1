IMPORT BIPV2, doxie, data_services;

EXPORT Key_LinkIds := MODULE

		shared  base_recs 					:= project(LiensV2.file_liens_party_BIPV2,LiensV2.Layout_liens_party_SSN_BIPV2 and not [tmsid_old,rmsid_old]);//DF-24061

		export  out_SuperKeyName  := Data_Services.Data_location.Prefix('Liensv2')+'thor_data400::key::liensv2::party::linkids_' + Doxie.Version_SuperKey;

		BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_recs, out_key, out_SuperKeyName);
		export Key := out_key;
			
			//DEFINE THE INDEX ACCESS
		export kFetch2(
				dataset(BIPV2.IDlayouts.l_xlink_ids2) inputs, 
				string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	 //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																															//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																														 //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
				unsigned2 ScoreThreshold = 0,											  //Applied at lowest leve of ID
				joinLimit = 25000,
				unsigned1 JoinType = BIPV2.IDconstants.JoinTypes.KeepJoin
									) :=FUNCTION

				BIPV2.IDmacros.mac_IndexFetch2(inputs, Key, out_fetch, Level, joinLimit, JoinType);
				return out_fetch;	
		END;
		
		// Depricated version of the above kFetch2
		export KeyFetch(
				dataset(BIPV2.IDlayouts.l_xlink_ids) in_ds_withids, 
				string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,	 //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
																															//Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
																														 //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
				unsigned2 ScoreThreshold = 0,											  //Applied at lowest leve of ID
				joinLimit = 25000
									) :=FUNCTION

				inputs_for2 := project(in_ds_withids, BIPV2.IDlayouts.l_xlink_ids2);
				f2 := kFetch2(inputs_for2, Level, ScoreThreshold, joinLimit);
				return project(f2, recordof(Key));
		END;

END;