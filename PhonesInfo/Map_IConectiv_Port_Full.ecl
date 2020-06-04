import std, ut;	
	
	//Pull Existing History w/ Newly Concatenated Daily
		dailyInput 		:= PhonesInfo.File_iConectiv.In_Port_Daily_History;

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
				self.vendor_last_reported_dt 			:= (string)max((unsigned)l.vendor_last_reported_dt, 						(unsigned)r.vendor_last_reported_dt);
				self.port_start_dt								:= (string)ut.min2((unsigned)l.port_start_dt, 											(unsigned)r.port_start_dt);
				self.port_end_dt									:= if(self.is_ported, '', (string)max((unsigned)l.port_end_dt, 	(unsigned)r.port_end_dt));
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

EXPORT Map_IConectiv_Port_Full := dedup(sort(distribute(fixEnd, hash(phone)), record, local), record, local);	