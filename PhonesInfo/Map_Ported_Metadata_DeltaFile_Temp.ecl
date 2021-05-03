//PORTED DELTA FILE PROCESS 
//Pulls only the iConectiv delta files and rolls up the records
//Delete records are kept
//History is not kept

IMPORT std, ut;	

//DF-28036: Convert 6-Digit Spids to 4-Character Spids

EXPORT Map_Ported_Metadata_DeltaFile_Temp(string version):= FUNCTION 

	//Adapted from PhonesInfo.Map_IConectiv_Port_Full
	
	tempLayout := record
		PhonesInfo.Layout_iConectiv.Intermediate;
		integer uniqueid;
		string ocn;
	end;

	//POPULATE & REFORMAT DATES - DAILY FILE	
	dailyTelo 				:= PhonesInfo.File_Metadata_Delta_Temp.In_Port_DailyDelta(length((string)tn)=10 and lrn<>0);
	
	dailyTeloAdd			:= dailyTelo(operation<>'D');
	dailyTeloDelAud		:= dailyTelo(operation='D' and trim(DownloadReason) = 'audit-discrepancy');	
	dailyTeloDelOth		:= dedup(sort(distribute(dailyTelo(operation='D' and trim(DownloadReason) <> 'audit-discrepancy'), hash(tn)), tn, lrn, spid, uniqueid, ((string)activationtimestamp)[1..8], -((string)operationtimestamp)[1..8], local), tn, local); //Keep Latest Delete		
	
	concatDailyTelo		:= dailyTeloAdd + dailyTeloDelAud + dailyTeloDelOth;	

	tempLayout fixTeloFile(concatDailyTelo l, unsigned c):= transform
	
			fn_timeConvert(integer timestamp) := function
														
				reformTimestamp := (string)Std.Date.SecondsToParts(timestamp).year 
																+ intformat(Std.Date.SecondsToParts(timestamp).month, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).day, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).hour, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).minute, 2, 1) 
																+ intformat(Std.Date.SecondsToParts(timestamp).second, 2, 1);
					
				return reformTimestamp;
				
			end;
			
			f_port_dt		:= stringlib.stringfilter((string)l.activationtimestamp, '0123456789');	
						
		self.filename									:= l.filename[stringlib.stringfind(l.filename, 'npac', 1)..stringlib.stringfind(l.filename, '.csv', 1)-1];					
		self.action_code							:= if(l.operation='M', 
																				if(trim(l.downloadreason)='audit-discrepancy', 'U', 'A'), 
																				l.operation);
		self.country_code							:= ''; 
		self.phone										:= (string)l.tn;		
		self.dial_type								:= '';		
		self.spid											:= '';					
		self.service_type							:= '';	
		self.routing_code							:= (string)l.lrn;	
		self.porting_dt								:= f_port_dt;	
		self.country_abbr							:= '';
		self.file_dt_time							:= if(length((string)l.updated)<14,
																				fn_timeConvert(l.updated),
																				(string)l.updated);
		self.vendor_first_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');
		self.vendor_last_reported_dt	:= if(self.file_dt_time<>'', self.file_dt_time, '');	
		self.port_start_dt						:= f_port_dt;
		self.port_end_dt							:= f_port_dt;
		self.remove_port_dt						:= if(l.operation='D', f_port_dt, '');
		self.groupid 									:= c;
		self.ocn 											:= l.spid;
		self.uniqueid									:= l.uniqueid;
	end;

	inputTelo 			:= project(concatDailyTelo, fixTeloFile(left, counter));
	
	//Append Spid
	srtCRef 				:= sort(distribute(PhonesInfo.File_Source_Reference.Main(is_current=TRUE), hash(ocn)), ocn, local);
	srtTInput				:= sort(distribute(inputTelo, hash(ocn)), ocn, local);
	
	tempLayout addSpidTr(srtTInput l, srtCRef r):= transform
		self.spid 										:= r.spid;	
		self 													:= l;
	end;
	
	addTSPID 				:= join(srtTInput, srtCRef,
													left.ocn = right.ocn,
													addSpidTr(left, right), left outer, local, keep(1));
	
	teloInput				:= dedup(sort(distribute(addTSPID, hash(phone)), record, local), record, local);
	
	//Process Activities
	inFile_d 				:= distribute(teloInput, hash(phone));
	inFile_s 				:= sort(inFile_d, phone, -port_start_dt, -file_dt_time, -uniqueid, if(action_code in ['A','U'], 2, 1) ,local);
	inFile_g 				:= group(inFile_s, phone);
	
	//Treat Adds and Updates the Same
	tempLayout iter1(inFile_g l, inFile_g r) := transform
			//Conditions to determine when to rollup into one record
				consecutiveAorU 		:= l.action_code in ['A','U'] and r.action_code in ['A','U'];
				sameOcnandRouting 	:= l.ocn = r.ocn and l.routing_code = r.routing_code;
				DafterAorU 					:= r.action_code in ['A','U'] and l.action_code = 'D';
				isLastAorU 					:= l.phone <> r.phone and r.action_code in ['A','U'];

			//Transactions to be rolled up into one record have the same groupid	
		self.groupid 									:= if((consecutiveAorU and sameOcnandRouting) or (DafterAorU and sameOcnandRouting), l.groupid, r.groupid);
		self.port_end_dt 							:= if(isLastAorU, '', 
																				if(r.is_ported=TRUE, l.port_start_dt, r.port_end_dt));			      
		self.is_ported 								:= if(isLastAorU, true, false);				
		self 													:= r;
	end;
			
	tagGroups 			:= iterate(inFile_g, iter1(left,right));
	tagGroups_ug 		:= ungroup(tagGroups);

	//Rollup Records by Groupid
	aggrTrans_d 		:= distribute(tagGroups_ug, hash(groupid, phone));
	aggrTrans_s			:= sort(aggrTrans_d, groupid, phone, port_start_dt, file_dt_time, uniqueid, if(action_code in ['A','U'], 1, 2), local);
	
	tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform
		self.is_ported								:= if(l.is_ported or r.is_ported, true, 														r.is_ported);
		self.vendor_first_reported_dt	:= (string)ut.min2((unsigned)l.vendor_first_reported_dt, 						(unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 	:= (string)max((unsigned)l.vendor_last_reported_dt, 								(unsigned)r.vendor_last_reported_dt);
		self.port_start_dt						:= (string)ut.min2((unsigned)l.port_start_dt, 											(unsigned)r.port_start_dt);
		self.port_end_dt							:= if(self.is_ported, '', (string)max((unsigned)l.port_end_dt, 			(unsigned)r.port_end_dt));
		self.porting_dt								:= if(l.porting_dt > r.porting_dt, l.porting_dt, 										r.porting_dt);
		self 													:= r;
	end;

	aggrTrans_r			:= rollup(aggrTrans_s, 
														left.groupid = right.groupid, 
														roll(left, right), local);
	
	//Reformat to iConectiv Base Layout (Service Providers will now be populated in the Metadata Base)
	PhonesInfo.Layout_iConectiv.Main remED(aggrTrans_r l):= transform
		self.port_end_dt							:= if(l.is_ported, '', l.port_end_dt);
		self.service_provider					:= '';
		self													:= l;
	end;
	
	fixEnd 					:= project(aggrTrans_r, remED(left));
	
	//Reformat to Metadata Base
	//Adapted from PhonesInfo.PhonesInfo.Map_Common_Port_Main
	
	//Rollup Records w/ Updates <= 3 Days
	rllUpdate				:= sort(distribute(fixEnd, hash(phone)), phone, spid, porting_dt, port_start_dt, routing_code, -vendor_last_reported_dt, local);	
		
	rllUpdate newDate(rllUpdate l, rllUpdate r) := transform
				
				minDate	:= ut.min2((unsigned)l.vendor_first_reported_dt,(unsigned)r.vendor_first_reported_dt);
				maxDate	:= max((unsigned)l.vendor_last_reported_dt, 		(unsigned)r.vendor_last_reported_dt);
				minStart:= ut.min2((unsigned)l.port_start_dt, 					(unsigned)r.port_start_dt);
				maxEnd	:= max((unsigned)l.port_end_dt, 								(unsigned)r.port_end_dt);

		self.vendor_first_reported_dt := (string)minDate;
		self.vendor_last_reported_dt  := (string)maxDate;
		self.port_start_dt					 	:= (string)minStart;
		//Pull Active Records First
		self.port_end_dt							:= if(l.port_end_dt='' or r.port_end_dt='', '', (string)maxEnd);
		self.is_ported								:= if(l.port_end_dt='' and l.is_ported=TRUE or 
																				r.port_end_dt='' and r.is_ported=TRUE, 
																				TRUE, FALSE);
		self 													:= l;
	end;
			
	applyRollupDates	:= rollup(rllUpdate, 
															left.phone = right.phone and
															left.spid = right.spid and
															left.porting_dt = right.porting_dt and
															left.port_start_dt = right.port_start_dt and
															left.routing_code = right.routing_code and
															//<3 day gap to account for holidays
															(ut.YYYYMMDDtoJulian((string8)left.port_end_dt)-ut.YYYYMMDDtoJulian((string8)right.vendor_first_reported_dt) between -3 and 0),
															newDate(left, right), local);
																			
	//Map to Common Layout
	PhonesInfo.Layout_Common.portedMain iConectM(applyRollupDates l):= transform
		self.source 										:= 'PK';
		self.porting_dt									:= (unsigned) stringlib.stringfilter(l.porting_dt, '0123456789')[1..8];
		self.porting_time								:= stringlib.stringfilter(l.porting_dt, '0123456789')[9..14];
		self.phoneType									:= '';
		self.vendor_first_reported_dt 	:= (unsigned) l.vendor_first_reported_dt[1..8];
		self.vendor_first_reported_time	:= l.vendor_first_reported_dt[9..14];
		self.vendor_last_reported_dt		:= (unsigned) l.vendor_last_reported_dt[1..8];
		self.vendor_last_reported_time	:= l.vendor_last_reported_dt[9..14];
		self.port_start_dt							:= (unsigned) l.port_start_dt[1..8];
		self.port_start_time						:= l.port_start_dt[9..14];
		self.port_end_dt								:= (unsigned) l.port_end_dt[1..8];
		self.port_end_time							:= l.port_end_dt[9..14];
		self.remove_port_dt							:= (unsigned) l.remove_port_dt[1..8];
		self 														:= l;
	end;

	iConectComm 			:= dedup(sort(project(applyRollupDates, iConectM(left)), record, local), record, local);
		
	//Map Ported Base to Common Layout - Append Serv/Line/Carrier Names from Reference Table
	//Adapted from PhonesInfo.Map_Ported_Metadata_Main
	srcRef						:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);

	sortSPID					:= sort(distribute(srcRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
	sortiCon					:= sort(distribute(iConectComm(source='PK'), hash(spid)), spid, local);
			
	//iConectiv File
	PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
		self.serv 											:= r.serv;
		self.line												:= r.line;	
		self.high_risk_indicator				:= r.high_risk_indicator;
		self.prepaid										:= r.prepaid;	
		self.operator_fullname 					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
		self.is_ported									:= if(l.port_end_dt not in [0], false, l.is_ported);
		self 														:= l;
	end;
			
	addiConON 				:= join(sortiCon, sortSPID,
														left.spid = right.spid,
														addiConSL(left, right), left outer, local, keep(1));
																			
	//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
	//There are a few instances where there are multiple ocns for a spid
	srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
	srtRefOFN_match		:= sort(distribute(srcRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
			
	PhonesInfo.Layout_Common.portedMetadata_Main addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 														:= l;
	end;
		
	addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
														left.spid = right.spid and
														PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
														addiCOFNTr(left, right), left outer, local, keep(1));	
		
	//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
	srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
	srtRefRem					:= sort(distribute(srcRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
	
	PhonesInfo.Layout_Common.portedMetadata_Main addiRemTr(srtAddiCRem l, srtRefRem r):= transform
		self.account_owner							:= r.ocn;
		self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
		self 														:= l;
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