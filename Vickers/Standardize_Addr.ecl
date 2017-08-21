IMPORT AID;

//////////////////////////////////////////////////////////////////////////////////////
// -- Apply AID process on the entire base recs for getting fresh address.
//////////////////////////////////////////////////////////////////////////////////////
EXPORT Standardize_Addr := module

export InsiderFF(DATASET(Vickers.Layouts_raw.common_FF_clean) pBaseFile) := module 

	tempLayout := RECORD
		STRING100 street_info;
		STRING50	city_st_zip;
		
		Vickers.Layouts_raw.common_FF_clean;
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
	
	line1 := IF(StringLib.StringFind(L.street, 'ATTN ', 1) > 0 or
		                   StringLib.StringFind(L.street, 'ATTN:', 1) > 0 or
		                   StringLib.StringFind(L.street, 'C/O', 1) > 0,
										'',
										L.street);
    line2 := IF(StringLib.StringFind(L.street2, 'ATTN ', 1) > 0 or
		               StringLib.StringFind(L.street2, 'ATTN:', 1) > 0 or
		               StringLib.StringFind(L.street2, 'C/O', 1) > 0,
								'',
								L.street2);
   

    // This utility takes care of trimming left and right automatically.
	  new_address1 := StringLib.StringCleanSpaces(line1 + ' ' + line2);

		

    // NOTE: All address pieces are already upper case, no need to apply that logic again.

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

	dWith_address		 := dPreAddrRec(HasAddress and trim(country) = 'USA');
	dWithout_address := dPreAddrRec(NOT(HasAddress) or trim(country) <> 'USA');

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, street_info, city_st_zip, raw_aid, dwithAID, lFlags);
	
	

	export dBase := PROJECT(dwithAID,
		               TRANSFORM(Vickers.Layouts_raw.common_FF_clean,
			                       SELF.ace_aid                           := LEFT.aidwork_acecache.aid;
			                       SELF.raw_aid                           := LEFT.aidwork_rawaid;
			                       SELF.clean_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
			                       SELF.clean_address.fips_county := LEFT.aidwork_acecache.county[3..];
			                       SELF.clean_address.zip					:= LEFT.aidwork_acecache.zip5;
			                       SELF.clean_address							:= LEFT.aidwork_acecache;
														 
			                       SELF := LEFT;)) + PROJECT(dWithout_address, Vickers.Layouts_raw.common_FF_clean);

	

END;


export cln_13d13g(DATASET(Vickers.Layouts_raw.Layout_13D13G_clean) pBaseFile) := module 

	tempLayout := RECORD
		STRING100 street_info;
		STRING50	city_st_zip;
		Vickers.Layouts_raw.Layout_13D13G_clean
	END;

	//////////////////////////////////////////////////////////////////////////////////////
	// -- fPreProcess
	// -- Get address ready for cleaning
	//////////////////////////////////////////////////////////////////////////////////////
	tempLayout tPreProcess(pBaseFile L) := TRANSFORM
	
	
	
	line3 := IF(StringLib.StringFind(L.contact_street, 'ATTN ', 1) > 0 or
		                   StringLib.StringFind(L.contact_street, 'ATTN:', 1) > 0 or
		                   StringLib.StringFind(L.contact_street, 'C/O', 1) > 0,
										'',
										L.contact_street);
  line4 := IF(StringLib.StringFind(L.contact_street2, 'ATTN ', 1) > 0 or
		               StringLib.StringFind(L.contact_street2, 'ATTN:', 1) > 0 or
		               StringLib.StringFind(L.contact_street2, 'C/O', 1) > 0,
								'',
								L.contact_street2);
   

    // This utility takes care of trimming left and right automatically.
	  new_address1 := StringLib.StringCleanSpaces(line3 + ' ' + line4);
    // NOTE: All address pieces are already upper case, no need to apply that logic again.

		new_address2 :=
		  StringLib.StringCleanSpaces(TRIM(L.contact_city) +
									                   IF(L.contact_city != '' AND (L.contact_state != '' OR L.contact_zip != ''), ', ', '') +
																	   TRIM(L.contact_state + ' ' + L.contact_zip[1..5]));

		SELF.street_info := new_address1;
		SELF.city_st_zip := new_address2;

		SELF := L;
	END;

	dPreAddrRec := PROJECT(pBaseFile, tPreProcess(LEFT));

	//////////////////////////////////////////////////////////////////////////////////////
	// -- Standardizes addresses using the AID macro
	//////////////////////////////////////////////////////////////////////////////////////
	HasAddress :=	dPreAddrRec.city_st_zip != '';
	
  Set of string us_st_ab_filter :=  ['AK','AK','AL','AL','AR','AZ','CA','CO','CT','DC','DE','FL','GA','HI',
                     'IA','ID','IL','IN','KS','KY','LA','MA','MD','ME','MI','MN','MO','MS',
                     'MT','NC','ND','NE','NH','NJ','NM','NV','NY','OH','OK','OR','PA','RI','SC',
                     'SD','TN','TX','UT','VA','VT','WA','WI','WV','WY' ];
										 
	dWith_address		 := dPreAddrRec(HasAddress and trim(contact_state) in us_st_ab_filter);
	dWithout_address := dPreAddrRec(NOT(HasAddress) or trim(contact_state) not in us_st_ab_filter);

	UNSIGNED4	lFlags := AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	

	AID.MacAppendFromRaw_2Line(dWith_address, street_info, city_st_zip, raw_aid, dwithAID, lFlags);

	export dBase := PROJECT(dwithAID,
		               TRANSFORM(Vickers.Layouts_raw.Layout_13D13G_clean,
			                       SELF.ace_aid                           := LEFT.aidwork_acecache.aid;
			                       SELF.raw_aid                           := LEFT.aidwork_rawaid;
			                       SELF.clean_contact_address.fips_state  := LEFT.aidwork_acecache.county[1..2];
			                       SELF.clean_contact_address.fips_county := LEFT.aidwork_acecache.county[3..];
			                       SELF.clean_contact_address.zip					:= LEFT.aidwork_acecache.zip5;
			                       SELF.clean_contact_address							:= LEFT.aidwork_acecache;
														 
			                       SELF := LEFT;)) + PROJECT(dWithout_address, Vickers.Layouts_raw.Layout_13D13G_clean);

	

END;

end;