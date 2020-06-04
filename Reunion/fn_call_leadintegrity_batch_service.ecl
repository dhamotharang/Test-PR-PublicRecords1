import Models, address;

EXPORT fn_call_leadintegrity_batch_service(DATASET(reunion.layouts.lMainRaw) input, unsigned1 seg) := FUNCTION

	low  := (seg-1)*reunion.constants.Seg_size + 1;
	high := seg*reunion.constants.Seg_size;
	input_seg := input(AccountNumber between low and high);
	
	layout_soap_in := record
		DATASET(Models.layouts.Layout_LeadIntegrity_Batch_In) batch_in;
		INTEGER1 DPPAPurpose;
		INTEGER1 GLBPurpose;
		STRING   DataRestrictionMask;
		STRING   DataPermissionMask;
		STRING   ModelName;
		INTEGER1 Version;
		STRING   HistoryDateYYYYMM;
		BOOLEAN  DisableDoNotMailFilter;
	end;

	Models.layouts.Layout_LeadIntegrity_Batch_In make_batch_in(input_seg le, integer c) := TRANSFORM
		SELF.seq := c;
		SELF.acctno      := (STRING)le.accountnumber;
		SELF.Name_First  := le.fname;
		SELF.Name_Middle := le.mname;
		SELF.Name_Last   := le.lname;
		SELF.Name_Suffix := le.name_suffix;
		SELF.street_addr := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);
		SELF.p_City_name := le.city_name;
		SELF.St          := le.st;
		SELF.z5          := le.zip;
		SELF.Home_Phone  := le.phone;
		SELF.DOB         := le.dob;
		SELF.Work_Phone  := le.phone;
		SELF := le;
		SELF := [];
	END;

	layout_soap_in append_settings(input_seg le, integer c) := TRANSFORM
		batch := PROJECT(le, make_batch_in(LEFT, c));
		SELF.batch_in 	 := batch;
		SELF.GLBPurpose  := reunion.constants.GLB;
		SELF.DataRestrictionMask := reunion.constants.DataRestrictionMask;  
		SELF.DataPermissionMask  := reunion.constants.DataPermissionMask;
		SELF.ModelName := 'msn1106_0' ;
		SELF.Version   := 4;
		SELF.HistoryDateYYYYMM := (STRING)reunion.constants.HistoryDate;
		SELF.DisableDoNotMailFilter := FALSE;
		SELF := le;
		SELF := [];
	END;

	soap_in := DISTRIBUTE(project(input_seg, append_settings(LEFT, COUNTER)), Random());

	layout_soap_out := record
		Models.layouts.layout_LeadIntegrity_attributes_batch_flattened;
		STRING errorcode;
	end;

	layout_soap_out myFail(soap_in le) := TRANSFORM
		SELF.errorcode := FAILCODE + FAILMESSAGE;
		SELF.acctno:=le.batch_in[1].acctno;
		SELF := le;
		SELF := [];
	END;
					
//*********** PERFORMING SOAPCALL TO ROXIE ************  
	soap_out := SOAPCALL(
				soap_in,
				reunion.constants.sRoxieIP,
                reunion.constants.LeadInt_Batch_Serv,
				{soap_in}, 
                DATASET(layout_soap_out),
                PARALLEL(reunion.constants.sThreads),
				RETRY(reunion.constants.sRetry),
				TIMEOUT(reunion.constants.sTimeout),
				onFail(myFail(LEFT))
				);

	reunion.layouts.lMainRaw append_attributes(reunion.layouts.lMainRaw le, soap_out re) := TRANSFORM
		SELF.PropOwnedHistoricalCount :=  (STRING3)if((integer)re.v4_PropOwnedHistoricalCount < 0, '0', re.v4_PropOwnedHistoricalCount);
		SELF.PropAgeOldestPurchase    :=  (STRING3)if((integer)re.v4_PropAgeOldestPurchase < 0, '0', re.v4_PropAgeOldestPurchase);
		SELF.PropAgeNewestPurchase    :=  (STRING3)if((integer)re.v4_PropAgeNewestPurchase < 0, '0', re.v4_PropAgeNewestPurchase);
		SELF.PropPurchasedCount12     :=  (STRING3)if((integer)re.v4_PropPurchasedCount12 < 0, '0', re.v4_PropPurchasedCount12);
		SELF.PropPurchasedCount60     :=  (STRING3)if((integer)re.v4_PropPurchasedCount60 < 0, '0', re.v4_PropPurchasedCount60);
		SELF.PropSoldCount12          :=  (STRING3)if((integer)re.v4_PropSoldCount12 < 0, '0', re.v4_PropSoldCount12);
		SELF.PropSoldCount60          :=  (STRING3)if((integer)re.v4_PropSoldCount60 < 0, '0', re.v4_PropSoldCount60);
		SELF.DerogSeverityIndex       :=  (STRING3)if((integer)re.v4_DerogSeverityIndex < 0, '0', re.v4_DerogSeverityIndex);
		SELF.DerogCount               :=  (STRING3)if((integer)re.v4_DerogCount < 0, '0', re.v4_DerogCount);
		SELF.DerogRecentCount         :=  (STRING3)if((integer)re.v4_DerogRecentCount < 0, '0', re.v4_DerogRecentCount);
		SELF.DerogAge                 :=  (STRING3)if((integer)re.v4_DerogAge < 0, '0', re.v4_DerogAge);
		SELF.FelonyCount              :=  (STRING3)if((integer)re.v4_FelonyCount < 0, '0', re.v4_FelonyCount);
		SELF.FelonyAge                :=  (STRING3)if((integer)re.v4_FelonyAge < 0, '0', re.v4_FelonyAge);
		SELF.FelonyCount12            :=  (STRING3)if((integer)re.v4_FelonyCount12 < 0, '0', re.v4_FelonyCount12);
		SELF.FelonyCount60            :=  (STRING3)if((integer)re.v4_FelonyCount60 < 0, '0', re.v4_FelonyCount60);
		SELF.ArrestCount              :=  (STRING3)if((integer)re.v4_ArrestCount < 0, '0', re.v4_ArrestCount);
		SELF.ArrestCount12            :=  (STRING3)if((integer)re.v4_ArrestCount12 < 0, '0', re.v4_ArrestCount12);
		SELF.ArrestCount60            :=  (STRING3)if((integer)re.v4_ArrestCount60 < 0, '0', re.v4_ArrestCount60);
		SELF.BankruptcyCount          :=  (STRING3)if((integer)re.v4_BankruptcyCount < 0, '0', re.v4_BankruptcyCount);
		SELF.BankruptcyCount12        :=  (STRING3)if((integer)re.v4_BankruptcyCount12 < 0, '0', re.v4_BankruptcyCount12);
		SELF.BankruptcyCount60        :=  (STRING3)if((integer)re.v4_BankruptcyCount60 < 0, '0', re.v4_BankruptcyCount60);
		SELF.did_from_roxie := (UNSIGNED6)re.did;
		SELF := le;
	END;

	result := join(distribute(input_seg, accountnumber), distribute(soap_out(errorcode = ''), (UNSIGNED4)acctno), left.accountnumber = (UNSIGNED4)right.acctno, append_attributes(LEFT, RIGHT), LEFT OUTER, LOCAL);
	return distribute(result + input(AccountNumber not between low and high), hash(did));

END;