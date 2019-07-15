IMPORT dx_PhonesInfo, Mdr, PhonesInfo, Std, Ut;

	//DF-24397: Create Dx-Prefixed Keys
	//DF-24599: Add Transaction_Count, Transaction_End_Dt & Transaction_End_Time Fields to Transaction File
	//DF-25056: PhonesInfo Update Phone Transaction Logic - Account for Porting_Dt Changes

	//Pull Existing History w/ Newly Concatenated Daily
		dailyInput 		:= PhonesInfo.File_iConectiv.In_Port_Daily_History(action_code in ['A','U','D'] and porting_dt<>'');

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

	inputF := project(dailyInput, fixFile(left, counter))(file_dt_time[1..8]>='20150308');
	
	inFile_d 			:= distribute(inputF, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, -port_start_dt, -file_dt_time, if(action_code in ['A','U'], 2, 1) ,local);
	inFile_g 			:= group(inFile_s, phone);
	
	//Treat Adds and Updates the Same
		PhonesInfo.Layout_iConectiv.Intermediate iter1(inFile_g l, inFile_g r) := transform
			
			//Conditions to determine when to rollup into one record
				consecutiveAorU 		:= l.action_code in ['A','U'] and r.action_code in ['A','U'];
				sameSpidRoutPortDt 	:= l.spid = r.spid and l.routing_code = r.routing_code  and l.port_start_dt = r.port_start_dt;
				DafterAorU 					:= r.action_code in ['A','U'] and l.action_code = 'D';
				isLastAorU 					:= l.phone <> r.phone and r.action_code in ['A','U'];

			//Transactions to be rolled up into one record have the same groupid	
				self.groupid 				:= if((consecutiveAorU and sameSpidRoutPortDt), l.groupid, r.groupid);
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
				self.is_ported										:= if(l.is_ported or r.is_ported, true, 												r.is_ported);
				self.vendor_first_reported_dt 		:= (string)ut.min2((unsigned)l.vendor_first_reported_dt, 				(unsigned)r.vendor_first_reported_dt);
				self.vendor_last_reported_dt 			:= (string)max((unsigned)l.vendor_last_reported_dt, 						(unsigned)r.vendor_last_reported_dt);
				self.port_start_dt								:= (string)ut.min2((unsigned)l.port_start_dt, 									(unsigned)r.port_start_dt);
				self.port_end_dt									:= if(self.is_ported, '', (string)max((unsigned)l.port_end_dt, 	(unsigned)r.port_end_dt));
				self.porting_dt										:= if(l.porting_dt > r.porting_dt, l.porting_dt, 								r.porting_dt);
				self 															:= r;
		end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);
	
	//////////////////////////////////////////////////////////////	
	//Transform File to Transaction Base Layout///////////////////
	//////////////////////////////////////////////////////////////
	dx_PhonesInfo.Layouts.Phones_Transaction_Main fixTr(aggrTrans_r l):= transform
		self.source											:= Mdr.sourceTools.Src_PhonesPorted_iConectiv; //PK	
		self.transaction_code						:= map(	l.action_code = 'A' => PhonesInfo.TransactionCode.PortAdd, 	  //PA - Add
																						l.action_code = 'U' => PhonesInfo.TransactionCode.PortAdd,		//PA - Update/Add
																						l.action_code = 'D' => PhonesInfo.TransactionCode.PortDelete,	//PD - Delete
																						'');
		self.vendor_first_reported_dt		:= (integer)(((string)l.vendor_first_reported_dt)[1..8]);
		self.vendor_first_reported_time	:= ((string)l.vendor_first_reported_dt)[9..];
		self.vendor_last_reported_dt		:= (integer)(((string)l.vendor_last_reported_dt)[1..8]);
		self.vendor_last_reported_time 	:= ((string)l.vendor_last_reported_dt)[9..];
		self.transaction_start_dt				:= (integer)l.port_start_dt[1..8];
		self.transaction_start_time			:= l.port_start_dt[9..];
		self.transaction_end_dt					:= (integer)l.port_end_dt[1..8];
		self.transaction_end_time				:= l.port_end_dt[9..];
		self.transaction_count					:= 0;
		self.carrier_name								:= '';
		self.phone_swap									:= '';
		self.ocn												:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;
	
	outFile 			:= project(aggrTrans_r, fixTr(left));
	
	//Add Record SID
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(outFile l) := transform
		self.transaction_code						:= if(l.transaction_code = PhonesInfo.TransactionCode.PortUpdate,
																					'PA',
																					l.transaction_code);
		self.record_sid									:= hash64(Mdr.sourceTools.Src_PhonesPorted_iConectiv + l.transaction_code + 
																							l.transaction_start_dt + l.transaction_start_time + 
																							l.transaction_end_dt + l.transaction_end_time + 
																							l.vendor_first_reported_dt + l.vendor_first_reported_time + 
																							l.routing_code + l.spid) + (integer)l.phone;
		self														:= l;
	end;
	
	addID					:= project(outFile, trID(left));

	//Dedup Results
	ddRec					:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);
	
EXPORT Remap_ICPort_File := ddRec;