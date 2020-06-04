IMPORT STD,_control, $;

//Files for S0376 are Located  //
EXPORT Spray_UpdateFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE
// IF(_control.thisenvironment.name = 'Dataland',
																															 // _control.IPAddress.bctlpedata12,
																															 // _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray BKMortgage Update File');
SHARED version := STD.Date.AdjustDate((integer)filedate,,,-1); //Folder date is a day after version date
SHARED filepath_Assignment:= '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Update/Assignment' +(string)version+ '/';
SHARED filepath_Release  	:= '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Update/Release' +(string)version+ '/';
SHARED group_name	   			:= STD.System.Thorlib.Group ( );
SHARED fn_Assignment      := '*_Assignment_Update_*.txt';
SHARED fn_Assignment_Orph := '*_Assignment_Orphan_Update_*.txt';
SHARED fn_Release        	:= '*_Release_Update_*.txt';
SHARED fn_Release_Orph  	:= '*_Release_Orphan_Update_*.txt';
SHARED maxRecordSize 			:= 8192;

//Sprayed raw files
SHARED dst_Assignment_raw   		:= '~thor_data400::in::BKMortgage::Update_Assignment::' + (string)version + '::raw';
SHARED dst_Assignment_orph_raw  := '~thor_data400::in::BKMortgage::Update_Assignment_orphan::' +(string)version+ '::raw';
SHARED dst_Release_raw   				:= '~thor_data400::in::BKMortgage::Update_Release::' + (string)version + '::raw';
SHARED dst_Release_orph_raw  		:= '~thor_data400::in::BKMortgage::Update_Release_orphan::' +(string)version+ '::raw';

//Raw files with filedate and file_type added
SHARED dst_Assignment    				:= '~thor_data400::in::BKMortgage::Update_Assignment::' + (string)version;
SHARED dst_Assignment_orph      := '~thor_data400::in::BKMortgage::Update_Assignment_orphan::' +(string)version;
SHARED dst_Release       				:= '~thor_data400::in::BKMortgage::Update_Release::' + (string)version;
SHARED dst_Release_orph      		:= '~thor_data400::in::BKMortgage::Update_Release_orphan::' +(string)version;

//Final input superfiles used for build process
SHARED sprf_Assignment   			:= '~thor_data400::in::BKMortgage::Update_Assignment';
SHARED sprf_Assignment_orph   := '~thor_data400::in::BKMortgage::Update_Assignment_orphan';
SHARED sprf_Release      			:= '~thor_data400::in::BKMortgage::Update_Release';
SHARED sprf_Release_orph   		:= '~thor_data400::in::BKMortgage::Update_Release_orphan';


SHARED Spray_Assignment  				:= STD.File.SprayVariable(pServerIP,filepath_Assignment + fn_Assignment,
																												maxRecordSize,'\t','\n',,group_name, dst_Assignment_raw,,,,TRUE,FALSE,TRUE,,,,7);

SHARED Spray_Assignment_Orphan  := STD.File.SprayVariable(pServerIP,filepath_Assignment + fn_Assignment_Orph,
																												maxRecordSize,'\t','\n',,group_name, dst_Assignment_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 																		 
SHARED Spray_Release  			:= STD.File.SprayVariable(pServerIP,filepath_Release + fn_Release,
																										maxRecordSize,'\t','\n',,group_name, dst_Release_raw,,,,TRUE,FALSE,TRUE,,,,7);
																					 
SHARED Spray_Release_Orphan  := STD.File.SprayVariable(pServerIP,filepath_Release + fn_Release_Orph,
																										maxRecordSize,'\t','\n',,group_name, dst_Release_Orph_raw,,,,TRUE,FALSE,TRUE,,,,7);

  TransformFile_Assignment := FUNCTION
	  dsraw := dataset(dst_Assignment_raw,
										          BKMortgage.Layouts.Assign_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Assign_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'ASSIGN_UPDATE'; 
																			SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
	TransformFile_Assignment_Orphan := FUNCTION
	  dsraw := DATASET(dst_Assignment_Orph_raw,
										          BKMortgage.Layouts.Assign_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Assign_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'ASSIGN_ORPHAN_UPDATE'; 
																			SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Release := FUNCTION
	  dsraw := dataset(dst_Release_raw,
										          BKMortgage.Layouts.Release_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Release_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'RELEASE_UPDATE'; 
																			SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
	TransformFile_Release_Orphan := FUNCTION
	  dsraw := DATASET(dst_Release_Orph_raw,
										          BKMortgage.Layouts.Release_Raw_in,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.Layouts.Release_Raw_out,SELF.ln_filedate := (string)version; SELF.bk_infile_type := 'RELEASE_ORPHAN_UPDATE'; 
																		SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
AddToSuperfile_Assignment := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Assignment, dst_Assignment);
END;	

AddToSuperfile_Assignment_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Assignment_Orph, dst_Assignment_Orph);
END;

AddToSuperfile_Release := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Release, dst_Release);
END;

AddToSuperfile_Release_Orph := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Release_Orph, dst_Release_Orph);
END;
	
//  Spray all update files	
Spray_Update_All 
  :=
	SEQUENTIAL(
	  Spray_Assignment,
		Spray_Assignment_Orphan,
		Spray_Release,
		Spray_Release_Orphan
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Assignment, , dst_Assignment,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Assignment_Orphan,, dst_Assignment_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Release, , dst_Release,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])),OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Release_Orphan,, dst_Release_Orph, CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR(['\n','\r','\r\n'])), OVERWRITE, COMPRESSED),
	);		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Assignment,
		AddToSuperfile_Assignment_Orph,
		AddToSuperfile_Release,
		AddToSuperfile_Release_Orph,
		STD.File.FinishSuperFileTransaction()
	);	
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_Update_All,xform_all,super_all);																					 
																		
END;