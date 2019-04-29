IMPORT Data_Services, dx_PhonesInfo, Gong, Mdr, Std, Ut;

#OPTION ('multiplePersistInstances', FALSE);
//DF-24397: Create Dx-Prefixed Keys

EXPORT Remap_Deact_Gong_History(string version) := FUNCTION

//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Pull Gong History Records///////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	

	ds 			:= Gong.Key_History_Phone;
	
	//Pull Date From Filename
	fd 			:= nothor(Fileservices.Getsuperfilesubname('~thor_data400::key::gong_history_phone_qa',1));
	trFDate	:= trim(fd, left, right);
	fDate		:= stringlib.stringfilter(trFDate[std.str.Find(trFDate, 'history', 1)..], '0123456789');
	
	//Concat Address Fields
	PhonesInfo.Layout_Deact_GH.History addA(ds l):= transform
			self.address1 		:= StringLib.StringCleanSpaces(l.prim_range+' '+l.predir+' '+l.prim_name+' '+l.suffix);
			self := l;
	end;

	addAddr := project(ds, addA(left));
	
	//Output History File (Input)
	//ghHistoryFile := output(addAddr,,'~thor_data400::in::phones::deact_gh_history_'+version, overwrite, __compressed__);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Dedup/Remap Gong History Records////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Dedup Gong History Records By Hhid, Did, or Bdid
	addAddr_hhid 		:= addAddr(hhid<>0 and did=0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid=0) + addAddr(hhid<>0 and did<>0 and bdid<>0) + addAddr(hhid=0 and did=0 and bdid=0);
	addAddr_did 		:= addAddr(hhid=0 and did<>0 and bdid=0) + addAddr(hhid=0 and did<>0 and bdid<>0);
	addAddr_bdid		:= addAddr(hhid=0 and did=0 and bdid<>0) + addAddr(hhid<>0 and did=0 and bdid<>0);
	
	//Pull Current Records First
	dhhid						:= dedup(sort(distribute(addAddr_hhid, hash(p3+phone7)), p3+phone7, hhid, -current_record_flag,  dt_first_seen, -dt_last_seen, local), p3+phone7, hhid, current_record_flag, local);
	ddid						:= dedup(sort(distribute(addAddr_did, hash(p3+phone7)), p3+phone7, did, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, did, current_record_flag, local);
	dbdid						:= dedup(sort(distribute(addAddr_bdid, hash(p3+phone7)), p3+phone7, bdid, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, bdid, current_record_flag, local);	

	allRec		:= dhhid + ddid + dbdid;

	//Dedup By Address1; Sort Current Records First
	ddRec 		:= dedup(sort(distribute(allRec, hash(p3+phone7)), p3+phone7, address1, -current_record_flag, dt_first_seen, -dt_last_seen, local), p3+phone7, address1, current_record_flag, local);

	tempLayout := record
		dx_PhonesInfo.Layouts.Phones_Transaction_Main;
		integer did;
		integer bdid;
		integer addID;
		integer groupid;
	end;

	//Remap Records to Common Layout	and Add Action Codes
	tempLayout fixF(ddRec l, unsigned c):= transform		
		self.phone											:= l.p3+l.phone7;
		self.source											:= Mdr.SourceTools.Src_Phones_Gong_History_Disconnect; //PG
		self.transaction_code 					:= if(l.deletion_date<>'', PhonesInfo.TransactionCode.Deact, PhonesInfo.TransactionCode.React); //DE/RE
		self.transaction_dt							:= (integer)if(l.deletion_date<>'', l.deletion_date, l.dt_first_seen);
		self.transaction_time						:= '';	
		self.vendor_first_reported_dt		:= (integer)fdate;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= (integer)fdate;
		self.vendor_last_reported_time	:= '';
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
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	inFile		:= project(ddRec, fixF(left, counter));

//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//Create Rollup Daily File////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	fixFields_d 		:= distribute(inFile, hash(phone));
	fixFields_s 		:= sort(fixFields_d, phone, -(integer)transaction_dt, addID, local);
	fixFields_g 		:= group(fixFields_s, phone);
		
	tempLayout iter1(fixFields_g l, fixFields_g r) := transform		
	//Conditions to determine when to rollup into one record
			sameID				:= l.addID = r.addID and ((string)l.transaction_dt)[1..8] = ((string)r.transaction_dt)[1..8];
			consecDE 			:= l.transaction_code in [PhonesInfo.TransactionCode.Deact] and r.transaction_code in [PhonesInfo.TransactionCode.Deact];
			consecRE 			:= l.transaction_code in [PhonesInfo.TransactionCode.React] and r.transaction_code in [PhonesInfo.TransactionCode.React];

	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 										:= if((consecDE or consecRE) and sameID, l.groupid, r.groupid); 
		self.transaction_code						:= r.transaction_code;		
		self.transaction_dt 						:= r.transaction_dt;
		self 														:= r;
	end;		
				
	tagGroups 			:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 		:= ungroup(tagGroups);

	aggrTrans_d 		:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s			:= sort(aggrTrans_d, (integer)groupid, (integer)transaction_dt, local);

	tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform	
		self.vendor_first_reported_dt 	:= ut.min2((unsigned)l.vendor_first_reported_dt, (unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 		:= MAX((unsigned)l.vendor_last_reported_dt, (unsigned)r.vendor_last_reported_dt);
		self.transaction_dt							:= ut.min2((unsigned)l.transaction_dt, (unsigned)r.transaction_dt);
		self 														:= r;
	end;

	aggrTrans_r			:= rollup(aggrTrans_s, 
														left.groupid = right.groupid, 
														roll(left, right), local)(length(trim(phone, left, right))=10); //Pull Valid Phones
														
	fixForm					:= project(aggrTrans_r, dx_PhonesInfo.Layouts.Phones_Transaction_Main);
	
	//Add Record SID
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(fixForm l):= transform
		self.record_sid 								:= hash64(Mdr.SourceTools.Src_Phones_Gong_History_Disconnect + l.transaction_code + l.transaction_dt + l.vendor_first_reported_dt) + (integer)l.phone;
		self 														:= l;
	end;
	
	addID							:= project(fixForm, trID(left))(length(trim(phone, left, right))=10); //Pull Complete Phones
		
	//DEDUP RESULTS
	ddRecords				:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//Exclude Deact Records Where Deact/React Start/End_Dt = Current Date (Potential Gong History Update Record)//
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////	
	filterDate			:= ddRecords(fDate not in [((string)transaction_dt)[1..8]]);
	filterSameDay		:= ddRecords(fDate in [((string)transaction_dt)[1..8]]):persist('~thor_data400::persist::gong_history_deact_sameDay2');
	filterSameDayOut:= choosen(filterSameDay, 500);

	//Output Base File
	ghFile 						:= output(filterDate,,'~thor_data400::base::phones::deact_gh_main_'+version, overwrite, __compressed__);
	allFiles					:= sequential(/*ghHistoryFile, */ghFile, output(filterSameDayOut));

	RETURN allFiles;

END;