IMPORT STD,ut,_control;
	   
//Files for S0376 are Located  //
// Spray initial update 20160729 only
EXPORT Spray_Foreclosure_Raw(STRING filedate) := MODULE

#workunit('name','Spray Foreclosure');

SHARED filepath_nod           := '/data/data_build_2/property/ln/epic/bk/foreclosure/NOD/' + filedate +'/';
SHARED filepath_reo           := '/data/data_build_2/property/ln/epic/bk/foreclosure/REO/' + filedate +'/';
SHARED group_name	            := 'thor400_dev01';
SHARED fn_nod_Orph            := '*_NOD_Orphan_Refresh_*.txt';
SHARED fn_nod_Ref             := '*_NOD_Refresh_*.txt';
SHARED fn_reo_Orph            := '*_REO_Orphan_Refresh_*.txt';
SHARED fn_reo_Ref             := '*_REO_Refresh_*.txt';
SHARED maxRecordSize	        := 8192;
SHARED destination_nod_Orph   := '~thor_data400::in::BKForeclosure::Nod_Orphan::' + filedate;
SHARED destination_nod_Ref    := '~thor_data400::in::BKForeclosure::Nod_Refresh::' + filedate;
SHARED destination_reo_orph   := '~thor_data400::in::BKForeclosure::Reo_Orphan::' + filedate;
SHARED destination_reo_Ref    := '~thor_data400::in::BKForeclosure::Reo_Refresh::' + filedate;

SHARED destination_nod_Orph_new   := '~thor_data400::in::BKForeclosure::Nod_Orphan::' + filedate + '::new';
SHARED destination_nod_Ref_new    := '~thor_data400::in::BKForeclosure::Nod_Refresh::' + filedate + '::new';
SHARED destination_reo_orph_new   := '~thor_data400::in::BKForeclosure::Reo_Orphan::' + filedate + '::new';
SHARED destination_reo_Ref_new    := '~thor_data400::in::BKForeclosure::Reo_Refresh::' + filedate + '::new';

SHARED superfile_nod_Orph     := '~thor_data400::in::BKForeclosure::Raw::Nod_Orphan';
SHARED superfile_nod_Ref      := '~thor_data400::in::BKForeclosure::Raw::Nod_Refresh';
SHARED superfile_reo_Orph     := '~thor_data400::in::BKForeclosure::Raw::Reo_Orphan';
SHARED superfile_reo_Ref      := '~thor_data400::in::BKForeclosure::Raw::Reo_Refresh';

 SHARED Spray_Nod_Orphan  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_nod + fn_nod_Orph,
                                           maxRecordSize,'\t','\n',,group_name, destination_nod_Orph,,,,TRUE,FALSE,TRUE);
																					 
 SHARED spray_Nod_Refresh := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_nod + fn_nod_Ref,
                                           maxRecordSize,'\t','\n',,group_name, destination_nod_Ref,,,,TRUE,FALSE,TRUE);																					 
																					 
 SHARED Spray_REO_Orphan  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_reo + fn_reo_Orph,
                                           maxRecordSize,'\t','\n',,group_name, destination_reo_Orph,,,,TRUE,FALSE,TRUE);
																					 
 SHARED Spray_REO_Refresh := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_reo + fn_reo_Ref,
                                           maxRecordSize,'\t','\n',,group_name, destination_reo_Ref,,,,TRUE,FALSE,TRUE);			

  TransformFile_Nod_Orphan := FUNCTION
	  dsraw := dataset(destination_nod_Orph,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'NOD_ORPHAN';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Nod_Refresh := FUNCTION
	  dsraw := dataset(destination_nod_Ref,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'NOD_REFRESH';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo_Orphan := FUNCTION
	  dsraw := dataset(destination_reo_Orph,
										          BKForeclosure.Layout_BK.REO_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'REO_ORPHAN';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo_Refresh := FUNCTION
	  dsraw := dataset(destination_reo_Ref,
										          BKForeclosure.Layout_BK.Reo_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO,SELF.ln_filedate := filedate;SELF.bk_infile_type := 'REO_REFRESH';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;	
	
	
AddToSuperfile_Nod_Orph := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_nod_Orph, destination_nod_Orph_new);
END;	

AddToSuperfile_Nod_Ref := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_nod_Ref, destination_nod_Ref_new);
END;	

AddToSuperfile_Reo_Orph := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_reo_Orph, destination_reo_Orph_new);
END;

AddToSuperfile_Reo_Ref := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_reo_Ref, destination_reo_Ref_new);
END;
	
SprayALL 
  :=
	SEQUENTIAL(
	  Spray_Nod_Orphan,
		Spray_Nod_Refresh, 
		Spray_REO_Orphan,
		Spray_REO_Refresh
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Nod_Orphan,, destination_nod_Orph_new,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE),
							OUTPUT(TransformFile_Nod_Refresh,, destination_nod_Ref_new,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE),
							OUTPUT(TransformFile_Reo_Orphan,, destination_Reo_Orph_new,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE),
							OUTPUT(TransformFile_Reo_Refresh,, destination_Reo_Ref_new,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE)
							);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Nod_Orph,
		AddToSuperfile_Nod_Ref,
		AddToSuperfile_Reo_Orph,		
		AddToSuperfile_Reo_Ref,
		FileServices.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(SprayAll,xform_all,super_all);																					 
																		
END;