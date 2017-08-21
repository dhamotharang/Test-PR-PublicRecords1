// spray VVirginia Dept. of Profess./Occupational Regulation / Multiple Professions// Professional Licenses Files for MARI	   

 
import ut,_control ,Prof_License_Mari,Lib_FileServices,lib_stringlib,Lib_date;
	   
	   
export spray_VAS0849(string filedate) := MODULE
#workunit('name','Spray VAS0849 ' + filedate);

SHARED filepath		  :=	'/data/data_build_5_2/MARI/in/VAS0849/' + filedate +'/';	
SHARED maxRecordSize:=	8192;
SHARED group_name	  :=	Common_Prof_Lic_Mari.group_name;
SHARED superfile_active   := '~thor_data400::in::proflic_mari::vas0849::using::active_license';
SHARED superfile_inactive := '~thor_data400::in::proflic_mari::vas0849::using::inactive_license';
SHARED destination  := Common_Prof_Lic_Mari.SourcesFolder + 'VAS0849::'+ filedate + '::';

clear_super_active
	:=
		IF(FileServices.SuperFileExists(superfile_active)
			,FileServices.ClearSuperFile(superfile_active)
			,FileServices.CreateSuperFile(superfile_active));

clear_super_inactive
	:= 
		IF(FileServices.SuperFileExists(superfile_inactive) 
					,FileServices.ClearSuperFile(superfile_inactive)
					,FileServices.CreateSuperFile(superfile_inactive));

SprayFile(string filename, string delim) := FUNCTION
	n := StringLib.StringFind(filename, '.',1);
	newname := filename[1..(n-1)];
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																		 filepath + filename, 
																		 maxRecordSize,
																		 If(delim = 'tab','\t',''),'\r\n','',
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
										Prof_License_Mari.Layout_VAS0849.raw,CSV(SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n'),HEADING(1)));
					
	ds := PROJECT(dsraw,TRANSFORM(Prof_License_Mari.Layout_VAS0849.src,SELF.ln_filedate := filedate; SELF := LEFT; self := [ ]));
	
	RETURN ds;
	
END;		


AddToSuperfileActive(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_active, destination + filename);

END;		
	
AddToSuperfileInactive(string filename) := FUNCTION
	RETURN 	
			FileServices.AddSuperFile(superfile_inactive, destination + filename);

END;	

//  Spray All Files
spray_all :=
	PARALLEL(
		SprayFile('0225a_act.txt', 	'tab'), 
		SprayFile('0225o_act.txt', 	'tab'), 
		SprayFile('0225p_act.txt', 	'tab'),
		SprayFile('0225s_act.txt', 	'tab'), 
		SprayFile('0226b__crnt.txt',	'tab'), 
		SprayFile('0226f__crnt.txt', 'tab'),
		SprayFile('0226l__crnt.txt', 'tab'), 
		SprayFile('0226o__crnt.txt', 'tab'), 
		SprayFile('4001c_act__crnt.txt', 	'tab'),
		SprayFile('4001g_act__crnt.txt', 	'tab'), 
		SprayFile('4001l_act__crnt.txt', 	'tab'), 
		SprayFile('4008__crnt.txt',	'tab'), 
		SprayFile('4002__crnt.txt',	'tab'),
		SprayFile('4003__crnt.txt',	'tab'),
		SprayFile('4004__crnt.txt',	'tab'),
		// SprayFile('4108__crnt.txt',	'tab'), 
		// SprayFile('4001l_inact__crnt.txt', 	'tab'), 
		SprayFile('0225a_inact.txt','tab'), 
		SprayFile('0225o_inact.txt','tab'),
		SprayFile('0225p_inact.txt','tab'), 
		SprayFile('0225s_inact.txt','tab'),
		SprayFile('4001c_inact__crnt.txt', 	'tab'),
		SprayFile('4001g_inact__crnt.txt', 	'tab'),
		SprayFile('4001l_inact__crnt.txt', 	'tab'),
		);


//  Transform All Files
xform_all
	:= PARALLEL(
							OUTPUT(TransformFile('0225a_act.txt'),, 	destination + '0225a_act.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225o_act.txt'),, 	destination + '0225o_act.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225p_act.txt'),, 	destination + '0225p_act.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225s_act.txt'),, 	destination + '0225s_act.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0226b__crnt.txt'),,	destination + '0226b__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0226f__crnt.txt'),,	destination + '0226f__crnt.txt', CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0226l__crnt.txt'),,  destination + '0226l__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0226o__crnt.txt'),,  destination + '0226o__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4001c_act__crnt.txt'),, 	destination + '4001c_act__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4001g_act__crnt.txt'),, 	destination + '4001g_act__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4001l_act__crnt.txt'),, 	destination + '4001l_act__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4008__crnt.txt'),,	destination + '4008__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4002__crnt.txt'),,	destination + '4002__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4003__crnt.txt'),,	destination + '4003__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4004__crnt.txt'),,	destination + '4004__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							// OUTPUT(TransformFile('4108__crnt.txt'),,	destination + '4108__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							// OUTPUT(TransformFile('4001l_inact__crnt.txt'),, 	destination + '4001l_inact__crnt.txt',	CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225a_inact.txt'),, destination + '0225a_inact.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225o_inact.txt'),, destination + '0225o_inact.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225p_inact.txt'),, destination + '0225p_inact.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('0225s_inact.txt'),, destination + '0225s_inact.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							
							OUTPUT(TransformFile('4001c_inact__crnt.txt'),, destination + '4001c_inact__crnt.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4001g_inact__crnt.txt'),, destination + '4001g_inact__crnt.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE),
							OUTPUT(TransformFile('4001l_inact__crnt.txt'),, destination + '4001l_inact__crnt.txt',CSV(HEADING(1),SEPARATOR('\t'),QUOTE('"'),TERMINATOR('\n')), OVERWRITE)
							

	);	


