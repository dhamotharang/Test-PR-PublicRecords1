IMPORT dx_PhonesInfo, Mdr, PhonesInfo, Std, Ut;

	//Pull Existing History w/ Newly Concatenated Daily
	inputFile 		:= PhonesInfo.Map_Common_Shared_PortData_Validate; 
	
	distr_InFile 	:= distribute(inputFile, hash(phone));
	srt_InFile 		:= sort(distr_InFile, phone, -port_start_dt, -file_dt_time, if(action_code in ['A'], 2, 1) ,local);
	gp_inFile 		:= group(srt_InFile, phone);
	
		//Treat Adds and Updates the Same
		PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate iter1(gp_inFile l, gp_inFile r) := transform
			
			//Conditions to determine when to rollup into one record
				consecutiveA 			:= l.action_code in ['A'] and r.action_code in ['A'];
				samePhPortDt			:= l.phone = r.phone and l.port_start_dt = r.port_start_dt;
				DafterA 					:= r.action_code in ['A'] and l.action_code = 'D';
				isLastA 					:= l.phone <> r.phone and r.action_code in ['A'];

		//Transactions to be rolled up into one record have the same groupid	
			self.groupid 				:= if((consecutiveA and samePhPortDt), l.groupid, r.groupid);
			self.port_end_dt 		:= if(isLastA, '', 
																if(r.is_ported=TRUE, l.port_start_dt, r.port_end_dt));			      
			self.is_ported 			:= if(isLastA, true, false);				
			self 								:= r;
		end;
			
	tagGroups 		:= iterate(gp_inFile, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);
	
	//Rollup Records by Groupid
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, groupid, port_start_dt, file_dt_time, if(action_code in ['A'], 1, 2) ,local);
	
		PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate roll(aggrTrans_s l, aggrTrans_s r) := transform
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
		PhonesInfo.Layout_iConectiv.Phones_Transaction_Main_PDV fixTr(aggrTrans_r l):= transform
			self.source											:= Mdr.sourceTools.Src_PhonesPorted2_iConectiv; //P!	
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
		PhonesInfo.Layout_iConectiv.Phones_Transaction_Main_PDV trID(outFile l) := transform
			self.transaction_code						:= if(l.transaction_code = PhonesInfo.TransactionCode.PortUpdate,
																						'PA',
																						l.transaction_code);
			self.record_sid									:= hash64(Mdr.sourceTools.src_PhonesPorted2_iConectiv + l.transaction_code + 
																								l.transaction_start_dt + l.transaction_start_time + 
																								l.transaction_end_dt + l.transaction_end_time + 
																								l.vendor_first_reported_dt + l.vendor_first_reported_time + 
																								l.routing_code + l.spid) + (integer)l.phone;
			self														:= l;
		end;
	
	addID					:= project(outFile, trID(left));

	//Dedup Results
	ddRec					:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);
	
EXPORT Remap_Combined_PortData_Valid := ddRec;