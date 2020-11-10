IMPORT Std;	

	//Reformat iConectiv PortData Validate Input File	
	
	//Pull iConectiv PortDataValidate File
	ds						:= project(distribute(PhonesInfo.File_iConectiv.Portdata_Validate_Daily), PhonesInfo.Layout_iConectiv.PortData_Validate_History);
	PortRaw				:= ds(stringlib.stringfind(jsondata,'"tid"',1)<>0);
	
	//Fix Delimiters
	fixFileDelim 	:= project(PortRaw, transform(PhonesInfo.Layout_iConectiv.PortData_Validate_History,
																								self.filename := '"'+trim(left.filename, left, right)+'"';	
																								self.jsonData := 
																									if(left.jsonData[1] in [','] and phonesInfo._functions.fn_alphaText(left.jsonData)<>''
																									 ,left.jsonData[2..]+'}',
																									if(left.jsonData[1] in ['{'] and stringlib.stringfind(left.jsonData, 'transactionData', 1)<>0
																									 , regexreplace('\\}\\}',Std.Str.FindReplace(left.jsonData[2..], '"transactionData": [', '')+'}','}'), 
																									 if(phonesInfo._functions.fn_alphaText(left.jsonData)=''
																									 ,phonesInfo._functions.fn_alphaText(left.jsonData)	
																									 ,regexreplace('\\}\\}',stringlib.stringfilterout('{'+ left.jsonData +'}','[]'),'}'))))
																								))(length(trim(jsonData, left, right))>0);

	//Add Filename to Record
	addFileName 	:= project(fixFileDelim, transform(PhonesInfo.Layout_iConectiv.PortData_Validate_History,
																										self.jsonData := regexreplace('\\}',left.jsonData,', "filename": ')+ trim(left.filename, left, right)+'}';
																										self := left));
	
	//Flatten JSON File 
	reformFile 		:= project(addFileName, transform(PhonesInfo.Layout_iConectiv.PortData_Validate_Json
																									,PhonesInfo.Layout_iConectiv.PortData_Validate_Json fields1:= FROMJSON(PhonesInfo.Layout_iConectiv.PortData_Validate_Json
																									,left.jsonData
																									,trim, ONFAIL(transform(PhonesInfo.Layout_iConectiv.PortData_Validate_Json
																									,self.action:=failmessage
																									,self:=[]
																									)));
																									self := fields1;
																									self := LEFT
																									));
	
	refFile				:= project(reformFile, PhonesInfo.Layout_iConectiv.PortData_Validate_History_Raw);

EXPORT File_iConectiv_PortData_Validate_In := refFile;