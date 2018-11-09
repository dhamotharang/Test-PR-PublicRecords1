import std, ut;

ds := PhonesInfo.File_Deact.History2;

		modRaw := record
			PhonesInfo.Layout_Deact.Raw;
			string changeid;
			string operatorid;
		end;

	//Convert Current Raw File To Previous Raw Layout
		modRaw conF(ds l)	:= transform	
			self.action_code	:= PhonesInfo._Functions.fn_FindActCode(stringlib.stringfilter(l.msisdneid, '0123456789'));
			self.timestamp			:= stringlib.stringfilter(l.timestamp, '0123456789');
			self.phone							:= l.msisdn[2..];
			self.phone_swap		:= l.msisdnnew[2..];
			self.changeid				:= l.changeid;
			self.operatorid		:= l.operatorid;
			self.filename				:= '';
		end;

	fixLayout := project(ds, conF(left));
	
	//Append Operator Name	
	srt_fix			:= sort(distribute(fixLayout, hash(operatorid)), operatorid, local);
	srt_his			:= sort(distribute(PhonesInfo.File_Deact.OIDMain, hash(operatorid)), operatorid, local);
	
		modRaw addOp(srt_fix l, srt_his r):= transform
			self.filename				:= trim(stringlib.stringtouppercase(
																									map(regexfind('ATT', r.operatorname, 0)<>'' 					=> 'ATT',
																													regexfind('Sprint', r.operatorname, 0)<>'' 		=> 'SPRINT',
																													regexfind('T-Mobile', r.operatorname, 0)<>'' => 'TMOBILE',
																													regexfind('Verizon', r.operatorname, 0)<>'' 	=> 'VERIZON',
																													r.operatorname)), left, right)+'_'+l.timestamp[1..8];
			self 												:= l;
		end;
	
		convPrev 	:= join(srt_fix, srt_his,
																				left.operatorid = right.operatorid,
																				addOp(left, right), left outer, local);

	//Map Daily Files To Common Layout
		PhonesInfo.Layout_Deact.Temp2 fixF(convPrev l, unsigned c):= transform
			trimFile := trim(l.filename, left, right);
			
			self.vendor_first_reported_dt	:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
			self.vendor_last_reported_dt		:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
			self.carrier_name													:= trimFile[1..length(trimFile)-9];		
			self.filedate																	:= trimFile[length(trimFile)-7..] ;
			self.swap_start_dt												:= if(l.action_code in ['SW'], (unsigned)l.timestamp, 0);
			self.swap_end_dt														:= if(l.action_code in ['SW'], (unsigned)l.timestamp, 0);
			self.deact_code															:= if(l.action_code in ['DE','SU'], l.action_code, '');
			self.deact_start_dt											:= if(l.action_code in ['DE','SU'], (unsigned)l.timestamp, 0);
			self.deact_end_dt													:= if(l.action_code in ['DE','SU'], (unsigned)l.timestamp, 0);
			self.react_start_dt											:= if(l.action_code in ['RE'], (unsigned)l.timestamp, 0);
			self.react_end_dt													:= if(l.action_code in ['RE'], (unsigned)l.timestamp, 0);
			self.porting_dt															:= 0;
			self.groupid																		:= c;
			self.pk_carrier_name										:= '';
			self.days_apart															:= 0;
			self 																									:= l;
		end;

