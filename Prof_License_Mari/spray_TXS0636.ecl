// spray Texas Office of Consumer Credit Commissioner Professional Licenses Files for MARI	   
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_TXS0636(STRING pVersion) := MODULE
	#workunit('name','Spray TXS0636'); 
	SHARED STRING7 code						:= 'TXS0636';
	SHARED destination 						:= Common_Prof_Lic_Mari.SourcesFolder + code + '::';
	SHARED superfile 							:= destination + 'using::' + 'reg_lenders';

clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));

//Transforming Raw File to Common Layout to Handling to constant layout changss	
TransformFile(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	sprayed_file					:= destination + pVersion + '::' + StringLib.StringToLowerCase(newname)+ '.raw';
	
	dsraw := DATASET(sprayed_file,
										Prof_License_Mari.layout_TXS0636.raw,CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n','\n\r'])));
					
	ds    := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.layout_TXS0636.src, SELF.LN_FILEDATE := pVersion;
																																			// SELF.LICENSETYPE := 'Regulated Lender';
																																			SELF := LEFT; 
																																			SELF :=[]));
		RETURN ds;
END;		


AddToSuperfile(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + pVersion + '::' +filename);
END;		
	
//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(pVersion, code, 'Regulated Lender.csv','comma');
		
	);
	
//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('Regulated Lender.csv'),, destination + pVersion + '::Regulated Lender.csv', CSV(SEPARATOR(','),QUOTE('"')), OVERWRITE);													

	);	
	
	
//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile('Regulated Lender.csv'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + pVersion + '::Regulated Lender.raw')
							 );


//  Spray All Files
EXPORT S0636_SprayFiles := 	SEQUENTIAL(clear_super,spray_all,xform_all,super_all,remove_raw);
														
																			
END;