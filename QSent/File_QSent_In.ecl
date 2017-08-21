import ut;

export File_QSent_In(unsigned8 mylimit = 0) := module

	// export orig := dataset('~thor_data400::in::qsent',qsent.Layout_Qsent.orig, CSV(SEPARATOR(['\t'])));
	
	export lsi_raw := choosen(dataset('~thor_data400::in::qsent::lsi', qsent.Layout_Qsent.lsi , csv),IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));
				 lsi_praw := qsent.fnPreprocess_LSI(lsi_raw); //fields are not in readable format. needs fn to clean up
	export lsi := lsi_praw;
  
	export lsp_raw := choosen(dataset('~thor_data400::in::qsent::lsp', qsent.Layout_Qsent.lsp, csv),IF(MyLimit<>0,MyLimit,CHOOSEN:ALL));
	export lsp := project(lsp_raw,transform(qsent.Layout_Qsent.common, self.file := 'P', self := left, self := [])); //- simple reformat to new layout
	
	export lss_old_raw := choosen(dataset('~thor_data400::in::qsent::lss', qsent.Layout_Qsent.lss_old, csv),IF(MyLimit<>0,(unsigned8)(MyLimit/2),CHOOSEN:ALL)); 
	export lss_new_raw := choosen(dataset('~thor_data400::in::qsent::lss_new', qsent.Layout_Qsent.lss_new, csv),IF(MyLimit<>0,(unsigned8)(MyLimit/2),CHOOSEN:ALL)); 
				 lss_old_praw := project(lss_old_raw,transform(qsent.Layout_Qsent.common, self.file := 'S', self := left, self := []));// layout change, simple reformat older to new layout
				 lss_new_praw := project(lss_new_raw,transform(qsent.Layout_Qsent.common, self.file := 'S', self := left, self := []));// layout change, simple reformat older to new layout
	export lss := lss_old_praw + lss_new_praw;

  export all_files := lsi + lsp + lss  : persist('~thor_data400::persist::qsent::lss');

end;
