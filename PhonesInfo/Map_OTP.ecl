IMPORT Data_Services, dx_PhonesInfo, Mdr, PhoneFraud, Ut;

	//DF-24397: Create Dx-Prefixed Keys
	//DF-24599: Add Transaction_Count, Transaction_End_Dt & Transaction_End_Time Fields to Transaction File

EXPORT Map_OTP 	:= FUNCTION

	//Pull Latest OTP Base File
	ds						:= PhoneFraud.File_OTP.Base;	
	
	//Restrict OTP Base Records to Rules Specified in JIRA: PHOM-80
	//Otp_delivery_method values: T - Text; M - Mobile; W - Work; H - Home; E - Email
	ds_filt				:= ds(otp_phone<>'' and otp_delivery_method in ['T','M','W','H'] and verify_passed=TRUE);
	
	/////////////////////////////////////////////////////////////////////////////////////////	
	//Get Filtered OTP Count by Phone////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////	
	srt_filt 			:= sort(ds_filt, otp_phone, event_date, local);
	
	rec := record
		srt_filt.otp_phone;
		srt_filt.event_date;
		total := count(group);
	end;

	filtCount  		:= table(srt_filt, rec, srt_filt.otp_phone, srt_filt.event_date);	

	/////////////////////////////////////////////////////////////////////////////////////////
	//Map Filtered Results to Common OTP Layout//////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trOTP(ds_filt l):= transform
	
		//Pull DBA's Date_Added, If Populated.  Otherwise, Use Build Load Date
		//Map to Layout Specified in PHOM-84
		findFileDate:= if(l.date_added<>'', l.date_added, l.date_file_loaded);
		
		self.source 										:= Mdr.SourceTools.Src_PhoneFraud_OTP; 			//OT
		self.phone											:= l.otp_phone;
		self.transaction_code						:= PhonesInfo.TransactionCode.ActiveStatus; //AS
		self.transaction_start_dt				:= (integer)l.event_date;
		self.transaction_start_time			:= l.event_time;
		self.transaction_end_dt					:= (integer)l.event_date;
		self.transaction_end_time				:= l.event_time;
		self.transaction_count					:= 0;
		self.vendor_first_reported_dt		:= (integer)findFileDate;
		self.vendor_first_reported_time	:= '';
		self.vendor_last_reported_dt		:= (integer)findFileDate;
		self.vendor_last_reported_time	:= '';
		self.country_code								:= '';
		self.country_abbr								:= '';
		self.routing_code								:= '';
		self.dial_type									:= '';
		self.spid												:= '';
		self.carrier_name								:= '';
		self.phone_swap									:= '';
		self.ocn												:= '';
		self.alt_spid										:= '';
		self.lalt_spid									:= '';
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	cmnOTP				:= project(ds_filt, trOTP(left));

	//Rollup Same Phones / Determine Min/Max Dates
	compFile 			:= sort(distribute(cmnOTP, hash(phone)), phone, -(((string)transaction_start_dt)+transaction_start_time), local);

	dx_PhonesInfo.Layouts.Phones_Transaction_Main trComp(compFile l, compFile r):= transform
	
		vendFirst		:= ut.Min2(l.vendor_first_reported_dt, r.vendor_first_reported_dt);
		vendLast		:= max(l.vendor_last_reported_dt, r.vendor_last_reported_dt);
		
			combDt1		:= ((string)l.transaction_start_dt)+l.transaction_start_time;
			combDt2		:= ((string)r.transaction_start_dt)+r.transaction_start_time;

		minTrans		:= ut.min2((unsigned)combDt1, (unsigned)combDt2);
		
			combDt3		:= ((string)l.transaction_end_dt)+l.transaction_end_time;
			combDt4		:= ((string)r.transaction_end_dt)+r.transaction_end_time;	
		
		maxTrans		:= max((unsigned)combDt3, (unsigned)combDt4);
		
		self.vendor_first_reported_dt		:= vendFirst;
		self.vendor_last_reported_dt		:= vendLast;
		self.transaction_start_dt				:= (unsigned)((string)minTrans)[1..8];
		self.transaction_start_time			:= ((string)minTrans)[9..];
		self.transaction_end_dt					:= (unsigned)((string)maxTrans)[1..8];
		self.transaction_end_time				:= ((string)maxTrans)[9..];
		self 														:= l;
	end;

	rollRec				:= rollup(compFile, 
													left.phone = right.phone and
													left.transaction_start_dt = right.transaction_start_dt,  
													trComp(left, right), local);
	
	/////////////////////////////////////////////////////////////////////////////////////////
	//Join Phone Record Counts to Rolled Up OTP Results//////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////
	srtRoll				:= sort(distribute(rollRec, hash(phone)), phone, transaction_start_dt, local);
	srtFilt				:= sort(distribute(filtCount, hash(otp_phone)), otp_phone, event_date, local);
	
	dx_PhonesInfo.Layouts.Phones_Transaction_Main addCtTr(srtRoll l, srtFilt r):= transform
		self.transaction_count 					:= r.total;	
		self 														:= l;
	end;
	
	addCount			:= join(srtRoll, srtFilt,
												left.phone = right.otp_phone and
												left.transaction_start_dt = (unsigned)right.event_date,
												addCtTr(left, right), left outer, local);
	
	ddAddCount		:= dedup(sort(distribute(addCount, hash(phone)), record, local), record, local);
	
	/////////////////////////////////////////////////////////////////////////////////////////
	//Add Record SID/////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(ddAddCount l):= transform
		self.record_sid 								:= hash64(Mdr.SourceTools.Src_PhoneFraud_OTP + l.phone + l.transaction_code + l.transaction_start_dt + l.transaction_start_time) + (integer)l.phone;	
		self 														:= l;
	end;
	
	addID					:= project(ddAddCount, trID(left));
	
	////////////////////////////////////////////////////////////////////////////////////////
	//Dedup Results/////////////////////////////////////////////////////////////////////////
	////////////////////////////////////////////////////////////////////////////////////////
	ddOTP					:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);

	RETURN ddOTP;
	
END;