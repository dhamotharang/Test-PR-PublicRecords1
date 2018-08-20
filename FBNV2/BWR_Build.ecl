// import FBNV2, Lib_FileServices, Roxiekeybuild, _Control, orbit_report, Scrubs, Scrubs_FBNV2, ut, tools, std;
import FBNV2, Lib_FileServices, Roxiekeybuild, _Control, orbit_report, Scrubs, Scrubs_FBNV2;

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
								trim(source,left,right) = 'Dallas'   => FAIL('FBN Spray, Scrubs, and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								trim(source,left,right) = 'InfoUSA'   => FAIL('FBN Spray, Scrubs, and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								trim(source,left,right) = 'San_Bernardino'   => FAIL('FBN Spray, Scrubs, and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),		
								trim(source,left,right) = 'NY'   => FAIL('FBN Spray, Scrubs, and Build Not Set Up For This Source.  This Source Has Not Been Sent By Vendor In A Long Time'),
								FAIL('Source Parameter passed did not match the Sources, please check the source value passed.'));	

runInputScrubs(string pSource) := 																 
							map(trim(source,left,right) = 'Orange' => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Orange', 'Input_CA_Orange', fileDate,leMailTarget),		
								trim(source,left,right) = 'San_Diego'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_San_Diego', 'Input_CA_San_Diego', fileDate,leMailTarget),
								trim(source,left,right) = 'Santa_Clara'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Santa_Clara', 'Input_CA_Santa_Clara', fileDate,leMailTarget),		
								trim(source,left,right) = 'Ventura'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Ventura', 'Input_CA_Ventura', fileDate,leMailTarget),
								trim(source,left,right) = 'Event'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Event', 'Input_FL_Event', fileDate,leMailTarget),		
								trim(source,left,right) = 'Filing'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Filing', 'Input_FL_Filing', fileDate,leMailTarget),		
								trim(source,left,right) = 'Harris'   => Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_TX_Harris', 'Input_TX_Harris', fileDate,leMailTarget));	

buildkeys := parallel(FBNV2.proc_Build_Autokey(filedate,File_FBN_Business_Base,File_FBN_Contact_Base),
							FBNV2.Proc_Build_Keys(filedate)) :  success(SendEmail(filedate).key_success), failure(SendEmail(filedate).build_failure);

UpdateRoxiePage := RoxieKeybuild.updateversion('Fbn2Keys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

orbit_report.FBN_Stats(getretval);
	  
buildprocess := sequential(
							validateSource(source),
							fSprayInputFiles(filename,filedate,source),
							Proc_Build_FBN_Contact_Base(source), 
							Proc_Build_FBN_Business_Base(source),
							runInputScrubs(source),
							//Waiting on feedback from Rosemary before I add Scrubs
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Orange', 'Input_CA_Orange', fileDate,leMailTarget),		
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_San_Diego', 'Input_CA_San_Diego', fileDate,leMailTarget),
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Santa_Clara', 'Input_CA_Santa_Clara', fileDate,leMailTarget),		
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_CA_Ventura', 'Input_CA_Ventura', fileDate,leMailTarget),
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Event', 'Input_FL_Event', fileDate,leMailTarget),		
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_FL_Filing', 'Input_FL_Filing', fileDate,leMailTarget),		
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Input_TX_Harris', 'Input_TX_Harris', fileDate,leMailTarget),	
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Base_Contact', 'Base_Contact', fileDate,leMailTarget),		
							// Scrubs.ScrubsPlus('FBNV2','Scrubs_FBNV2','Scrubs_FBNV2_Base_Business', 'Base_Business', fileDate,leMailTarget),
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