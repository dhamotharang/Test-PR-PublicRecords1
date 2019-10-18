IMPORT STD,_control,$;
	   
//Files for S0376 are Located  //
EXPORT Spray_DeleteFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE //Use folder date
// IF(_control.thisenvironment.name = 'Dataland',
																																	// _control.IPAddress.bctlpedata12,
																																	// _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray Mortgage Deletes');
SHARED version := STD.Date.AdjustDate((integer)filedate,,,-1); //Folder date is a day after version date
SHARED filepath_Assignment:= '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Update/Assignment' +(string)version+ '/';
SHARED filepath_Release   := '/data/data_build_2/property/ln/epic/bk/mortgage/data/' +(string)filedate+'/Managed_Update/Release' +(string)version+ '/';
SHARED group_name	        := STD.System.Thorlib.Group ( );
SHARED fAssignment       	:= 'Assignment_Update_Delete_*.txt';
SHARED fRelease          	:= 'Release_Update_Delete_*.txt';

SHARED maxRecordSize	    := 8192;

//Sprayed input file
SHARED dst_Delete_Assignment_raw  := '~thor_data400::in::BKMortgage::delete_Assignment::' +(string)version+ '::raw';
SHARED dst_Delete_Release_raw   	:= '~thor_data400::in::BKMortgage::delete_Release::' +(string)version+ '::raw';

//Input file with filedate and delete_flag set
SHARED dst_Delete_Assignment    := '~thor_data400::in::BKMortgage::delete_Assignment::' +(string)version;
SHARED dst_Delete_Release       := '~thor_data400::in::BKMortgage::delete_Release::' +(string)version;

//Delete superfiles used by build process
SHARED sprf_Delete_Assignment   := '~thor_data400::in::BKMortgage::delete_Assignment';
SHARED sprf_Delete_Release      := '~thor_data400::in::BKMortgage::delete_Release';

SHARED Spray_Delete_Assignment	:= STD.File.SprayVariable(pServerIP,filepath_Assignment + fAssignment,
																													maxRecordSize,'\t','\n',,group_name, dst_Delete_Assignment_raw,,,,TRUE,FALSE,TRUE);
SHARED Spray_Delete_Release  		:= STD.File.SprayVariable(pServerIP,filepath_Release + fRelease,
																													maxRecordSize,'\t','\r\n',,group_name, dst_Delete_Release_raw,,,,TRUE,FALSE,TRUE);
																					 
	
  TransformFile_Assignment:= FUNCTION
	  dsraw := DATASET(dst_Delete_Assignment_raw,
										          BKMortgage.layouts.Delete_Rec,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.layouts.Delete_Rec,SELF.ln_filedate := (string)version; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Release := FUNCTION
	  dsraw := DATASET(dst_Delete_Release_raw,
										          BKMortgage.Layouts.Delete_Rec,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\r\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKMortgage.layouts.Delete_Rec,SELF.ln_filedate := (string)version; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;

AddToSuperfile_Assignment := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Delete_Assignment, dst_Delete_Assignment);
END;	

AddToSuperfile_Release := FUNCTION
	RETURN 	
			STD.File.AddSuperFile(sprf_Delete_Release, dst_Delete_Release);
END;
	
// Spray all delete files
Spray_delete_all 
  :=
	 SEQUENTIAL(
	   Spray_Delete_Assignment,
		 Spray_Delete_Release
	   );
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Assignment,, dst_Delete_Assignment, OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Release,, dst_Delete_Release, OVERWRITE, COMPRESSED)
					   );		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Assignment,
		AddToSuperfile_Release,		
		STD.File.FinishSuperFileTransaction()
	);
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_delete_all,xform_all,super_all);																					 
																		
END;