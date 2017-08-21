IMPORT BKForeclosure;

EXPORT fGetInputFile(STRING filedate) := MODULE
  
  SHARED superfile_nod := '~thor_data400::in::BKForeclosure::nod_infile::using';
  SHARED superfile_reo := '~thor_data400::in::BKForeclosure::reo_infile::using';

  SHARED Nod_File_used := File_BK_Foreclosure.Nod_File_used;
	SHARED Reo_File_used := File_BK_Foreclosure.Reo_File_used;
	
  SHARED Nod_Update    := File_BK_Foreclosure.Nod_Update;
	SHARED Reo_Update    := File_BK_Foreclosure.Reo_Update;	
	
	SHARED Nod_Delete    := File_BK_Foreclosure.Nod_Delete;
	SHARED Reo_Delete    := File_BK_Foreclosure.Reo_Delete;

  SHARED NOD_Refresh   := File_BK_Foreclosure.Nod_Refresh;
  SHARED REO_Refresh   := File_BK_Foreclosure.Reo_Refresh;

  BKForeclosure.layout_BK.nod 		trans_Flag_Nod(Nod_File_used L, Nod_Delete R) := TRANSFORM
		SELF.Delete_Flag := R.Delete_Flag;
		SELF := L;
  END;
 
  EXPORT Nod_File_Filter := JOIN(Nod_File_used, Nod_Delete,
                            TRIM(LEFT.fips_cd) = TRIM(RIGHT.fips_cd)
													  AND TRIM(LEFT.lps_internal_pid) = TRIM(RIGHT.pid),
												    trans_Flag_Nod(LEFT,RIGHT),LEFT OUTER,LOOKUP);

  SHARED ds_nod1         := OUTPUT(Nod_File_Filter);
	SHARED ds_nod1_Delete  := OUTPUT(Nod_File_Filter(TRIM(delete_flag) <>''));
	
  BKForeclosure.layout_BK.reo 		trans_Flag_Reo(Reo_File_used L, Reo_Delete R) := TRANSFORM
		SELF.Delete_Flag := R.Delete_Flag;
		SELF := L;
END;
 
 EXPORT Reo_File_Filter := JOIN(Reo_File_used, Reo_Delete,
                           TRIM(LEFT.fips_cd) = TRIM(RIGHT.fips_cd)
													 AND TRIM(LEFT.lps_internal_pid) = TRIM(RIGHT.pid),
												   trans_Flag_Reo(LEFT,RIGHT),LEFT OUTER,LOOKUP);													 

 ds_reo1        := OUTPUT(Reo_File_Filter);
 ds_reo1_Delete := OUTPUT(Reo_File_Filter(TRIM(delete_flag) <>''));
 
 InFile_Reo := DEDUP(SORT(Reo_File_Filter + REO_Refresh + REO_Update,RECORD,LOCAL),RECORD,ALL,LOCAL);
 InFile_Nod := DEDUP(SORT(Nod_File_Filter + NOD_Refresh + NOD_Update,RECORD,LOCAL),RECORD,ALL,LOCAL);

 
 d_Reo   := OUTPUT(InFile_Reo, ,'~thor_data400::in::BKForeclosure::Reo_Infile::' + filedate, OVERWRITE);
 d_Nod   := OUTPUT(InFile_Nod, ,'~thor_data400::in::BKForeclosure::Nod_Infile::' + filedate, OVERWRITE); 
 
 reo_in  := InFile_Reo(delete_flag = '');
 nod_in  := InFile_Nod(delete_flag = '');

AddToSuperfile_Nod := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_nod, '~thor_data400::in::BKForeclosure::Nod_Infile::' + filedate);
END;	

AddToSuperfile_reo := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_reo, '~thor_data400::in::BKForeclosure::Reo_Infile::' + filedate);
END;		
	
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_Reo,		
		FileServices.FinishSuperFileTransaction()
	);	
	
Move_to_used   := PARALLEL(BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::refresh_nod_orphan','using','used'),
                           BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::refresh_nod_refresh','using','used'),
													 BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::refresh_reo_orphan','using','used'),
                           BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::refresh_reo_refresh','using','used'),
													 BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::update_nod','using','used'),
                           BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::update_reo','using','used'),
													 BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::delete_nod','using','used'),
                           BKForeclosure.func_move_file.MoveFile('in::bkforeclosure::delete_reo','using','used'));
													 
 EXPORT do_all
  :=
	SEQUENTIAL(
	           ds_nod1,
	           ds_nod1_Delete,
	           ds_reo1,
						 ds_reo1_Delete,
	           d_Reo,d_Nod,
						 super_all,
						 Move_to_used
						 ); 
	
 // RETURN do_all;

END;