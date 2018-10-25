// spray ALS0812 Professional Licenses Files for MARI	   
import ut
	   ,_control
       ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   

//Files for S0812 are Located  //
export spray_ALS0812 (string filedate) := MODULE

#workunit('name','Yogurt:Spray ALS0812');

shared filepath		    :=	'/data/data_build_5_2/MARI/in/ALS0812/' + filedate +'/';
shared sourcepath			:=	'/data/data_build_5_2/MARI/';
shared group_name			:=	'thor400_66';
shared maxRecordSize	:=	8192;
shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'ALS0812::' + filedate + '::';
shared superfile_cmpny := '~thor_data400::in::proflic_mari::als0812::using::company_personel';
shared superfile_rle := '~thor_data400::in::proflic_mari::als0812::using::real_estate_licensee';

	   
clear_super_cmpny
	:=
		IF(FileServices.SuperFileExists(superfile_cmpny)
			,FileServices.ClearSuperFile(superfile_cmpny)
			,FileServices.CreateSuperFile(superfile_cmpny)
			);		 


clear_super_rle
	:=
		IF(FileServices.SuperFileExists(superfile_rle)
			,FileServices.ClearSuperFile(superfile_rle)
			,FileServices.CreateSuperFile(superfile_rle)
			);		
			
SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\n','',
																		 group_name, 
																		 destination + StringLib.StringToLowerCase(newname) + '.raw',
																			,
																				,
																					,
																						TRUE,
																							,
																								FALSE); 																									
END;



TransformFile_Comp(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_ALS0812.Comp_Personnel,CSV(SEPARATOR(','),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ALS0812.Comp_Personnel_src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


TransformFile_Agents(string filename) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	dsraw := dataset(destination + StringLib.StringToLowerCase(newname) + '.raw',
										Prof_License_Mari.Layout_ALS0812.Agents,CSV(SEPARATOR(','),QUOTE('"')));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_ALS0812.Agents_src,SELF.ln_filedate := filedate; SELF := LEFT; SELF :=[]));
	
	RETURN ds;
	
END;		


AddToSuperfileComp(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_cmpny, destination + filename);

END;		

AddToSuperfileAgents(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_rle, destination + filename);

END;	

//  Spray All Files
spray_all	:=
	PARALLEL(
		SprayFile('Company_Personel_AREC.txt','\\,'), 	 
		SprayFile('Lic_List_AREC.txt','\\,') 
		
	);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile_Comp('Company_Personel_AREC.txt'),, destination + 'Company_Personel_AREC.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile_Agents('Lic_List_AREC.txt'),, destination + 'Lic_List_AREC.txt', CSV(SEPARATOR(','),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)	

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
		AddToSuperfileComp('Company_Personel_AREC.txt'),
		AddToSuperfileAgents('Lic_List_AREC.txt'),
		FileServices.FinishSuperFileTransaction()
	);


//  Spray All Files
export S0812_SprayFiles := SEQUENTIAL(
																			clear_super_cmpny
																			,clear_super_rle
																		  ,spray_all
																			,xform_all
																			,super_all);
																		

END;


