//PORTED DELTA FILE PROCESS 
//Pulls only the iConectiv delta files and rolls up the records
//Delete records are kept
//History is not kept

import std, ut;	

EXPORT Map_Ported_Metadata_DeltaFile(string version):= FUNCTION 

	//Adapted from PhonesInfo.Map_IConectiv_Port_Full

	//POPULATE & REFORMAT DATES - DAILY FILE	
		dailyInput 		:= distribute(PhonesInfo.File_Metadata_Delta.In_Port_DailyDelta(action_code in ['A','D','U']));

	//Reformat Dates & Add Counter
		PhonesInfo.Layout_iConectiv.Intermediate fixFile(dailyInput l, unsigned c):= transform
				init_dt 							:= l.filename[std.str.Find(l.filename, '_init_', 1)+6..std.str.Find(l.filename, '_init_', 1)+20];
				incr_dt 							:= l.filename[std.str.Find(l.filename, 'mid_102_', 1)+8..std.str.Find(l.filename, 'mid_102_', 1)+22];
						
				f_dt_time							:=  if(std.str.Find(l.filename, '_init_', 1 ) > 0,
																			PhonesInfo._Functions.fn_FixTimeStamp(init_dt),
																			incr_dt);
					
				f_port_dt							:= stringlib.stringfilter(l.porting_dt, '0123456789');	
				
			self.filename											:= l.filename[stringlib.stringfind(l.filename, 'mid', 1)..stringlib.stringfind(l.filename, '.csv', 1)-1];					
			self.file_dt_time									:= std.str.FindReplace(f_dt_time,'_', '');
			self.vendor_first_reported_dt			:= if(self.file_dt_time<>'', self.file_dt_time, '');
			self.vendor_last_reported_dt			:= if(self.file_dt_time<>'', self.file_dt_time, '');	
			self.port_start_dt								:= f_port_dt;
			self.port_end_dt									:= f_port_dt;
			self.remove_port_dt								:= if(l.action_code = 'D', f_port_dt, '');
			self.groupid 											:= c;
			self.is_ported                    := if(l.action_code in['A','U'], true, false);
			self 															:= l;
		end;

	input := project(dailyInput, fixFile(left, counter))(file_dt_time[1..8]>='20150308');
	
	inFile_d 			:= distribute(input, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, -port_start_dt, -file_dt_time, if(action_code in ['A','U'], 2, 1) ,local);
	inFile_g 			:= group(inFile_s, phone);
	
	//Treat Adds and Updates the Same
		PhonesInfo.Layout_iConectiv.Intermediate iter1(inFile_g l, inFile_g r) := transform
			//Conditions to determine when to rollup into one record
				consecutiveAorU 		:= l.action_code in ['A','U'] and r.action_code in ['A','U'];
				sameSpidandRouting 	:= l.spid = r.spid and l.routing_code = r.routing_code;
				DafterAorU 					:= r.action_code in ['A','U'] and l.action_code = 'D';
				isLastAorU 					:= l.phone <> r.phone and r.action_code in ['A','U'];

			//Transactions to be rolled up into one record have the same groupid	
				self.groupid 				:= if((consecutiveAorU and sameSpidandRouting) or (DafterAorU and sameSpidandRouting), l.groupid, r.groupid);
				self.port_end_dt 		:=  if(isLastAorU, '', 
																	if(r.is_ported=TRUE, l.port_start_dt, r.port_end_dt));			      
				self.is_ported 			:= if(isLastAorU, true, false);				
				self 								:= r;
		end;
			
	tagGroups 		:= iterate(inFile_g, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);

	//Rollup Records by Groupid
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, groupid, port_start_dt, file_dt_time, if(action_code in ['A','U'], 1, 2) ,local);
	
		PhonesInfo.Layout_iConectiv.Intermediate roll(aggrTrans_s l, aggrTrans_s r) := transform
				self.is_ported										:= if(l.is_ported or r.is_ported, true, 														r.is_ported);
				self.vendor_first_reported_dt 		:= (string)ut.min2((unsigned)l.vendor_first_reported_dt, 						(unsigned)r.vendor_first_reported_dt);
				self.vendor_last_reported_dt 			:= (string)ut.max2((unsigned)l.vendor_last_reported_dt, 						(unsigned)r.vendor_last_reported_dt);
				self.port_start_dt								:= (string)ut.min2((unsigned)l.port_start_dt, 											(unsigned)r.port_start_dt);
				self.port_end_dt									:= if(self.is_ported, '', (string)ut.max2((unsigned)l.port_end_dt, 	(unsigned)r.port_end_dt));
				self.porting_dt										:= if(l.porting_dt > r.porting_dt, l.porting_dt, 										r.porting_dt);
				self 															:= r;
		end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);
	
	//Reformat to iConectiv Base Layout (Service Providers will now be populated in the Metadata Base)
		PhonesInfo.Layout_iConectiv.Main remED(aggrTrans_r l):= transform
				self.port_end_dt									:= if(l.is_ported, '', l.port_end_dt);
				self.service_provider							:= '';
				self															:= l;
		end;
	
	fixEnd 				:= project(aggrTrans_r, remED(left));
	
	//Reformat to Metadata Base
	//Adapted from PhonesInfo.PhonesInfo.Map_Common_Port_Main
	
	//Rollup Records w/ Updates <= 3 Days
		rllUpdate	:= sort(distribute(fixEnd, hash(phone)), phone, spid, porting_dt, port_start_dt, routing_code, -vendor_last_reported_dt, local);	
		
		rllUpdate newDate(rllUpdate l, rllUpdate r) := transform
				
				minDate	:= ut.min2((unsigned)l.vendor_first_reported_dt, 	(unsigned)r.vendor_first_reported_dt);
				maxDate	:= ut.max2((unsigned)l.vendor_last_reported_dt, 	(unsigned)r.vendor_last_reported_dt);
				minStart:= ut.min2((unsigned)l.port_start_dt, 						(unsigned)r.port_start_dt);
				maxEnd	:= ut.max2((unsigned)l.port_end_dt, 							(unsigned)r.port_end_dt);

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
																			left.routing_code = right.routing_code and
																			//<3 day gap to account for holidays
																			(ut.YYYYMMDDtoJulian((string8)left.port_end_dt)-ut.YYYYMMDDtoJulian((string8)right.vendor_first_reported_dt) between -3 and 0),
																			newDate(left, right), local);
																			
	//Map to Common Layout
	PhonesInfo.Layout_Common.portedMain iConectM(applyRollupDates l):= transform
		self.source 											:= 'PK';
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

		sortSPID		:= sort(distribute(PhonesInfo.File_Source_Reference.Main(is_current=TRUE), hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
		sortiCon		:= sort(distribute(iConectComm(source='PK'), hash(spid)), spid, local);
		
		//iConectiv File
		PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
			self.serv 							:= r.serv;
			self.line								:= r.line;	
			self.high_risk_indicator:= r.high_risk_indicator;
			self.prepaid						:= r.prepaid;	
			self.operator_fullname 	:= r.carrier_name;
			self.is_ported					:= if(l.port_end_dt not in [0], false, l.is_ported);
			self 										:= l;
		end;
			
		addiConFields 						:= join(sortiCon, sortSPID,
																			left.spid = right.spid,
																			addiConSL(left, right), left outer, local, keep(1));

		ddiConAddFields 					:= dedup(sort(distribute(addiConFields, hash(phone)), record, local), record, local);
		
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