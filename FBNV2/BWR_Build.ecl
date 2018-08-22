import FBNV2, Lib_FileServices, Roxiekeybuild, _Control, orbit_report;

export BWR_Build(string filename, string filedate, string source) := FUNCTION

#workunit('name', 'FBN Build Busreg, CA(5), CP Hist, Experian, FL, TX, NYC, InfoUSA' + fileDate);
 
leMailTarget      := _control.MyInfo.EmailAddressNotify;

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);	
			
validateSource(string pSource) :=
			map(trim(source,left,right) = 'Orange' => fSendMail('FBN Build Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'San_Diego'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),
								trim(source,left,right) = 'Santa_Clara'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Ventura'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),
								trim(source,left,right) = 'Event'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Filing'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Harris'   => fSendMail('FBN Build Started','Valid Source Parameter Entered'),		
								trim(source,left,right) = 'Dallas'   => FAIL('FBN Spray and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								trim(source,left,right) = 'InfoUSA'   => FAIL('FBN Spray and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								trim(source,left,right) = 'San_Bernardino'   => FAIL('FBN Spray and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),		
								trim(source,left,right) = 'NY'   => FAIL('FBN Spray and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								FAIL('Source Parameter passed did not match the Sources, please check the source value passed.'));	

buildkeys := parallel(FBNV2.proc_Build_Autokey(filedate,File_FBN_Business_Base,File_FBN_Contact_Base),
							FBNV2.Proc_Build_Keys(filedate)) :  success(SendEmail(filedate).key_success), failure(SendEmail(filedate).build_failure);

UpdateRoxiePage := RoxieKeybuild.updateversion('Fbn2Keys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

orbit_report.FBN_Stats(getretval);
	  
buildprocess := sequential(
							validateSource(source),
							fSprayInputFiles(filename,filedate,source),
							Proc_Build_FBN_Contact_Base(source), 
							Proc_Build_FBN_Business_Base(source),
							fSendMail('FBN Build Part 1 of 2','Base Files Build Complete, Starting Key Build'),
							BuildKeys,
							Proc_build_boolean_keys(filedate),
							UpdateRoxiePage,
							Strata_Pop_Base(filedate),
							SampleRecs(filedate),
							getretval,
							//For future use
							// BIPStats(filedate),
							fSendMail('FBN Build Part 2 of 2 ' + filedate,'Build Complete and Moved to QA. \r\n \r\n ' ));

 return buildprocess;
 
 end;