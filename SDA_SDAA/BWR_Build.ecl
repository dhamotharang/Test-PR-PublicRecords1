import Lib_FileServices;

export BWR_Build(string filedate) := FUNCTION

#workunit('name','Build SDA SDAA Base' );

leMailTarget      := 'zhuang@seisint.com;skasavajjala@seisint.com';
fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
	  
buildprocess :=  sequential(Proc_Build_SDAA_Base(filedate),
                              Proc_Build_SDA_Base(fileDate),
							  Strata_Pop_SDA_SDAA_Base,
							  output(choosen(fSDA_As_Business_Header(File_SDA_Base+File_SDAa_Base),100)),
							  output(choosen(File_SDA_Base+File_SDAa_Base,100)),
  							  fSendMail('SDA SDAA','Data cleansing and mapping complete'));
							  

 return buildprocess;
 
 end; 