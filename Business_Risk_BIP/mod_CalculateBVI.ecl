IMPORT Business_Risk_BIP, BusinessInstantID20_Services, Models, STD;

EXPORT mod_CalculateBVI( Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE ) :=
	MODULE
		
		SHARED fein                          := le.input_echo.fein;
		SHARED rep_ssn                       := le.input_echo.rep_ssn;
		SHARED fein_input_contradictory_in   := le.Verification.FEINAddrNameMismatch;
		SHARED ver_name_src_count            := le.Verification.NameMatchSourceCount;
		SHARED ver_altnm_src_count			     := le.Verification.AltNameMatchSourceCount;
		SHARED ver_addr_src_count            := le.Verification.AddrVerificationSourceCount; 
		SHARED ver_phn_src_count             := le.Verification.PhoneMatchSourceCount;
		SHARED ver_phn_src_id_count          := le.Verification.PhoneMatchSourceCountID;
		SHARED ver_fein_src_count            := le.Verification.FEINMatchSourceCount;
		SHARED cons_record_match_name        := le.Business_To_Person_Link.BusAddrPersonNameOverlap;
		SHARED cons_record_match_altnm		   := le.Business_To_Person_Link.BusAddrPersonAltNameOverlap;
		SHARED cons_record_match_addr        := le.Business_To_Person_Link.BusFEINPersonAddrOverlap;
		SHARED e2b_rep1_name_on_file         := le.Business_To_Executive_Link.BusExecLinkAuthRepNameOnFile;
		SHARED e2b_rep1_idsearch_name        := le.Business_To_Executive_Link.AR2BRep1NameBusHeaderLexID;
		SHARED e2b_rep1_paw_match            := le.Business_To_Executive_Link.AR2BBusPAWRep1;
		SHARED e2b_rep1_match_bus_file_addr  := le.Business_To_Executive_Link.BusExecLinkAuthRepAddrBusAddr;
		SHARED e2b_rep1_match_bus_file_fein  := le.Business_To_Executive_Link.BusExecLinkAuthRepSSNBusFEIN;
		SHARED name_input_watchlist          := le.Verification.VerWatchlistNameMatch;
		SHARED altnm_input_watchlist			   := le.Verification.VerWatchlistAltNameMatch;
		SHARED addr_input_zipcode_ver        := le.Verification.AddrZipVerification;
		SHARED sbfe_name_input_mth_since_ls  := le.SBFE.SBFENameMatchMonthsLastSeen;
		SHARED sbfe_altnm_input_mth_since_ls := le.SBFE.SBFEAltNameMatchMonthsLastSeen;
		SHARED sbfe_addr_input_mth_since_ls  := le.SBFE.SBFEAddrMatchMonthsLastSeen;
		SHARED sbfe_phn_input_mth_since_ls   := le.SBFE.SBFEPhoneMatchMonthsLastSeen;
		SHARED sbfe_fein_input_mth_since_ls  := le.SBFE.SBFEFEINMatchMonthsLastSeen;
		SHARED sbfe_e2b_rep1_name_on_file    := le.SBFE.SBFEBusExecLinkRep1NameonFile;
		
		
		EXPORT _fein_input_contradictory_in := MAP(
				fein_input_contradictory_in = '1' => '|NAT|',
				fein_input_contradictory_in = '2' => '| AT|',
				fein_input_contradictory_in = '3' => '|N T|',
				fein_input_contradictory_in = '4' => '|  T|',
																					 '|   |');

		EXPORT ver_nam := ((INTEGER)ver_name_src_count > 0 OR (INTEGER)ver_altnm_src_count > 0) OR 
											(useSBFE AND ((INTEGER)sbfe_name_input_mth_since_ls >= 0 OR (INTEGER)sbfe_altnm_input_mth_since_ls >= 0));
		EXPORT ver_add := (INTEGER)ver_addr_src_count > 0 OR 
		                  (useSBFE AND (INTEGER)sbfe_addr_input_mth_since_ls >= 0);
		EXPORT ver_phn := (INTEGER)ver_phn_src_count > 0 OR (INTEGER)ver_phn_src_id_count > 0 OR 
		                  (useSBFE AND (INTEGER)sbfe_phn_input_mth_since_ls >= 0);
		EXPORT ver_tin := (INTEGER)ver_fein_src_count > 0 OR 
		                  (useSBFE AND (INTEGER)sbfe_fein_input_mth_since_ls >= 0);
		
		EXPORT ver_nam_flag := IF(ver_nam, 'N', ' ');
		EXPORT ver_add_flag := IF(ver_add, 'A', ' ');
		EXPORT ver_phn_flag := IF(ver_phn, 'P', ' ');
		EXPORT ver_tin_flag := IF(ver_tin, 'T', ' ');

		EXPORT napt_n := '|' + ver_nam_flag + ver_add_flag + ver_phn_flag + ver_tin_flag + '|';

		// Source counts can be less than zero if the Business was not found; ensure no counts are < 0.
		EXPORT _ver_name_src_count  := MAX( 0, (INTEGER)ver_name_src_count );
		EXPORT _ver_altnm_src_count := MAX( 0, (INTEGER)ver_altnm_src_count );
		EXPORT _ver_addr_src_count  := MAX( 0, (INTEGER)ver_addr_src_count );

		// Express as 1 or 0 whether SBFE data was seen in the past for the Business. This indicates 
		// the SBFE source count.
		EXPORT _sbfe_name_input_mth_since_ls  := (INTEGER)(useSBFE AND (INTEGER)sbfe_name_input_mth_since_ls >= 0);
		EXPORT _sbfe_altnm_input_mth_since_ls := (INTEGER)(useSBFE AND (INTEGER)sbfe_altnm_input_mth_since_ls >= 0);
		EXPORT _sbfe_addr_input_mth_since_ls  := (INTEGER)(useSBFE AND (INTEGER)sbfe_addr_input_mth_since_ls >= 0);

		// Calculate the higher source count total among the primary and alternate Business names.
		EXPORT prm_name_count := SUM( _ver_name_src_count, _sbfe_name_input_mth_since_ls );
		EXPORT alt_name_count := SUM( _ver_altnm_src_count, _sbfe_altnm_input_mth_since_ls );

		EXPORT name_src_count := MAX( prm_name_count, alt_name_count );
		
		EXPORT addr_src_count := SUM( _ver_addr_src_count, _sbfe_addr_input_mth_since_ls );

		EXPORT ver_cons_index := MAP(
				(cons_record_match_name = '2' OR cons_record_match_altnm = '2') AND cons_record_match_addr = '2' => '|NAT|',
				cons_record_match_name = '2' OR cons_record_match_altnm = '2'                                 	 => '|NA |',
				cons_record_match_addr = '2'                                 																		 => '| AT|',
				cons_record_match_addr = '1'                                																	   => '|  T|',
				cons_record_match_name = '1' OR cons_record_match_altnm = '1'																		 => '| A |',
																																																						'|   |');

		EXPORT BOOLEAN _e2b_rep1_name                   := e2b_rep1_name_on_file = '3' OR e2b_rep1_idsearch_name = '1' OR e2b_rep1_paw_match = '2' OR (useSBFE AND sbfe_e2b_rep1_name_on_file = '3');
		EXPORT BOOLEAN _e2b_rep1_match_bus_file_addr    := e2b_rep1_match_bus_file_addr = '1';
		EXPORT BOOLEAN _e2b_rep1_match_bus_in_fein      := TRIM((STRING)fein, ALL) != '' AND TRIM((STRING)rep_ssn, ALL) != '' AND TRIM((STRING)fein, ALL) = TRIM((STRING)rep_ssn, ALL);
		EXPORT BOOLEAN _e2b_rep1_match_bus_file_fein    := _e2b_rep1_match_bus_in_fein = TRUE AND e2b_rep1_match_bus_file_fein = '1';
		EXPORT STRING1 _e2b_rep1_name_fl                := IF(_e2b_rep1_name, 'N', ' ');
		EXPORT STRING1 _e2b_rep1_match_bus_file_addr_fl := IF(_e2b_rep1_match_bus_file_addr, 'A', ' ');
		EXPORT STRING1 _e2b_rep1_match_bus_file_fein_fl := IF(_e2b_rep1_match_bus_file_fein, 'T', ' ');

		EXPORT rep_bus_match := '|' + _e2b_rep1_name_fl + _e2b_rep1_match_bus_file_addr_fl + _e2b_rep1_match_bus_file_fein_fl + '|';

		EXPORT bvi_desc_key := MAP(
				(name_input_watchlist IN ['1', '2', '3'] OR altnm_input_watchlist IN ['1', '2', '3'] )     								=> '101',
				napt_n = '|NAPT|'                                                                          								=> '524',
				napt_n = '|NA T|'                                                                          								=> '523',
				_fein_input_contradictory_in = '|NAT|'                                                     								=> '523',
				napt_n = '|NAP |'                                                                          								=> '522',
				((INTEGER)ver_name_src_count > 1 OR (INTEGER)ver_altnm_src_count > 1) AND (INTEGER)ver_addr_src_count > 1 => '521',
				useSBFE AND (INTEGER)name_src_count > 1 and (INTEGER)addr_src_count > 1                    								=> '521',
				napt_n = '|NA  |'                                                                          								=> '421',
				napt_n = '|N PT|' AND (ver_cons_index IN ['|NAT|', '|NA |', '| AT|'])                      								=> '419',
				napt_n = '|N  T|' AND (ver_cons_index IN ['|NAT|', '|NA |', '| AT|'])                      								=> '418',
				_fein_input_contradictory_in = '|N T|' AND (ver_cons_index IN ['|NAT|', '|NA |', '| AT|']) 								=> '418',
				napt_n = '| APT|' AND (ver_cons_index IN ['|NAT|', '|NA |'])                               								=> '417',
				napt_n = '| A T|' AND (ver_cons_index IN ['|NAT|', '|NA |'])                               								=> '416',
				_fein_input_contradictory_in = '| AT|' AND (ver_cons_index IN ['|NAT|', '|NA |'])          								=> '416',
				napt_n = '|N P |' AND (ver_cons_index IN ['|NAT|', '|NA |', '| AT|'])                      								=> '415',
				napt_n = '|  PT|' AND (ver_cons_index IN ['|NAT|', '|NA |'])                               								=> '414',
				napt_n = '| AP |' AND (ver_cons_index IN ['|NAT|', '|NA |'])                               								=> '413',
				napt_n = '|N PT|' AND (rep_bus_match IN ['|NAT|', '|NA |'])                                								=> '405',
				napt_n = '|N  T|' AND (rep_bus_match IN ['|NAT|', '|NA |'])                                								=> '404',
				_fein_input_contradictory_in = '|N T|' AND (rep_bus_match IN ['|NAT|', '|NA |'])           								=> '404',
				napt_n = '| APT|' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '403',
				napt_n = '| A T|' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '402',
				_fein_input_contradictory_in = '| AT|' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])  								=> '402',
				napt_n = '|N P |' AND (rep_bus_match IN ['|NAT|', '|NA |'])                                								=> '401',
				napt_n = '|N PT|'                                                                          								=> '325',
				napt_n = '|N  T|'                                                                          								=> '324',
				_fein_input_contradictory_in = '|N T|'                                                     								=> '324',
				napt_n = '| APT|'                                                                          								=> '323',
				napt_n = '| A T|'                                                                          								=> '322',
				_fein_input_contradictory_in = '| AT|'                                                     								=> '322',
				napt_n = '|N P |'                                                                          								=> '321',
				napt_n = '|  PT|' AND ver_cons_index = '| AT|'                                             								=> '313',
				napt_n = '| AP |' AND ver_cons_index = '| AT|'                                             								=> '312',
				napt_n = '|  PT|'                                                                          								=> '223',
				napt_n = '| AP |'                                                                          								=> '222',
				ver_cons_index = '|NAT|'                                                                  					      => '412',
				ver_cons_index = '|NA |'                                                                   								=> '411',
				ver_cons_index = '| AT|'                                                                  							  => '311',
				napt_n = '|N   |' AND addr_input_zipcode_ver = '1'                                         								=> '221',
				napt_n = '|   T|' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '204',
				napt_n = '|N   |' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '203',
				napt_n = '| A  |' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '202',
				napt_n = '|  P |' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '201',
				napt_n = '|   T|'                                                                          								=> '124',
				_fein_input_contradictory_in = '|  T|'                                                     								=> '124',
				napt_n = '|N   |'                                                                          								=> '123',
				napt_n = '| A  |'                                                                          								=> '122',
				napt_n = '|  P |'                                                                          								=> '121',
				napt_n = '|    |' AND (rep_bus_match IN ['|NAT|', '|NA |', '|N T|'])                       								=> '102',
				/* default.............................................................................................. */  '000'
			);
		
		SHARED get_bvi_desc(STRING3 _bvi_desc_key) := 
			CASE( TRIM(_bvi_desc_key),
				'000' => 'Nothing verified',
				'101' => 'Input business name found on watchlist. ',
				'102' => 'Multiple authorized rep inputs verified on a business record (unable to verify business inputs).',
				'121' => 'Only input business phone could be found on a business record.',
				'122' => 'Only input business address could be found on a business record.',
				'123' => 'Only input business name could be found on a business record.',
				'124' => 'Input business FEIN is associated with a different business name and address. ',
				'201' => 'Input business phone verified on a business record and input authorized rep verified as a business contact.',
				'202' => 'Input business address verified on a business record and input authorized rep verified as a business contact.',
				'203' => 'Input business name verified on a business record and input authorized rep verified as a business contact.',
				'204' => 'Input business FEIN verified on a business record and input authorized rep verified as a business contact.',
				'221' => 'Input business name and zip code verified on a business record.',
				'222' => 'Input business address and phone verified on a business record.',
				'223' => 'Input business phone and FEIN verified on a business record.',
				'311' => 'Input business address and FEIN verified on a person record (unable to verify multiple business inputs).',
				'312' => 'Input business address, phone and FEIN verified across business records and a person record.',
				'313' => 'Input business address, phone and FEIN verified across business records and a person record.',
				'321' => 'Input business name and phone verified on a business record.',
				'322' => 'Input business address and FEIN verified on a business record.',
				'323' => 'Input business address, phone and FEIN verified on a business record.',
				'324' => 'Input business name and FEIN verified on a business record.',
				'325' => 'Input business name, phone and FEIN verified on a business record.',
				'401' => 'Input business name and phone verified on a business record and input authorized rep verified as a business contact.',
				'402' => 'Input business address and FEIN verified on a business record and input authorized rep verified as a business contact.',
				'403' => 'Input business address, phone and FEIN verified on a business record and input authorized rep verified as a business contact.',
				'404' => 'Input business name and FEIN verified on a business record and input authorized rep verified as a business contact.',
				'405' => 'Input business name, phone and FEIN verified on a business record and input authorized rep verified as a business contact.',
				'411' => 'Input business name and address verified on a person record (unable to verify multiple business inputs).',
				'412' => 'Input business name, address and FEIN verified on a person record (unable to verify multiple business inputs).',
				'413' => 'Input business name, address and phone verified across a business record and a person record. ',
				'414' => 'Input business name, address, phone and FEIN verified across a business record and a person record. ',
				'415' => 'Input business name, address and phone verified across a business record and a person record. ',
				'416' => 'Input business name, address and FEIN verified across a business record and a person record. ',
				'417' => 'Input business name, address, phone and FEIN verified across a business record and a person record. ',
				'418' => 'Input business name, address and FEIN verified across a business record and a person record. ',
				'419' => 'Input business name, address, phone and FEIN verified across a business record and a person record. ',
				'421' => 'Input business name and address verified on a business record.',
				'521' => 'Input business name and address verified on multiple sources on a business record.',
				'522' => 'Input business name, address and phone verified on a business record.',
				'523' => 'Input business name, address and FEIN verified on a business record.',
				'524' => 'Input business name, address, phone and FEIN verified on a business record. ',
				/* default */ ''
			);
			
		SHARED bvi_pre := ((INTEGER)bvi_desc_key) DIV 100 * 10;

		EXPORT bvi := IF( (STRING)bvi_pre = '0', '00', (STRING)bvi_pre );
		
		EXPORT bvi_desc := get_bvi_desc( bvi_desc_key );
	END;
	