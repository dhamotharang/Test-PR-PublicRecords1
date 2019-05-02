IMPORT STD,_control;

//Files for S0376 are Located  //
EXPORT Spray_refreshFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE
// pServerIP	= IF(_control.thisenvironment.name = 'Dataland',
																																	// _control.IPAddress.bctlpedata12,
																																	// _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray Foreclosure Refresh');

SHARED filepath_nod       := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Refresh/NOD/';
SHARED filepath_reo       := '/data/data_build_2/property/ln/epic/bk/in/test/foreclosure/' +filedate +'/Managed_Refresh/REO/';
SHARED group_name	        := STD.System.Thorlib.Group ( );
SHARED fn_nod_Orph        := '*_NOD_Orphan_Refresh_*.txt';
SHARED fn_nod_Ref         := '*_NOD_Refresh_*.txt';
SHARED fn_reo_Orph        := '*_REO_Orphan_Refresh_*.txt';
SHARED fn_reo_Ref         := '*_REO_Refresh_*.txt';
SHARED maxRecordSize	    := 8192;

//Sprayed input files
SHARED dst_nod_orph_raw   := '~thor_data400::in::BKForeclosure::refresh_nod_orphan::' + filedate + '::raw';
SHARED dst_nod_ref_raw    := '~thor_data400::in::BKForeclosure::refresh_nod::' + filedate + '::raw';
SHARED dst_reo_orph_raw   := '~thor_data400::in::BKForeclosure::refresh_reo_orphan::' + filedate + '::raw';
SHARED dst_reo_ref_raw    := '~thor_data400::in::BKForeclosure::refresh_reo::' + filedate + '::raw';

//Input files with filedate and file_type added
SHARED dst_nod_orph       := '~thor_data400::in::BKForeclosure::refresh_nod_orphan::' + filedate;
SHARED dst_nod_ref        := '~thor_data400::in::BKForeclosure::refresh_nod::' + filedate;
SHARED dst_reo_orph       := '~thor_data400::in::BKForeclosure::refresh_reo_orphan::' + filedate;
SHARED dst_reo_ref        := '~thor_data400::in::BKForeclosure::refresh_reo::' + filedate;

//Final input superfiles used for build
SHARED sprf_nod_orph     := '~thor_data400::in::BKForeclosure::refresh_nod_orphan';
SHARED sprf_nod_ref      := '~thor_data400::in::BKForeclosure::refresh_nod';
SHARED sprf_reo_orph     := '~thor_data400::in::BKForeclosure::refresh_reo_orphan';
SHARED sprf_reo_ref      := '~thor_data400::in::BKForeclosure::refresh_reo';

 SHARED Spray_Nod_Orphan  := STD.File.SprayVariable(pServerIP,filepath_nod + fn_nod_Orph,
                                           maxRecordSize,'\t','\n',,group_name, dst_nod_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
 SHARED spray_Nod_refresh := STD.File.SprayVariable(pServerIP,filepath_nod + fn_nod_Ref,
                                           maxRecordSize,'\t','\n',,group_name, dst_nod_Ref_raw,,,,TRUE,FALSE,TRUE,,,,7);																					 
																					 
 SHARED Spray_REO_Orphan  := STD.File.SprayVariable(pServerIP,filepath_reo + fn_reo_Orph,
                                           maxRecordSize,'\t','\n',,group_name, dst_reo_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
 SHARED Spray_REO_refresh := STD.File.SprayVariable(pServerIP,filepath_reo + fn_reo_Ref,
                                           maxRecordSize,'\t','\n',,group_name, dst_reo_Ref_raw,,,,TRUE,FALSE,TRUE,,,,7);			

  TransformFile_Nod_Orphan := FUNCTION
	  dsraw := DATASET(dst_nod_Orph_raw,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'NOD_ORPHAN';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Nod_refresh := FUNCTION
	  dsraw := DATASET(dst_nod_ref_raw,
										          BKForeclosure.Layout_BK.Nod_raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.Nod_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'NOD_REFRESH'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo_Orphan := FUNCTION
	  dsraw := DATASET(dst_reo_orph_raw,
										          BKForeclosure.Layout_BK.REO_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'REO_ORPHAN';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo_refresh := FUNCTION
	  dsraw := DATASET(dst_reo_ref_raw,
										          BKForeclosure.Layout_BK.Reo_Raw,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.Layout_BK.REO_in,SELF.ln_filedate := filedate; SELF.bk_infile_type := 'REO_REFRESH';SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;	
	
	
AddToSuperfile_Nod_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_nod_Orph, dst_nod_Orph);
END;	

AddToSuperfile_Nod_Ref := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_nod_Ref, dst_nod_Ref);
END;	

AddToSuperfile_Reo_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_reo_Orph, dst_reo_Orph);
END;

AddToSuperfile_Reo_Ref := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_reo_Ref, dst_reo_Ref);
END;
	
// Spray all refresh files	
Spray_Refresh_All 
  :=
	SEQUENTIAL(
	  Spray_Nod_Orphan,
		Spray_Nod_refresh, 
		Spray_REO_Orphan,
		Spray_REO_refresh
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Nod_Orphan,, dst_nod_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Nod_refresh,, dst_nod_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Reo_Orphan,, dst_Reo_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Reo_refresh,, dst_Reo_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED)
	);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod_orphan'/*, TRUE*/),
		AddToSuperfile_Nod_Orph,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_nod'/*, TRUE*/),
		AddToSuperfile_Nod_Ref,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo_orphan'/*, TRUE*/),
		AddToSuperfile_Reo_Orph,
		STD.File.ClearSuperFile('~thor_data400::in::BKForeclosure::refresh_reo'/*, TRUE*/),
		AddToSuperfile_Reo_Ref,
		STD.File.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_Refresh_All,xform_all,super_all);																					 
																		
END;