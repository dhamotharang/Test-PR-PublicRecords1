import Taxpro, Lib_FileServices;

export BWR_Build(string filedate) := FUNCTION

//#workunit('name','Taxpro  Build' );

leMailTarget      := 'zhuang@seisint.com';

fSendMail(string pSubject, string pBody)
      := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);
	  
buildprocess := sequential(
							output(choosen(TAXPRO.Proc_Build_Base,100)),
							fSendMail('Taxpro Build 1 of 2','Base files complete, Key is building'),
							Taxpro.proc_Build_Autokey(filedate),
							TAXPRO.Proc_Build_Key(filedate),
							Strata_Pop_Base(fileDate),
							Proc_Build_Boolean_Keys(fileDate),
							fSendMail('Taxpro Build 2 of 2 ' + filedate,'Key Finishing last keys. \r\n \r\n ' ));

 return buildprocess;
 
 end;