//California Mortgage Lender CAS0681
import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
export spray_CAS0681 (string filedate) := MODULE

#workunit('name','Yogurt:Spray CAS0681');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/CAS0681/' + filedate +'/';
shared sourcepath		:=	'/data/data_build_5_2/MARI/';
shared group_name	:=	Common_Prof_Lic_Mari.group_name;
shared maxRecordSize	:=	8192;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'CAS0681::' + filedate + '::';
shared superfile := '~thor_data400::in::proflic_mari::CAS0681::using::real_estate';


clear_super
	:=
		IF(FileServices.SuperFileExists(superfile)
			,FileServices.ClearSuperFile(superfile)
			,FileServices.CreateSuperFile(superfile));
	
	
SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;
	

TransformFile(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_CAS0681.raw,csv(SEPARATOR(','),quote('"'),heading(1), terminator('\n')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_CAS0681.common; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfile(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile, destination + filename);

END;		

//  Spray All Files
spray_all	:=
	PARALLEL(
		
		SprayFile('mlo_list.csv','\\,') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('mlo_list.csv'),, destination + 'mlo_list.csv', csv(SEPARATOR(','),quote('"'),heading(1), terminator('\n')), OVERWRITE)
	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
			
		AddToSuperfile('mlo_list.csv'),
		
		FileServices.FinishSuperFileTransaction()
	);

// Remove RAW file
   remove_raw		:=	FileServices.DeleteLogicalFile('mlo_list.raw');
	


//  Spray All Files
export S0681_SprayFiles := SEQUENTIAL(
																			clear_super
																		  ,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;


