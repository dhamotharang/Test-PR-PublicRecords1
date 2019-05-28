IMPORT dx_PhonesInfo, Mdr, Ut;

	//DF-24397: Create Dx-Prefixed Keys
	//DF-24599: Add Transaction_Count, Transaction_End_Dt & Transaction_End_Time Fields to Transaction File

//Pull Records from Deact History File
	deactHist 	:= PhonesInfo.File_Deact.History2;

	modRaw := record
		PhonesInfo.Layout_Deact.Raw;
		string changeid;
		string operatorid;
	end;

//////////////////////////////////////////////////////////////	
//Map Raw Layout / Translate Action Codes/////////////////////
//////////////////////////////////////////////////////////////

	modRaw conF(deactHist l)	:= transform	
		self.action_code								:= PhonesInfo._Functions.fn_FindActCode(stringlib.stringfilter(l.msisdneid, '0123456789'));
		self.timestamp									:= stringlib.stringfilter(l.timestamp, '0123456789');
		self.phone											:= l.msisdn[2..];
		self.phone_swap									:= l.msisdnnew[2..];
		self.changeid										:= l.changeid;
		self.operatorid									:= l.operatorid;
		self.filename										:= '';
	end;

	fixLayout 	:= project(deactHist, conF(left));
	
//Append Operator Name	
	opID				:= PhonesInfo.File_Deact.OIDMain;
	
	modRaw addOp(fixLayout l, opID r):= transform
		self.filename										:= trim(stringlib.stringtouppercase(map(regexfind('ATT', r.operatorname, 0)<>'' 			=> 'ATT',
																																						regexfind('Sprint', r.operatorname, 0)<>'' 		=> 'SPRINT',
																																						regexfind('T-Mobile', r.operatorname, 0)<>'' 	=> 'TMOBILE',
																																						regexfind('Verizon', r.operatorname, 0)<>'' 	=> 'VERIZON',
																																						r.operatorname)), left, right)+'_'+l.timestamp[1..8];
		self 														:= l;
	end;
	
	convPrev 		:= join(fixLayout, opID,
											left.operatorid = right.operatorid,
											addOp(left, right), left outer, lookup);

//////////////////////////////////////////////////////////////	
//Separate Swap Transactions//////////////////////////////////
//////////////////////////////////////////////////////////////

	swRec				:= convPrev(action_code='SW');
	nonSWRec 		:= convPrev(action_code<>'SW');
	
	//Create Record for SD - Swap Delete
	modRaw swTR1(swRec l) := transform
		self.action_code 								:= PhonesInfo.TransactionCode.SwapDelete; //SD
		self														:= l;
	end;
	
	sdRec 			:= project(swRec, swTR1(left));
	
	//Create Record for SA - Swap Add
	modRaw swTR2(swRec l) := transform
		self.action_code 								:= PhonesInfo.TransactionCode.SwapAdd; //SA
		self.phone											:= l.phone_swap;
		self.phone_swap									:= '';
		self														:= l;
	end;
	
	saRec 			:= project(swRec, swTR2(left));
	
	//Concat Swap Records
	concatSW 		:= sdRec + saRec;
	
	//Concat All Records
	concatAll 	:= nonSWRec + concatSW;

//////////////////////////////////////////////////////////////	
//Map Records to Common Deact Layout//////////////////////////
//////////////////////////////////////////////////////////////

	PhonesInfo.Layout_Deact.Temp2 fixF(concatAll l, unsigned c):= transform
		trimFile 	:= trim(l.filename, left, right);
		
		self.vendor_first_reported_dt		:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
		self.vendor_last_reported_dt		:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
		self.carrier_name								:= trimFile[1..length(trimFile)-9];		
		self.filedate										:= trimFile[length(trimFile)-7..] ;
		self.swap_start_dt							:= if(l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete], (unsigned)l.timestamp, 0);
		self.swap_end_dt								:= if(l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete], (unsigned)l.timestamp, 0);
		self.deact_code									:= if(l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend], l.action_code, '');
		self.deact_start_dt							:= if(l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend], (unsigned)l.timestamp, 0);
		self.deact_end_dt								:= if(l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend], (unsigned)l.timestamp, 0);
		self.react_start_dt							:= if(l.action_code in [PhonesInfo.TransactionCode.React], (unsigned)l.timestamp, 0);
		self.react_end_dt								:= if(l.action_code in [PhonesInfo.TransactionCode.React], (unsigned)l.timestamp, 0);
		self.porting_dt									:= 0;
		self.groupid										:= c;
		self.pk_carrier_name						:= '';
		self.days_apart									:= 0;
		self 														:= l;
	end;

	inFile			:= project(concatAll, fixF(left, counter));

