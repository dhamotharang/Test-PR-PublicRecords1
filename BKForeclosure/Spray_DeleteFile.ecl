IMPORT STD,_control;
	   
//Files for S0376 are Located  //
EXPORT Spray_DeleteFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE
// IF(_control.thisenvironment.name = 'Dataland',
																																	// _control.IPAddress.bctlpedata12,
																																	// _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray Foreclosure');

SHARED filepath_nod       := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Update/NOD/';
SHARED filepath_reo       := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Update/REO/';
SHARED group_name	        := STD.System.Thorlib.Group ( );
SHARED fnod             	:= 'NOD_Update_Delete_*.txt';
SHARED freo             	:= 'REO_Update_Delete_*.txt';

SHARED maxRecordSize	    := 8192;

//Sprayed input file
SHARED dst_Delete_Nod_raw   := '~thor_data400::in::BKForeclosure::delete_nod::' + filedate + '::raw';
SHARED dst_Delete_Reo_raw   := '~thor_data400::in::BKForeclosure::delete_reo::' + filedate + '::raw';

//Input file with filedate and delete_flag set
SHARED dst_Delete_Nod       := '~thor_data400::in::BKForeclosure::delete_nod::' + filedate;
SHARED dst_Delete_Reo       := '~thor_data400::in::BKForeclosure::delete_reo::' + filedate;

//Delete superfiles used by build process
SHARED sprf_Delete_Nod      := '~thor_data400::in::BKForeclosure::delete_nod';
SHARED sprf_Delete_Reo      := '~thor_data400::in::BKForeclosure::delete_reo';

SHARED Spray_Delete_Nod  := STD.File.SprayVariable(pServerIP,filepath_nod + fnod,
                                           maxRecordSize,'\t','\n',,group_name, dst_Delete_Nod_raw,,,,TRUE,FALSE,TRUE);
SHARED Spray_Delete_Reo  := STD.File.SprayVariable(pServerIP,filepath_reo + freo,
                                           maxRecordSize,'\t','\n',,group_name, dst_Delete_Reo_raw,,,,TRUE,FALSE,TRUE);
																					 
	
  TransformFile_Nod := FUNCTION
	  dsraw := DATASET(dst_Delete_Nod_raw,
										          BKForeclosure.layout_BK.Delete_Nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Nod,SELF.ln_filedate := filedate; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo := FUNCTION
	  dsraw := DATASET(dst_Delete_Reo_raw,
										          BKForeclosure.Layout_BK.Delete_Reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Reo,SELF.ln_filedate := filedate; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;

AddToSuperfile_Nod := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Delete_Nod, dst_Delete_Nod);
END;	

AddToSuperfile_Reo := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Delete_Reo, dst_Delete_Reo);
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
							OUTPUT(TransformFile_Nod,, dst_Delete_Nod, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Reo,, dst_Delete_Reo, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')), OVERWRITE, COMPRESSED)
					   );		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_nod'),
		AddToSuperfile_Nod,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::delete_reo'),
		AddToSuperfile_Reo,		
		STD.File.FinishSuperFileTransaction()
	);
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_delete_all,xform_all,super_all);																					 
																		
END;