IMPORT AID;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
EXPORT Standardize_Addr(DATASET(Layouts.Base) pBaseFile) := FUNCTION

	SHARED tempLayout := RECORD
		STRING50	city_st_zip;
		Layouts.Base;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
		SELF.city_st_zip :=
		  StringLib.StringCleanSpaces(
				StringLib.StringToUpperCase(TRIM(L.city) +
									                     IF(L.city != '' AND L.state != '', ', ', '') +
																			 TRIM(L.state)));

		SELF := L;
	END;

	dPreAddrRec := PROJECT(pBaseFile, tPreProcess(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	TRIM(dPreAddrRec.city_st_zip, LEFT, RIGHT) != '';

	dWith_address		 := dPreAddrRec(HasAddress);
	dWithout_address := dPreAddrRec(NOT(HasAddress));

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, address, city_st_zip, raw_aid, dwithAID, lFlags);

	dBase := PROJECT(dwithAID,
		               TRANSFORM(Layouts.Base,
			                       SELF.ace_aid                   := LEFT.aidwork_acecache.aid;
			                       SELF.raw_aid                   := LEFT.aidwork_rawaid;
			                       SELF.clean_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
			                       SELF.clean_address.fips_county := LEFT.aidwork_acecache.county[3..];
			                       SELF.clean_address.zip					:= LEFT.aidwork_acecache.zip5;
			                       SELF.clean_address							:= LEFT.aidwork_acecache;
														 
			                       SELF := LEFT;)) + PROJECT(dWithout_address, Layouts.Base);

	RETURN dBase;

END;