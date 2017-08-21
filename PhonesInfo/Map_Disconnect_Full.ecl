import std, ut;

ds 				:= PhonesInfo.File_Deact.History;

	//Map Daily Files To Common Layout
		PhonesInfo.Layout_Deact.Temp fixF(ds l, unsigned c):= transform
				
			trFilename 		:= std.str.findreplace(trim(l.filename, left, right), '.txt', '');
			truncFilename := trFilename[27..]; 
			
			self.vendor_first_reported_dt	:= if(trFilename[length(trFilename)-7..]<>'', (unsigned)trFilename[length(trFilename)-7..], 0);
			self.vendor_last_reported_dt	:= if(trFilename[length(trFilename)-7..]<>'', (unsigned)trFilename[length(trFilename)-7..], 0);
			self.carrier_name							:= trim(map(std.str.find(truncFilename, 'att', 1)<>0 			=> 'ATT',
																								std.str.find(truncFilename, 'sprint', 1)<>0 	=> 'SPRINT',
																								std.str.find(truncFilename, 'tmobile', 1)<>0 	=> 'TMOBILE',
																								std.str.find(truncFilename, 'uscc', 1)<>0 		=> 'USCC',
																								std.str.find(truncFilename, 'verizon', 1)<>0 	=> 'VERIZON',
																								std.str.find(truncFilename, 'clearsky', 1)<>0 => 'CLEARSKY',
																								''), left, right);		
			self.filedate									:= trFilename[length(trFilename)-7..];
			self.swap_start_dt						:= if(l.action_code in ['SW'], (unsigned)l.timestamp, 0);
			self.swap_end_dt							:= if(l.action_code in ['SW'], (unsigned)l.timestamp, 0);
			self.deact_code								:= if(l.action_code in ['DE','SU'], l.action_code, '');
			self.deact_start_dt						:= if(l.action_code in ['DE','SU'], (unsigned)l.timestamp, 0);
			self.deact_end_dt							:= if(l.action_code in ['DE','SU'], (unsigned)l.timestamp, 0);
			self.react_start_dt						:= if(l.action_code in ['RE'], (unsigned)l.timestamp, 0);
			self.react_end_dt							:= if(l.action_code in ['RE'], (unsigned)l.timestamp, 0);
			self.porting_dt								:= 0;
			self.groupid									:= c;
			self 													:= l;
		end;

