IMPORT Ut;

EXPORT _fn_Map_Common_PortedPhones(dataset(PhonesInfo.Layout_iConectiv.Main) inFile, string src):= FUNCTION

		//Rollup Records w/ Updates <= 3 Days
		rllUpdate						:= sort(distribute(inFile, hash(phone)), phone, spid, porting_dt, port_start_dt, routing_code, -vendor_last_reported_dt, local);	
		
		rllUpdate newDate(rllUpdate l, rllUpdate r) := transform
				
				minDate	:= ut.min2((unsigned)l.vendor_first_reported_dt, 	(unsigned)r.vendor_first_reported_dt);
				maxDate	:= max((unsigned)l.vendor_last_reported_dt, 			(unsigned)r.vendor_last_reported_dt);
				minStart:= ut.min2((unsigned)l.port_start_dt, 						(unsigned)r.port_start_dt);
				maxEnd	:= max((unsigned)l.port_end_dt, 									(unsigned)r.port_end_dt);

			self.vendor_first_reported_dt 	:= (string)minDate;
			self.vendor_last_reported_dt  	:= (string)maxDate;
			self.port_start_dt					 		:= (string)minStart;
			
			//Pull Active Records First
			self.port_end_dt								:= if(l.port_end_dt='' or r.port_end_dt='', '', (string)maxEnd);
			self.is_ported									:= if(l.port_end_dt='' and l.is_ported=TRUE or 
																						r.port_end_dt='' and r.is_ported=TRUE, 
																						TRUE, FALSE);
			self 														:= l;
		end;
			
		applyRollupDates	:= rollup(rllUpdate, 
																left.phone = right.phone and
																left.spid = right.spid and
																left.porting_dt = right.porting_dt and
																left.port_start_dt = right.port_start_dt and
																left.routing_code = right.routing_code and
																//<3 day gap to account for holidays
																(ut.YYYYMMDDtoJulian((string8)left.port_end_dt)-ut.YYYYMMDDtoJulian((string8)right.vendor_first_reported_dt) between -3 and 0),
																newDate(left, right), local);
																			
	//Map to Common Layout
	PhonesInfo.Layout_Common.portedMain iConectM(applyRollupDates l):= transform
		self.source 											:= src;
		self.porting_dt										:= (unsigned) stringlib.stringfilter(l.porting_dt, '0123456789')[1..8];
		self.porting_time									:= stringlib.stringfilter(l.porting_dt, '0123456789')[9..14];
		self.phoneType										:= '';
		self.vendor_first_reported_dt 		:= (unsigned) l.vendor_first_reported_dt[1..8];
		self.vendor_first_reported_time		:= l.vendor_first_reported_dt[9..14];
		self.vendor_last_reported_dt			:= (unsigned) l.vendor_last_reported_dt[1..8];
		self.vendor_last_reported_time		:= l.vendor_last_reported_dt[9..14];
		self.port_start_dt								:= (unsigned) l.port_start_dt[1..8];
		self.port_start_time							:= l.port_start_dt[9..14];
		self.port_end_dt									:= (unsigned) l.port_end_dt[1..8];
		self.port_end_time								:= l.port_end_dt[9..14];
		self.remove_port_dt								:= (unsigned) l.remove_port_dt[1..8];
		self 															:= l;
	end;

	iConectComm 				:= project(applyRollupDates, iConectM(left));
	
	RETURN iConectComm;

END;