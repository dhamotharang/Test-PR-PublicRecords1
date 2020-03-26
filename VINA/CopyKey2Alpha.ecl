IMPORT _control, ut;

EXPORT CopyKey2Alpha (string sname, string destinationGroup = 'thor400_112') := FUNCTION
 
 emails := 'InsDataOps@LexisNexisRisk.com;suman.burjukindi@lexisnexisrisk.com;patrick.bell@lexisnexisrisk.com';

		Alpha_Prod_Logical_FileName := IF(FileServices.SuperFileExists(ut.foreign_aprod+sname), nothor(fileservices.superfilecontents(ut.foreign_aprod+sname))[1].name, '');
		Boca_Prod_Logical_FileName := nothor(fileservices.superfilecontents('~' + sname))[1].name;
		sAlpha_Prod_Logical_FileName := Alpha_Prod_Logical_FileName[26..];
		New_Alpha_Prod_Logical_FileName := Boca_Prod_Logical_FileName;
	
	CopyKey := nothor(fileservices.fCopy('~' + sname
																				 ,destinationGroup
																				 ,'~'+sname
																				 ,_control.IPAddress.prod_thor_dali 
																				 , 
																				 ,'http://alpha_prod_thor_esp.risk.regn.net:8010/FileSpray'
																				 ,
																				 ,true
																				 ,true
																				 ,true
																				 ,true)); 


		LetsDoIt_ExclamationPoint := 		SEQUENTIAL(CopyKey, 
																						fileservices.sendemail(emails, 'Boca Files: New ' + sname + ' Key on Alpha Prod', WORKUNIT + ': ' + New_Alpha_Prod_Logical_FileName));
		
		RETURN LetsDoIt_ExclamationPoint;
								
	END;