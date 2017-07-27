import Official_Records, Lib_FileServices;

#workunit('name','Official Records ' + Official_Records.Version_Development);

leMailTarget := 'avenkatachalam@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
 (
	parallel(
			   Official_Records.Out_Moxie_Party
			  ,Official_Records.Out_Moxie_Document
			  ,Official_Records.Out_Roxie_Party
			  ,Official_Records.Out_Roxie_Document
			 ),
	fSendMail('Official Records 1 of 2','Moxie and all Roxie files complete'),
	parallel(
			   Official_Records.Out_Moxie_Party_Dev_Stats
			  ,Official_Records.Out_Moxie_Document_Dev_Stats
			  ,Official_Records.Out_Moxie_Party_Keys
			  ,Official_Records.Out_Moxie_Document_Keys
			 ),
	fSendMail('Official Records 2 of 2','Moxie job complete')
 );