IMPORT $, STD,_control;

//Files for S0376 are Located  //
EXPORT Spray_refreshFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE
// pServerIP	= IF(_control.thisenvironment.name = 'Dataland',
																																	// _control.IPAddress.bctlpedata12,
																																	// _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray Mortgage Refresh');
SHARED version := STD.Date.AdjustDate((integer)filedate,,,-1); //Folder date is a day after version date
SHARED filepath_Assignment    := '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Refresh/Assignment'+(string)version+'/';
SHARED filepath_Release       := '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Refresh/Release'+(string)version+'/';
SHARED group_name	     				:= STD.System.Thorlib.Group ( );
SHARED fn_Assignment_Orph     := '*_Assignment_Orphan_Refresh_*.txt';
SHARED fn_Assignment_Ref      := '*_Assignment_Refresh_*.txt';
SHARED fn_Release_Orph        := '*_Release_Orphan_Refresh_*.txt';
SHARED fn_Release_Ref         := '*_Release_Refresh_*.txt';
SHARED maxRecordSize	    		:= 8192;

//Sprayed input files
SHARED dst_Assignment_orph_raw  := '~thor_data400::in::BKMortgage::refresh_Assignment_orphan::' +(string)version+ '::raw';
SHARED dst_Assignment_ref_raw   := '~thor_data400::in::BKMortgage::refresh_Assignment::' +(string)version+ '::raw';
SHARED dst_Release_orph_raw   	:= '~thor_data400::in::BKMortgage::refresh_Release_orphan::' +(string)version+ '::raw';
SHARED dst_Release_ref_raw    	:= '~thor_data400::in::BKMortgage::refresh_Release::' +(string)version+ '::raw';

//Input files with filedate and file_type added
SHARED dst_Assignment_orph      := '~thor_data400::in::BKMortgage::refresh_Assignment_orphan::' +(string)version;
SHARED dst_Assignment_ref       := '~thor_data400::in::BKMortgage::refresh_Assignment::' +(string)version;
SHARED dst_Release_orph      		:= '~thor_data400::in::BKMortgage::refresh_Release_orphan::' +(string)version;
SHARED dst_Release_ref        	:= '~thor_data400::in::BKMortgage::refresh_Release::' +(string)version;

//Final input superfiles used for build
SHARED sprf_Assignment_orph     := '~thor_data400::in::BKMortgage::refresh_Assignment_orphan';
SHARED sprf_Assignment_ref      := '~thor_data400::in::BKMortgage::refresh_Assignment';
SHARED sprf_Release_orph     		:= '~thor_data400::in::BKMortgage::refresh_Release_orphan';
SHARED sprf_Release_ref      		:= '~thor_data400::in::BKMortgage::refresh_Release';

 SHARED Spray_Assignment_Orphan  := STD.File.SprayVariable(pServerIP,filepath_Assignment + fn_Assignment_Orph,
                                           maxRecordSize,'\t','\n',,group_name, dst_Assignment_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
 SHARED spray_Assignment_refresh := STD.File.SprayVariable(pServerIP,filepath_Assignment + fn_Assignment_Ref,
                                           maxRecordSize,'\t','\n',,group_name, dst_Assignment_Ref_raw,,,,TRUE,FALSE,TRUE,,,,7);																					 
																					 
 SHARED Spray_Release_Orphan  := STD.File.SprayVariable(pServerIP,filepath_Release + fn_Release_Orph,
                                           maxRecordSize,'\t','\n',,group_name, dst_Release_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
 SHARED Spray_Release_refresh := STD.File.SprayVariable(pServerIP,filepath_Release + fn_Release_Ref,
                                           maxRecordSize,'\t','\n',,group_name, dst_Release_Ref_raw,,,,TRUE,FALSE,TRUE,,,,7);			

  TransformFile_Assignment_Orphan := FUNCTION
	  dsraw := DATASET(dst_Assignment_Orph_raw,
										          BKMortgage.Layouts.Assign_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Assign_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'ASSIGN_ORPHAN_REFRESH'; 
																		SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Assignment_refresh := FUNCTION
	  dsraw := DATASET(dst_Assignment_ref_raw,
										          BKMortgage.Layouts.Assign_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Assign_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'ASSIGN_REFRESH';
																		SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Release_Orphan := FUNCTION
	  dsraw := DATASET(dst_Release_orph_raw,
										          BKMortgage.Layouts.Release_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Release_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'RELEASE_ORPHAN_REFRESH';
																			SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Release_refresh := FUNCTION
	  dsraw := DATASET(dst_Release_ref_raw,
										          BKMortgage.Layouts.Release_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Release_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'RELEASE_REFRESH';
																		SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;	
	
	
AddToSuperfile_Assignment_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Assignment_Orph, dst_Assignment_Orph);
END;	

AddToSuperfile_Assignment_Ref := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Assignment_Ref, dst_Assignment_Ref);
END;	

AddToSuperfile_Release_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Release_Orph, dst_Release_Orph);
END;

AddToSuperfile_Release_Ref := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Release_Ref, dst_Release_Ref);
END;
	
// Spray all refresh files	
Spray_Refresh_All 
  :=
	SEQUENTIAL(
	  Spray_Assignment_Orphan,
		Spray_Assignment_refresh, 
		Spray_Release_Orphan,
		Spray_Release_refresh
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Assignment_Orphan,, dst_Assignment_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Assignment_refresh,, dst_Assignment_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Release_Orphan,, dst_Release_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Release_refresh,, dst_Release_Ref, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED)
	);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Assignment_Orph,
		AddToSuperfile_Assignment_Ref,
		AddToSuperfile_Release_Orph,
		AddToSuperfile_Release_Ref,
		STD.File.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_Refresh_All,xform_all,super_all);																					 
																		
END;