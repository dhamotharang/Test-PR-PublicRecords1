import Header, Lib_FileServices;

#workunit('name','Header Keybuild');
#option('skipFileFormatCrcCheck', 1);

leMailTarget := 'kgummadi@seisint.com;gavin.witz@lexisnexis.com,jose.bello@lexisnexis.com';

fSendMail(string pSubject, string pBody)
 := lib_fileservices.fileservices.sendemail(leMailTarget,pSubject,pBody);

sequential
 (

//no longer needed	 header.Proc_Int_To_String_For_Despray,

	 Header.MOXIE_Header_Keys_Part_10,	fSendMail('HDR_KEYS_PART_10','Header keys part 10 complete')
	 
	,Header.MOXIE_Header_Keys_Part_8,	fSendMail('HDR_KEYS_PART_8','Header keys part 08 complete')
	
	,Header.MOXIE_Header_Keys_Part_1,	fSendMail('HDR_KEYS_PART_1','Header keys part 01 complete')

	,Header.MOXIE_Header_Keys_Part_2,	fSendMail('HDR_KEYS_PART_2','Header keys part 02 complete')

	,Header.MOXIE_Header_Keys_Part_3,	fSendMail('HDR_KEYS_PART_3','Header keys part 03 complete')

	,Header.MOXIE_Header_Keys_Part_4,	fSendMail('HDR_KEYS_PART_4','Header keys part 04 complete')

	,Header.MOXIE_Header_Keys_Part_5,	fSendMail('HDR_KEYS_PART_5','Header keys part 05 complete')

	,Header.MOXIE_Header_Keys_Part_7,	fSendMail('HDR_KEYS_PART_7','Header keys part 07 complete')

	,Header.MOXIE_Header_Keys_Part_9,	fSendMail('HDR_KEYS_PART_9','Header keys part 09 complete')

 );