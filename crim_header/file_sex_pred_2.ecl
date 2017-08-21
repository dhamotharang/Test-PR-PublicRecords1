import ut,crimsrch;
export File_Sex_Pred_2
 := dataset(ut.foreign_prod + '~thor_data400::in::sex_pred_2_' + crim_header.Version.SexPred,
			CrimSrch.Layout_Sex_Pred_2,flat,unsorted
		   );