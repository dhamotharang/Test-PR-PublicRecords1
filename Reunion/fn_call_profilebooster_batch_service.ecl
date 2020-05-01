import ProfileBooster, address;

EXPORT fn_call_profilebooster_batch_service(DATASET(reunion.layouts.lMainRaw) input, unsigned1 seg) := FUNCTION

	low  := (seg-1)*reunion.constants.Seg_size + 1;
	high := seg*reunion.constants.Seg_size;
	input_seg := input(AccountNumber between low and high);
	
	layout_soap_in := record
		DATASET(ProfileBooster.Layouts.Layout_PB_In) batch_in;
		STRING    DataRestrictionMask;
		STRING    DataPermissionMask;
		STRING    AttributesVersionRequest;
		UNSIGNED4 HistoryDateYYYYMM;
	end;

	ProfileBooster.Layouts.Layout_PB_In make_batch_in(input_seg le, integer c) := TRANSFORM
		SELF.seq := c;
		SELF.acctno      := (STRING)le.accountnumber;
		SELF.Name_First  := le.fname;
		SELF.Name_Middle := le.mname;
		SELF.Name_Last   := le.lname;
		SELF.Name_Suffix := le.name_suffix;
		SELF.street_addr := address.Addr1FromComponents(le.prim_range,le.predir,le.prim_name,le.suffix,le.postdir,le.unit_desig,le.sec_range);;
		SELF.City_name   := le.city_name;
		SELF.St          := le.st;
		SELF.z5          := le.zip;
		SELF.Phone10  	 := le.phone;
		SELF.DOB         := le.dob;
		SELF := le;
		SELF := [];
	END;

	layout_soap_in append_settings(input_seg le, integer c) := TRANSFORM
		batch := PROJECT(le, make_batch_in(LEFT, c));
		SELF.batch_in 	 := batch;
		SELF.DataRestrictionMask := reunion.constants.DataRestrictionMask;  
		SELF.DataPermissionMask  := reunion.constants.DataPermissionMask;
		SELF.AttributesVersionRequest := 'PBATTRV1';
		SELF.HistoryDateYYYYMM := reunion.constants.HistoryDate;
		SELF := le;
		SELF := [];
	END;

	soap_in := DISTRIBUTE(project(input_seg, append_settings(LEFT, COUNTER)), Random());
	// soap_in := project(input_seg, append_settings(LEFT, COUNTER));

	layout_soap_out := record
		ProfileBooster.Layouts.Layout_PB_BatchOutFlat;
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
                reunion.constants.ProfBoost_Batch_Serv,
				{soap_in}, 
                DATASET(layout_soap_out),
                PARALLEL(reunion.constants.sThreads),
				RETRY(reunion.constants.sRetry),
				TIMEOUT(reunion.constants.sTimeout),
				onFail(myFail(LEFT))
				);

	input append_attributes(input le, soap_out re) := TRANSFORM
		SELF.ProspectEstimatedIncomeRange :=  (STRING3)if((integer)re.v1_ProspectEstimatedIncomeRange < 0, '0', re.v1_ProspectEstimatedIncomeRange);
		SELF.ResCurrAVMValue    		  :=  (STRING3)if((integer)re.v1_ResCurrAVMValue < 0, '0', re.v1_ResCurrAVMValue);
		SELF.OccProfLicenseCategory    	  :=  (STRING3)if((integer)re.v1_OccProfLicenseCategory < 0, '0', re.v1_OccProfLicenseCategory);
		SELF.LifeEvEconTrajectory     	  :=  (STRING3)if((integer)re.v1_LifeEvEconTrajectory < 0, '0', re.v1_LifeEvEconTrajectory);
		SELF.PPCurrOwnedCnt     		  :=  (STRING3)if((integer)re.v1_PPCurrOwnedCnt < 0, '0', re.v1_PPCurrOwnedCnt);
		SELF.PropEverOwnedCnt             :=  (STRING3)if((integer)re.v1_PropEverOwnedCnt < 0, '0', re.v1_PropEverOwnedCnt);
		SELF.PropCurrOwnedAssessedTtl     :=  (STRING3)if((integer)re.v1_PropCurrOwnedAssessedTtl < 0, '0', re.v1_PropCurrOwnedAssessedTtl);
		SELF.AssetCurrOwner       		  :=  (STRING3)if((integer)re.v1_AssetCurrOwner < 0, '0', re.v1_AssetCurrOwner);
		SELF.did_from_roxie := (UNSIGNED6)re.LexID;
		SELF := le;
	END;

	result := join(distribute(input_seg, accountnumber), distribute(soap_out(errorcode = ''), (UNSIGNED4)acctno), left.accountnumber = (UNSIGNED4)right.acctno, append_attributes(LEFT, RIGHT), LEFT OUTER, LOCAL);
	return distribute(result + input(AccountNumber not between low and high), hash(did));

END;