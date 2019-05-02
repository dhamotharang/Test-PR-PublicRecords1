IMPORT STD,_control;

//Files for S0376 are Located  //
EXPORT Spray_UpdateFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE
// IF(_control.thisenvironment.name = 'Dataland',
																															 // _control.IPAddress.bctlpedata12,
																															 // _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray BKForeclosure Update File');

SHARED filepath_nod  := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Update/NOD/';
SHARED filepath_reo  := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Update/REO/';
SHARED group_name	   := STD.System.Thorlib.Group ( );
SHARED fn_nod        := '*_NOD_Update_*.txt';
SHARED fn_reo        := '*_REO_Update_*.txt';
SHARED maxRecordSize := 8192;

//Sprayed raw files
SHARED dst_nod_raw   := '~thor_data400::in::BKForeclosure::Update_Nod::' + filedate + '::raw';
SHARED dst_reo_raw   := '~thor_data400::in::BKForeclosure::Update_Reo::' + filedate + '::raw';

//Raw files with filedate and file_type added
SHARED dst_nod       := '~thor_data400::in::BKForeclosure::Update_Nod::' + filedate;
SHARED dst_reo       := '~thor_data400::in::BKForeclosure::Update_Reo::' + filedate;

//Final input superfiles used for build process
SHARED sprf_nod      := '~thor_data400::in::BKForeclosure::Update_Nod';
SHARED sprf_reo      := '~thor_data400::in::BKForeclosure::Update_Reo';


SHARED Spray_Nod  := STD.File.SprayVariable(pServerIP,filepath_nod + fn_Nod,
                                           maxRecordSize,'\t','\n',,group_name, dst_nod_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
																		 
SHARED Spray_REO  := STD.File.SprayVariable(pServerIP,filepath_reo + fn_reo,
                                           maxRecordSize,'\t','\n',,group_name, dst_reo_raw,,,,TRUE,FALSE,TRUE,,,,7);

  TransformFile_Nod := FUNCTION
	  dsraw := dataset(dst_nod_raw,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'NOD_UPDATE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_reo := FUNCTION
	  dsraw := dataset(dst_reo_raw,
										          BKForeclosure.Layout_BK.REO_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'REO_UPDATE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	

	
AddToSuperfile_Nod := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_nod, dst_nod);
END;	


AddToSuperfile_reo := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_reo, dst_reo);
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
							OUTPUT(TransformFile_Nod, , dst_nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Reo, , dst_reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED)
	);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Nod'/*, TRUE*/),
		AddToSuperfile_Nod,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::Update_Reo'/*, TRUE*/),
		AddToSuperfile_reo,
		STD.File.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_Update_All,xform_all,super_all);																					 
																		
END;