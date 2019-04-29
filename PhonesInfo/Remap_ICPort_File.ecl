IMPORT dx_PhonesInfo, Mdr, PhonesInfo, Std, Ut;

//DF-24397: Create Dx-Prefixed Keys

//Pull Existing History w/ Newly Concatenated Daily
	dailyICInput 		:= PhonesInfo.File_iConectiv.In_Port_Daily_History(action_code in ['A','U','D']);
		
	tempLayout := record
		dx_PhonesInfo.Layouts.Phones_Transaction_Main;
		string temp_report_dt;
		string temp_transaction_dt;
		integer groupid;
	end;

//Reformat Dates & Add Counter
	tempLayout trIC(dailyICInput l, unsigned c):= transform
			
		//Pull Filedate from Filename
			init_dt 		:= l.filename[std.str.Find(l.filename, '_init_', 1)+6..std.str.Find(l.filename, '_init_', 1)+20];
			incr_dt 		:= l.filename[std.str.Find(l.filename, 'mid_102_', 1)+8..std.str.Find(l.filename, 'mid_102_', 1)+22];
						
			f_dt_time		:= stringlib.stringfilter(if(std.str.Find(l.filename, '_init_', 1 ) > 0,
												PhonesInfo._Functions.fn_FixTimeStamp(init_dt),
												incr_dt), '0123456789');
					
			f_port_dt		:= stringlib.stringfilter(l.porting_dt[1..19], '0123456789');	
				
		self.source											:= Mdr.sourceTools.Src_PhonesPorted_iConectiv; //PK	
			
		//Treat Adds and Updates the Same
		self.transaction_code						:= map(	l.action_code = 'A' => PhonesInfo.TransactionCode.PortAdd, 	  //PA - Add
																						l.action_code = 'U' => PhonesInfo.TransactionCode.PortAdd,		//PA - Update/Add
																						l.action_code = 'D' => PhonesInfo.TransactionCode.PortDelete,	//PD - Delete
																						'');
		self.transaction_dt							:= 0;
		self.transaction_time						:= '';	
		self.vendor_first_reported_dt		:= (integer)f_dt_time;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= (integer)f_dt_time;
		self.vendor_last_reported_time	:= '';
		self.phone_swap									:= '';
		self.carrier_name								:= '';
		self.temp_report_dt							:= f_dt_time;
		self.temp_transaction_dt				:= f_port_dt;
		self.groupid										:= c;
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	//Restrict the Records Used
	//Port Source (PJ/PM) Supplies the Historical Data Before 20150308
	pkRec := project(dailyICInput, trIC(left, counter))(((string)vendor_first_reported_dt)[1..8]>='20150308'); 
		
	inFile_d 			:= distribute(pkRec, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, temp_transaction_dt, temp_report_dt, transaction_code ,local);
	inFile_g 			:= group(inFile_s, phone);
	
//Assign Groupid	
	tempLayout iter1(inFile_g l, inFile_g r) := transform
		
		//Conditions to determine when to rollup into one record
		consecutivePA 			:= l.transaction_code in [PhonesInfo.TransactionCode.PortAdd] and r.transaction_code in [PhonesInfo.TransactionCode.PortAdd]; //PA
		sameSpidandRouting 	:= l.spid = r.spid and l.routing_code = r.routing_code;
				
		//Transactions to be rolled up into one record have the same groupid	
		self.groupid 										:= if((consecutivePA and sameSpidandRouting), l.groupid, r.groupid);		      		
		self 														:= r;
	end;
			
	tagGroups 		:= iterate(inFile_g, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);

//Rollup Records by Groupid
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, groupid, temp_transaction_dt, temp_report_dt, transaction_code, local);
		
	tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform
		
			repFirst 	:= ut.min2((unsigned)l.vendor_first_reported_dt, (unsigned)r.vendor_first_reported_dt);
			repLast 	:= max((unsigned)l.vendor_last_reported_dt, (unsigned)r.vendor_last_reported_dt);
			prtFirst	:= ut.min2((unsigned)l.temp_transaction_dt, (unsigned)r.temp_transaction_dt);
		
		self.vendor_first_reported_dt 	:= (integer)repFirst;
		self.vendor_last_reported_dt 		:= (integer)repLast;
		self.transaction_dt							:= (integer)prtFirst;
		self 														:= r;
	end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);
		
//Add Transaction Date to Remaining Records & Parse Out Date/Time
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trRem(aggrTrans_r l) := transform
		self.vendor_first_reported_dt 	:= if(l.vendor_first_reported_dt<>0,(integer)(((string)l.vendor_first_reported_dt)[1..8]),(integer)(((string)l.temp_report_dt)[1..8]));
		self.vendor_first_reported_time	:= if(l.vendor_first_reported_dt<>0,((string)l.vendor_first_reported_dt)[9..], 						((string)l.temp_report_dt)[9..]);
		self.vendor_last_reported_dt 		:= if(l.vendor_last_reported_dt<>0, (integer)(((string)l.vendor_last_reported_dt)[1..8]), (integer)(((string)l.temp_report_dt)[1..8]));
		self.vendor_last_reported_time	:= if(l.vendor_last_reported_dt<>0, ((string)l.vendor_last_reported_dt)[9..], 						((string)l.temp_report_dt)[9..]);
		self.transaction_dt							:= if(l.transaction_dt<>0, 					(integer)(((string)l.transaction_dt)[1..8]), 					(integer)(((string)l.temp_transaction_dt)[1..8]));
		self.transaction_time						:= if(l.transaction_dt<>0, 					(((string)l.transaction_dt)[9..]), 										(((string)l.temp_transaction_dt)[9..]));
		self 														:= l;
	end;

	outFile 			:= project(aggrTrans_r, trRem(left));
	
//Add Record SID
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(outFile l) := transform
		self.record_sid									:= hash64(Mdr.sourceTools.Src_PhonesPorted_iConectiv + l.transaction_code + l.transaction_dt + l.transaction_time + l.vendor_first_reported_dt + l.vendor_first_reported_time + l.routing_code + l.spid) + (integer)l.phone;
		self														:= l;
	end;
	
	addID		:= project(outFile, trID(left));

//Dedup Results
	ddRec					:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);
	
EXPORT Remap_ICPort_File := ddRec;