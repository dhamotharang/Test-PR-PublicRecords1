IMPORT dx_PhonesInfo, PhonesInfo, PhonesPlus_V2, Ut;

	//DF-24550: Replace the Neustar Port File with the iConectiv One.
	
	//1. Pass the iConectiv Ported Phone Records through the Lerg6 to determine the 'coc_type.' 
	//2. Join these results to the Phone Type file to determine the current 'serv/line' type.
	//3. Compare the appended Lerg6 'coc_type' with the appended 'serv/line' types.
	//4. Changes from the original Lerg6 to a different serv/line type will be kept in the final output file.

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//APPEND COC_TYPE FROM THE LERG6 TO THE PORT FILE///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Add Missing SPID to Port Delete Records in Need of One
	dsNewPhone		:= PhonesInfo.File_Phones_Transaction.Main(source in ['P!','PK']);
	
		ds 					:= distribute(dsNewPhone, hash(phone));
		sortDs 			:= sort(ds, phone, transaction_start_dt, vendor_first_reported_dt ,local);
		gpDs				:= group(sortDs, phone, LOCAL);

		//Populate SPIDs Related Fields to the Delete Records
		sortDs addFl(sortDs L, sortDs R):= TRANSFORM
			self.spid				:= if(l.transaction_code in ['PA'] and r.transaction_code = 'PD' and l.phone = r.phone and r.spid='',
														l.spid,
														r.spid);
			self						:= r;
		end;

		addSpid 			:= iterate(gpDs, addFL(LEFT,RIGHT));
		ungroupSpid 	:= ungroup(addSpid);	
	
	//Pull Port Records
	srtNewPhone		:= sort(distribute(ungroupSpid, hash(phone[1..7])), phone[1..7], local);

	//Latest Lerg6 Records
	dsL6					:= dx_PhonesInfo.Key_Phones_Lerg6(is_current=TRUE);	
	srtL6					:= sort(distribute(dsL6, hash(npa+nxx+block_id)), npa+nxx+block_id, local);	

	l6Layout := record
		dx_PhonesInfo.Layouts.Phones_Transaction_Main;
		string	coc_type;
		string	ssc;
		string  account_owner;
	end;

	//Match Ported Phone to the Lerg6 by First Seven Digits of the Phone
	l6Layout appTr(srtNewPhone l, srtL6 r):= transform
		self.coc_type				:= r.coc_type;
		self.ssc						:= r.ssc;
		self.account_owner	:= r.ocn;
		self								:= l;
	end;

	appendFile 		:= join(srtNewPhone, srtL6,
												left.phone[1..7] = right.npa + right.nxx + right.block_id,
												appTr(left, right), left outer, local);

	ddAppendFile 	:= dedup(sort(distribute(appendFile, hash(phone)), record, local), record, local);

	//Append the Ocn from the Lerg6 - Isolate the Non-Matched Records
	matchLerg6Rec			:= ddAppendFile(account_owner<>'');
	noMatchLerg6Rec		:= ddAppendFile(account_owner='');

	//Run the Non-Matched Records through Lerg6 w/ Block_ID = A by Phone[1..6]
	srtBlock					:= sort(distribute(dsL6(block_id='A'), hash(npa+nxx)), npa+nxx, local);
	srtNoLerg6Match		:= sort(distribute(noMatchLerg6Rec, hash(phone[1..6])), phone[1..6], local);

	l6Layout appTr2(srtNoLerg6Match l, srtBlock r):= transform
		self.coc_type				:= r.coc_type;
		self.ssc						:= r.ssc;
		self.account_owner	:= r.ocn;
		self								:= l;
	end;

	appendFile2 	:= join(srtNoLerg6Match, srtBlock,
												left.phone[1..6] = right.npa + right.nxx,
												appTr2(left, right), left outer, local);

	ddAppendFile2 := dedup(sort(distribute(appendFile2, hash(phone)), record, local), record, local);
	
	//Concat the Lerg6 Append Results//////////////////////////////////////////////////////////////////////
	concatApp			:= matchLerg6Rec + ddAppendFile2;
	concatAppend 	:= dedup(sort(distribute(concatApp, hash(phone)), phone, spid, local), record, local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//APPEND SERV/LINE TYPES FROM PHONE TYPE FILE///////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Append Serv/Line Types from the Phone Type file to the Transaction File 
	dsPType 		:= dedup(sort(distribute(PhonesInfo.File_Phones_Type.Main(source in ['P!','PK']), hash(phone)), phone, spid, -(((string)vendor_last_reported_dt)+vendor_last_reported_time), local), phone, spid, local);

	srtPType 		:= sort(distribute(dsPType, hash(phone, spid)), phone, spid, local);
	srtApp			:= sort(distribute(concatAppend, hash(phone, spid)), phone, spid, local);
	
	addFields := record
		l6Layout;
		string serv;
		string line;
	end;

	addFields addTr(srtPType l, srtApp r):= transform
		self 				:= r;
		self.serv		:= l.serv;
		self.line		:= l.line;
	end;

	compFiles 		:= join(srtPType, srtApp,
												left.phone = right.phone and
												left.spid = right.spid,
												addTr(left, right), local);

	ddCompFiles 	:= dedup(sort(distribute(compFiles, hash(phone)), phone, transaction_code,  local), record, local);

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//REFORMAT RESULTS FOR NEUSTAR HISTORY TABLE////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	tempLayout := record
		Phonesplus_v2.Layout_Neustar_History;
		string10 spid;
		string2 transaction_code;
		string dt_last_seen_time;
		string coc_type;
		string ssc;
		string serv;
		string line;
		unsigned  groupid			:= 0;
		string keep_rec;
	end;
	
	//Begin Reformat to Neustar History
	tempLayout addTr4(ddCompFiles l, unsigned c):= transform
																							//Landline				 //Wireless
		self.is_land_to_cell	:= if(l.coc_type in ['EOC','VOI'] and (l.serv='1' and l.line='1'), TRUE, FALSE);											//Landline-to-Wireless
		self.is_current				:= if(l.transaction_code='PA', TRUE, FALSE);																													//Port Add		
		self.dt_first_seen		:= if(l.source='PK',
																l.transaction_start_dt,
																l.vendor_first_reported_dt);
		self.dt_last_seen			:= l.vendor_last_reported_dt;
		self.dt_last_seen_time:= l.vendor_last_reported_time;
		
		//Set records that changed phone types to keep_rec='Y'	
																							//Landline				//Wireless
		self.keep_rec					:= if(l.coc_type in ['EOC','VOI'] and (l.serv='1' and l.line='1'), 																		//Landline-to-Wireless
																'Y', 					//Wireless				//Not Wireless or Unknown
															if(l.coc_type in ['PMC','SP2'] and (l.serv not in ['1','3',''] and l.line  not in ['1','3','']),	//Wireless-to-Landline
																'Y',
																''));
		self.groupid					:= c;
		self									:= l;
	end;
	
	neusHist			:= project(ddCompFiles, addTr4(left, counter))(phone<>'');
	
	//Populate 'is_current' Status
	inFile_d 			:= distribute(neusHist, hash(phone));
	inFile_s 			:= sort(inFile_d, phone, -(((string)dt_last_seen)+dt_last_seen_time), if(transaction_code in ['PA'], 2, 1) ,local);
	inFile_g 			:= group(inFile_s, phone);

	tempLayout iter1(inFile_g l, inFile_g r) := transform
		//Conditions to determine when to rollup into one record
				consecutiveA 			:= l.transaction_code='PA' and r.transaction_code='PA';
				sameSL 						:= l.serv = r.serv and l.line = r.line;
				DafterA 					:= r.transaction_code='PA' and l.transaction_code='PD';
				isLastA 					:= l.phone <> r.phone and r.transaction_code='PA';

		//Transactions to be rolled up into one record have the same groupid	
		self.groupid 					:= if((consecutiveA and sameSL) or (DafterA and sameSL), l.groupid, r.groupid);		      
		self.is_current 			:= if(isLastA, true, false);				
		self 									:= r;
	end;
			
	tagGroups 		:= iterate(inFile_g, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);
	
	//Rollup Records by Groupid
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, groupid, dt_first_seen, (((string)dt_last_seen)+dt_last_seen_time), if(transaction_code in ['PA'], 1, 2) ,local);
	
		tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform
			self.dt_first_seen := ut.min2((unsigned)l.dt_first_seen, (unsigned)r.dt_first_seen);
			self.dt_last_seen  := max((unsigned)l.dt_last_seen,(unsigned)r.dt_last_seen);
			self 							 := r;
		end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);

EXPORT Map_iConectiv_Ported_Phone_Type_Changes := aggrTrans_r;	