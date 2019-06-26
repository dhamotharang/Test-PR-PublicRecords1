﻿IMPORT STD,_control;
	   
////Raw file location
EXPORT Spray_DeleteFile(STRING filedate, STRING	pServerIP	= _control.IPAddress.bctlpedata12) := MODULE //Use folder date
// IF(_control.thisenvironment.name = 'Dataland',
																																	// _control.IPAddress.bctlpedata12,
																																	// _control.IPAddress.bctlpedata11)) := MODULE

#workunit('name','Spray Foreclosure');
SHARED version := STD.Date.AdjustDate((integer)filedate,,,-1); //Folder date is a day after version date
SHARED filepath_nod       := '/data/data_build_2/property/ln/epic/bk/foreclosure/data/' +(string)filedate+'/Managed_Update/NOD' +(string)version+ '/';
SHARED filepath_reo       := '/data/data_build_2/property/ln/epic/bk/foreclosure/data/' +(string)filedate+'/Managed_Update/REO' +(string)version+ '/';
SHARED group_name	        := STD.System.Thorlib.Group ( );
SHARED fnod             	:= 'NOD_Update_Delete_*.txt';
SHARED freo             	:= 'REO_Update_Delete_*.txt';

SHARED maxRecordSize	    := 8192;

//Sprayed input file
SHARED dst_Delete_Nod_raw   := '~thor_data400::in::BKForeclosure::delete_nod::' +(string)version+ '::raw';
SHARED dst_Delete_Reo_raw   := '~thor_data400::in::BKForeclosure::delete_reo::' +(string)version+ '::raw';

//Input file with filedate and delete_flag set
SHARED dst_Delete_Nod       := '~thor_data400::in::BKForeclosure::delete_nod::' +(string)version;
SHARED dst_Delete_Reo       := '~thor_data400::in::BKForeclosure::delete_reo::' +(string)version;

//Delete superfiles used by build process
SHARED sprf_Delete_Nod      := '~thor_data400::in::BKForeclosure::delete_nod';
SHARED sprf_Delete_Reo      := '~thor_data400::in::BKForeclosure::delete_reo';

SHARED Spray_Delete_Nod  := STD.File.SprayVariable(pServerIP,filepath_nod + fnod,
                                           maxRecordSize,'\t','\n',,group_name, dst_Delete_Nod_raw,,,,TRUE,FALSE,TRUE);
SHARED Spray_Delete_Reo  := STD.File.SprayVariable(pServerIP,filepath_reo + freo,
                                           maxRecordSize,'\t','\r\n',,group_name, dst_Delete_Reo_raw,,,,TRUE,FALSE,TRUE);
																					 
	
  TransformFile_Nod := FUNCTION
	  dsraw := DATASET(dst_Delete_Nod_raw,
										          BKForeclosure.layout_BK.Delete_Nod,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Nod,SELF.ln_filedate := (string)version; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
	RETURN ds;
	END;
	
  TransformFile_Reo := FUNCTION
	  dsraw := DATASET(dst_Delete_Reo_raw,
										          BKForeclosure.Layout_BK.Delete_Reo,CSV(SEPARATOR('\t'),QUOTE(''),TERMINATOR('\r\n')));
		ds    := PROJECT(dsraw,TRANSFORM(BKForeclosure.layout_BK.Delete_Reo,SELF.ln_filedate := (string)version; SELF.Delete_Flag := 'DELETE'; SELF := LEFT; SELF :=[]));
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
							OUTPUT(TransformFile_Nod,, dst_Delete_Nod, OVERWRITE, COMPRESSED),
							OUTPUT(TransformFile_Reo,, dst_Delete_Reo, OVERWRITE, COMPRESSED)
					   );		
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		STD.File.StartSuperFileTransaction(),
		AddToSuperfile_Nod,
		AddToSuperfile_Reo,		
		STD.File.FinishSuperFileTransaction()
	);
																					 
EXPORT SprayFile   :=  SEQUENTIAL(Spray_delete_all,xform_all,super_all);																					 
																		
END;