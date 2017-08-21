// spray NMS0843 New Mexico Real Estate Appraiser Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;  
EXPORT spray_NMS0843(STRING filedate) := MODULE

	SHARED code 									:= 'NMS0843';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile      			  := destination + 'sprayed::' + 'apr';
	
clear_super	:= FileServices.ClearSuperFile(superfile);			
												
// Transform Real Estate License	
TransformFile(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_NMS0843.appr,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_NMS0843.Common,SELF := LEFT; 
																																				SELF:= []));
	
	RETURN ds;
END;		

AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filedate + '::' +filename);
END;		
		

//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'lexisnexis.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('lexisnexis.csv'),, 	destination + filedate + '::lexisnexis.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('lexisnexis.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::lexisnexis.raw'),
							 );
							 
EXPORT s0843_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;