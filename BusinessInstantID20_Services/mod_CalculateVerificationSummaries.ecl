/*2017-03-29T03:32:00Z (Chris Albee_prod)
Changes for CR5 (Alternate Company Name added to index calculations).
*/
IMPORT Business_Risk_BIP, STD;

EXPORT mod_CalculateVerificationSummaries( Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE ) :=
	MODULE
		SHARED ver_name_src_list   := le.Verification.NameMatchSourceList;
		SHARED ver_altnm_src_list  := le.Verification.AltNameMatchSourceList;
		SHARED ver_addr_src_list   := le.Verification.AddrVerificationSourceList;
		SHARED ver_fein_src_list   := le.Verification.FeinMatchSourceList;
		SHARED ver_phn_src_id_list := le.Verification.PhoneMatchSourceListID;
		SHARED ver_phn_src_list    := le.Verification.PhoneMatchSourceList;

		SHARED ver_name_src_set  := STD.Str.SplitWords(ver_name_src_list,',') + STD.Str.SplitWords(ver_altnm_src_list,',');
		SHARED ver_addr_src_set  := STD.Str.SplitWords(ver_addr_src_list,',');
		SHARED ver_fein_src_set  := STD.Str.SplitWords(ver_fein_src_list,',');
		SHARED ver_phone_src_set := STD.Str.SplitWords(ver_phn_src_id_list,',') + STD.Str.SplitWords(ver_phn_src_list,',');

		SHARED ver_name_src_ds  := DATASET( [ver_name_src_set], {STRING src_code} );
		SHARED ver_addr_src_ds  := DATASET( [ver_addr_src_set], {STRING src_code} );
		SHARED ver_fein_src_ds  := DATASET( [ver_fein_src_set], {STRING src_code} );
		SHARED ver_phone_src_ds := DATASET( [ver_phone_src_set], {STRING src_code} );
		
		SHARED sbfe_name_input_mth_since_ls := le.SBFE.SBFENameMatchMonthsLastSeen;
		SHARED sbfe_altnm_input_mth_since_ls := le.SBFE.SBFEAltNameMatchMonthsLastSeen;
		SHARED sbfe_addr_input_mth_since_ls := le.SBFE.SBFEAddrMatchMonthsLastSeen;
		SHARED sbfe_phn_input_mth_since_ls  := le.SBFE.SBFEPhoneMatchMonthsLastSeen;
		SHARED sbfe_fein_input_mth_since_ls := le.SBFE.SBFEFEINMatchMonthsLastSeen;

		SHARED getVerificationDesc( UNSIGNED1 src_index, BOOLEAN src_verifies_name, BOOLEAN src_verifies_addr, BOOLEAN src_verifies_fein, BOOLEAN src_verifies_phon ) := 
				CASE( src_index,
					4 => 'Input Business Name, Address, Phone, and FEIN verified',
					3 =>
						MAP(
							NOT src_verifies_name => 'Input Business Address, Phone, and FEIN verified',
							NOT src_verifies_addr => 'Input Business Name, Phone, and FEIN verified',
							NOT src_verifies_fein => 'Input Business Name, Address, and Phone verified',
							NOT src_verifies_phon => 'Input Business Name, Address, and FEIN verified',
							''
						),
					2 =>
						MAP(
							src_verifies_name AND src_verifies_addr => 'Input Business Name and Address verified',
							src_verifies_name AND src_verifies_phon => 'Input Business Name and Phone verified',
							src_verifies_name AND src_verifies_fein => 'Input Business Name and FEIN verified',
							src_verifies_addr AND src_verifies_phon => 'Input Business Address and Phone verified',
							src_verifies_addr AND src_verifies_fein => 'Input Business Address and FEIN verified',
							src_verifies_phon AND src_verifies_fein => 'Input Business Phone and FEIN verified',
							''
						),
					1 =>
						MAP(
							src_verifies_name => 'Input Business Name verified',
							src_verifies_addr => 'Input Business Address verified',
							src_verifies_fein => 'Input Business FEIN verified',
							src_verifies_phon => 'Input Business Phone verified',
							''
						),
					'No business inputs verified on this source'				
				);
			
		// ----------[ Bureau Sources ]----------
		
		SHARED ds_bureau_sources := 
			DATASET( 
				[ 
					{Business_Risk_BIP.Constants.Src_Bureau            , 'A'}, // 'ER'
					{Business_Risk_BIP.Constants.Src_ExperianCRDB      , 'B'}, // 'Q3'
					{Business_Risk_BIP.Constants.Src_DunnBradstreetFEIN, 'A'}, // 'DN'
					{Business_Risk_BIP.Constants.Src_ExperianFEIN      , 'B'}  // 'EF'
				], 
				{STRING2 source_code, STRING1 class} 
			);

		SHARED bureau_sources_verifies_name_pre := 
			COUNT( JOIN( ver_name_src_ds, ds_bureau_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		
		SHARED bureau_sources_verifies_addr_pre := 
			COUNT( JOIN( ver_addr_src_ds, ds_bureau_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
			
		SHARED bureau_sources_verifies_fein_pre := 
			COUNT( JOIN( ver_fein_src_ds, ds_bureau_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
			
		SHARED bureau_sources_verifies_phon_pre := 
			COUNT( JOIN( ver_phone_src_ds, ds_bureau_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;

		SHARED sbfe_source_verifies_name := useSBFE AND ((INTEGER)sbfe_name_input_mth_since_ls > 0 OR (INTEGER)sbfe_altnm_input_mth_since_ls > 0);
		SHARED sbfe_source_verifies_addr := useSBFE AND (INTEGER)sbfe_addr_input_mth_since_ls > 0;
		SHARED sbfe_source_verifies_fein := useSBFE AND (INTEGER)sbfe_fein_input_mth_since_ls > 0;
		SHARED sbfe_source_verifies_phon := useSBFE AND (INTEGER)sbfe_phn_input_mth_since_ls  > 0;

		SHARED bureau_sources_verifies_name := bureau_sources_verifies_name_pre OR sbfe_source_verifies_name;
		SHARED bureau_sources_verifies_addr := bureau_sources_verifies_addr_pre OR sbfe_source_verifies_addr;
		SHARED bureau_sources_verifies_fein := bureau_sources_verifies_fein_pre OR sbfe_source_verifies_fein;
		SHARED bureau_sources_verifies_phon := bureau_sources_verifies_phon_pre OR sbfe_source_verifies_phon;

		SHARED _ver_bureau_src_index := 
			SUM(
				(UNSIGNED)bureau_sources_verifies_name,
				(UNSIGNED)bureau_sources_verifies_addr,
				(UNSIGNED)bureau_sources_verifies_fein,
				(UNSIGNED)bureau_sources_verifies_phon
			);
		
		SHARED _ver_bureau_desc := getVerificationDesc( _ver_bureau_src_index, bureau_sources_verifies_name, bureau_sources_verifies_addr, bureau_sources_verifies_fein, bureau_sources_verifies_phon );
		
		// ----------[ Business Directory Sources ]----------
		
		SHARED ds_bus_directory_sources := 
			DATASET( 
				[ 
					{Business_Risk_BIP.Constants.Src_INFOUSA_ABIUS_USABIZ  , 'B'}, // 'IA'
					{Business_Risk_BIP.Constants.Src_DCA                   , 'A'}, // 'DF'
					{Business_Risk_BIP.Constants.Src_BBB_Non_Member        , 'B'}, // 'BN'
					{Business_Risk_BIP.Constants.Src_BBB_Member            , 'B'}, // 'BM'
					{Business_Risk_BIP.Constants.Src_TXBUS                 , 'B'}, // 'TX'
					{Business_Risk_BIP.Constants.Src_Frandx                , 'A'}, // 'L0'
					{Business_Risk_BIP.Constants.Src_CalBus                , 'B'}, // 'C#'
					{Business_Risk_BIP.Constants.Src_Prolic                , 'B'}, // 'PL'
					{Business_Risk_BIP.Constants.Src_SKA                   , 'B'}, // 'SK'
					{Business_Risk_BIP.Constants.Src_CA_Sales_Tax          , 'C'}, // 'FT'
					{Business_Risk_BIP.Constants.Src_INFOUSA_DEAD_COMPANIES, 'C'}, // 'IC'
					{Business_Risk_BIP.Constants.Src_Utility_sources       , 'C'}  // 'UT'
				], 
				{STRING2 source_code, STRING1 class} 
			);

		SHARED bus_directory_sources_verifies_name := COUNT( JOIN( ver_name_src_ds, ds_bus_directory_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED bus_directory_sources_verifies_addr := COUNT( JOIN( ver_addr_src_ds, ds_bus_directory_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED bus_directory_sources_verifies_fein := COUNT( JOIN( ver_fein_src_ds, ds_bus_directory_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED bus_directory_sources_verifies_phon := COUNT( JOIN( ver_phone_src_ds, ds_bus_directory_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;

		SHARED _ver_bus_directories_src_index := 
			(UNSIGNED)bus_directory_sources_verifies_name + (UNSIGNED)bus_directory_sources_verifies_addr + 
			(UNSIGNED)bus_directory_sources_verifies_fein + (UNSIGNED)bus_directory_sources_verifies_phon;
		
		SHARED _ver_bus_directories_desc := getVerificationDesc( _ver_bus_directories_src_index, bus_directory_sources_verifies_name, bus_directory_sources_verifies_addr, bus_directory_sources_verifies_fein, bus_directory_sources_verifies_phon );

		// ----------[ Phone Sources ]----------
		
		SHARED ds_phone_sources := 
			DATASET( 
				[ 
					{Business_Risk_BIP.Constants.Src_Gong        , 'C'}, // 'GB'
					{Business_Risk_BIP.Constants.Src_PhonesPlus  , 'C'}, // 'PP'
					{Business_Risk_BIP.Constants.Src_Yellow_Pages, 'B'}  // 'Y'
				], 
				{STRING2 source_code, STRING1 class} 
			);

		SHARED phone_sources_verifies_name := COUNT( JOIN( ver_name_src_ds, ds_phone_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED phone_sources_verifies_addr := COUNT( JOIN( ver_addr_src_ds, ds_phone_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED phone_sources_verifies_fein := COUNT( JOIN( ver_fein_src_ds, ds_phone_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED phone_sources_verifies_phon := COUNT( JOIN( ver_phone_src_ds, ds_phone_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;

		SHARED _ver_phone_src_index := 
			(UNSIGNED)phone_sources_verifies_name + (UNSIGNED)phone_sources_verifies_addr + 
			(UNSIGNED)phone_sources_verifies_fein + (UNSIGNED)phone_sources_verifies_phon;
		
		SHARED _ver_phone_desc := getVerificationDesc( _ver_phone_src_index, phone_sources_verifies_name, phone_sources_verifies_addr, phone_sources_verifies_fein, phone_sources_verifies_phon );

		// ----------[ Public Record Property Lien Sources ]----------
		
		SHARED ds_pubrec_filing_sources := 
			DATASET( 
				[ 
					{Business_Risk_BIP.Constants.Src_Property  , 'B'}, // 'P'
					{Business_Risk_BIP.Constants.Src_Watercraft, 'B'}, // 'WA'
					{Business_Risk_BIP.Constants.Src_Liens     , 'A'}, // 'L2'
					{Business_Risk_BIP.Constants.Src_Vehicles  , 'B'}, // 'V2'
					{Business_Risk_BIP.Constants.Src_Aircrafts , 'B'}  // 'AR'
				], 
				{STRING2 source_code, STRING1 class} 
			);

		SHARED pubrec_filing_sources_verifies_name := COUNT( JOIN( ver_name_src_ds, ds_pubrec_filing_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED pubrec_filing_sources_verifies_addr := COUNT( JOIN( ver_addr_src_ds, ds_pubrec_filing_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED pubrec_filing_sources_verifies_fein := COUNT( JOIN( ver_fein_src_ds, ds_pubrec_filing_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED pubrec_filing_sources_verifies_phon := COUNT( JOIN( ver_phone_src_ds, ds_pubrec_filing_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;

		SHARED _ver_pubrec_filing_src_index := 
			(UNSIGNED)pubrec_filing_sources_verifies_name + (UNSIGNED)pubrec_filing_sources_verifies_addr + 
			(UNSIGNED)pubrec_filing_sources_verifies_fein + (UNSIGNED)pubrec_filing_sources_verifies_phon;
		
		SHARED _ver_pubrec_filing_desc := getVerificationDesc( _ver_pubrec_filing_src_index, pubrec_filing_sources_verifies_name, pubrec_filing_sources_verifies_addr, pubrec_filing_sources_verifies_fein, pubrec_filing_sources_verifies_phon );

		// ----------[ Public Record Registration Sources ]----------

		SHARED ds_govt_reg_sources := 
			DATASET( 
				[ 
					{Business_Risk_BIP.Constants.Src_BusinessRegistration, 'A'}, // 'BR'
					{Business_Risk_BIP.Constants.Src_FBN                 , 'A'}, // 'FB'
					{Business_Risk_BIP.Constants.Src_IRS5500             , 'B'}, // 'I'
					{Business_Risk_BIP.Constants.Src_CorpV2              , 'A'}, // 'C'
					{Business_Risk_BIP.Constants.Src_CreditUnions        , 'B'}, // 'CU'
					{Business_Risk_BIP.Constants.Src_UCC                 , 'A'}, // 'U2'
					{Business_Risk_BIP.Constants.Src_IRS_Non_Profit      , 'B'}, // 'IN'
					{Business_Risk_BIP.Constants.Src_DEA                 , 'B'}, // 'DA'
					{Business_Risk_BIP.Constants.Src_FDIC                , 'B'}, // 'FI'
					{Business_Risk_BIP.Constants.Src_OSHA                , 'B'}, // 'OS'
					{Business_Risk_BIP.Constants.Src_Bankruptcy          , 'B'}, // 'BA'
					{Business_Risk_BIP.Constants.Src_Workers_Compensation, 'C'}  // 'WK'
				], 
				{STRING2 source_code, STRING1 class} 
			);
			
		SHARED govt_reg_sources_verifies_name := COUNT( JOIN( ver_name_src_ds, ds_govt_reg_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED govt_reg_sources_verifies_addr := COUNT( JOIN( ver_addr_src_ds, ds_govt_reg_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED govt_reg_sources_verifies_fein := COUNT( JOIN( ver_fein_src_ds, ds_govt_reg_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;
		SHARED govt_reg_sources_verifies_phon := COUNT( JOIN( ver_phone_src_ds, ds_govt_reg_sources, LEFT.src_code = RIGHT.source_code, INNER ) ) > 0;

		SHARED _ver_govt_reg_src_index := 
			(UNSIGNED)govt_reg_sources_verifies_name + (UNSIGNED)govt_reg_sources_verifies_addr + 
			(UNSIGNED)govt_reg_sources_verifies_fein + (UNSIGNED)govt_reg_sources_verifies_phon;
		
		SHARED _ver_govt_reg_desc := getVerificationDesc( _ver_govt_reg_src_index, govt_reg_sources_verifies_name, govt_reg_sources_verifies_addr, govt_reg_sources_verifies_fein, govt_reg_sources_verifies_phon );

		SHARED BusinessInstantID20_Services.Layouts.VerificationSummariesLayout xfm_verification_summaries := 
			TRANSFORM
				SELF.Seq                           := le.Seq;
				SELF.ver_phone_src_index           := _ver_phone_src_index;
				SELF.ver_phone_desc                := _ver_phone_desc; 
				SELF.ver_bureau_src_index          := _ver_bureau_src_index;
				SELF.ver_bureau_desc               := _ver_bureau_desc;
				SELF.ver_govt_reg_src_index        := _ver_govt_reg_src_index;
				SELF.ver_govt_reg_desc             := _ver_govt_reg_desc;
				SELF.ver_pubrec_filing_src_index   := _ver_pubrec_filing_src_index;
				SELF.ver_pubrec_filing_desc        := _ver_pubrec_filing_desc;
				SELF.ver_bus_directories_src_index := _ver_bus_directories_src_index;
				SELF.ver_bus_directories_desc      := _ver_bus_directories_desc;
				SELF := [];
			END;
			
		EXPORT rw_verification_summaries := ROW( xfm_verification_summaries );

		SHARED BusinessInstantID20_Services.Layouts.VerificationSummariesLayout xfm_verification_summaries_null := 
			TRANSFORM
				SELF.Seq := le.Seq;
				SELF     := [];
			END;
			
		EXPORT rw_verification_summaries_null := ROW( xfm_verification_summaries_null );
		
		EXPORT rw_result := IF( BusinessInstantID20_Services.fn_DoesNotMeetMinInputBusinessReqs( le ), rw_verification_summaries_null, rw_verification_summaries );

		EXPORT ver_phone_src_index           := (STRING)rw_result.ver_phone_src_index;
		EXPORT ver_bureau_src_index          := (STRING)rw_result.ver_bureau_src_index;
		EXPORT ver_govt_reg_src_index        := (STRING)rw_result.ver_govt_reg_src_index;
		EXPORT ver_pubrec_filing_src_index   := (STRING)rw_result.ver_pubrec_filing_src_index;
		EXPORT ver_bus_directories_src_index := (STRING)rw_result.ver_bus_directories_src_index;
		
	END;
	