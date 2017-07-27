IMPORT Address, doxie, Experian_Phones, gateway, MDR, moxie_phonesplus_server, PhoneMart, Progressive_Phone, ut;

EXPORT premium_phone := MODULE;

	EXPORT phone_rec := RECORD
		STRING10 phone;
	END;

	EXPORT premium_phone_rec := RECORD
		moxie_phonesplus_server.Layout_batch_did.w_timezone;
		STRING2 vendor;
	END;

	SHARED mac_get_records() := MACRO

		workPhoneRec := RECORD
			UNSIGNED6 did;
			STRING10 phone;
			STRING3 phone_digits;
		END;

		inputPhoneDigitRecs := DEDUP(SORT(PROJECT(phones,TRANSFORM(workPhoneRec,
			SELF.did:=dids[1].did;SELF.phone:=LEFT.phone,
			SELF.phone_digits:=LEFT.phone[MAX(1,LENGTH(TRIM(LEFT.phone))-2)..]
			)),did,phone),did,phone);

		// EQUIFAX
		inhouseEquifaxRecs := DEDUP(SORT(JOIN(dids,PhoneMart.key_phonemart_did,
			KEYED(LEFT.did=RIGHT.l_did) AND RIGHT.history_flag='',
			TRANSFORM(RECORDOF(PhoneMart.key_phonemart_did),SELF:=RIGHT),
			LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)),phone,-dt_last_seen),phone);

		notInInputPhonesRecs := JOIN(inputPhoneDigitRecs,inhouseEquifaxRecs,
			LEFT.did=RIGHT.did AND LEFT.phone=RIGHT.phone,
			TRANSFORM(RECORDOF(PhoneMart.key_phonemart_did),SELF:=RIGHT),RIGHT ONLY);

		equifaxDigitRecs := PROJECT(notInInputPhonesRecs,TRANSFORM(workPhoneRec,
			SELF.did:=LEFT.l_did,SELF.phone:=LEFT.phone,
			SELF.phone_digits:=LEFT.phone[MAX(1,LENGTH(TRIM(LEFT.phone))-2)..]
			));

		notRestrictedEquifaxRecs := IF(UsePremiumSourceA AND dataRestrictionMask[24] IN ['0',''],
			TOPN(notInInputPhonesRecs,PremiumSourceALimit,-dt_last_seen),DATASET([],RECORDOF(PhoneMart.key_phonemart_did)));
			
    // boolean to indicate if equifax recs exist			
		NoEquifaxRecsExist := (~(EXISTS(notRestrictedEquifaxRecs)));

		// EXPERIAN
		// don't even do join if equifax recs exist.
		//
		inhouseExperianRecs := 
		   IF (NoEquifaxRecsExist,
					JOIN(dids,Experian_Phones.Key_Did,
						KEYED(LEFT.did=RIGHT.did) AND RIGHT.rec_type!='SP',
						TRANSFORM(Experian_Phones.Layouts.base,SELF:=RIGHT),
						LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)),
					dataset([],RECORDOF(Experian_Phones.Layouts.base))
			);

		notIn3DigitPhoneRecs := JOIN(inputPhoneDigitRecs+equifaxDigitRecs,inhouseExperianRecs,
			LEFT.did=RIGHT.did AND LEFT.phone_digits=RIGHT.phone_digits,
			TRANSFORM(Experian_Phones.Layouts.base,SELF:=RIGHT),RIGHT ONLY);

		notRestrictedExperianRecs := IF(UseMetronet AND dataRestrictionMask[15] IN ['0',''] and NoEquifaxRecsExist,
			TOPN(notIn3DigitPhoneRecs,MetronetLimit,-score,-date_last_seen),DATASET([],Experian_Phones.Layouts.base));

	ENDMACRO;

	EXPORT get_count(
		DATASET(doxie.layout_references) dids,
		DATASET(phone_rec) phones,
		STRING25 dataRestrictionMask,
		BOOLEAN  UsePremiumSourceA=FALSE,
		BOOLEAN  UseMetronet=FALSE,
		UNSIGNED PremiumSourceALimit=1,
		UNSIGNED MetronetLimit=1
		) := FUNCTION

		mac_get_records();
	 // only return counts of experianRecs if EquifaxRecs don't exist at all
	 // since the NonRestrictedExperianRecs is nulled out in above attr 'notRestrictedExperianRecs'
	 // if there exists equifaxRecs
				RETURN COUNT(notRestrictedEquifaxRecs)+COUNT(notRestrictedExperianRecs);
   								
									
	END;

	EXPORT get_records(
		DATASET(doxie.layout_references) dids,
		DATASET(phone_rec) phones,
		DATASET(gateway.layouts.config) gateways,
		STRING25 dataRestrictionMask,
		BOOLEAN  UsePremiumSourceA=FALSE,
		BOOLEAN  UseMetronet=FALSE,
		UNSIGNED PremiumSourceALimit=1,
		UNSIGNED MetronetLimit=1
		) := FUNCTION

		mac_get_records();

		Progressive_Phone.Layout_Progressive_Phones.Layout_EXP_Multiple_Phones setGatewayRequest(Experian_Phones.Layouts.base L) := TRANSFORM
			SELF.did:=L.did;
			SELF.Subj_First:=L.PIN_fname;
			SELF.Subj_Middle:=L.PIN_mname;
			SELF.Subj_Last:=L.PIN_lname;
			SELF.Subj_Suffix:=L.PIN_name_suffix;
			SELF.Phone_Score:=(STRING)L.score;
			SELF.ExperianPIN:=L.Encrypted_Experian_PIN;
			SELF.Phone_Last3Digits:=L.Phone_digits;
			SELF.Phones_Last3Digits:=DATASET([{(L.Phone_digits)}],progressive_phone.layout_progressive_phones.Phone_Last3Digits);
			SELF:=[];
		END;

		gatewayRequest  := PROJECT(notRestrictedExperianRecs,setGatewayRequest(LEFT));
		metronetGateway := Gateways(Gateway.Configuration.IsMetronet(servicename))[1];
	
      // call experian gateway only if No equifax recs exist.														
    gatewayResultsExperian  := IF(EXISTS(gatewayRequest) AND UseMetronet and NoEquifaxRecsExist,		                      
			                      Gateway.SoapCall_Metronet(gatewayRequest,MetronetGateway,2,0),
												DATASET([],progressive_phone.layout_progressive_phones.layout_exp_multiple_phones)
												);												

	
		premium_phone_rec xFormEquifax(notRestrictedEquifaxRecs L) := TRANSFORM
			clnAddr:=Address.GetCleanAddress(L.address,L.city+' '+L.state+' '+L.zipcode,address.Components.Country.US);
			SELF.did         :=(STRING)L.did;
			SELF.phoneno     :=L.phone;
			SELF.name_first  :=L.fname;
			SELF.name_middle :=L.mname;
			SELF.name_last   :=L.lname;
			SELF.name_suffix :=L.name_suffix;
			SELF.prim_range  :=clnAddr.results.prim_range;
			SELF.predir      :=clnAddr.results.predir;
			SELF.prim_name   :=clnAddr.results.prim_name;
			SELF.suffix      :=clnAddr.results.suffix;
			SELF.postdir     :=clnAddr.results.postdir;
			SELF.sec_range   :=clnAddr.results.sec_range;
			SELF.city        :=clnAddr.results.v_city;
			SELF.st          :=clnAddr.results.state;
			SELF.z5          :=clnAddr.results.zip;
			SELF.z4          :=clnAddr.results.zip4;
			SELF.vendor:=MDR.sourceTools.src_EQUIFAX;
			SELF:=[];
		END;	
												
    premium_phone_rec xFormExperian(gatewayResultsExperian L) := TRANSFORM
			SELF.did:=(STRING)L.did;
			SELF.listing_type_bus  := IF(TRIM(L.phpl_phones_plus_type)='B',L.phpl_phones_plus_type,'');
			SELF.listing_type_res  := IF(TRIM(L.phpl_phones_plus_type)='R',L.phpl_phones_plus_type,'');
			SELF.listing_type_cell := IF(TRIM(L.phpl_phones_plus_type)='M',L.phpl_phones_plus_type,'');
			SELF.phoneno     := L.subj_phone10;
			SELF.name_first  := L.subj_first;
			SELF.name_middle := L.subj_middle;
			SELF.name_last   := L.subj_last;
			SELF.name_suffix := L.subj_suffix;
			SELF.listed_name := L.subj_name_dual;
			SELF.phonetype := CASE(
				TRIM(L.phpl_phones_plus_type),
					'B' => 'Business',
					'R' => 'Residential',
					'M' => 'Mobile','');
			SELF.vendor:=MDR.sourceTools.src_Metronet_Gateway;
			SELF:=[];
		END;												
    // if Equifax recs exist return just them and forget about experian recs.
		// Otherwise return just the experian recs and no need to check
		// if they exist.
    retRes := IF (EXISTS(notRestrictedEquifaxRecs), PROJECT(notRestrictedEquifaxRecs,xFormEquifax(LEFT)),
		                PROJECT(gatewayResultsExperian,xFormExperian(LEFT))
										);
    // output(notRestrictedEquifaxRecs, named('notRestrictedEquifaxRecs'));	
		// output(NoEquifaxRecsExist, named('NoEquifaxRecsExist'));
		// output(gatewayResultsExperian, named('gatewayResultsExperian'));
		// output(gatewayResults, named('gatewayResults'));
		// output(retRes, named('retResWithMods'));
		
    return(retRes);										
	END;

END;