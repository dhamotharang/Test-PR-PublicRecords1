import FBNV2, Lib_FileServices, Roxiekeybuild, _Control, orbit_report;

export BWR_Build(string filedate) := FUNCTION

#workunit('name', 'FBN Build Busreg, CA(4), CP Hist, Experian, FL, TX' + fileDate);
 
leMailTarget      := _control.MyInfo.EmailAddressNotify;

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);	

buildkeys := parallel(FBNV2.proc_Build_Autokey(filedate,File_FBN_Business_Base,File_FBN_Contact_Base),
							FBNV2.Proc_Build_Keys(filedate)) :  success(SendEmail(filedate).key_success), failure(SendEmail(filedate).build_failure);

UpdateRoxiePage := RoxieKeybuild.updateversion('Fbn2Keys', filedate, _control.MyInfo.EmailAddressNotify,,'N|B');

orbit_report.FBN_Stats(getretval);
	  
buildprocess := sequential(
							Proc_Build_FBN_Contact_Base, 
							Proc_Build_FBN_Business_Base,
							fSendMail('FBN Build Part 1 of 2','Base Files Build Complete, Starting Key Build'),
							BuildKeys,
							Proc_build_boolean_keys(filedate),
							UpdateRoxiePage,
							Strata_Pop_Base(filedate),
							SampleRecs(filedate),
							getretval,
							fSendMail('FBN Build Part 2 of 2 ' + filedate,'Build Complete and Moved to QA. \r\n \r\n ' ));

 return buildprocess;
 
 end;