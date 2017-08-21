IMPORT STD,_control;
	   
//Files for S0376 are Located  //
EXPORT Spray_DeleteFile(STRING filedate) := MODULE

#workunit('name','Spray Foreclosure');

SHARED filepath_nod       := '/data/data_build_2/property/ln/epic/bk/foreclosure/' +filedate +'/Managed_Update/NOD/';
SHARED filepath_reo       := '/data/data_build_2/property/ln/epic/bk/foreclosure/' +filedate +'/Managed_Update/REO/';
SHARED group_name	        := 'thor400_dev01';
SHARED fn_nod             := 'NOD_Update_Delete_*.txt';
SHARED fn_reo             := 'REO_Update_Delete_*.txt';

SHARED maxRecordSize	    := 8192;
SHARED dst_Delete_Nod_raw   := '~thor_data400::in::BKForeclosure::delete_nod::' + filedate + '::raw';
SHARED dst_Delete_Reo_raw   := '~thor_data400::in::BKForeclosure::delete_reo::' + filedate + '::raw';
SHARED dst_Delete_Nod       := '~thor_data400::in::BKForeclosure::delete_nod::' + filedate;
SHARED dst_Delete_Reo       := '~thor_data400::in::BKForeclosure::delete_reo::' + filedate;

SHARED sprf_Delete_Nod      := '~thor_data400::in::BKForeclosure::delete_nod::using';
SHARED sprf_Delete_Reo      := '~thor_data400::in::BKForeclosure::delete_reo::using';

SHARED Spray_Delete_Nod  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_nod + fn_nod,
                                           maxRecordSize,'\t','\n',,group_name, dst_Delete_Nod_raw,,,,TRUE,FALSE,TRUE);
SHARED Spray_Delete_Reo  := STD.File.SprayVariable(_Control.IPAddress.bctlpedata10,filepath_reo + fn_reo,
                                           maxRecordSize,'\t','\n',,group_name, dst_Delete_Reo_raw,,,,TRUE,FALSE,TRUE);
																					 
	
  TransformFile_Nod := FUNCTION
	  dsraw := dataset(dst_Delete_Nod_raw,
										          BKForeclosure.layout_BK.Delete_Nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Nod,SELF.ln_filedate := filedate; SELF.Delete_Flag := 'Delete'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo := FUNCTION
	  dsraw := dataset(dst_Delete_Reo_raw,
										          BKForeclosure.Layout_BK.Delete_Reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Reo,SELF.ln_filedate := filedate; SELF.Delete_Flag := 'Delete'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;

AddToSuperfile_Nod := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(sprf_Delete_Nod, dst_Delete_Nod);
END;	

AddToSuperfile_Reo := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(sprf_Delete_Reo, dst_Delete_Reo);
END;
	
// Spray all delete files
Spray_delete_all 
  :=
	 SEQUENTIAL(
	   Spray_Delete_Nod,
		 Spray_Delete_Reo
	   );
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Nod,, dst_Delete_Nod, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_Reo,, dst_Delete_Reo, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')), OVERWRITE)
					   );		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_Reo,		
		FileServices.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_delete_all,xform_all,super_all);																					 
																		
END;