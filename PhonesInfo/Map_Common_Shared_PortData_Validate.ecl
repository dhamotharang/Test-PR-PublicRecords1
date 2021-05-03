IMPORT Std, Ut;
	
	////////////////////////////////////////////////////////////////////////////////////////////	
	//Reformat iConectiv Input File/////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////////
	
	//Pull iConectiv PortDataValidate File
	PortRaw				:= PhonesInfo.File_iConectiv.PortData_Validate_History(stringlib.stringfind(jsondata,'"tid"',1)<>0);
	
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

	//Reformat Dates & Add Counter
	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate fixFile(reformFile l):= transform
			
			file_dt_time					:= Std.Str.FindReplace(Std.Str.FindReplace(l.filename,'thor_data400::in::phones::portdata_validate_daily_iconectiv_', ''),'.json',''); //Pull Date and Timestamp Only from Filename	
			f_port_dt							:= stringlib.stringfilter(l.actTs, '0123456789');	
			
		self.action_code									:= map(l.action = 'u' => 'A',
																						 l.action = 'd' => 'D',
																						 l.action = 'm' => 'M',
																						 '');	
		self.country_code									:= '';
		self.phone												:= l.digits;
		self.dial_type										:= '';
		self.spid													:= stringlib.stringtouppercase(l.spid);
		self.service_type									:= '';
		self.routing_code									:= '';
		self.porting_dt										:= l.actTs;
		self.country_abbr									:= '';	
		self.filename											:= l.filename;					
		self.file_dt_time									:= file_dt_time;
		self.vendor_first_reported_dt			:= if(self.file_dt_time<>'', self.file_dt_time[1..8], '');
		self.vendor_last_reported_dt			:= if(self.file_dt_time<>'', self.file_dt_time[1..8], '');	
		self.port_start_dt								:= f_port_dt;
		self.port_end_dt									:= f_port_dt;
		self.remove_port_dt								:= if(l.action = 'd', f_port_dt, '');
		self.groupid 											:= 0;
		self.is_ported                    := if(l.action = 'u', true, false);
		self.alt_spid											:= l.altspid;
		self.lalt_spid										:= l.laltspid;
		self.line_type										:= l.linetype;
		self 															:= l;
	end;

	reformIn			:= project(reformFile(length(((string)digits))=10), fixFile(left))(action_code in ['A','D']);	//Pull 10-Digit Phones w/ action_codes
	
	//Add Counter to Concatenated Records
	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate addCt(reformIn l, unsigned c):= transform
		self.groupid 	:= c;	
		self 					:= l;
	end;
	
	inFile 				:= project(reformIn, addCt(left, counter));

	inFile_d 			:= distribute(inFile, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, port_start_dt, file_dt_time ,local);
	gpTyp					:= group(inFile_s, phone, LOCAL);

	//Populate SPIDs Related Fields to the Delete Records
	inFile_s addFl(inFile_s L, inFile_s R):= TRANSFORM
		self.spid				:= if(l.action_code in ['A'] and r.action_code = 'D' and l.phone = r.phone,
													l.spid,
													r.spid);
		self.alt_spid		:= if(l.action_code in ['A'] and r.action_code = 'D' and l.phone = r.phone,
													l.alt_spid,
													r.alt_spid);
		self.lalt_spid	:= if(l.action_code in ['A'] and r.action_code = 'D' and l.phone = r.phone,
													l.lalt_spid,
													r.lalt_spid);
		self.line_type	:= if(l.action_code in ['A'] and r.action_code = 'D' and l.phone = r.phone,
													l.line_type,
													r.line_type);
		self						:= r;
	end;

	addFlag 			:= iterate(gpTyp, addFL(LEFT,RIGHT));
	addFlag_ug 		:= ungroup(addFlag);
	
EXPORT Map_Common_Shared_PortData_Validate := addFlag_ug : INDEPENDENT;