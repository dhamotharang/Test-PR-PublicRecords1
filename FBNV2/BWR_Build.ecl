import FBNV2, Lib_FileServices;

export BWR_Build(string filedate) := FUNCTION

#workunit('name','FBN Rewrite Build CA(5),InfoUSa ,TD,TH, NYC, FL' );

leMailTarget      := 'zhuang@seisint.com';

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
	  
buildprocess := sequential(
							Proc_Build_FBN_Business_Base,
							Proc_Build_FBN_Contact_Base,
							fSendMail('FBN Build 1 of 2','Base files complete, Key is building'),
							parallel(	
									   FBNV2.proc_Build_Autokey(filedate,File_FBN_Business_Base,File_FBN_Contact_Base),
									   FBNV2.Proc_Build_Keys(filedate)),
									   output(FBNV2.File_FBN_Business_Base),
									   output(FBNV2.File_FBN_Contact_Base),
							fSendMail('FBN Build 2 of 2 ' + filedate,'Key Finishing last keys. \r\n \r\n ' ));

 return buildprocess;
 
 end;