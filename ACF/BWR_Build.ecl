import Lib_FileServices,ACF;

export BWR_Build(string filedate) := FUNCTION

#workunit('name','Build ACF ACFA Base' );

leMailTarget      := 'zhuang@seisint.com;skasavajjala@seisint.com';
fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
	  
buildprocess :=  sequential(Proc_Build_Base(filedate), 
							  Strata_Pop_Base(filedate),
							  output(choosen(fACF_As_Business_Header(File_ACF_Base),100)),
							  output(choosen(File_ACF_Base,100)),
  							  fSendMail('ACF','Data cleansing and mapping complete'));
							  

 return buildprocess;
 
 end; 