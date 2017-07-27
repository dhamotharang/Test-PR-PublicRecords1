
IMPORT AddrBest, Address, ADVO, AutoStandardI, census_data, Codes, doxie, iesp, progressive_phone, 
       risk_indicators, Riskwise, ut;

EXPORT functions := MODULE

	EXPORT getAddressMetadata(DATASET(VerificationOfOccupancy.Layouts.Subject_Addresses) SubjectAddresses,
	                          STRING10 lat = '',
	                          STRING11 long = '',
	                          BOOLEAN isXML = FALSE) := FUNCTION
														
		// Get the input and current addresses
		CTAddressesAll :=	SubjectAddresses(AddressStatus IN ['TARGET', 'CURRENT']); 			
		CTAddressesAllSorted := SORT(UNGROUP(CTAddressesAll), Prim_Range, Prim_Name, Predir, Addr_Suffix, Sec_Range, Z5);
		
		// Rollup the addresses we got from the VOO Shell, combine the current and target if they are the same (So that we don't hit the keys twice for no good reason)
		VerificationOfOccupancy.Layouts.Subject_Addresses rollAddresses(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
			SELF.AddressStatus := MAP(le.AddressStatus = 'CT' OR ri.AddressStatus = 'CT' => 'CT', // Current/Target Address Merged
																(le.AddressStatus = 'TARGET' AND ri.AddressStatus = 'CURRENT') OR
																(ri.AddressStatus = 'TARGET' AND le.AddressStatus = 'CURRENT') => 'CT', // Merge Current/Target Address to avoid searching the keys twice for the same address
																																																	le.AddressStatus);
			// Keep these if populated
			SELF.DwellingType := IF(le.DwellingType = '', ri.DwellingType, le.DwellingType);
			SELF.AddrCleanerStatus := IF(le.AddrCleanerStatus = '', ri.AddrCleanerStatus, le.AddrCleanerStatus);
			SELF.County := IF(ri.AddressStatus IN ['TARGET', 'CT'], ri.County, le.County); // Keep the county for the Target address as this is the newer cleaned county
			SELF.Date := IF(le.Date = '', ri.Date, le.Date);
			SELF.Lat := IF(le.Lat = '', ri.Lat, le.Lat);
			SELF.Long := IF(le.Long = '', ri.Long, le.Long);
			SELF.DistanceFromTarget := 0;
			SELF := le;
		END;

		CTAddressesRolled := ROLLUP(CTAddressesAllSorted, LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																					LEFT.Predir = RIGHT.Predir AND LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND
																					LEFT.Sec_Range = RIGHT.Sec_Range AND LEFT.z5 = RIGHT.z5, rollAddresses(LEFT, RIGHT));

		//We need to display county name rather than county number so go pick up name here
		CTAddresses := join(CTAddressesRolled, census_data.Key_Fips2County, 
			keyed(left.st=right.state_code) and
			keyed(left.county=right.county_fips),
			transform(VerificationOfOccupancy.Layouts.Subject_Addresses, 
				self.county := right.county_name,
				self := left,
				self := []), left outer, KEEP(1), ATMOST(500));
		
		// Get the dwelling type and address cleaner status for addresses that don't have it (Addresses that we found from the header, not from Input as the Input should have already be cleaned)
		VerificationOfOccupancy.Layouts.Subject_Addresses getDwellType(VerificationOfOccupancy.Layouts.Subject_Addresses le) := TRANSFORM
			street_addr := Address.Addr1FromComponents(le.prim_range, le.predir, le.prim_name, le.addr_suffix, le.postdir, le.unit_desig, le.sec_range);
			clean_a2 := Risk_Indicators.MOD_AddressClean.clean_addr(street_addr, le.city_name, le.st, le.z5);
			SELF.DwellingType := Risk_Indicators.iid_constants.override_addr_type(street_addr, Address.CleanFields(clean_a2).rec_type[1], Address.CleanFields(clean_a2).cart);
			SELF.AddrCleanerStatus := Address.CleanFields(clean_a2).err_stat;
			thisLat := Address.CleanFields(clean_a2).Geo_Lat;
			thisLong := Address.CleanFields(clean_a2).Geo_Long;
			SELF.Lat := thisLat;
			SELF.Long := thisLong;
			
			SELF.DistanceFromTarget := IF(le.AddressStatus IN ['TARGET', 'CT'], 0,
																																					UT.LL_Dist((REAL)Lat, (REAL)Long, (REAL)thisLat, (REAL)thisLong));
			
			SELF := le;
		END;
		CTDwellStatus := PROJECT(CTAddresses (DwellingType = '' OR AddrCleanerStatus = '' OR Lat = '' OR Long = ''), getDwellType(LEFT));
		
		// Combine the newly cleaned header addresses with the already cleaned addresses
		CTAddressesClean := CTDwellStatus + (CTAddresses (DwellingType <> '' AND AddrCleanerStatus <> '' AND Lat <> '' AND Long <> ''));
			
		// At this point we have unique addresses, search for the metadata!
		ADVOAddressKey := ADVO.Key_Addr1_history;
		AddressRiskKey := Risk_Indicators.Key_HRI_Address_To_SIC;
		
		// Determine if the Address Cleaner thinks the Address is invalid
		VerificationOfOccupancy.Layouts.Subject_Addresses getInvalidAddr(VerificationOfOccupancy.Layouts.Subject_Addresses le) := TRANSFORM
			SELF.InvalidAddress := le.AddrCleanerStatus[1] = 'E'; // If the address cleaner returned an error with the address, mark it as invalid
			
			SELF := le;
		END;
		CTAddressesFinal := PROJECT(CTAddressesClean, getInvalidAddr(LEFT));
		
		// Get the ADVO (Valassis) Data
		VerificationOfOccupancy.Layouts.Subject_Addresses getADVO(VerificationOfOccupancy.Layouts.Subject_Addresses le, ADVOAddressKey ri) := TRANSFORM
			SELF.ADVOResidentialBusiness := TRIM(ri.Residential_Or_Business_Ind);
			SELF.ADVOType := TRIM(ri.Record_Type_Code);
			SELF.ADVOMixedUse := TRIM(ri.Mixed_Address_Usage);
			SELF.ADVOVacant := TRIM(ri.Address_Vacancy_Indicator) = 'Y';
			SELF.ADVOSeasonal := TRIM(ri.Seasonal_Delivery_Indicator) = 'Y';
		
			SELF := le;
		END;
		CTAddressesADVOTemp := JOIN(CTAddressesFinal, ADVOAddressKey, isXML AND LEFT.Z5 <> '' AND LEFT.Prim_Name <> '' AND
																						KEYED(LEFT.z5 = RIGHT.zip AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																									LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																									LEFT.Sec_Range = RIGHT.Sec_Range), 
																				getADVO(LEFT, RIGHT), LEFT OUTER, KEEP(100), ATMOST(RiskWise.max_atmost));
		
		// It's possible to get multiple ADVO Results, keep the most information we can
		VerificationOfOccupancy.Layouts.Subject_Addresses rollADVO(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
			SELF.ADVOResidentialBusiness := MAP(le.ADVOResidentialBusiness = 'D' OR ri.ADVOResidentialBusiness = 'D' => 'D',
																					le.ADVOResidentialBusiness = 'C' OR ri.ADVOResidentialBusiness = 'C' => 'C',
																					le.ADVOResidentialBusiness = 'B' OR ri.ADVOResidentialBusiness = 'B' => 'B',
																					le.ADVOResidentialBusiness = 'A' OR ri.ADVOResidentialBusiness = 'A' => 'A',
																																																									le.ADVOResidentialBusiness);
			SELF.ADVOType := IF(le.ADVOType = '', ri.ADVOType, le.ADVOType);
			SELF.ADVOMixedUse := IF(le.ADVOMixedUse = '', ri.ADVOMixedUse, le.ADVOMixedUse);
			SELF.ADVOVacant := le.ADVOVacant OR ri.ADVOVacant;
			SELF.ADVOSeasonal := le.ADVOSeasonal OR ri.ADVOSeasonal;
			
			SELF := le;
		END;
		CTAddressesADVOSorted := SORT(UNGROUP(CTAddressesADVOTemp), Z5, Prim_Range, Prim_Name, Addr_Suffix, Predir, Postdir, Sec_Range);
		
		CTAddressesADVO := ROLLUP(CTAddressesADVOSorted, LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																									LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																									LEFT.Sec_Range = RIGHT.Sec_Range, 
																				rollADVO(LEFT, RIGHT));
		
		// Get the High Risk Indicators for the Addresses
		VerificationOfOccupancy.Layouts.Subject_Addresses getHRI(VerificationOfOccupancy.Layouts.Subject_Addresses le, AddressRiskKey ri) := TRANSFORM
			SELF.CorrectionalFacility := ri.SIC_Code = '2225';
			
			SELF.HRIAddress := IF(ri.SIC_Code <> '', DATASET([{ri.SIC_Code, Codes.Various_HRI_Files.HRI_Code(ri.SIC_Code)}], Risk_Indicators.Layout_Desc),
																							 DATASET([], Risk_Indicators.Layout_Desc));
			
			SELF := le;
		END;
		CTAddressesMetadataTemp := JOIN(CTAddressesADVO, AddressRiskKey, LEFT.Z5 <> '' AND LEFT.Prim_Name <> '' AND
																						KEYED(LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Name = RIGHT.Prim_Name AND LEFT.Addr_Suffix = RIGHT.Suffix AND LEFT.Predir = RIGHT.Predir AND
																									LEFT.Postdir = RIGHT.Postdir AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Sec_Range = RIGHT.Sec_Range), 
																				getHRI(LEFT, RIGHT), LEFT OUTER, KEEP(100), ATMOST(RiskWise.max_atmost));

		// It's possible to get multiple results from the Address Risk Key, keep the most information we can
		VerificationOfOccupancy.Layouts.Subject_Addresses rollHRI(VerificationOfOccupancy.Layouts.Subject_Addresses le, VerificationOfOccupancy.Layouts.Subject_Addresses ri) := TRANSFORM
			SELF.CorrectionalFacility := le.CorrectionalFacility OR ri.CorrectionalFacility;
			
			// Keep Unique HRI's for this Address
			SELF.HRIAddress := DEDUP(SORT((le.HRIAddress + ri.HRIAddress), HRI), HRI);
			
			SELF := le;
		END;
		CTAddressesMetadataSorted := SORT(UNGROUP(CTAddressesMetadataTemp), Z5, Prim_Range, Prim_Name, Addr_Suffix, Predir, Postdir, Sec_Range);
		
		CTAddressesMetadata := ROLLUP(CTAddressesMetadataSorted, LEFT.Z5 = RIGHT.Z5 AND LEFT.Prim_Range = RIGHT.Prim_Range AND LEFT.Prim_Name = RIGHT.Prim_Name AND
																									LEFT.Addr_Suffix = RIGHT.Addr_Suffix AND LEFT.Predir = RIGHT.Predir AND LEFT.Postdir = RIGHT.Postdir AND
																									LEFT.Sec_Range = RIGHT.Sec_Range, 
																				rollHRI(LEFT, RIGHT));	
		RETURN CTAddressesMetadata;				
	END;
		
	EXPORT getPhonesPlusMetadata(doxie.layout_best best_rec) :=
		FUNCTION		
			progressive_phone.layout_progressive_batch_in xfm_build_input_rec := 
				TRANSFORM
					SELF.acctno      := '1';
					SELF.did         := best_rec.did; 
					SELF.ssn         := best_rec.ssn;
					SELF.name_first  := best_rec.fname;
					SELF.name_middle := best_rec.mname;
					SELF.name_last   := best_rec.lname;
					SELF.name_suffix := best_rec.name_suffix;
					SELF.dob         := (STRING)best_rec.dob;
					SELF.phoneno     := best_rec.phone;
					SELF.prim_range  := best_rec.prim_range;
					SELF.predir      := best_rec.predir;
					SELF.prim_name   := best_rec.prim_name;
					SELF.suffix      := best_rec.suffix;
					SELF.postdir     := best_rec.postdir;
					SELF.unit_desig  := best_rec.unit_desig;
					SELF.sec_range   := best_rec.sec_range;
					SELF.p_city_name := best_rec.city_name;
					SELF.st          := best_rec.st;
					SELF.z5          := best_rec.zip;
					SELF.z4          := best_rec.zip4;
					SELF := [];
				END;
				
			f_in_progressive_phone := DATASET([xfm_build_input_rec]);

			tmpMod :=
				MODULE(PROJECT(AutoStandardI.GlobalModule(),progressive_phone.iParam.Batch,OPT))
					EXPORT INTEGER MaxPhoneCount := 5; 
					EXPORT INTEGER CountPP       := 5; // PhonesPlus
					EXPORT INTEGER CountES       := 5; // EDA/Gong
					EXPORT INTEGER CountSE       := 5; // SkipTrace (Gong, Header)
				END;

			progressive_phone_recs := 
				AddrBest.Progressive_phone_common(
					f_in_progressive_phone, 
					tmpMod,
					useNeustar := TRUE		
				);

			// Project results into iesp.smartlinxReport.t_SLRBestPhone
			get_telcordia_rec(STRING subj_phone10) := 
				FUNCTION 
					tel1 := risk_indicators.Key_Telcordia_tds( KEYED(npa = subj_phone10[1..3] AND nxx = subj_phone10[4..6]) AND tb = subj_phone10[7] );
					
					tel2 := 
						JOIN(
							tel1, risk_indicators.Key_Telcordia_tpm, 
							KEYED(
								LEFT.npa = RIGHT.npa AND 
								LEFT.nxx = RIGHT.nxx
							) AND 
							LEFT.tb = RIGHT.tb, 
							KEEP(1), 
							LEFT OUTER
						);
						
					tel3 := 
						PROJECT( 
							tel2, 
							TRANSFORM( {RECORDOF(tel2), STRING tz}, 
								SELF.tz := 
									IF( 
										(LEFT.npa = '' and LEFT.nxx = '') OR LENGTH(TRIM(subj_phone10,ALL)) != 10, 
										LEFT.timezone, 
										ut.timeZone_Convert((UNSIGNED)LEFT.timezone, LEFT.state) 
									), 
								SELF := LEFT
							)
						);
						
					RETURN tel3[1];
				END;

			get_phone_type_desc(STRING3 npa, STRING3 COCType, STRING4 SSC) :=
				FUNCTION	
					phone_type :=  
						MAP(COCType IN ['EOC','PMC','RCC','SP1','SP2'] AND 
							 REGEXFIND('(C|R|S)',SSC) => 'Cellular',
							 REGEXFIND('B',      SSC) => 'Paging',
							 REGEXFIND('N',      SSC) => 'Landline',
							 ''  // default
						);
					RETURN phone_type;
				END;

			get_ssc_desc(STRING4 ssc) := 
				CASE( ssc[1], // Just get the first one.
					'A' => 'IntraLATA Use Only',
					'B' => 'Paging Services',
					'C' => 'Cellular Services',
					'I' => 'Pseudo 800 Service Code',
					'J' => 'Extended/expanded Calling scope',
					'M' => 'Local Mass Calling Code',
					'N' => 'N/A',
					'O' => 'Other',
					'R' => 'Two-way Conventional Mobile Radio',
					'S' => 'Miscellaneous Services',
					'T' => 'Time',
					'W' => 'Weather',
					'X' => 'Local Exchange IntraLATA Special Billing Option',
					'Z' => 'Selective Local Exchange IntraLATA Special Billing Option',
					'8' => 'Puerto Rico and U.S. Virgin Islands codes',
					''
				);
						
			iesp.smartlinxReport.t_SLRBestPhone xfm_intoSmartLinx(progressive_phone_recs le) :=
				TRANSFORM // See for comparison SmartRollup.fn_smart_getPhonesPlusMetadata.toESDL( )
				
					// Get Telcordia data, since by now it has been lost when phones data was converted
					// to layout_progressive_phone_common_plus.
					telcordia_rec   := get_telcordia_rec(le.subj_phone10);
					phone_type_desc := get_phone_type_desc(telcordia_rec.npa, telcordia_rec.COCType, telcordia_rec.SSC);
					
					SELF.AlsoFound                       := FALSE; // These records are not results of a WAF search...
					SELF.TelcordiaOnly                   := FALSE; // ...or of a Telcordia-only search.
					SELF.TypeFlag                        := ''; 
					SELF.UniqueId                        := (STRING)le.did;
					SELF.Name.First                      := le.subj_first;
					SELF.Name.Middle                     := le.subj_middle;
					SELF.Name.Last                       := le.subj_last;
					SELF.Address.StreetNumber            := le.prim_range;
					SELF.Address.StreetPreDirection      := le.predir;
					SELF.Address.StreetName              := le.prim_name;
					SELF.Address.StreetSuffix            := le.addr_suffix;
					SELF.Address.StreetPostDirection     := le.postdir;
					SELF.Address.UnitDesignation         := le.unit_desig;
					SELF.Address.UnitNumber              := le.sec_range;
					SELF.Address.City                    := le.p_city_name;
					SELF.Address.State                   := le.st;
					SELF.Address.Zip5                    := le.zip5;
					SELF.CompanyName                     := '',
					SELF.ListedName                      := TRIM(le.p_name_last) + ' ' + TRIM(le.p_name_first);
					SELF.Phone10                         := le.subj_phone10;
					SELF.TimeZone                        := telcordia_rec.tz; 
					SELF.CentralOfficeCode.Code          := telcordia_rec.coctype; 
					SELF.CentralOfficeCode.Descriptions  := DATASET( [{phone_type_desc}], iesp.share.t_StringArrayItem );
					SELF.SpecialServiceCode.Code         := telcordia_rec.ssc;
					SELF.SpecialServiceCode.Descriptions := DATASET( [{get_ssc_desc(telcordia_rec.SSC)}], iesp.share.t_StringArrayItem ); 
					SELF.DialIndicator                   := telcordia_rec.dial_ind = 'Y'; 
					SELF.PhoneRegion.City                := le.phpl_carrier_city;
					SELF.PhoneRegion.State               := le.phpl_carrier_state;
					SELF.CarrierName                     := le.phpl_phone_carrier;
					SELF.IsConfirmed                     := FALSE;
					SELF.ListedNameVerified              := '';
					SELF.NewType := 
						MAP( phone_type_desc = 'Cellular' => 'Possible Cell Phone', phone_type_desc = 'Landline' => 'Possible non-DA', '' );  // Naive implementation.
					SELF.VendorId                        := le.vendor;
					SELF.DateFirstSeen.Year              := (UNSIGNED)(le.subj_date_first[1..4]);
					SELF.DateFirstSeen.Month             := (UNSIGNED)(le.subj_date_first[5..6]);
					SELF.DateFirstSeen.Day               := 0;
					SELF.DateLastSeen.Year               := (UNSIGNED)(IF( le.subj_phone_date_last != '', le.subj_phone_date_last[1..4], le.subj_date_last[1..4] ));
					SELF.DateLastSeen.Month              := (UNSIGNED)(IF( le.subj_phone_date_last != '', le.subj_phone_date_last[5..6], le.subj_date_last[5..6] ));
					SELF.DateLastSeen.Day                := 0;
					SELF.PhoneFeedback                   := []; 
					SELF.ListingTypes                    := [];
					SELF.HighRiskIndicators              := [];
					SELF := [];	
				END;
				
			progressive_phone_recs_as_SmartLinx := PROJECT( progressive_phone_recs, xfm_intoSmartLinx(LEFT) );

			// OUTPUT( f_in_progressive_phone, NAMED('input_record') );
			// OUTPUT( progressive_phone_recs, NAMED('progressive_phone_recs') );
			// OUTPUT( phone_recs_as_SmartLinx, NAMED('as_SmartLinx') );
			
			RETURN progressive_phone_recs_as_SmartLinx;
		END;

		EXPORT createAddressRow(VerificationOfOccupancy.Layouts.Layout_address addr) :=
			FUNCTION
				iesp.share.t_Address xfm_createAddressRow := TRANSFORM
					SELF.StreetNumber        := addr.address_prim_range;
					SELF.StreetPreDirection  := addr.address_predir;
					SELF.StreetName          := addr.address_prim_name;
					SELF.StreetSuffix        := addr.address_suffix;
					SELF.StreetPostDirection := addr.address_postdir;
					SELF.UnitDesignation     := addr.address_unit_desig;
					SELF.UnitNumber          := addr.address_sec_range;
					SELF.StreetAddress1      := Address.Addr1FromComponents(addr.address_prim_range, addr.address_predir, addr.address_prim_name, addr.address_suffix, addr.address_postdir, addr.address_unit_desig, addr.address_sec_range);
					SELF.StreetAddress2      := '';
					SELF.City                := addr.address_city;
					SELF.State               := addr.address_state;
					SELF.Zip5                := addr.address_zip;
					SELF := [];		
				END;
				RETURN ROW(xfm_createAddressRow);
		END;
		
		EXPORT createDateRangeRow(VerificationOfOccupancy.Layouts.Layout_address addr) :=
			FUNCTION
				iesp.share.t_DateRange xfm_createDateRangeRow := TRANSFORM
					SELF.StartDate := ROW( { addr.address_date_first_seen DIV 100, addr.address_date_first_seen % 100, 0 }, iesp.share.t_Date ); // { YYYY, MM, DD }
					SELF.EndDate   := ROW( { addr.address_date_last_seen DIV 100, addr.address_date_last_seen % 100, 0 }, iesp.share.t_Date );   // { YYYY, MM, DD }
					SELF := [];		
				END;
				RETURN ROW(xfm_createDateRangeRow);			
			END;

END;