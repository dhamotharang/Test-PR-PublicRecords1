import std, ut;	
	
	//Pull Existing History w/ Newly Concatenated Daily
		dailyInput 		:= Reformat_Port_Input(file_dt_time[1..8]>='20150308');
	
		inFile_d 			:= distribute(dailyInput, hash(phone));
		inFile_s 			:= sort(inFile_d, phone, -port_start_dt, -file_dt_time, -uniqueid, if(action_code in ['A','U'], 2, 1), local);
		inFile_g 			:= group(inFile_s, phone);
	
	//Treat Adds and Updates the Same
		tempLayout := record
			PhonesInfo.Layout_iConectiv.Intermediate;
			integer uniqueid;
			string ocn;
		end;
	
		tempLayout iter1(inFile_g l, inFile_g r) := transform
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
		aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid, phone));
		aggrTrans_s		:= sort(aggrTrans_d, groupid, phone, port_start_dt, file_dt_time, uniqueid, if(action_code in ['A','U'], 1, 2), local);
	
		tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform
			self.is_ported										:= if(l.is_ported or r.is_ported, true, 														r.is_ported);
			self.vendor_first_reported_dt 		:= (string)ut.min2((unsigned)l.vendor_first_reported_dt, 						(unsigned)r.vendor_first_reported_dt);
			self.vendor_last_reported_dt 			:= (string)max((unsigned)l.vendor_last_reported_dt, 								(unsigned)r.vendor_last_reported_dt);
			self.port_start_dt								:= (string)ut.min2((unsigned)l.port_start_dt, 											(unsigned)r.port_start_dt);
			self.port_end_dt									:= if(self.is_ported, '', (string)max((unsigned)l.port_end_dt, 			(unsigned)r.port_end_dt));
			self.porting_dt										:= if(l.porting_dt > r.porting_dt, l.porting_dt, 										r.porting_dt);
			self 															:= r;
		end;

		aggrTrans_r		:= rollup(aggrTrans_s, 
														left.groupid = right.groupid and
														left.phone = right.phone, 
														roll(left, right), local);
	
	//Reformat to iConectiv Base Layout (Service Providers will now be populated in the Metadata Base)
		PhonesInfo.Layout_iConectiv.Main remED(aggrTrans_r l):= transform
			self.port_end_dt									:= if(l.is_ported, '', l.port_end_dt);
			self.service_provider							:= '';
			self															:= l;
		end;
	
	fixEnd 					:= project(aggrTrans_r, remED(left));

EXPORT Map_Combined_Port_Full := dedup(sort(distribute(fixEnd, hash(phone)), record, local), record, local);	