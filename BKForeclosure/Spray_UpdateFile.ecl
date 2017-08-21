IMPORT STD,_control;

//Files for S0376 are Located  //
EXPORT Spray_UpdateFile(STRING filedate) := MODULE

#workunit('name','Spray BKForeclosure Update File');

SHARED filepath_nod  := '/data/data_build_2/property/ln/epic/bk/foreclosure/' +filedate +'/Managed_Update/NOD/';
SHARED filepath_reo  := '/data/data_build_2/property/ln/epic/bk/foreclosure/' +filedate +'/Managed_Update/REO/';
SHARED group_name	   := 'thor400_dev01';
SHARED fn_nod        := '*_NOD_Update_*.txt';
SHARED fn_reo        := '*_REO_Update_*.txt';
SHARED maxRecordSize := 8192;
SHARED dst_nod_raw   := '~thor_data400::in::BKForeclosure::Update_Nod::' + filedate + '::raw';
SHARED dst_reo_raw   := '~thor_data400::in::BKForeclosure::Update_Reo::' + filedate + '::raw';

SHARED dst_nod       := '~thor_data400::in::BKForeclosure::Update_Nod::' + filedate;
SHARED dst_reo       := '~thor_data400::in::BKForeclosure::Update_Reo::' + filedate;

SHARED sprf_nod      := '~thor_data400::in::BKForeclosure::Update_Nod::using';
SHARED sprf_reo      := '~thor_data400::in::BKForeclosure::Update_Reo::using';


SHARED Spray_Nod  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_nod + fn_Nod,
                                           maxRecordSize,'\t','\n',,group_name, dst_nod_raw,,,,TRUE,FALSE,TRUE);
																					 
																		 
SHARED Spray_REO  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_reo + fn_reo,
                                           maxRecordSize,'\t','\n',,group_name, dst_reo_raw,,,,TRUE,FALSE,TRUE);

  TransformFile_Nod := FUNCTION
	  dsraw := dataset(dst_nod_raw,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_reo := FUNCTION
	  dsraw := dataset(dst_reo_raw,
										          BKForeclosure.Layout_BK.REO_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	

	
AddToSuperfile_Nod := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(sprf_nod, dst_nod);
END;	


AddToSuperfile_reo := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(sprf_reo, dst_reo);
END;
	
//  Spray all update files	
Spray_Update_All 
  :=
	SEQUENTIAL(
	  Spray_Nod,
		Spray_reo,
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Nod, , dst_nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE),
							OUTPUT(TransformFile_Reo, , dst_reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE)
	);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_reo,
		FileServices.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_Update_All,xform_all,super_all);																					 
																		
END;