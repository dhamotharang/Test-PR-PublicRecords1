//PORTED DELTA FILE PROCESS 
//Pulls only the iConectiv delta files and rolls up the records
//Delete records are kept
//History is not kept

IMPORT Std, Ut;	

//DF-28036: Convert 6-Digit Spids to 4-Character Spids
EXPORT Map_Ported_Metadata_DeltaFile_PDV(string version):= FUNCTION 

	//////////////////////////////////////////
	//POPULATE & REFORMAT DATES - DAILY FILE//
	//////////////////////////////////////////
		PortRaw			:= distribute(PhonesInfo.File_Metadata_Delta_PDV.In_Port_DailyDelta(stringlib.stringfind(jsondata,'"tid"',1)<>0));

	//////////////////////////////////////////
	//REFORMAT - DAILY FILE///////////////////
	//////////////////////////////////////////
	
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
	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate fixFile(reformFile l, unsigned c):= transform
			
			file_dt_time					:= Std.Str.FindReplace(Std.Str.FindReplace(l.filename,'thor_data400::in::phones::portdata_validate_dailydelta_iconectiv_', ''),'.json',''); //Pull Date and Timestamp Only from Filename	
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
		self.groupid 											:= c;
		self.is_ported                    := if(l.action = 'u', true, false);
		self.alt_spid											:= l.altspid;
		self.lalt_spid										:= l.laltspid;
		self.line_type										:= l.linetype;
		self 															:= l;
	end;

	input 				:= project(reformFile(length(((string)digits))=10), fixFile(left, counter))(action_code in ['A','D']);	//Pull 10-Digit Phones w/ action_codes

	inFile_d 			:= distribute(input, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, port_start_dt, file_dt_time ,local);
	gpTyp					:= group(inFile_s, phone, LOCAL);

	//Populate SPIDs Related Fields to the Delete Records
	inFile_s addFl(inFile_s L, inFile_s R):= TRANSFORM
		self.spid				:= if(l.action_code = 'A' and r.action_code = 'D' and l.phone = r.phone,
													l.spid,
													r.spid);
		self.alt_spid		:= if(l.action_code = 'A' and r.action_code = 'D' and l.phone = r.phone,
													l.alt_spid,
													r.alt_spid);
		self.lalt_spid	:= if(l.action_code = 'A' and r.action_code = 'D' and l.phone = r.phone,
													l.lalt_spid,
													r.lalt_spid);
		self.line_type	:= if(l.action_code = 'A' and r.action_code = 'D' and l.phone = r.phone,
													l.line_type,
													r.line_type);
		self						:= r;
	end;

	addFlag 			:= iterate(gpTyp, addFL(LEFT,RIGHT));
	addFlag_ug 		:= project(ungroup(addFlag), PhonesInfo.Layout_Common.Intermediate);
	
	//////////////////////////////////////////
	//PROCESS - DAILY FILE////////////////////
	//////////////////////////////////////////	
	
	inFile_d2 		:= distribute(addFlag_ug, hash(phone));
	inFile_s2 		:= sort(inFile_d2, phone, -port_start_dt, -file_dt_time, if(action_code = 'A', 2, 1) ,local);
	inFile_g2			:= group(inFile_s2, phone);
	
	//Treat Adds and Updates the Same
		PhonesInfo.Layout_Common.Intermediate iter1(inFile_g2 l, inFile_g2 r) := transform
			//Conditions to determine when to rollup into one record
				consecutiveA 				:= l.action_code = 'A' and r.action_code = 'A';
				sameSpid 						:= l.spid = r.spid;
				DafterA 						:= r.action_code = 'A' and l.action_code = 'D';
				isLastA 						:= l.phone <> r.phone and r.action_code = 'A';

			//Transactions to be rolled up into one record have the same groupid	
				self.groupid 				:= if((consecutiveA and sameSpid) or (DafterA and sameSpid), l.groupid, r.groupid);
				self.port_end_dt 		:=  if(isLastA, '', 
																	if(r.is_ported=TRUE, l.port_start_dt, r.port_end_dt));			      
				self.is_ported 			:= if(isLastA, true, false);				
				self 								:= r;
		end;
			
	tagGroups 		:= iterate(inFile_g2, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);

	//Rollup Records by Groupid
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, groupid, port_start_dt, file_dt_time, if(action_code in ['A','U'], 1, 2) ,local);
	
		PhonesInfo.Layout_Common.Intermediate roll(aggrTrans_s l, aggrTrans_s r) := transform
				self.is_ported										:= if(l.is_ported or r.is_ported, true, 														r.is_ported);
				self.vendor_first_reported_dt 		:= (string)ut.min2((unsigned)l.vendor_first_reported_dt, 						(unsigned)r.vendor_first_reported_dt);
				self.vendor_last_reported_dt 			:= (string)max((unsigned)l.vendor_last_reported_dt, 								(unsigned)r.vendor_last_reported_dt);
				self.port_start_dt								:= (string)ut.min2((unsigned)l.port_start_dt, 											(unsigned)r.port_start_dt);
				self.port_end_dt									:= if(self.is_ported, '', (string)max((unsigned)l.port_end_dt, 			(unsigned)r.port_end_dt));
				self.porting_dt										:= if(l.porting_dt > r.porting_dt, l.porting_dt, 										r.porting_dt);
				self 															:= r;
		end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);
	
	//Reformat to iConectiv Base Layout (Service Providers will now be populated in the Metadata Base)
		PhonesInfo.Layout_Common.Main remED(aggrTrans_r l):= transform
				self.port_end_dt									:= if(l.is_ported, '', l.port_end_dt);
				self.service_provider							:= '';
				self															:= l;
		end;
	
	fixEnd 				:= project(aggrTrans_r, remED(left));
	
	//Reformat to Metadata Base
	//Adapted from PhonesInfo.PhonesInfo.Map_Common_Port_Main
	
	//Rollup Records w/ Updates <= 3 Days
		rllUpdate	:= sort(distribute(fixEnd, hash(phone)), phone, spid, porting_dt, port_start_dt, -vendor_last_reported_dt, local);	
		
		rllUpdate newDate(rllUpdate l, rllUpdate r) := transform
				
				minDate	:= ut.min2((unsigned)l.vendor_first_reported_dt,(unsigned)r.vendor_first_reported_dt);
				maxDate	:= max((unsigned)l.vendor_last_reported_dt, 		(unsigned)r.vendor_last_reported_dt);
				minStart:= ut.min2((unsigned)l.port_start_dt, 					(unsigned)r.port_start_dt);
				maxEnd	:= max((unsigned)l.port_end_dt, 								(unsigned)r.port_end_dt);

			self.vendor_first_reported_dt 	:= (string)minDate;
			self.vendor_last_reported_dt  	:= (string)maxDate;
			self.port_start_dt					 		:= (string)minStart;
			//Pull Active Records First
			self.port_end_dt								:= if(l.port_end_dt='' or r.port_end_dt='', '', (string)maxEnd);
			self.is_ported									:= if(l.port_end_dt='' and l.is_ported=TRUE or 
																						r.port_end_dt='' and r.is_ported=TRUE, 
																						TRUE, FALSE);
			self 														:= l;
		end;
			
		applyRollupDates	:= rollup(rllUpdate, 
																			left.phone = right.phone and
																			left.spid = right.spid and
																			left.porting_dt = right.porting_dt and
																			left.port_start_dt = right.port_start_dt and
																			//<3 day gap to account for holidays
																			(ut.YYYYMMDDtoJulian((string8)left.port_end_dt)-ut.YYYYMMDDtoJulian((string8)right.vendor_first_reported_dt) between -3 and 0),
																			newDate(left, right), local);
																			
	//Map to Common Layout
		PhonesInfo.Layout_Common.portedMain iConectM(applyRollupDates l):= transform
			self.source 											:= 'P!';
			self.porting_dt										:= (unsigned) stringlib.stringfilter(l.porting_dt, '0123456789')[1..8];
			self.porting_time									:= stringlib.stringfilter(l.porting_dt, '0123456789')[9..14];
			self.phoneType										:= '';
			self.vendor_first_reported_dt 		:= (unsigned) l.vendor_first_reported_dt[1..8];
			self.vendor_first_reported_time		:= l.vendor_first_reported_dt[9..14];
			self.vendor_last_reported_dt			:= (unsigned) l.vendor_last_reported_dt[1..8];
			self.vendor_last_reported_time		:= l.vendor_last_reported_dt[9..14];
			self.port_start_dt								:= (unsigned) l.port_start_dt[1..8];
			self.port_start_time							:= l.port_start_dt[9..14];
			self.port_end_dt									:= (unsigned) l.port_end_dt[1..8];
			self.port_end_time								:= l.port_end_dt[9..14];
			self.remove_port_dt								:= (unsigned) l.remove_port_dt[1..8];
			self 															:= l;
		end;

	iConectComm := dedup(sort(project(applyRollupDates, iConectM(left)), record, local), record, local);
		
	//Map Ported Base to Common Layout - Append Serv/Line/Carrier Names from Reference Table
	//Adapted from PhonesInfo.Map_Ported_Metadata_Main
		srcRef			:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);

		sortSPID		:= sort(distribute(srcRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	

		sortiCon		:= sort(distribute(iConectComm(source='P!'), hash(spid)), spid, local);
			
		//iConectiv File
		PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
			self.serv 							:= r.serv;
			self.line								:= r.line;	
			self.high_risk_indicator:= r.high_risk_indicator;
			self.prepaid						:= r.prepaid;	
			self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);

			self.is_ported					:= if(l.port_end_dt not in [0], false, l.is_ported);
			self 										:= l;
		end;
			
		addiConON 				:= join(sortiCon, sortSPID,
														left.spid = right.spid,
														addiConSL(left, right), left outer, local, keep(1));
																			
	//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
	//There are a few instances where there are multiple ocns for a spid
		srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
		srtRefOFN_match		:= sort(distribute(srcRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
			
		PhonesInfo.Layout_Common.portedMetadata_Main addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
			self.account_owner			:= r.ocn;
			self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 										:= l;
		end;
		
		addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
															left.spid = right.spid and
															PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
															addiCOFNTr(left, right), left outer, local, keep(1));	
		
		//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
		srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
		srtRefRem					:= sort(distribute(srcRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
	
		PhonesInfo.Layout_Common.portedMetadata_Main addiRemTr(srtAddiCRem l, srtRefRem r):= transform
			self.account_owner			:= r.ocn;
			self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 										:= l;
		end;	
	
		addiCRem 					:= join(srtAddiCRem, srtRefRem,
															left.spid = right.spid,
															addiRemTr(left, right), left outer, local, keep(1));
	
	//Concat Appended OCN/Carrier Name Results
	ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);

		//Reformat to Key Layout
		keyLayout := record
			string10 phone;
			PhonesInfo.Layout_Common.portedMetadata_Main-phone;
			unsigned8 __internal_fpos__;
		end;

		keyLayout keyTr(ddiConAddFields l):= transform
			self.__internal_fpos__ 	:= 0;	
			self 										:= l;
		end;
	
		keyFile := project(ddiConAddFields(phone<>''), keyTr(left)); 
		
	RETURN keyFile;
	
END;