//  Add Files to Superfile
super_all	
	:=	
	SEQUENTIAL(
		FileServices.StartSuperFileTransaction(),
// Add Active Licenses			
		AddToSuperfileActive('0225a_act.txt'),
		AddToSuperfileActive('0225o_act.txt'),
		AddToSuperfileActive('0225p_act.txt'),
		AddToSuperfileActive('0225s_act.txt'),
		AddToSuperfileActive('0226b__crnt.txt'),
		AddToSuperfileActive('0226f__crnt.txt'),
		AddToSuperfileActive('0226l__crnt.txt'),
		AddToSuperfileActive('0226o__crnt.txt'),
		AddToSuperfileActive('4001c_act__crnt.txt'),
		AddToSuperfileActive('4001g_act__crnt.txt'),
		AddToSuperfileActive('4001l_act__crnt.txt'),
		AddToSuperfileActive('4008__crnt.txt'),
		AddToSuperfileActive('4002__crnt.txt'),
		AddToSuperfileActive('4003__crnt.txt'),
		AddToSuperfileActive('4004__crnt.txt'),
		// AddToSuperfileActive('4108__crnt.txt'),
		
//Add Inactive Licenses		
		// AddToSuperfileInActive('4001l_inact__crnt.txt'),
		AddToSuperfileInactive('0225a_inact.txt'),
		AddToSuperfileInactive('0225o_inact.txt'),
		AddToSuperfileInactive('0225p_inact.txt'),
		AddToSuperfileInactive('0225s_inact.txt'),
		AddToSuperfileInactive('4001c_inact__crnt.txt'),
		AddToSuperfileInactive('4001g_inact__crnt.txt'),
		AddToSuperfileInactive('4001l_inact__crnt.txt'),
		FileServices.FinishSuperFileTransaction()
	);


remove_raw 
	:= 
		SEQUENTIAL(
							 FileServices.DeleteLogicalFile(destination + '0225a_act.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225o_act.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225p_act.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225s_act.raw'),
							 FileServices.DeleteLogicalFile(destination + '0226b__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '0226f__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '0226l__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '0226o__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001c_act__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001g_act__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001l_act__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4008__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4002__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4003__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4004__crnt.raw'),
							 // FileServices.DeleteLogicalFile(destination + '4108__crnt.raw'),
							 // FileServices.DeleteLogicalFile(destination + '4001l_inact__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225a_inact.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225o_inact.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225p_inact.raw'),
							 FileServices.DeleteLogicalFile(destination + '0225s_inact.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001c_inact__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001g_inact__crnt.raw'),
							 FileServices.DeleteLogicalFile(destination + '4001l_inact__crnt.raw')
							 );


//  Spray All Files
export S0849_SprayFiles := SEQUENTIAL(
																			clear_super_active
																			,clear_super_inactive
																			,spray_all
																			,xform_all
																			,super_all
																			,remove_raw);
																			

END;


