IMPORT Data_Services, dx_PhonesInfo, Mdr, PhoneFraud, Ut;

//DF-24397: Create Dx-Prefixed Keys

EXPORT Map_OTP := FUNCTION

	//Pull Latest OTP Base File
	ds					:= PhoneFraud.File_OTP.Base;	
	
	//Restrict OTP Base Records on Rules Specified in JIRA: PHOM-80
	//Otp_delivery_method values: T - Text; M - Mobile; W - Work; H - Home; E - Email
	ds_filt			:= ds(otp_phone<>'' and otp_delivery_method in ['T','M','W','H'] and verify_passed=TRUE);

	//Map to Common OTP Layout
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trOTP(ds_filt l):= transform
	
		//Pull DBA's Date_Added, If Populated.  Otherwise, Use Build Load Date
		//Map to Layout Specified in PHOM-84
		findFileDate := if(l.date_added<>'', l.date_added, l.date_file_loaded);
		
		self.source 										:= Mdr.SourceTools.Src_PhoneFraud_OTP; //OT
		self.phone											:= l.otp_phone;
		self.transaction_code						:= PhonesInfo.TransactionCode.ActiveStatus; //AS
		self.transaction_dt							:= (integer)l.event_date;
		self.transaction_time						:= l.event_time;
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
		self.global_sid									:= 0;
		self.record_sid									:= 0;
		self 														:= l;
	end;

	cmnOTP			:= project(ds_filt, trOTP(left));

	//Rollup Same-Day OTP Transactions / Determine Min/Max Dates
	compFile 		:= sort(distribute(cmnOTP, hash(phone)), phone, (((string)transaction_dt)+transaction_time), local);

	dx_PhonesInfo.Layouts.Phones_Transaction_Main trComp(compFile l, compFile r):= transform
	
		combDt1		:= ((string)l.transaction_dt)+l.transaction_time;
		combDt2		:= ((string)r.transaction_dt)+r.transaction_time;

		minFirst	:= ut.min2((unsigned)combDt1, (unsigned)combDt2);
		
		self.transaction_dt					:= (unsigned)((string)minFirst)[1..8];
		self.transaction_time				:= ((string)minFirst)[9..];
		self 												:= l;
	end;

	combRec			:= rollup(compFile, 
												left.phone = right.phone and
												left.transaction_dt = right.transaction_dt, 
												trComp(left, right), local);
	
	//Add Record SID
	dx_PhonesInfo.Layouts.Phones_Transaction_Main trID(combRec l):= transform
		self.record_sid 						:= hash64(Mdr.SourceTools.Src_PhoneFraud_OTP + l.transaction_code + l.transaction_dt + l.transaction_time + l.vendor_first_reported_dt) + (integer)l.phone;	
		self 												:= l;
	end;
	
	addID			:= project(combRec, trID(left));
	
	//Dedup Results
	ddOTP			:= dedup(sort(distribute(addID, hash(phone)), record, local), record, local);

	RETURN ddOTP;
	
END;