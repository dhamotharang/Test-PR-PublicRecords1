/*2017-06-26T23:02:50Z (Judy Tao)
DF-18913: Changes for expanded port file
*/
import std, ut;

EXPORT _Functions := MODULE
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	//iConectiv Port//////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT fn_FixTimeStamp(string ds_filter):= FUNCTION

		ds_year 		:= ds_filter[1..4];
		ds_month 		:= ds_filter[5..6];
		ds_day 			:= ds_filter[7..8];
		ds_hour 		:= ds_filter[10..11];
		ds_min			:= ds_filter[12..13];
		ds_sec			:= ds_filter[14..15];

		//Alter INIT Timestamp - Subtract 30 min
		init_min		:= 	//min:[00-29]
										if((ds_min[1] in ['0','1','2'] and ds_min[2] in ['0','1','2','3','4','5','6','7','8','9']),
											(string)(60-(30-(integer)ds_min)),
										//min:[30-59]
											(string)((integer)ds_min-30));

		init_minute := 	//min:[0-9]- add leading zero
										if(length(init_min)=1,
											'0'+init_min,
										//min:[10-59]
											init_min);
										
		init_hr			:= 	//min:[00-29]
										if((ds_min[1] in ['0','1','2'] and ds_min[2] in ['0','1','2','3','4','5','6','7','8','9']),
											(string)((integer)ds_hour-1),
										//min:[30-59]		
											ds_hour);

		init_hour 	:= 	//hr:[0-9]- add leading zero
										if(length(init_hr)=1,
											'0'+init_hr,
										//hr:[10-23]
											init_hr);

		return ds_year + ds_month + ds_day + '_' + init_hour + init_minute + ds_sec;

	END;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	//TCPA History Port///////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	EXPORT fn_addPhoneTypes(dataset(PhonesInfo.Layout_TCPA.Historical) inFile, string fileType):= FUNCTION
		
		PhonesInfo.Layout_TCPA.Historical tRec(inFile l):= transform
			self.phoneType 				:= fileType;
			self 									:= l;
		end;
			
		addTyp									:= project(inFile, tRec(left));
			
		return addTyp;
		
	END;		
	
	EXPORT fn_denormDate(dataset(PhonesInfo.Layout_TCPA.Historical) ds):= FUNCTION

		PhonesInfo.Layout_TCPA.Historical refRec(ds l):= transform
			self.add_date					:= l.add_date[7..10]+l.add_date[1..2]+l.add_date[4..5];
			self.phoneType				:= l.phonetype;
			self 									:= l;
		end;
		
		dsSort 									:= sort(project(ds, refRec(left)), add_date, phoneType);
	
	//Denorm Add Dates
		PhonesInfo.Layout_TCPA.Historical denormDates(dsSort l, dsSort r, integer c):= transform
			self.add_date					:= if(c=1,
																	r.add_date,
																if(l.add_date<>'',
																	l.add_date+';'+r.add_date,
																	r.add_date));
			self.phoneType				:= if(c=1,
																	r.phoneType,
																if(l.phoneType<>'',
																	l.phoneType+';'+r.phoneType,
																	r.phoneType)); 	
			self									:= l;
		end;
		
		dsDenorm 								:= dedup(DENORMALIZE(dsSort, dsSort,
																								left.phone = right.phone, 
																								denormDates(left,right,COUNTER)), all);
														
		return dsDenorm;

	END;
	
	EXPORT fn_standardName(string name):= FUNCTION
	
		stdName := stringlib.stringfilter(stringlib.stringtouppercase(trim(name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	
		return stdName;
	
	END;
	
	EXPORT fn_carrierName(string name):= FUNCTION
	
		carrName := stringlib.stringfilter(stringlib.stringtouppercase(trim(name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ3 .-:*&/_;\'"()!+,@#');
	
		return carrName;
	
	END;
	
	EXPORT fn_alphaText(string name):= FUNCTION
		
		alphaText := stringlib.stringfilter(stringlib.stringtouppercase(trim(name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ');
	
		return alphaText;
	
	END;
	
	EXPORT fn_alphaNumText(string name):= FUNCTION
		
		alphaNumText := stringlib.stringfilter(stringlib.stringtouppercase(trim(name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ');
	
		return alphaNumText;
	
	END;
		
	/////////////////////////////////////////////////////////////////////////////////////
	//REFERENCE DIFF/////////////////////////////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////////////////
	EXPORT fn_FindSPIDDiff(string version):= FUNCTION
	
		ds_main 	:= PhonesInfo.File_Source_Reference.Main(spid<>'');
		srt_main	:= sort(distribute(ds_main, hash(spid)), spid, operator_full_name, local);

		ds_icon		:= PhonesInfo.Lookup_Tables.iConectiv_SPID(spid<>'');
		srt_icon	:= sort(distribute(ds_icon, hash(spid)), spid, operator_fullname, local);

		cmLayout := record
			string	ic_spid;
			string  ic_operator_fullname;
			string  ic_name;
			string	ref_spid;
			string  ref_operator_fullname;
			string  ref_name;
		end;
		/*
		cmLayout compFM(srt_main l, srt_icon r):= transform
			self.ic_spid 								:= l.spid;
			self.ic_operator_fullname 	:= l.operator_full_name;
			self.ic_name								:= PhonesInfo._Functions.fn_standardName(l.operator_full_name);
			self.ref_spid								:= r.spid;
			self.ref_operator_fullname 	:= r.operator_fullname;
			self.ref_name								:= PhonesInfo._Functions.fn_standardName(r.operator_fullname);
		end;

		joinRecM 	:= join(srt_main, srt_icon,
											left.spid = right.spid and
											PhonesInfo._Functions.fn_standardName(left.operator_full_name) = PhonesInfo._Functions.fn_standardName(right.operator_fullname),
											compFM(left, right), local);

		dedupRec1 := dedup(sort(distribute(joinRecM, hash(ic_spid)), record, local), record, local);
		*/
		cmLayout compFL(srt_icon l, srt_main r):= transform
			self.ic_spid 								:= l.spid;
			self.ic_operator_fullname 	:= l.operator_fullname;
			self.ic_name								:= stringlib.stringfilter(stringlib.stringtouppercase(trim(l.operator_fullname, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
			self.ref_spid								:= r.spid;
			self.ref_operator_fullname 	:= r.operator_full_name;
			self.ref_name								:= stringlib.stringfilter(stringlib.stringtouppercase(trim(r.operator_full_name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
		end;

		joinRecL 	:= join(srt_icon, srt_main,
											left.spid = right.spid and
											stringlib.stringfilter(stringlib.stringtouppercase(trim(left.operator_fullname, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') = stringlib.stringfilter(stringlib.stringtouppercase(trim(right.operator_full_name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
											compFL(left, right), left only, local);

		dedupRecL := dedup(sort(distribute(joinRecL, hash(ic_spid)), record, local), record, local);

		cmLayout compFR(srt_main l, srt_icon r):= transform
				self.ic_spid 								:= r.spid;
				self.ic_operator_fullname 	:= r.operator_fullname;
				self.ic_name								:= stringlib.stringfilter(stringlib.stringtouppercase(trim(r.operator_fullname, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
				self.ref_spid								:= l.spid;
				self.ref_operator_fullname 	:= l.operator_full_name;
				self.ref_name								:= stringlib.stringfilter(stringlib.stringtouppercase(trim(l.operator_full_name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
			end;

		joinRecR 	:= join(srt_main, srt_icon,
											left.spid = right.spid and
											stringlib.stringfilter(stringlib.stringtouppercase(trim(left.operator_full_name, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789') = stringlib.stringfilter(stringlib.stringtouppercase(trim(right.operator_fullname, left, right)), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),
											compFR(left, right), left only, local);

		dedupRecR := dedup(sort(distribute(joinRecR, hash(ref_spid)), record, local), record, local);

		srt_i			:= sort(distribute(dedupRecL, hash(ic_spid)), ic_spid, local);
		srt_r			:= sort(distribute(dedupRecR, hash(ref_spid)), ref_spid, local);

		cmLayout mSPD(srt_i l, srt_r r):= transform
			self.ic_spid								:= l.ic_spid;
			self.ic_operator_fullname		:= l.ic_operator_fullname;
			self.ic_name								:= l.ic_name;
			self.ref_spid								:= r.ref_spid;
			self.ref_operator_fullname	:= r.ref_operator_fullname;
			self.ref_name								:= r.ref_name;
		end;

		matchRec := join(srt_i, srt_r,
											left.ic_spid = right.ref_spid,
											mSPD(left, right), local):persist('~thor_400::persist::ref_iconectiv_differences_'+version);
	
		return matchRec;
		
	END;
	
	//////////////////////////////////////////////////////////////////////////////////////////////////////
	//DEACT///////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////

	EXPORT DaysApart (string8 d1, string8 d2) := FUNCTION
	
		//this works only with dates in YYYYMMDD format
		dayDiff := ut.DaysSince1900(d1[1..4], d1[5..6], d1[7..8]) - ut.DaysSince1900(d2[1..4], d2[5..6], d2[7..8]);

	
		return dayDiff;

	END;
	
	EXPORT fn_FindActCode(string cd):= FUNCTION
	
		actCode 				:= trim(map(cd = '1' => 'DE', //Deactivation - MDN Deactivation
																										cd = '2' => 'RE',	//Reactivation - MDN Resume
																										cd = '3' => 'SU',	//Suspend 					- MDN Suspend
																										cd = '4' => 'SW',	//Swap 								- MDN Transfer
																										cd = '5'	=> '', 		//No PSMS 					- No PSMS
																										''), left, right);
		return actCode;
		
	END;
	
	EXPORT fn_keyCarrier(string name):= FUNCTION

		keyCarrier 			:= trim(map(std.str.find(name, 'AT&T', 1)<>0 												=> 'ATT',
																std.str.find(name, 'CINGULAR WIRELESS', 1)<>0 					=> 'ATT',
																std.str.find(name, 'CRICKET COMMUNICATIONS', 1)<>0 			=> 'ATT',
																std.str.find(name, 'SPRINT', 1)<>0 											=> 'SPRINT',
																std.str.find(name, 'T MOBILE', 1)<>0										=> 'TMOBILE',
																std.str.find(name, 'TMOBILE', 1)<>0											=> 'TMOBILE',
																std.str.find(name, 'T-MOBILE', 1)<>0										=> 'TMOBILE',
																std.str.find(name, 'USCC', 1)<>0 												=> 'USCC',
																std.str.find(name, 'UNITED STATES CELLULAR CORP', 1)<>0 => 'USCC',
																std.str.find(name, 'VERIZON', 1)<>0 										=> 'VERIZON',
																name), left, right);
		
		return keyCarrier;
	
	END;
	
	/////////////////////////////////////////////////////////////////////////////////////
	//LIDB DELTABASE/////////////////////////////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////////////////
	
	//remove nulls
	EXPORT rmNull(string fld):= FUNCTION
		return std.str.findReplace(trim(fld, left, right), 'NULL', '');
	END;
	
	/////////////////////////////////////////////////////////////////////////////////////
	//LERG6//////////////////////////////////////////////////////////////////////////////	
	/////////////////////////////////////////////////////////////////////////////////////
	
	EXPORT fn_maxLerg6FileDt(dataset(PhonesInfo.Layout_Lerg.lerg6Main) ds):= function

		dtLayout := record
			string filename;
		end;

		dtLayout rTr(ds l):= transform			
			self.filename := l.dt_last_reported;
		end;

		findDate	:= project(ds, rTr(left));
		findMax		:=(string)max(findDate(std.date.isValidDate((unsigned)(filename[1..8]))), (unsigned)filename); //Pull Highest Filedate

		return findMax;

	END;

END;