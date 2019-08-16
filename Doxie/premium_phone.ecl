IMPORT Address, doxie, MDR, moxie_phonesplus_server, PhoneMart, Suppress, ut;

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
      UNSIGNED4 global_sid := 0;
      UNSIGNED8 record_sid := 0;
		END;
    
		inputPhoneDigitRecs := DEDUP(SORT(PROJECT(phones,TRANSFORM(workPhoneRec,
			SELF.did:=dids[1].did;SELF.phone:=LEFT.phone,
			SELF.phone_digits:=LEFT.phone[MAX(1,LENGTH(TRIM(LEFT.phone))-2)..]
			)),did,phone),did,phone);

		// EQUIFAX
		inhouseEquifaxRecs_pre := DEDUP(SORT(JOIN(dids,PhoneMart.key_phonemart_did,
			KEYED(LEFT.did=RIGHT.l_did) AND RIGHT.history_flag='',
			TRANSFORM(RECORDOF(PhoneMart.key_phonemart_did),SELF:=RIGHT),
			LIMIT(ut.limits.PHONE_PER_PERSON,SKIP)),phone,-dt_last_seen),phone);

    inhouseEquifaxRecs := Suppress.MAC_SuppressSource(inhouseEquifaxRecs_pre, mod_access);
    
		notInInputPhonesRecs := JOIN(inputPhoneDigitRecs,inhouseEquifaxRecs,
			LEFT.did=RIGHT.did AND LEFT.phone=RIGHT.phone,
			TRANSFORM(RECORDOF(PhoneMart.key_phonemart_did),SELF:=RIGHT),RIGHT ONLY);
         
		notRestrictedEquifaxRecs := IF(UsePremiumSourceA AND mod_access.dataRestrictionMask[24] IN ['0',''],
			TOPN(notInInputPhonesRecs,PremiumSourceALimit,-dt_last_seen),DATASET([],RECORDOF(PhoneMart.key_phonemart_did)));
      
	ENDMACRO;

	EXPORT get_count(
		DATASET(doxie.layout_references) dids,
		DATASET(phone_rec) phones,
		doxie.IDataAccess mod_access,
		BOOLEAN  UsePremiumSourceA=FALSE,
		UNSIGNED PremiumSourceALimit=1
		) := FUNCTION
    
		mac_get_records();
	 // only return counts of experianRecs if EquifaxRecs don't exist at all
	 // since the NonRestrictedExperianRecs is nulled out in above attr 'notRestrictedExperianRecs'
	 // if there exists equifaxRecs
				RETURN COUNT(notRestrictedEquifaxRecs);
   								
									
	END;

	EXPORT get_records(
		DATASET(doxie.layout_references) dids,
		DATASET(phone_rec) phones,
		doxie.IDataAccess mod_access,
		BOOLEAN  UsePremiumSourceA=FALSE,
		UNSIGNED PremiumSourceALimit=1
			) := FUNCTION
    
		mac_get_records();
		
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
												
   
    // if Equifax recs exist return just them and forget about experian recs.
		// Otherwise return just the experian recs and no need to check
		// if they exist.
    retRes := PROJECT(notRestrictedEquifaxRecs,xFormEquifax(LEFT));		                
			
			// output(notRestrictedEquifaxRecs, named('notRestrictedEquifaxRecs'));	
		// output(NoEquifaxRecsExist, named('NoEquifaxRecsExist'));
		// output(gatewayResultsExperian, named('gatewayResultsExperian'));
		// output(gatewayResults, named('gatewayResults'));
		// output(retRes, named('retResWithMods'));	
    
    return(retRes);										
	END;

END;