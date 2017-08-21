import ut,crimsrch;
export File_Sex_Pred_Search_DID
 := dataset(ut.foreign_prod + '~thor_data400::in::sex_pred_search_' + crim_header.Version.SexPred,
			CrimSrch.Layout_Sex_Pred_Search_DID,flat,unsorted
		   );
		   
