// spray MOS0820 Professional Licenses Files for MARI
//unzip files before running spray process	    
IMPORT Prof_License_Mari, Lib_FileServices, lib_stringlib;

EXPORT spray_MOS0820 := MODULE

	#workunit('name','Yogurt: Spray MOS0820');
	SHARED STRING7 code						:= 'MOS0820';
	//  Spray all raw files
	EXPORT S0820_SprayFiles(string pVersion) := FUNCTION
	
		RETURN PARALLEL(Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BRA.TXT', 'bra','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BRK.TXT', 'brk','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BRO.TXT', 'bro','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BRP.TXT', 'brp','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'BRS.TXT', 'brs','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'IAS.TXT', 'ias','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'INB.TXT', 'inb','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'PCB.TXT', 'pcb','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'PCS.TXT', 'pcs','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RAP.TXT', 'rap','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REA.TXT', 'rea','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'REC.TXT', 'rec','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RPF.TXT', 'rpf','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'RSL.TXT', 'rsl','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'SAL.TXT', 'sal','tab'),
										Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'SCG.TXT', 'scg','tab'),
										//New in 20130815
										//Prof_License_Mari.spray_common.spray_csv(pVersion, code, 'ACM.TXT', 'acm','tab')
										);
	END;

END;
/*
import ut
	   ,_control
     ,Prof_License_Mari
	   ,Lib_FileServices
	   ,lib_stringlib
	   ,Lib_date;
	   
	   
export spray_MOS0820 := MODULE
shared filepath		  :=	'/data_build_5_2/MARI/in/MOS0820/';	
// shared sourcepath		:=	'/data_build_5_2/MARI/';

shared maxRecordSize	:=	8192;
shared group_name	:=	'thor40_241';

shared destination := Common_Prof_Lic_Mari.SourcesFolder + 'MOS0820::';

// filedate	:= StringLib.GetDateYYYYMMDD();


SprayFile(string filename, string newname, string delim) := FUNCTION
    
	RETURN 	FileServices.SprayVariable(Common_Prof_Lic_Mari.sourceIP, 
																			filepath + filename, 
																			maxRecordSize,
																			If(delim = 'tab','\\t','\\,'),'\r\n','"',
																			Common_Prof_Lic_Mari.group_name, 
																			destination + StringLib.StringToLowerCase(newname),
																			,
																				,
																					,
																						TRUE,
																							TRUE,
																								FALSE); 				
END;

	

//  Spray All Files
export S0820_SprayFiles :=
	PARALLEL(
		SprayFile('BRA.TXT', 'bra.txt','tab'), 
		SprayFile('BRO.TXT','bro.txt','tab'), 
		SprayFile('BRP.TXT', 'brp.txt','tab'), 
    SprayFile('BRS.TXT', 'brs.txt','tab'),
		SprayFile('PCB.TXT', 'pcb.txt','tab'),
		SprayFile('PCS.TXT', 'pcs.txt','tab'), 
		SprayFile('REA.TXT', 'rea.txt','tab'), 
		SprayFile('REC.TXT', 'rec.txt','tab'),
		SprayFile('RPF.TXT', 'rpf.txt','tab'), 
		SprayFile('SAL.TXT', 'sal.txt','tab'), 
		SprayFile('BRK.TXT', 'brk.txt','tab'),
		SprayFile('IAS.TXT', 'ias.txt','tab'),
		SprayFile('INB.TXT', 'inb.txt','tab'),
		SprayFile('RAP.TXT', 'rap.txt','tab'),
		SprayFile('RSL.TXT', 'rsl.txt','tab'),
		SprayFile('SCG.TXT', 'scg.txt','tab')
	);

END;
*/