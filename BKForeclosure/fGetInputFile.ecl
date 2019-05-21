IMPORT BKForeclosure, STD;

EXPORT fGetInputFile(STRING filedate) := MODULE
  
  SHARED superfile_nod := '~thor_data400::in::BKForeclosure::nod_infile';
  SHARED superfile_reo := '~thor_data400::in::BKForeclosure::reo_infile';

  SHARED Nod_File 			:= File_BK_Foreclosure.Nod_File;
	SHARED Reo_File 			:= File_BK_Foreclosure.Reo_File;
	
  SHARED Nod_Update    := File_BK_Foreclosure.Nod_Update;
	SHARED Reo_Update    := File_BK_Foreclosure.Reo_Update;	

  SHARED NOD_Refresh   := File_BK_Foreclosure.Nod_Refresh;
  SHARED REO_Refresh   := File_BK_Foreclosure.Reo_Refresh;


 BOOLEAN REOUpdateExists	:=	NOTHOR(STD.File.GetSuperFileSubCount('~thor_data400::in::BKForeclosure::update_reo'))>0;
 BOOLEAN NODUpdateExists	:=	NOTHOR(STD.File.GetSuperFileSubCount('~thor_data400::in::BKForeclosure::update_nod'))>0;
 BOOLEAN REORefreshExists	:=	NOTHOR(STD.File.GetSuperFileSubCount('~thor_data400::in::BKForeclosure::refresh_reo'))>0;
 BOOLEAN NODRefreshExists	:=	NOTHOR(STD.File.GetSuperFileSubCount('~thor_data400::in::BKForeclosure::refresh_nod'))>0;
 
 InFile_Reo := IF(REOUpdateExists AND REORefreshExists, REO_Refresh + REO_Update,
								IF(REOUpdateExists AND ~REORefreshExists, REO_Update, REO_Refresh));
 InFile_Nod := IF(NODUpdateExists AND NODRefreshExists, NOD_Refresh + NOD_Update,
								IF(NODUpdateExists AND ~NODRefreshExists, NOD_Update, NOD_Refresh));
 
 Ded_Reo := DEDUP(SORT(InFile_Reo,RECORD,LOCAL),RECORD,ALL,LOCAL);
 Ded_Nod := DEDUP(SORT(InFile_Nod,RECORD,LOCAL),RECORD,ALL,LOCAL);
 
 d_Reo   := OUTPUT(Ded_Reo, ,'~thor_data400::in::BKForeclosure::Reo_Infile::' + filedate, OVERWRITE, COMPRESSED);
 d_Nod   := OUTPUT(Ded_Nod, ,'~thor_data400::in::BKForeclosure::Nod_Infile::' + filedate, OVERWRITE, COMPRESSED); 

AddToSuperfile_reo := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(superfile_reo, '~thor_data400::in::BKForeclosure::Reo_Infile::' + filedate);
END;

AddToSuperfile_Nod := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(superfile_nod, '~thor_data400::in::BKForeclosure::Nod_Infile::' + filedate);
END;			
	
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::reo_infile'/*, TRUE*/),
		AddToSuperfile_Reo,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::nod_infile'/*, TRUE*/),
		AddToSuperfile_Nod,
		FileServices.FinishSuperFileTransaction()
	);		
													 
 EXPORT do_all
  :=
	SEQUENTIAL(
	           d_Reo,
						 d_Nod,
						 super_all
						 );
END;