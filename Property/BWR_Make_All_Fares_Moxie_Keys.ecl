import Property, Lib_FileServices;

#workunit('name','Fares Keys');

leMailTarget := 'jlezcano@seisint.com';			// for multiple email targets, separate multiple address with semi-colons

fSendMail(string pSubject,string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
	(
	 Property.Out_MoxieFaresSearchKeys_Fpos
	,fSendMail('Fares Search Fpos Key Done','Fares search fpos.data.key complete')
	,Property.Out_MoxieFaresSearchKeys_Part1
	,Property.Out_MoxieFaresSearchKeys_Part2
	,Property.Out_MoxieFaresSearchKeys_Part3
	,fSendMail('Fares Search Keys Done','Fares search keys complete')
	,Property.Out_MoxieFares1080Keys
	,fSendMail('Fares 1080 Keys Done','Fares 1080 keys complete')
	,Property.Out_MoxieFares2580Keys
	,fSendMail('Fares 2580 Keys Done','Fares 2580 keys complete')
	)
;