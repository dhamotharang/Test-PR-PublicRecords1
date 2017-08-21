EXPORT StandardizeAddr (DATASET(layout_aircraft_reg.innew) pBaseFile) := module 


Address.Layout_Clean182_fips clean_address;

	tempLayout := RECORD
		STRING100 street_info;
		STRING50	city_st_zip;
		layout_aircraft_reg.innew;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
    // NOTE: All address pieces are already upper case, no need to apply that logic again.
		new_address1 := StringLib.StringCleanSpaces(L.STREET + L.STREET2);

		new_address2 :=
		  StringLib.StringCleanSpaces(TRIM(L.CITY) +
									                   IF(L.CITY != '' AND (L.STATE != '' OR L.ZIP_CODE != ''), ', ', '') +
																	   TRIM(L.STATE + ' ' + L.ZIP_CODE[1..5]));

		SELF.street_info := new_address1;
		SELF.city_st_zip := new_address2;

		SELF := L;
	END;

	dPreAddrRec := PROJECT(pBaseFile, tPreProcess(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	dPreAddrRec.city_st_zip != '';

	dWith_address		 := dPreAddrRec(HasAddress);
	dWithout_address := dPreAddrRec(NOT(HasAddress));

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, street_info, city_st_zip, raw_aid, dwithAID, lFlags);

	export dBase := PROJECT(dwithAID,
		               TRANSFORM(layout_aircraft_reg.innew,
			                       SELF.ace_aid                           := LEFT.aidwork_acecache.aid;
			                       SELF.raw_aid                           := LEFT.aidwork_rawaid;
			                       SELF.clean_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
			                       SELF.clean_address.fips_county := LEFT.aidwork_acecache.county[3..];
			                       SELF.clean_address.zip					:= LEFT.aidwork_acecache.zip5;
			                       SELF.clean_address							:= LEFT.aidwork_acecache;
														 
			                       SELF := LEFT;)) + PROJECT(dWithout_address, layout_aircraft_reg.innew);

	

END;