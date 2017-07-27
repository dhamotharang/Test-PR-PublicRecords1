IMPORT AID;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
EXPORT Standardize_Addr(DATASET(Layouts.Base) pBaseFile) := FUNCTION

	tempLayout := RECORD
		STRING100 street_info;
		STRING50	city_st_zip;
		Layouts.Base;
	END;

  mi_base := pBaseFile(customer_id = _Constants().mi_cust_id);
	il_base := pBaseFile(customer_id = _Constants().il_cust_id);

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get MI address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
	  // General logic to remove non-address related material out of the address1-3 fields.  In
		// some cases, there's company name info. in these fields (nothing I can cleanly use either).
		//
		// 1) If address2 and address3 are blank, just use address1.
		// 2) If it's just address1 and address2, need to do a number check on address1.  If it has
		//    a number in it, then concat 1 and 2... otherwise use address2 only.
		// 3) If it's all 3, need to do a number check on 1 and 2.  If address1 has a number in it,
		//    concat all 3.  If address1 does't but address2 does have a number, then concat 2 and 3.
		//    If 1 and 2 have no numbers, then just use address3.

    address1_only := L.address2 = '' AND L.address3 = '';
		address1_and_2_only := L.address1 != '' AND L.address2 != '' AND L.address3 = '';
		address1_has_number := REGEXFIND('[0-9]', L.address1);
		address2_has_number := REGEXFIND('[0-9]', L.address2);

    // The TRIMs are likely unnecessary, doing it just in case.
	  address_info := MAP(address1_only       => TRIM(L.address1),
		                    address1_and_2_only => IF(address1_has_number,
												                          TRIM(L.address1 + ' ' + L.address2),
																						      TRIM(L.address2)),
												MAP(address1_has_number AND address2_has_number =>
												       TRIM(L.address1 + ' ' + L.address2 + ' ' + L.address3),
														address2_has_number => TRIM(L.address2 + ' ' + L.address3),
														L.address3));

    // NOTE: All address pieces are already upper case, no need to apply that logic again.
		new_address1 := StringLib.StringCleanSpaces(address_info);

		new_address2 :=
		  StringLib.StringCleanSpaces(TRIM(L.city) +
									                IF(L.city != '' AND (L.state != '' OR L.full_zip != ''), ', ', '') +
																	TRIM(L.state + ' ' + L.full_zip[1..5]));

		SELF.street_info := new_address1;
		SELF.city_st_zip := new_address2;

		SELF := L;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get IL address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tILPreProcess(pBaseFile L) := TRANSFORM
	  // Address1 is supposed to contain the attention line, Address2 is supposed to contain the 
		// address itself, and Address3 should contain suite/apt numbers and whatnot.  This is not
		// always the case, so attempting to account for it as best as possible.  The attention line
		// cannot simply be ignored, unfortunately, and address parts are not always in order.  I was 
		// thinking of attempting to correct the order, but sometimes it works, sometimes not.  So,
		// for now, filter out what I can and put it all together.
		//
		// 1) Blow away all care of (C/O) and ATTN address entries('ATTN ' and 'ATTN:'), they're useless.
		// 2) FYI: When the state is blank, it's a foreign address.

    attn_line := IF(StringLib.StringFind(L.address1, 'ATTN ', 1) > 0 or
		                   StringLib.StringFind(L.address1, 'ATTN:', 1) > 0 or
		                   StringLib.StringFind(L.address1, 'C/O', 1) > 0,
										'',
										L.address1);
    line1 := IF(StringLib.StringFind(L.address2, 'ATTN ', 1) > 0 or
		               StringLib.StringFind(L.address2, 'ATTN:', 1) > 0 or
		               StringLib.StringFind(L.address2, 'C/O', 1) > 0,
								'',
								L.address2);
    line2 := IF(StringLib.StringFind(L.address3, 'ATTN ', 1) > 0 or
		               StringLib.StringFind(L.address3, 'ATTN:', 1) > 0 or
		               StringLib.StringFind(L.address3, 'C/O', 1) > 0,
								'',
								L.address3);

    // This utility takes care of trimming left and right automatically.
	  new_address1 := StringLib.StringCleanSpaces(attn_line + ' ' + line1 + ' ' + line2);

		new_address2 :=
		  StringLib.StringCleanSpaces(TRIM(L.city) +
									                   IF(L.city != '' AND (L.state != '' OR L.full_zip != ''),
																	      ', ',
																		    '') +
																		 TRIM(L.state + ' ' + L.full_zip[1..5]));

		SELF.street_info := new_address1;
		SELF.city_st_zip := new_address2;

		SELF := L;
	END;

	dMIPreAddrRec := PROJECT(mi_base, tPreProcess(LEFT));
	dILPreAddrRec := PROJECT(il_base, tILPreProcess(LEFT));
	dPreAddrRec := dMIPreAddrRec + dILPreAddrRec;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	dPreAddrRec.city_st_zip != '';

	dWith_address		 := dPreAddrRec(HasAddress);
	dWithout_address := dPreAddrRec(NOT(HasAddress));

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, street_info, city_st_zip, raw_aid, dwithAID, lFlags);

	dBase := PROJECT(dwithAID,
		               TRANSFORM(Layouts.Base,
			                       SELF.ace_aid                           := LEFT.aidwork_acecache.aid;
			                       SELF.raw_aid                           := LEFT.aidwork_rawaid;
			                       SELF.clean_company_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
			                       SELF.clean_company_address.fips_county := LEFT.aidwork_acecache.county[3..];
			                       SELF.clean_company_address.zip					:= LEFT.aidwork_acecache.zip5;
			                       SELF.clean_company_address							:= LEFT.aidwork_acecache;

			                       SELF := LEFT;)) + PROJECT(dWithout_address, Layouts.Base);

	RETURN dBase;

END;