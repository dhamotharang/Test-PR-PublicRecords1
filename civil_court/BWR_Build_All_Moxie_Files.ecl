import Civil_Court, Lib_FileServices;

#workunit('name','Civil Court ' + Civil_Court.Version_Development);

leMailTarget := 'nglasrot@seisint.com';

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
 (
	Civil_Court.Out_Missing_Datasets,
	parallel(
			   Civil_Court.Out_Moxie_Party
			  ,Civil_Court.Out_Moxie_Matter
			  ,Civil_Court.Out_Moxie_Case_Activity
			 ),
	fSendMail('Civil Court 1 of 2','Civil Court Moxie files complete'),
	parallel(
			   Civil_Court.Out_Moxie_Party_Dev_Stats
			  ,Civil_Court.Out_Moxie_Matter_Dev_Stats
			  ,Civil_Court.Out_Moxie_Case_Activity_Dev_Stats
			  ,Civil_Court.Out_Moxie_Matter_Keys
			  ,Civil_Court.Out_Moxie_Case_Activity_Keys
  			  ,Civil_Court.Out_Moxie_Party_Keys
			 ),
	fSendMail('Civil Court 2 of 2','Civil Court job complete')
 );