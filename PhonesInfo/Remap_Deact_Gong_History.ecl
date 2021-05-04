IMPORT Data_Services, dx_PhonesInfo, Gong, Mdr, Std, Ut;

	#OPTION ('multiplePersistInstances', FALSE);
	//DF-24397: Create Dx-Prefixed Keys
	//DF-24599: Add Transaction_Count, Transaction_End_Dt & Transaction_End_Time Fields to Transaction File

EXPORT Remap_Deact_Gong_History(string version) := FUNCTION

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Pull Gong History Records///////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

  ds := File_OptedOut_Inputs.Gong;//CCPA-799
  
	//Pull Date From Filename
	fd 								:= nothor(Fileservices.Getsuperfilesubname(Data_Services.foreign_prod+'thor_data400::key::gong_history_phone_qa',1));
	trFDate						:= trim(fd, left, right);
	fDate							:= stringlib.stringfilter(trFDate[std.str.Find(trFDate, 'history', 1)..], '0123456789');
	
	//Concat Address Fields
	PhonesInfo.Layout_Deact_GH.History addA(ds l):= transform
			self.address1 								:= StringLib.StringCleanSpaces(l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix);
			self 													:= l;
	end;

	addAddr 					:= project(ds, addA(left));
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Dedup/Remap Gong History Records////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Dedup Gong History Records By Hhid, Did, or Bdid
	addAddr_hhid 			:= addAddr(hhid<>0 and did=0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid<>0) + addAddr(hhid=0 and did=0 and bdid=0);
	addAddr_did 			:= addAddr(hhid=0 and did<>0 and bdid=0) + addAddr(hhid=0 and did<>0 and bdid<>0);
	addAddr_bdid			:= addAddr(hhid=0 and did=0 and bdid<>0) + addAddr(hhid<>0 and did=0 and bdid<>0);
	
	//Pull Current Records First//CCPA-799 - performance tuning
	dhhid							:= dedup(sort(addAddr_hhid(dt_first_seen not in ['','0']), p3+phone7, hhid, -current_record_flag,  dt_first_seen, -dt_last_seen, local), p3+phone7, hhid, local);
	ddid							:= dedup(sort(addAddr_did(dt_first_seen not in ['','0']) , p3+phone7, did, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, did, local);
	dbdid							:= dedup(sort(addAddr_bdid(dt_first_seen not in ['','0']), p3+phone7, bdid, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, bdid, local);	

	allRec						:= dhhid + ddid + dbdid;

	//Dedup By Address1; Sort Current Records First
	ddRec 						:= dedup(sort(allRec, p3+phone7, address1, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, address1, local);

	tempLayout := record
		dx_PhonesInfo.Layouts.Phones_Transaction_Main;
		integer did;
		integer bdid;
		integer addID;
		integer groupid;
		string  timestamp;
		unsigned8 deact_start_dt;
		unsigned8 deact_end_dt;
		unsigned8 react_start_dt;
		unsigned8 react_end_dt;
		string  is_deact;
		string  is_react;
	end;

	//Remap Records to Common Layout	and Add Action Codes
	tempLayout fixF(ddRec l, unsigned c):= transform		
		self.phone											:= l.p3+l.phone7;
		self.source											:= Mdr.SourceTools.Src_Phones_Gong_History_Disconnect; //PG		
		self.transaction_code 					:= if(l.deletion_date<>'', PhonesInfo.TransactionCode.Deact, PhonesInfo.TransactionCode.React); //DE/RE
		self.transaction_start_dt				:= 0;
		self.transaction_start_time			:= '';	
		self.transaction_end_dt					:= 0;
		self.transaction_end_time				:= '';
		self.transaction_count					:= 0;
		self.vendor_first_reported_dt		:= (integer)fdate;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= (integer)fdate;
		self.vendor_last_reported_time	:= '';
		self.timestamp 									:= if(l.deletion_date<>'', l.deletion_date, l.dt_first_seen);
		self.deact_start_dt							:= if(l.deletion_date<>'', (unsigned)l.deletion_date, 0);
		self.deact_end_dt								:= if(l.deletion_date<>'', (unsigned)l.deletion_date, 0);
		self.react_start_dt							:= if(l.deletion_date='',  (unsigned)l.dt_first_seen, 0);
		self.react_end_dt								:= if(l.deletion_date='',  (unsigned)l.dt_first_seen, 0);
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.spid												:= '';
		self.carrier_name								:= '';
		self.phone_swap									:= '';
		self.did 												:= l.did;
		self.bdid 											:= l.bdid;
		self.addID											:= hash(l.p3+l.phone7+l.did+l.hhid+l.bdid);
		self.groupid										:= c;
		self.ocn												:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self.is_deact										:= 'N';
		self.is_react										:= 'N';
		self.alt_spid										:= '';
		self.lalt_spid									:= '';
		self 														:= l;
	end;

	inF								:= project(ddRec, fixF(left, counter));
	
	inRE 							:= inF(transaction_code=PhonesInfo.TransactionCode.React);
	inDE							:= inF(transaction_code=PhonesInfo.TransactionCode.Deact);

	//Keep Earliest React 
	inFRE 						:= dedup(sort(distribute(inRE, hash(phone)), phone, react_start_dt, local), phone, local);
	inFile 						:= inFRE + inDE;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Create Rollup Daily File////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	fixFields_d 			:= distribute(inFile, hash(phone));
	fixFields_s 			:= sort(fixFields_d, phone, -(integer)timestamp, addID, local);
	fixFields_g 			:= group(fixFields_s, phone);
		
	tempLayout iter1(fixFields_g l, fixFields_g r) := transform		
	//Conditions to determine when to rollup into one record
			sameID				:= l.addID = r.addID and ((string)l.transaction_start_dt)[1..8] = ((string)r.transaction_start_dt)[1..8];
			
			REafterDE 		:= r.transaction_code in [PhonesInfo.TransactionCode.Deact] and l.transaction_code in [PhonesInfo.TransactionCode.React];
			DEafterRE 		:= r.transaction_code in [PhonesInfo.TransactionCode.React] and l.transaction_code in [PhonesInfo.TransactionCode.Deact];
			
			consecDE 			:= l.transaction_code in [PhonesInfo.TransactionCode.Deact] and r.transaction_code in [PhonesInfo.TransactionCode.Deact];
			consecRE 			:= l.transaction_code in [PhonesInfo.TransactionCode.React] and r.transaction_code in [PhonesInfo.TransactionCode.React];

			isLastDE 			:= l.phone <> r.phone	and r.transaction_code in [PhonesInfo.TransactionCode.Deact];
			isLastRE 			:= l.phone <> r.phone	and r.transaction_code in [PhonesInfo.TransactionCode.React];
		
	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 										:= if((consecDE or consecRE) and sameID, l.groupid, r.groupid); 
		self.transaction_code						:= r.transaction_code;		
		self.deact_end_dt 							:= if(isLastDE, 0, 
																					if(consecDE and ~sameID, l.deact_start_dt, 
																					if(REafterDE and ~sameID, l.react_start_dt,	
																					r.deact_end_dt)));	
		self.react_end_dt 							:= if(isLastRE, 0, 
																					if(consecRE and ~sameID, l.react_start_dt, 
																					if(DEafterRE and ~sameID, l.deact_start_dt,
																					r.react_start_dt)));
		self.is_deact										:= if(isLastDE, 'Y', 'N');
		self.is_react										:= if(isLastRE, 'Y', 'N'); 	
		self 														:= r;
	end;		
				
	tagGroups 				:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 			:= ungroup(tagGroups);

	aggrTrans_d 			:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s				:= sort(aggrTrans_d, (integer)groupid, (integer)timestamp, local);

	tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform	
		self.vendor_first_reported_dt 	:= ut.min2((unsigned)l.vendor_first_reported_dt, (unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 		:= MAX((unsigned)l.vendor_last_reported_dt, (unsigned)r.vendor_last_reported_dt);
		self.deact_start_dt							:= ut.min2((unsigned)l.deact_start_dt, (unsigned)r.deact_start_dt);
		self.react_start_dt							:= ut.min2((unsigned)l.react_start_dt,(unsigned)r.react_start_dt);
		self.deact_end_dt								:= if(r.is_deact='Y', 0, 
																					if(l.deact_start_dt<>0 and l.deact_start_dt<r.react_start_dt, r.react_start_dt, 
																					MAX(l.deact_end_dt, r.deact_end_dt)));
		self.react_end_dt								:= if(r.is_react='Y', 0, 
																					if(l.react_start_dt<>0 and l.react_start_dt<r.deact_start_dt, r.deact_start_dt, 
																					MAX(l.react_end_dt, r.react_end_dt)));	
		self 														:= r;
	end;

	aggrTrans_r				:= rollup(aggrTrans_s, 
															left.groupid = right.groupid, 
															roll(left, right), local)(length(trim(phone, left, right))=10); //Pull Valid Phones
														
	//Reformat to Transaction Layout
	dx_PhonesInfo.Layouts.Phones_Transaction_Main fixTr(aggrTrans_r l):= transform
		self.transaction_start_dt				:= if(l.deact_start_dt<>0, l.deact_start_dt, l.react_start_dt);
		self.transaction_end_dt					:= if(l.deact_end_dt<>0, l.deact_end_dt, l.react_end_dt);
		self														:= l;
	end;
	
	fixForm						:= project(aggrTrans_r, fixTr(left));
	
	//Append Carrier Related Info	to Transaction File 
	srtFixForm				:= sort(distribute(fixForm, hash(phone)), phone, -vendor_last_reported_dt, local);
	srtPType					:= sort(distribute(PhonesInfo.File_Phones_Type.Main(source in [mdr.sourceTools.src_Phones_Lerg6, mdr.sourceTools.src_Phones_LIDB]), hash(phone)), phone, -vendor_last_reported_dt, local);
	
	dx_PhonesInfo.Layouts.Phones_Transaction_Main addOTr(srtFixForm l, srtPType r):= transform
		self.ocn												:= r.account_owner;	
		self.spid												:= r.spid;
		self 														:= l;
	end;
	
	addOcn						:= join(srtFixForm, srtPType,
														trim(left.phone, left, right) = trim(right.phone, left, right),
														addOTr(left, right), left outer, local, keep(1));
	
	ddAddOcn					:= dedup(sort(distribute(addOcn, hash(phone)), record, local), record, local);
	
	//Add Record SID
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(ddAddOcn l):= transform
		self.record_sid 								:= hash64(Mdr.SourceTools.Src_Phones_Gong_History_Disconnect + l.transaction_code + l.transaction_start_dt + l.transaction_end_dt + l.vendor_first_reported_dt) + (integer)l.phone;
		self 														:= l;
	end;
	
	addID							:= project(ddAddOcn, trID(left))(length(trim(phone, left, right))=10); //Pull Complete Phones
		
	//DEDUP RESULTS
	ddRecords					:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Exclude Deact Records Where Deact/React Start/End_Dt = Current Date (Potential Gong History Update Record)//
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	filterDate				:= ddRecords(fDate not in [((string)transaction_start_dt)[1..8]]);
	filterSameDay			:= ddRecords(fDate in [((string)transaction_start_dt)[1..8]]):persist('~thor_data400::persist::gong_history_deact_sameDay2');
	filterSameDayOut	:= choosen(filterSameDay, 500);

	//Output Base File
	ghFile 						:= output(filterDate,,'~thor_data400::base::phones::deact_gh_main_'+version, overwrite, __compressed__);
	allFiles					:= sequential(ghFile, output(filterSameDayOut));

	RETURN allFiles;

END;