inFile	:= project(ds, fixF(left, counter));
	
	//CREATE ROLLED UP DAILY FILE
	fixFields_d 		:= distribute(inFile, hash(phone));
	fixFields_s 		:= sort(fixFields_d, phone, -(integer)timestamp, carrier_name, -if(action_code in ['DE', 'SU'], 1, 2), local);
	fixFields_g 		:= group(fixFields_s, phone);
	
	PhonesInfo.Layout_Deact.Temp iter1(fixFields_g l, fixFields_g r) := transform
	//conditions to determine when to rollup into one record
		sameCarrierDate			:= l.carrier_name = r.carrier_name 	and l.timestamp[1..8] = r.timestamp[1..8];
		consecDESU 					:= l.action_code in ['DE','SU'] 		and r.action_code in ['DE','SU'];
		REafterDESU 				:= r.action_code in ['DE','SU'] 		and l.action_code in ['RE'];
		SWafterDESU					:= r.action_code in ['DE','SU'] 		and l.action_code in ['SW'];
			
		consecRE 						:= l.action_code in ['RE'] 					and r.action_code in ['RE'];
		
		DESUafterRE 				:= r.action_code in ['RE'] 					and l.action_code in ['DE','SU'];
		SWafterRE						:= r.action_code in ['RE'] 					and l.action_code in ['SW'];

		consecSW 						:= l.action_code in ['SW'] 					and r.action_code in ['SW'];
		DESUafterSW					:= r.action_code in ['SW'] 					and l.action_code in ['DE','SU'];
		REafterSW						:= r.action_code in ['SW'] 					and l.action_code in ['RE'];

		isLastDESU 					:= l.phone <> r.phone 							and r.action_code in ['DE','SU'];
		isLastRE 						:= l.phone <> r.phone 							and r.action_code in ['RE'];
		isLastSW 						:= l.phone <> r.phone 						  and r.action_code in ['SW'];
			
	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 				:= if(((consecDESU or consecRE or SWafterDESU or SWafterRE) and sameCarrierDate) or
															 (consecSW and sameCarrierDate and l.phone_swap = r.phone_swap) or
															 (REafterDESU and l.carrier_name = r.carrier_name), l.groupid, 
															r.groupid); 
		self.deact_code			:= r.deact_code;		
		self.deact_end_dt 	:= if(isLastDESU, 0, 
															if(consecDESU and ~sameCarrierDate, l.deact_start_dt, 
															if(REafterDESU and ~sameCarrierDate, l.react_start_dt,
															if(SWafterDESU and ~sameCarrierDate, l.swap_start_dt,
															r.deact_end_dt))));	
		self.react_end_dt 	:= if(isLastRE, 0, 
															if(consecRE and ~sameCarrierDate, l.react_start_dt, 
															if(DESUafterRE and ~sameCarrierDate, l.deact_start_dt,
															if(SWafterRE and ~sameCarrierDate, l.swap_start_dt,
															r.react_start_dt))));	
		self.swap_end_dt 		:= if(isLastSW, 0, 
															if(consecSW and ~sameCarrierDate, l.swap_start_dt,
															if(DESUafterSW and ~sameCarrierDate, l.deact_start_dt,
															if(REafterSW and ~sameCarrierDate, l.react_start_dt,
															r.swap_end_dt))));
		self.is_deact				:= if(isLastDESU or isLastSW, 'Y', 'N');
		self.is_react				:= if(isLastRE, 'Y', 'N');
		self 								:= r;
	end;		
			
	tagGroups 			:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 		:= ungroup(tagGroups);

	aggrTrans_d 		:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s			:= sort(aggrTrans_d, (integer)groupid, (integer)timestamp, carrier_name, if(action_code in ['DE', 'SU'], 1, 2),local);

	PhonesInfo.Layout_Deact.Temp roll(aggrTrans_s l, aggrTrans_s r) := transform	
		self.vendor_first_reported_dt 	:= ut.min2((unsigned)l.vendor_first_reported_dt,(unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 		:= max((unsigned)l.vendor_last_reported_dt,(unsigned)r.vendor_last_reported_dt);
		self.deact_start_dt							:= ut.min2((unsigned)l.deact_start_dt,(unsigned)r.deact_start_dt);
		self.react_start_dt							:= ut.min2((unsigned)l.react_start_dt,(unsigned)r.react_start_dt);
		self.swap_start_dt							:= ut.min2((unsigned)l.swap_start_dt,(unsigned)r.swap_start_dt);
		self.deact_code									:= if(r.deact_code<>'', r.deact_code, l.deact_code);
		self.deact_end_dt								:= if(r.is_deact='Y', 0, 
																					if(l.deact_start_dt<>0 and l.deact_start_dt<r.react_start_dt, r.react_start_dt, 
																						max(l.deact_end_dt, r.deact_end_dt)));
		self.react_end_dt								:= if(r.is_react='Y', 0, 
																					if(l.react_start_dt<>0 and l.react_start_dt<r.deact_start_dt, r.deact_start_dt, 
																						max(l.react_end_dt, r.react_end_dt)));
		self.swap_end_dt								:= if(r.is_deact='Y' and r.swap_start_dt=0, 0,
																						if(l.swap_start_dt<>0 and l.swap_start_dt<r.deact_start_dt, r.deact_start_dt,
																						if(l.swap_start_dt<>0 and l.swap_start_dt<r.react_start_dt, r.react_start_dt,
																						if(r.is_deact='Y' and l.swap_start_dt<>0 and l.swap_start_dt<r.swap_start_dt, 0,
																						max(l.swap_end_dt, r.swap_end_dt)))));
		self 														:= r;
	end;

	aggrTrans_r			:= rollup(aggrTrans_s, 
														left.groupid = right.groupid, 
														roll(left, right), local);
	
	PhonesInfo.Layout_Deact.Temp fixCode(aggrTrans_r l):= transform
		self.deact_code									:= if(l.deact_code<>'' and l.deact_start_dt<>0, l.deact_code, '');
		self														:= l;
	end;
	
	fixDeactcode		:= project(aggrTrans_r, fixCode(left));
	ddConcat				:= dedup(sort(distribute(fixDeactcode, hash(phone)), record, local), record, local);	
	
	//APPEND PORT INFO TO ALL MATCHING PHONES (CURRENT & HISTORICAL)
		pR							:= PhonesInfo.File_Phones.Ported_Current; 
		portRec 				:= sort(distribute(pR((source='PJ' and vendor_first_reported_dt<=20150308) or source='PK'), hash(phone)), phone, port_start_dt, local);	
		discARec				:= sort(distribute(ddConcat, hash(phone)), phone, deact_start_dt, swap_start_dt, local);

		PhonesInfo.Layout_Deact.Temp addCd(discARec l, portRec r):= transform
		
			//Codes Translations:	
			//P - Ported
			//Y - Active Deact/React
			//N - Nonactive Deact/React
		
				deacMatch 		:= if(l.deact_start_dt<>0 and r.port_start_dt<>0 and (ut.YYYYMMDDtoJulian(((string)l.deact_start_dt)[1..8])-ut.YYYYMMDDtoJulian(((string)r.port_start_dt)[1..8]) between -1 and 1),
														TRUE,
														FALSE);		
				swapMatch			:= if(l.swap_start_dt<>0 and r.port_start_dt<>0 and (ut.YYYYMMDDtoJulian(((string)l.swap_start_dt)[1..8])-ut.YYYYMMDDtoJulian(((string)r.port_start_dt)[1..8]) between -1 and 1),
														TRUE,
														FALSE);
									
			self.is_deact 	:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacMatch=TRUE and l.deact_code in ['DE','SU'], 'P',
														if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapMatch=TRUE and l.swap_start_dt<>0, 'P',
														l.is_deact));
			self.is_react 	:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacMatch=TRUE and l.deact_code in ['DE','SU'], 'P',
														if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapMatch=TRUE and l.swap_start_dt<>0, 'P',
														l.is_react));
			self.porting_dt := if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacMatch=TRUE and l.deact_code in ['DE','SU'], r.porting_dt,
														if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapMatch=TRUE and l.swap_start_dt<>0 and l.swap_end_dt=0, r.porting_dt,
														0));
			self 						:= l;
		end;
	
		portMatch 	:= dedup(sort(distribute(join(discARec, portRec,
																					left.phone = right.phone and
																					((ut.YYYYMMDDtoJulian(((string)left.deact_start_dt)[1..8])-ut.YYYYMMDDtoJulian(((string)right.port_start_dt)[1..8]) between -1 and 1) or
																					(ut.YYYYMMDDtoJulian(((string)left.swap_start_dt)[1..8])-ut.YYYYMMDDtoJulian(((string)right.port_start_dt)[1..8]) between -1 and 1)),
																					addCd(left, right), left outer, local), hash(phone)), record, local), record, except porting_dt, local);
		
EXPORT Map_Disconnect_Full := portMatch;