// spray USS0645 - HUD (Housing & Urban Development) Mortgage Lenders  
IMPORT ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	      
//Files for S0645 are Located  //
EXPORT spray_USS0645(STRING filedate) := MODULE

#workunit('name','Yogurt:Spray USS0645 ' + filedate);
SHARED STRING7 code		:= 'USS0645';
SHARED filepath		    :=	'/data/data_build_5_2/MARI/in/USS0645/' + filedate +'/';
SHARED sourcepath			:=	'/data/data_build_5_2/MARI/';
SHARED group_name			:=	Common_Prof_Lic_Mari.group_name;
SHARED maxRecordSize	:=	8192;
SHARED destination := Common_Prof_Lic_Mari.SourcesFolder + 'USS0645::' + filedate + '::';
SHARED superfile_lender := '~thor_data400::in::proflic_mari::USS0645::using::lender';
SHARED superfile_branch := '~thor_data400::in::proflic_mari::USS0645::using::branch';

	   
clear_super_le
	:=
		IF(FileServices.SuperFileExists(superfile_lender)
			,FileServices.ClearSuperFile(superfile_lender)
			,FileServices.CreateSuperFile(superfile_lender)
			);		 


clear_super_br
	:=
		IF(FileServices.SuperFileExists(superfile_branch)
			,FileServices.ClearSuperFile(superfile_branch)
			,FileServices.CreateSuperFile(superfile_branch)
			);		
			

TransformFile_Lender(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_USS0645.lender,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_USS0645.COMMON, SELF.BRANCH_FLAG := 'N',SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


TransformFile_Branch(STRING filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := DATASET(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_USS0645.branch,CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR(['\n','\r','\r\n'])));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_USS0645.COMMON, SELF.BRANCH_FLAG := 'Y',SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile_lender(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_lender, destination + filename);

END;		

AddTosuperfile_branch(STRING filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_branch, destination + filename);

END;	

//  Spray All Files
spray_all	:=
	PARALLEL(
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'branches.csv','comma'),
		Prof_License_Mari.spray_common_modified.spray_csv(filedate, code, 'Lenders.csv','comma')
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Branch('branches.csv'),, destination + 'branches.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_Lender('Lenders.csv'),, destination + 'Lenders.csv', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)	
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfile_Branch('branches.csv'),
		AddTosuperfile_Lender('Lenders.csv'),
		FileServices.FinishSuperFileTransaction()
	);

remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + 'branches.raw'),
							 FileServices.DeleteLogicalFile(destination + 'Lenders.raw'),
							 );

//  Spray All Files
EXPORT S0645_SprayFiles := SEQUENTIAL(
																			clear_super_le
																			,clear_super_br
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																		

END;