//////////////////////////////////////////////////////////////	
//Populate Transaction Dates//////////////////////////////////
//////////////////////////////////////////////////////////////

	fixFields_d := distribute(inFile, hash(phone));
	fixFields_s := sort(fixFields_d, phone, -(integer)changeid, carrier_name, -if(action_code in [PhonesInfo.TransactionCode.Deact, PhonesInfo.TransactionCode.Suspend], 1, 2), local);
	fixFields_g := group(fixFields_s, phone);
	
	PhonesInfo.Layout_Deact.Temp2 iter1(fixFields_g l, fixFields_g r) := transform
	//conditions to determine when to rollup into one record
	sameCarrierDate	:= l.carrier_name = r.carrier_name 		and l.timestamp[1..8] = r.timestamp[1..8];
		consecDESU 					:= r.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend] 	and l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend];
		REafterDESU 				:= r.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend] 	and l.action_code in [PhonesInfo.TransactionCode.React];
		SWafterDESU					:= r.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend] 	and l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete];
			
		consecRE 						:= r.action_code in [PhonesInfo.TransactionCode.React] 																					and l.action_code in [PhonesInfo.TransactionCode.React];
		
		DESUafterRE 				:= r.action_code in [PhonesInfo.TransactionCode.React] 																					and l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend];
		SWafterRE						:= r.action_code in [PhonesInfo.TransactionCode.React] 																					and l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete];

		consecSA 						:= r.action_code in [PhonesInfo.TransactionCode.SwapAdd] 																				and l.action_code in [PhonesInfo.TransactionCode.SwapAdd];
		consecSD 						:= r.action_code in [PhonesInfo.TransactionCode.SwapDelete] 																		and l.action_code in [PhonesInfo.TransactionCode.SwapDelete];
		DESUafterSW					:= r.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete] 	and l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend];
		REafterSW						:= r.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete] 	and l.action_code in [PhonesInfo.TransactionCode.React];

		isLastDESU 					:= l.phone <> r.phone and r.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend];
		isLastRE 						:= l.phone <> r.phone and r.action_code in [PhonesInfo.TransactionCode.React];
		isLastSW 						:= l.phone <> r.phone and r.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete];
			
	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 										:= if(((consecDESU or consecRE or SWafterDESU or SWafterRE) and sameCarrierDate) or
																					((consecSA or consecSD) and sameCarrierDate and l.phone_swap = r.phone_swap) or
																					(REafterDESU and l.carrier_name = r.carrier_name), l.groupid, 
																					r.groupid); 
		self.deact_code									:= r.deact_code;		
		self.deact_end_dt 							:= if(isLastDESU, 0, 
																				if(consecDESU and ~sameCarrierDate, l.deact_start_dt, 
																				if(REafterDESU and ~sameCarrierDate, l.react_start_dt,
																				if(SWafterDESU and ~sameCarrierDate, l.swap_start_dt,
																				r.deact_end_dt))));	
		self.react_end_dt 							:= if(isLastRE, 0, 
																				if(consecRE and ~sameCarrierDate, l.react_start_dt, 
																				if(DESUafterRE and ~sameCarrierDate, l.deact_start_dt,
																				if(SWafterRE and ~sameCarrierDate, l.swap_start_dt,
																				r.react_start_dt))));	
		self.swap_end_dt 								:= if(isLastSW, 0, 
																				if((consecSA or consecSD) and ~sameCarrierDate, l.swap_start_dt,
																				if(DESUafterSW and ~sameCarrierDate, l.deact_start_dt,
																				if(REafterSW and ~sameCarrierDate, l.react_start_dt,
																				r.swap_end_dt))));
		self.is_deact										:= if(isLastDESU or isLastSW, 'Y', 'N');
		self.is_react										:= if(isLastRE, 'Y', 'N');
		self 														:= r;
	end;		
			
	tagGroups 	:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug:= ungroup(tagGroups);
	
//////////////////////////////////////////////////////////////	
//Transform File to Transaction Base Layout///////////////////
//////////////////////////////////////////////////////////////

	dx_PhonesInfo.Layouts.Phones_Transaction_Main fixTr(tagGroups_ug l):= transform
		self.source											:= Mdr.SourceTools.src_Phones_Disconnect; //PX	
		self.transaction_code						:= l.action_code;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_time 	:= '';
		self.transaction_start_dt				:= map(l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend] 			=> l.deact_start_dt,
																					l.action_code in [PhonesInfo.TransactionCode.React]  																				=> l.react_start_dt, 
																					l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete]	=> l.swap_start_dt,
																						0);
		self.transaction_start_time			:= '';
		self.transaction_end_dt					:= map(l.action_code in [PhonesInfo.TransactionCode.Deact,PhonesInfo.TransactionCode.Suspend] 			=> l.deact_end_dt,
																					l.action_code in [PhonesInfo.TransactionCode.React]  																				=> l.react_end_dt, 
																					l.action_code in [PhonesInfo.TransactionCode.SwapAdd,PhonesInfo.TransactionCode.SwapDelete]	=> l.swap_end_dt,
																					0);
		self.transaction_end_time				:= '';
		self.transaction_count					:= 0;
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.spid												:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;
	
	transLayout := project(tagGroups_ug, fixTr(left));

//////////////////////////////////////////////////////////////	
//Add Record_Sid//////////////////////////////////////////////
//////////////////////////////////////////////////////////////

	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(transLayout l):= transform
		self.record_sid 								:= hash64(Mdr.SourceTools.src_Phones_Disconnect + 
																							l.phone_swap + 
																							l.source + 
																							l.carrier_name + 
																							l.transaction_code + 
																							l.transaction_start_dt + 
																							l.transaction_end_dt + 
																							l.vendor_first_reported_dt) + (integer)l.phone;
		self 														:= l;
	end;
	
	addID 			:= project(transLayout, trID(left))(transaction_code<>'' and phone<>'');
	
//////////////////////////////////////////////////////////////	
//Dedup Results///////////////////////////////////////////////
//////////////////////////////////////////////////////////////
	
	ddRec				:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);

EXPORT Remap_Deact_File := ddRec;