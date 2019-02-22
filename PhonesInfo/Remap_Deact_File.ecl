IMPORT mdr, ut;

//Pull Records from Deact History File
	deactHist := PhonesInfo.File_Deact.History2;

	modRaw := record
		PhonesInfo.Layout_Deact.Raw;
		string changeid;
		string operatorid;
	end;

//Convert Current Raw File To Previous Raw Layout
	modRaw conF(deactHist l)	:= transform	
		self.action_code	:= PhonesInfo._Functions.fn_FindActCode(stringlib.stringfilter(l.msisdneid, '0123456789'));
		self.timestamp		:= stringlib.stringfilter(l.timestamp, '0123456789');
		self.phone				:= l.msisdn[2..];
		self.phone_swap		:= l.msisdnnew[2..];
		self.changeid			:= l.changeid;
		self.operatorid		:= l.operatorid;
		self.filename			:= '';
	end;

	fixLayout := project(deactHist, conF(left));
	
//Append Operator Name	
	opID			:= PhonesInfo.File_Deact.OIDMain;
	
	modRaw addOp(fixLayout l, opID r):= transform
		self.filename			:= trim(stringlib.stringtouppercase(map(regexfind('ATT', r.operatorname, 0)<>'' 			=> 'ATT',
																															regexfind('Sprint', r.operatorname, 0)<>'' 		=> 'SPRINT',
																															regexfind('T-Mobile', r.operatorname, 0)<>'' 	=> 'TMOBILE',
																															regexfind('Verizon', r.operatorname, 0)<>'' 	=> 'VERIZON',
																															r.operatorname)), left, right)+'_'+l.timestamp[1..8];
		self 		:= l;
	end;
	
	convPrev 	:= join(fixLayout, opID,
										left.operatorid = right.operatorid,
										addOp(left, right), left outer, lookup);
	
	tempLayout := record
		PhonesInfo.Layout_Common.Phones_Transaction_Main;
		string changeid;
		string timestamp;
		integer groupid;
	end;

//Map Daily Files To Common Layout
	tempLayout fixF(convPrev l, unsigned c):= transform
			trimFile := trim(l.filename, left, right);
		
		self.source											:= Mdr.SourceTools.src_Phones_Disconnect; //PX
		self.vendor_first_reported_dt		:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
		self.vendor_first_reported_time	:= '';	
		self.vendor_last_reported_dt		:= if(trimFile[length(trimFile)-7..]<>'', (unsigned)trimFile[length(trimFile)-7..], 0);
		self.vendor_last_reported_time	:= '';	
		self.carrier_name								:= trimFile[1..length(trimFile)-9];		
		self.transaction_code						:= l.action_code;
		self.transaction_dt							:= (unsigned)l.timestamp;
		self.transaction_time						:= '';
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.groupid										:= c;
		self.spid												:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	inFile		:= project(convPrev, fixF(left, counter));

//CREATE ROLLED UP DAILY FILE
	fixFields_d 	:= distribute(inFile, hash(phone));
	fixFields_s 	:= sort(fixFields_d, phone, -(integer)changeid, carrier_name, transaction_code, local);
	fixFields_g 	:= group(fixFields_s, phone);
	
	tempLayout iter1(fixFields_g l, fixFields_g r) := transform
	//Conditions to determine when to rollup into one record
			sameCarrierDate	:= l.carrier_name = r.carrier_name and l.timestamp[1..8] = r.timestamp[1..8];
			consecDESU 			:= r.transaction_code in [PhonesInfo.TransactionCode.Deact, PhonesInfo.TransactionCode.Suspend] and l.transaction_code in [PhonesInfo.TransactionCode.Deact, PhonesInfo.TransactionCode.Suspend];	//DE/SU	
			consecRE 				:= r.transaction_code in [PhonesInfo.TransactionCode.React] and l.transaction_code in [PhonesInfo.TransactionCode.React]; //RE
			consecSW 				:= r.transaction_code in ['SW'] and l.transaction_code in ['SW'];
			
	//Transactions to be rolled up into one record have the same groupid		
		self.groupid 			:= if(((consecDESU or consecRE) and sameCarrierDate) or
														(consecSW and sameCarrierDate and l.phone_swap = r.phone_swap), 
														l.groupid, 
														r.groupid); 
		self 							:= r;
	end;		
			
	tagGroups 		:= iterate(fixFields_g, iter1(left,right));
	tagGroups_ug 	:= ungroup(tagGroups);
	
	aggrTrans_d 	:= distribute(tagGroups_ug, hash(groupid));
	aggrTrans_s		:= sort(aggrTrans_d, (integer)groupid, (integer)changeid, carrier_name, transaction_code, local);

	tempLayout roll(aggrTrans_s l, aggrTrans_s r) := transform	
		self.vendor_first_reported_dt := ut.min2((unsigned)l.vendor_first_reported_dt,(unsigned)r.vendor_first_reported_dt);
		self.vendor_last_reported_dt 	:= MAX((unsigned)l.vendor_last_reported_dt,(unsigned)r.vendor_last_reported_dt);
		self.transaction_dt						:= ut.min2((unsigned)l.transaction_dt,(unsigned)r.transaction_dt);
		self 													:= r;
	end;

	aggrTrans_r		:= rollup(aggrTrans_s, 
													left.groupid = right.groupid, 
													roll(left, right), local);
	
//SEPARATE SWAP TRANSACTIONS
	swRec					:= aggrTrans_r(transaction_code='SW');
	nonSWRec 			:= aggrTrans_r(transaction_code<>'SW');
	
	//Create Record for SD - Swap Delete
	tempLayout swTR1(swRec l) := transform
		self.transaction_code 				:= PhonesInfo.TransactionCode.SwapDelete; //SD
		self													:= l;
	end;
	
	sdRec 				:= project(swRec, swTR1(left));
	
	//Create Record for SA - Swap Add
	tempLayout swTR2(swRec l) := transform
		self.transaction_code 				:= PhonesInfo.TransactionCode.SwapAdd; //SA
		self.phone										:= l.phone_swap;
		self.phone_swap								:= '';
		self													:= l;
	end;
	
	saRec 				:= project(swRec, swTR2(left));
	
	//Concat Swap Records
	concatSW 			:= sdRec + saRec;
	
//CONCAT ALL RECORDS
	concatAll 		:= project(nonSWRec + concatSW, PhonesInfo.Layout_Common.Phones_Transaction_Main);
	
//DEDUP RESULTS
	ddRec					:= dedup(sort(distribute(concatAll(transaction_code<>'' and phone<>''), hash(phone)), record, local), record, local);

EXPORT Remap_Deact_File := ddRec;