inFile	:= project(convPrev, fixF(left, counter));
	
	//CREATE ROLLED UP DAILY FILE
	fixFields_d 		:= distribute(inFile, hash(phone));
	fixFields_s 		:= sort(fixFields_d, phone, -(integer)changeid, carrier_name, -if(action_code in ['DE', 'SU'], 1, 2), local);
	fixFields_g 		:= group(fixFields_s, phone);
	
	PhonesInfo.Layout_Deact.Temp2 iter1(fixFields_g l, fixFields_g r) := transform
	//conditions to determine when to rollup into one record
		sameCarrierDate	:= l.carrier_name = r.carrier_name 	and l.timestamp[1..8] = r.timestamp[1..8];
		consecDESU 					:= r.action_code in ['DE','SU'] and l.action_code in ['DE','SU'];
		REafterDESU 				:= r.action_code in ['DE','SU'] and l.action_code in ['RE'];
		SWafterDESU					:= r.action_code in ['DE','SU'] and l.action_code in ['SW'];
			
		consecRE 							:= r.action_code in ['RE'] 					and l.action_code in ['RE'];
		
		DESUafterRE 				:= r.action_code in ['RE'] 					and l.action_code in ['DE','SU'];
		SWafterRE							:= r.action_code in ['RE'] 					and l.action_code in ['SW'];

		consecSW 							:= r.action_code in ['SW'] 					and l.action_code in ['SW'];
		DESUafterSW					:= r.action_code in ['SW'] 					and l.action_code in ['DE','SU'];
		REafterSW							:= r.action_code in ['SW'] 					and l.action_code in ['RE'];

		isLastDESU 					:= l.phone <> r.phone 										and r.action_code in ['DE','SU'];
		isLastRE 							:= l.phone <> r.phone 										and r.action_code in ['RE'];
		isLastSW 							:= l.phone <> r.phone 						  		and r.action_code in ['SW'];
			
	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 						:= if(((consecDESU or consecRE or SWafterDESU or SWafterRE) and sameCarrierDate) or
																										 (consecSW and sameCarrierDate and l.phone_swap = r.phone_swap) or
																										 (REafterDESU and l.carrier_name = r.carrier_name), l.groupid, 
																											r.groupid); 
		self.deact_code				:= r.deact_code;		
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
		self.is_deact						:= if(isLastDESU or isLastSW, 'Y', 'N');
		self.is_react						:= if(isLastRE, 'Y', 'N');
		self 														:= r;
	end;		
			
	tagGroups 						:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 			:= ungroup(tagGroups);

	aggrTrans_d 				:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s					:= sort(aggrTrans_d, (integer)groupid, (integer)changeid, carrier_name, if(action_code in ['DE', 'SU'], 1, 2),local);

	PhonesInfo.Layout_Deact.Temp2 roll(aggrTrans_s l, aggrTrans_s r) := transform	
		self.vendor_first_reported_dt 	:= ut.min2((unsigned)l.vendor_first_reported_dt,(unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 		:= MAX((unsigned)l.vendor_last_reported_dt,(unsigned)r.vendor_last_reported_dt);
		self.deact_start_dt												:= ut.min2((unsigned)l.deact_start_dt,(unsigned)r.deact_start_dt);
		self.react_start_dt												:= ut.min2((unsigned)l.react_start_dt,(unsigned)r.react_start_dt);
		self.swap_start_dt													:= ut.min2((unsigned)l.swap_start_dt,(unsigned)r.swap_start_dt);
		self.deact_code																:= if(r.deact_code<>'', r.deact_code, l.deact_code);
		self.deact_end_dt														:= if(r.is_deact='Y', 0, 
																																					if(l.deact_start_dt<>0 and l.deact_start_dt<r.react_start_dt, r.react_start_dt, 
																																						MAX(l.deact_end_dt, r.deact_end_dt)));
		self.react_end_dt														:= if(r.is_react='Y', 0, 
																																					if(l.react_start_dt<>0 and l.react_start_dt<r.deact_start_dt, r.deact_start_dt, 
																																						MAX(l.react_end_dt, r.react_end_dt)));
		self.swap_end_dt															:= if(r.is_deact='Y' and r.swap_start_dt=0, 0,
																																					if(l.swap_start_dt<>0 and l.swap_start_dt<r.deact_start_dt, r.deact_start_dt,
																																					if(l.swap_start_dt<>0 and l.swap_start_dt<r.react_start_dt, r.react_start_dt,
																																					if(r.is_deact='Y' and l.swap_start_dt<>0 and l.swap_start_dt<r.swap_start_dt, 0,
																																					MAX(l.swap_end_dt, r.swap_end_dt)))));
		self 																										:= r;
	end;

	aggrTrans_r						:= rollup(aggrTrans_s, 
																												left.groupid = right.groupid, 
																												roll(left, right), local);
	
	PhonesInfo.Layout_Deact.Temp2 fixCode(aggrTrans_r l):= transform
		self.deact_code	:= if(l.deact_code<>'' and l.deact_start_dt<>0, l.deact_code, '');
		self												:= l;
	end;
	
	fixDeactcode					:= project(aggrTrans_r, fixCode(left));
	ddConcat									:= dedup(sort(distribute(fixDeactcode, hash(phone)), record, local), record, local);	
	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//APPEND PORT INFO TO ALL MATCHING PHONES (CURRENT & HISTORICAL)/////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	pR									:= PhonesInfo.File_Phones.Ported_Current; 

	discARec			:= sort(distribute(ddConcat, hash(phone)), phone, deact_start_dt, swap_start_dt, local);
	
	//Find Carrier_Name
	ds_rf						:= PhonesInfo.File_Source_Reference.Main;
	srt_pk					:= sort(distribute(pR(source='PK'), hash(spid)), spid, local);
	srt_rf					:= sort(distribute(ds_rf, hash(spid)), spid, carrier_name, local);

	PhonesInfo.Layout_Common.portedMain addCn(srt_pk l, srt_rf r):= transform
		self.service_provider := r.carrier_name;	
		self 					:= l;
	end;

	fndCn 					:= join(srt_pk, srt_rf,
																				left.spid = right.spid,
																				addCn(left, right), left outer, local, keep(1));

	portRec 			:= sort(distribute(pR(source='PJ' and vendor_first_reported_dt<=20150308) + fndCn, hash(phone)), phone, port_start_dt, local);	
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//SET DEACT & REACT FLAGS////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////
	PhonesInfo.Layout_Deact.Temp addCd(discARec l, portRec r):= transform
		
		//Code translations for is_deact and is_react:	
		//P - Ported
		//Y - Active Deact/React
		//N - Nonactive Deact/React		
			
			dcDaysApt 							:= PhonesInfo._Functions.Daysapart(((string)l.deact_start_dt)[1..8],((string)r.port_start_dt)[1..8]);
			swDaysApt								:= PhonesInfo._Functions.Daysapart(((string)l.swap_start_dt)[1..8],((string)r.port_start_dt)[1..8]);
			
		//Condition 1: Flag records as "ported," when the difference between the deact_start_dt and port_start_dt is -1 to 5 days
			deacDtMatch_1_5 	:= if(l.deact_start_dt<>0 and r.port_start_dt<>0 and dcDaysApt between -1 and 5,
																										TRUE,
																										FALSE);		
			swapDtMatch_1_5		:= if(l.swap_start_dt<>0 and r.port_start_dt<>0 and swDaysApt between -1 and 5,
																										TRUE,
																										FALSE);
			
		//Condition 2: Flag records as "ported," when the difference between the deact_start_dt and port_start_dt is 6 to 30 days and 
		//the deact carrier_name is different than the port carrier_name	
			deacDtMatch_6_30 := if(l.deact_start_dt<>0 and r.port_start_dt<>0 and dcDaysApt between 6 and 30 and 
																										trim(l.carrier_name, left, right)<>'' and trim(r.service_provider, left, right)<>'' and 
																										trim(l.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(r.service_provider, left, right)),
																										TRUE,
																										FALSE);		
			swapDtMatch_6_30	:= if(l.swap_start_dt<>0 and r.port_start_dt<>0 and swDaysApt between 6 and 30 and 
																										trim(l.carrier_name, left, right)<>'' and trim(r.service_provider, left, right)<>'' and 
																										trim(l.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(r.service_provider, left, right)),
																										TRUE,
																										FALSE);
									
		self.is_deact 				:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_5=TRUE and l.deact_code in ['DE','SU'], 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_1_5=TRUE and l.swap_start_dt<>0, 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_6_30=TRUE and l.deact_code in ['DE','SU'], 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_6_30=TRUE and l.swap_start_dt<>0, 'P',
																										l.is_deact))));
		self.is_react 				:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_5=TRUE and l.deact_code in ['DE','SU'], 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_1_5=TRUE and l.swap_start_dt<>0, 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_6_30=TRUE and l.deact_code in ['DE','SU'], 'P',
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_6_30=TRUE and l.swap_start_dt<>0, 'P',
																										l.is_react))));
		self.porting_dt 		:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and (deacDtMatch_1_5=TRUE or deacDtMatch_6_30=TRUE) and l.deact_code in ['DE','SU'],
																										r.port_start_dt,
																										if(trim(l.phone, left, right) = trim(r.phone, left, right) and (swapDtMatch_1_5=TRUE or swapDtMatch_6_30=TRUE) and l.swap_start_dt<>0, 
																										r.port_start_dt,
																										0));														
		
		self.pk_carrier_name 	:= r.service_provider;	
		
		self.days_apart			:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_5=TRUE and l.deact_code in ['DE','SU'],
																										dcDaysApt,
																									if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_1_5=TRUE and l.swap_start_dt<>0, 
																										swDaysApt,
																									if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_6_30=TRUE and l.deact_code in ['DE','SU'],
																										dcDaysApt,
																									if(trim(l.phone, left, right) = trim(r.phone, left, right) and swapDtMatch_6_30=TRUE and l.swap_start_dt<>0, 
																										swDaysApt,
																										0)))),
		self 													:= l;
	end;
	
	portMatch 									:= dedup(sort(distribute(join(discARec, portRec,
																														left.phone = right.phone and
																														((PhonesInfo._Functions.Daysapart(((string)left.deact_start_dt)[1..8],((string)right.port_start_dt)[1..8]) between -1 and 5) or
																														 (PhonesInfo._Functions.Daysapart(((string)left.swap_start_dt)[1..8],((string)right.port_start_dt)[1..8]) between -1 and 5) or
																														 (PhonesInfo._Functions.Daysapart(((string)left.deact_start_dt)[1..8],((string)right.port_start_dt)[1..8]) between 6 and 30 and 
																															trim(left.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(right.service_provider, left, right)) and trim(left.carrier_name, left, right)<>'' and trim(right.service_provider, left, right)<>'') or
																														 (PhonesInfo._Functions.Daysapart(((string)left.swap_start_dt)[1..8],((string)right.port_start_dt)[1..8]) between 6 and 30 and 
																															trim(left.carrier_name, left, right)<>PhonesInfo._Functions.fn_keyCarrier(trim(right.service_provider, left, right)) and trim(left.carrier_name, left, right)<>'' and trim(right.service_provider, left, right)<>'')),
																														addCd(left, right), left outer, local), 
																														hash(phone)), 
																														phone, phone_swap, vendor_first_reported_dt, vendor_last_reported_dt, deact_start_dt, deact_end_dt, swap_start_dt, swap_end_dt, days_apart, local), 
																														record, except porting_dt, pk_carrier_name, days_apart, local);
		
EXPORT Map_Disconnect_Full := portMatch;