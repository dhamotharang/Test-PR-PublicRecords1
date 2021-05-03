IMPORT Std, Ut;
	
	commonInput		:= PhonesInfo.Map_Common_Shared_PortData_Validate;
	
	distr_inFile 	:= distribute(commonInput, hash(phone));
	srt_inFile 		:= sort(distr_inFile, phone, -port_start_dt, -file_dt_time, if(action_code in ['A','U'], 2, 1) ,local);
	gp_inFile 		:= group(srt_inFile, phone);
	
	//Treat Adds and Updates the Same
	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate iter1(gp_inFile l, gp_inFile r) := transform
			
			//Conditions to determine when to rollup into one record
			consecutiveA 				:= l.action_code in ['A'] and r.action_code in ['A'];
			sameSpid 						:= l.spid = r.spid;	
			samePhPortDt				:= l.phone = r.phone and l.port_start_dt[1..8] = r.port_start_dt[1..8];
			DafterA 						:= r.action_code in ['A'] and l.action_code = 'D';
			isLastA 						:= l.phone <> r.phone and r.action_code in ['A'];

		//Transactions to be rolled up into one record have the same groupid	
		self.groupid 				:= if((consecutiveA and sameSpid) or (DafterA and sameSpid), l.groupid, r.groupid);
		self.port_end_dt 		:= if(isLastA, '', 
															if(r.is_ported=TRUE, l.port_start_dt, r.port_end_dt));			      
		self.is_ported 			:= if(isLastA, true, false);				
		self 								:= r;
	end;
			
	tagGroups 		:= iterate(gp_inFile, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);

		//Rollup Records by groupid
		aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
		aggrTrans_s		:= sort(aggrTrans_d, groupid, port_start_dt, file_dt_time, if(action_code in ['A'], 1, 2) ,local);
	
	PhonesInfo.Layout_iConectiv.Intermediate_PortData_Validate roll(aggrTrans_s l, aggrTrans_s r) := transform
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
	
	//Reformat to iConectiv Base Layout
	PhonesInfo.Layout_iConectiv.Main_PortData_Validate remED(aggrTrans_r l):= transform
		self.port_end_dt									:= if(l.is_ported, '', l.port_end_dt);
		self.service_provider							:= '';
		self.alt_service_provider					:= '';
		self.lalt_service_provider				:= '';	
		self															:= l;
	end;
	
	fixEnd 				:= project(aggrTrans_r, remED(left));
	
EXPORT Map_PortData_Validate := fixEnd;