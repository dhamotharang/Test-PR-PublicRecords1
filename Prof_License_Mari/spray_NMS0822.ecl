// spray NMS0822 New Mexico Real Estate Professionals Licenses Files for MARI	  
//#workunit('name','Spray NMS0822');
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, Lib_date, lib_stringlib;

EXPORT spray_NMS0822(STRING pVersion) := MODULE

	SHARED STRING7 code						:= 'NMS0822';
	SHARED destination 						:= Prof_License_Mari.Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile_pr				  	:= destination + 'using::' + 'persons';
 

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile_pr)
			,FileServices.ClearSuperFile(superfile_pr)
			,FileServices.CreateSuperFile(superfile_pr));



//Transform Residential File	
TransformFile_pr(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_NMS0822.LAYOUT_PERSONS,CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.layout_NMS0822.COMMON, //SELF.SOURCE_ID := 'R';
																																												// SELF.DOB	:= LEFT.DATE_BIRTH;
																																												SELF := LEFT; 
																																												SELF :=[]));
  RETURN ds;	
	
END;				
																																								

AddToSuperfile_pr(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_pr, destination + pVersion + '::' +filename);

END;		
	
//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'Persons.csv','comma');
 );
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_pr('Persons.csv'),, destination + pVersion + '::Persons.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);							
              );	
	
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_pr('Persons.csv'),
		FileServices.FinishSuperFileTransaction()
	);



remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + pVersion + '::Persons.raw'),
						 );
	



EXPORT S0822_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw
																			);
																			
END;	
	
	