// spray MOS0634 Professional Licenses Files for MARI	   
IMPORT ut, _control, Prof_License_Mari, Lib_FileServices, lib_stringlib,Lib_date;  
EXPORT spray_MOS0634(STRING filedate) := MODULE
#workunit('name','Yogurt: Spray MOS0634');

	SHARED code 									:= 'MOS0634';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
  SHARED superfile        			:= destination + 'using::' + 'mtg';
	

clear_super	:=
							PARALLEL(
												FileServices.ClearSuperFile(superfile);
												);

// Transform Real Estate License
TransformFile(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname 			:= filename[1..(n-1)];
	sprayed_file	:= destination + filedate + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.Layout_MOS0634.raw,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_MOS0634.Common, SELF := LEFT; 
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
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Finance_Entities.csv','comma');
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Finance_Entities.csv'),, 	destination + filedate + '::Finance_Entities.csv',	CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE),
							);	

//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('Finance_Entities.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + filedate + '::Finance_Entities.raw'),
							 );
EXPORT S0634_SprayFiles := SEQUENTIAL(
																			clear_super
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			
END;
