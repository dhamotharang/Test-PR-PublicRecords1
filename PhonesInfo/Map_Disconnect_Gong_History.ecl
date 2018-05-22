Import Gong, Ut;

#OPTION ('multiplePersistInstances', FALSE);

EXPORT Map_Disconnect_Gong_History(string version) := function

 //////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Pull Gong History Records///////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	ds 			:= Gong.Key_History_Phone;
	
	//Find File Date
	fd 			:= nothor(Fileservices.Getsuperfilesubname('~thor_data400::key::gong_history_phone_qa',1));
	fdate := fd[34..41];
	
	//Concat Address Fields
	PhonesInfo.Layout_Deact_GH.History addA(ds l):= transform
			self.address1 		:= StringLib.StringCleanSpaces(l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix);
			self := l;
	end;

	addAddr := project(ds, addA(left));
	
	//Output History File (Input)
	ghHistoryFile := output(addAddr,,'~thor_data400::in::phones::deact_gh_history_'+version, overwrite, __compressed__);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Dedup/Remap Gong History Records////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Dedup Gong History Records By Hhid, Did, or Bdid
	addAddr_hhid 	:= addAddr(hhid<>0 and did=0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid<>0) + addAddr(hhid=0 and did=0 and bdid=0);
	addAddr_did 		:= addAddr(hhid=0 and did<>0 and bdid=0) + addAddr(hhid=0 and did<>0 and bdid<>0);
	addAddr_bdid		:= addAddr(hhid=0 and did=0 and bdid<>0) + addAddr(hhid<>0 and did=0 and bdid<>0);
	
	//Pull Current Records First
	dhhid									:= dedup(sort(distribute(addAddr_hhid, hash(phone10)), phone10, hhid, -current_record_flag,  dt_first_seen, -dt_last_seen, local), phone10, hhid, local);
	ddid										:= dedup(sort(distribute(addAddr_did, hash(phone10)), phone10, did, -current_record_flag, dt_first_seen, -dt_last_seen, local), phone10, did, local);
	dbdid									:= dedup(sort(distribute(addAddr_bdid, hash(phone10)), phone10, bdid, -current_record_flag, dt_first_seen, -dt_last_seen, local), phone10, bdid, local);	

	allRec		:= dhhid + ddid + dbdid;

	//Dedup By Address1; Sort Current Records First
	ddRec 		:= dedup(sort(distribute(allRec, hash(phone10)), phone10, address1, -current_record_flag, dt_first_seen, -dt_last_seen, local), phone10, address1, local);

	//Remap Records to Common Layout	and Add Action Codes
	PhonesInfo.Layout_Deact_GH.Temp2 fixF(ddRec l, unsigned c):= transform			
			self.vendor_first_reported_dt	:= (integer)version;
			self.vendor_last_reported_dt		:= (integer)version;
			self.action_code 													:= if(l.deletion_date<>'', 'DE', 'RE');
			self.timestamp 															:= if(l.deletion_date<>'', l.deletion_date, l.dt_first_seen);
			self.phone 																			:= l.phone10;
			self.phone_swap															:= '';
			self.carrier_name													:= '';		
			self.filedate																	:= fd[34..41];
			self.swap_start_dt												:= 0;
			self.swap_end_dt														:= 0;
			self.deact_code															:= if(l.deletion_date<>'', self.action_code, '');
			self.deact_start_dt											:= if(l.deletion_date<>'', (unsigned)l.deletion_date, 0);
			self.deact_end_dt													:= if(l.deletion_date<>'', (unsigned)l.deletion_date, 0);
			self.react_start_dt											:= if(l.deletion_date='', (unsigned)l.dt_first_seen, 0);
			self.react_end_dt													:= if(l.deletion_date='', (unsigned)l.dt_first_seen, 0);
			self.did 																					:= l.did;
			self.bdid 																				:= l.bdid;
			self.addID																				:= hash(l.phone10+l.did+l.hhid+l.bdid);
			self.filename 																:= 'gong_history_'+ fd[34..41];
			self.porting_dt															:= 0;
			self.groupid																		:= c;
			self.pk_carrier_name										:= '';
			self.days_apart															:= 0;
			self 																									:= l;
	end;

	inF				:= project(ddRec, fixF(left, counter));

	inRE 		:= inF(action_code='RE');
	inDE			:= inF(action_code='DE');

	//Keep Earliest React 
	inFRE 	:= dedup(sort(distribute(inRE, hash(phone)), phone, react_start_dt, local), phone, local);
	inFile := inFRE + inDE;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Rollup Daily File////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	fixFields_d 		:= distribute(inFile, hash(phone));
	fixFields_s 		:= sort(fixFields_d, phone, -(integer)timestamp, addID, local);
	fixFields_g 		:= group(fixFields_s, phone);
		
	PhonesInfo.Layout_Deact_GH.Temp2 iter1(fixFields_g l, fixFields_g r) := transform		
	//Conditions to determine when to rollup into one record
			sameID						:= l.addID = r.addID and l.timestamp[1..8] = r.timestamp[1..8];
			
			REafterDE 		:= r.action_code in ['DE'] and l.action_code in ['RE'];
			DEafterRE 		:= r.action_code in ['RE'] and l.action_code in ['DE'];
			
			consecDE 			:= l.action_code in ['DE'] and r.action_code in ['DE'];
			isLastDE 			:= l.phone <> r.phone	and r.action_code in ['DE'];

			consecRE 			:= l.action_code in ['RE'] and r.action_code in ['RE'];
			isLastRE 			:= l.phone <> r.phone	and r.action_code in ['RE'];

	//Transactions to be rolled up into one record have the same groupid		
			self.groupid 					:= if((consecDE or consecRE) and sameID, l.groupid, r.groupid); 
			self.deact_code			:= r.deact_code;		
			self.deact_end_dt := if(isLastDE, 0, 
																											if(consecDE and ~sameID, l.deact_start_dt, 
																											if(REafterDE and ~sameID, l.react_start_dt,	
																											r.deact_end_dt
																											)));	
			self.react_end_dt := if(isLastRE, 0, 
																										if(consecRE and ~sameID, l.react_start_dt, 
																										if(DEafterRE and ~sameID, l.deact_start_dt,
																										r.react_start_dt)));
			self.swap_end_dt 	:= 0;
			self.is_deact					:= if(isLastDE, 'Y', 'N');
			self.is_react					:= if(isLastRE, 'Y', 'N');
			self 													:= r;
	end;		
				
	tagGroups 				:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);

	aggrTrans_d 		:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s			:= sort(aggrTrans_d, (integer)groupid, (integer)timestamp, local);

	PhonesInfo.Layout_Deact_GH.Temp2 roll(aggrTrans_s l, aggrTrans_s r) := transform	
			self.vendor_first_reported_dt 	:= ut.min2((unsigned)l.vendor_first_reported_dt, (unsigned)r.vendor_first_reported_dt);
			self.vendor_last_reported_dt 		:= MAX((unsigned)l.vendor_last_reported_dt, (unsigned)r.vendor_last_reported_dt);
			self.deact_start_dt												:= ut.min2((unsigned)l.deact_start_dt, (unsigned)r.deact_start_dt);
			self.react_start_dt												:= ut.min2((unsigned)l.react_start_dt,(unsigned)r.react_start_dt);
			self.swap_start_dt													:= 0;
			self.deact_code																:= if(r.deact_code<>'', r.deact_code, l.deact_code);
			self.deact_end_dt														:= if(r.is_deact='Y', 0, 
																																					if(l.deact_start_dt<>0 and l.deact_start_dt<r.react_start_dt, r.react_start_dt, 
																																						MAX(l.deact_end_dt, r.deact_end_dt)));
			self.react_end_dt														:= if(r.is_react='Y', 0, 
																																					if(l.react_start_dt<>0 and l.react_start_dt<r.deact_start_dt, r.deact_start_dt, 
																																						MAX(l.react_end_dt, r.react_end_dt)));
			self.swap_end_dt															:= 0;
			self 																										:= r;
	end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
																								left.groupid = right.groupid, 
																								roll(left, right), local);

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Check Against Phones Metadata File//////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	portRec 					:= sort(distribute(PhonesInfo.File_Phones.Ported_Current((source='PJ' and vendor_first_reported_dt<=20150308) or source='PK'), hash(phone)), phone, port_start_dt, local);
	discARec					:= sort(distribute(aggrTrans_r, hash(phone)), phone, deact_start_dt, local);

	PhonesInfo.Layout_Deact_GH.Temp addPrt(discARec l, portRec r):= transform
			
	//Code translations for is_deact and is_react:	
			//P - Ported
			//Y - Active Deact/React
			//N - Nonactive Deact/React		
			
	//Flag records as "Ported," when there are -1 and 30 days between the deact_start_dt and the port_start_dt
			dcDaysApt 								:= PhonesInfo._Functions.Daysapart(((string)l.deact_start_dt)[1..8],((string)r.port_start_dt)[1..8]);
			deacDtMatch_1_30 	:= if(l.deact_start_dt<>0 and r.port_start_dt<>0 and dcDaysApt between -1 and 30, TRUE, FALSE);		
																										
			self.is_deact 				:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_30=TRUE and l.deact_code in ['DE'], 'P', l.is_deact);
			self.is_react 				:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_30=TRUE and l.deact_code in ['DE'], 'P', l.is_react);
			self.porting_dt 		:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_30=TRUE and l.deact_code in ['DE'], r.port_start_dt, 0);														
			self.days_apart			:= if(trim(l.phone, left, right) = trim(r.phone, left, right) and deacDtMatch_1_30=TRUE and l.deact_code in ['DE'], dcDaysApt, 0);
			self 													:= l;
	end;
		
	portMatch 			:= join(discARec, portRec,
																						left.phone = right.phone and
																						PhonesInfo._Functions.Daysapart(((string)left.deact_start_dt)[1..8],((string)right.port_start_dt)[1..8]) between -1 and 30,
																						addPrt(left, right), left outer, local);
	 
	ddPortMatch		:= dedup(sort(distribute(portMatch, hash(phone)), phone, vendor_first_reported_dt, vendor_last_reported_dt, deact_start_dt, deact_end_dt, days_apart, local), record, except deact_end_dt, react_end_dt, porting_dt, days_apart, local):INDEPENDENT;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Exclude Deact Records Where Deact/React Start/End_Dt = Current Date (Potential Gong History Update Record)//
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	filterDate			:= ddPortMatch(fd[34..41] not in [((string)deact_start_dt)[1..8], ((string)deact_end_dt)[1..8], ((string)react_start_dt)[1..8], ((string)react_end_dt)[1..8]]);
	filterSameDay		:= ddPortMatch(fd[34..41] in [((string)deact_start_dt)[1..8], ((string)deact_end_dt)[1..8], ((string)react_start_dt)[1..8], ((string)react_end_dt)[1..8]]):persist('~thor_data400::persist::gong_history_deact_sameDay');
	filterSameDayOut:= choosen(filterSameDay, 500);

	//Output Base File
	ghFile 						:= output(filterDate,,'~thor_data400::base::phones::disconnect_gh_main_'+version, overwrite, __compressed__);
	allFiles					:= sequential(ghHistoryFile, ghFile, output(filterSameDayOut));
	
return allFiles;

end;