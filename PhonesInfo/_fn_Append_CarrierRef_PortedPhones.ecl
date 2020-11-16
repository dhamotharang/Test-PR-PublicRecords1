IMPORT dx_PhonesInfo, lib_date;

EXPORT _fn_Append_CarrierRef_PortedPhones := MODULE

	EXPORT Ph_Metadata(dataset(PhonesInfo.Layout_Common.portedMain) inFile):= FUNCTION
	
		//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
		srcRef						:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);
		sortSPID					:= sort(distribute(srcRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
		sortiCon					:= sort(distribute(inFile, hash(spid)), spid, local);
	
		PhonesInfo.Layout_Common.portedMetadata_Main addiConSL(sortiCon l, sortSPID r):= transform
			self.serv 							:= r.serv;
			self.line								:= r.line;	
			self.operator_fullname 	:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
			self.high_risk_indicator:= r.high_risk_indicator;
			self.prepaid						:= r.prepaid;				
			self.is_ported					:= if(l.port_end_dt not in [0], false, l.is_ported);
			self 										:= l;
		end;
		
		addiConON 				:= join(sortiCon, sortSPID,
															left.spid = right.spid,
															addiConSL(left, right), left outer, local, keep(1));
	
		//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
		//There are a few instances where there are multiple ocns for a spid
		srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
		srtRefOFN_match		:= sort(distribute(srcRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
			
		PhonesInfo.Layout_Common.portedMetadata_Main addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
			self.account_owner			:= r.ocn;
			self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 										:= l;
		end;
		
		addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
															left.spid = right.spid and
															PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
															addiCOFNTr(left, right), left outer, local, keep(1));
		
		//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
		srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
		srtRefRem					:= sort(distribute(srcRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
		
		PhonesInfo.Layout_Common.portedMetadata_Main addiRemTr(srtAddiCRem l, srtRefRem r):= transform
			self.account_owner			:= r.ocn;
			self.carrier_name				:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 										:= l;
		end;	
		
		addiCRem 					:= join(srtAddiCRem, srtRefRem,
															left.spid = right.spid,
															addiRemTr(left, right), left outer, local, keep(1));
		
		//Concat Appended OCN/Carrier Name Results
		ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);
		
		RETURN	ddiConAddFields;
	
	END;
	
	EXPORT Ph_Transact(dataset(dx_PhonesInfo.Layouts.Phones_Transaction_Main) inFile):= FUNCTION	
	
		//Append Serv, Line, High Risk Indicator, Prepaid, & Operator Full Name
		dsCarrRef					:= PhonesInfo.File_Source_Reference.Main(is_current=TRUE);
		sortiCon					:= sort(distribute(inFile, hash(spid)), spid, local);
		sortSPID					:= sort(distribute(dsCarrRef, hash(spid)), spid, serv, line, carrier_name, local);//Lookup Supplied Internally	
		
		tempLayout := record
			dx_PhonesInfo.Layouts.Phones_Type_Main;
			string temp_vfreported;
			string temp_vlreported;
		end;	
		
		tempLayout addiConSL(sortiCon l, sortSPID r):= transform
			self.temp_vfreported						:= ((string)l.vendor_first_reported_dt) + l.vendor_first_reported_time;
			self.temp_vlreported						:= ((string)l.vendor_last_reported_dt) + l.vendor_last_reported_time;
			self.reference_id								:= '';
			self.reply_code									:= '';
			self.local_routing_number				:= '';
			self.account_owner							:= '';
			self.carrier_category						:= '';
			self.local_area_transport_area 	:= '';
			self.point_code									:= '';
			self.serv 											:= r.serv;
			self.line												:= r.line;	
			self.operator_fullname 					:= PhonesInfo._Functions.fn_CarrierName(r.operator_full_name);
			self.high_risk_indicator				:= r.high_risk_indicator;
			self.prepaid										:= r.prepaid;		
			self.global_sid									:= 0;	//CCPA Requirement
			self.record_sid									:= 0;	//CCPA Requirement
			self 														:= l;
		end;
			
		addiConON 				:= join(sortiCon, sortSPID,
															left.spid = right.spid,
															addiConSL(left, right), left outer, local, keep(1));
		
		//Append OCN and Carrier Name to Port Recs By Joining to Ref Table (where carrier_name = operator_full_name) By SPID
		//There are a few instances where there are multiple ocns for a spid
		srtAddiCOFN				:= sort(distribute(addiConON, hash(spid)), spid, operator_fullname, local);
		srtRefOFN_match		:= sort(distribute(dsCarrRef(carrier_name=operator_full_name), hash(spid)), spid, carrier_name, local);
			
		tempLayout addiCOFNTr(srtAddiCOFN l, srtRefOFN_match r):= transform
			self.account_owner							:= r.ocn;
			self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 														:= l;
		end;
		
		addiOCN_match 		:= join(srtAddiCOFN, srtRefOFN_match,
															left.spid = right.spid and
															PhonesInfo._Functions.fn_CarrierName(left.operator_fullname) = PhonesInfo._Functions.fn_CarrierName(right.carrier_name),
															addiCOFNTr(left, right), left outer, local, keep(1));
		
		//Append OCN and Carrier Name to Remaining Port Recs (where account_owner='') By Joining to Ref Table (where carrier_name <> operator_full_name) By SPID
		srtAddiCRem				:= sort(distribute(addiOCN_match(account_owner=''), hash(spid)), spid, operator_fullname, local);
		srtRefRem					:= sort(distribute(dsCarrRef(carrier_name<>operator_full_name), hash(spid)), spid, operator_full_name, carrier_name, local);
		
		tempLayout addiRemTr(srtAddiCRem l, srtRefRem r):= transform
			self.account_owner							:= r.ocn;
			self.carrier_name								:= PhonesInfo._Functions.fn_CarrierName(r.carrier_name);
			self 														:= l;
		end;			
		
		addiCRem 					:= join(srtAddiCRem, srtRefRem,
															left.spid = right.spid,
															addiRemTr(left, right), left outer, local, keep(1));
		
		//Concat Appended OCN/Carrier Name Results
		ddiConAddFields 	:= dedup(sort(distribute(addiOCN_match(account_owner<>'')+addiCRem, hash(phone)), record, local), record, local);

		//Rollup Same Port Phone Type Records
		srtDdiConAddFields:= sort(distribute(ddiConAddFields, hash(phone)), phone, carrier_name, account_owner, serv, line, high_risk_indicator, prepaid, -vendor_last_reported_dt, local);

		tempLayout rollupiConDate(srtDdiConAddFields l, srtDdiConAddFields r) := transform
				
			minDate		:= lib_date.earliestdate((integer)l.temp_vfreported, (integer)r.temp_vfreported);
			maxDate		:= lib_date.latestdate((integer)l.temp_vlreported, (integer)r.temp_vlreported);
			
			self.temp_vfreported						:= (string)minDate;
			self.temp_vlreported						:= (string)maxDate;
			self.global_sid									:= 0;	//CCPA Requirement
			self.record_sid									:= 0;	//CCPA Requirement
			self 														:= l;
		end;

		rollupiConDates		:= rollup(srtDdiConAddFields, 
																left.phone = right.phone and
																left.carrier_name = right.carrier_name and
																left.account_owner = right.account_owner and
																left.serv = right.serv and
																left.line = right.line and
																left.high_risk_indicator = right.high_risk_indicator and
																left.prepaid = right.prepaid,
																rollupiConDate(left, right), local);
		
		//Fix Vendor First/Last Reported Date/Time
		dx_PhonesInfo.Layouts.Phones_Type_Main dtTr(rollupiConDates l):= transform
			self.vendor_first_reported_dt		:= (integer)(l.temp_vfreported[1..8]);
			self.vendor_first_reported_time := l.temp_vfreported[9..];
			self.vendor_last_reported_dt 		:= (integer)(l.temp_vlreported[1..8]);
			self.vendor_last_reported_time	:= l.temp_vlreported[9..];
			self														:= l;
		end;
		
		applyiConDates 		:= project(rollupiConDates, dtTr(left));
	
		RETURN applyiConDates;
		
	END;

END;