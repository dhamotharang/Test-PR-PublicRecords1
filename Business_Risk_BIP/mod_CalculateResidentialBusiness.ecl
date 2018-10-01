IMPORT Business_Risk_BIP, BusinessInstantID20_Services, Models, STD;

EXPORT mod_CalculateResidentialBusiness( Business_Risk_BIP.Layouts.Shell le, BOOLEAN useSBFE = FALSE ) :=
	MODULE

		// Max length for the list fields to be imported into SAS (Technically SAS can handle 
		// up to 32,767 - but modeling only wants 1,000 to help with speed of imports).
		SHARED MaxSASLength := 1000; 
		
					

		// Fields from Business Shell 2.2 with SBFE
		SHARED ver_src_list            := Business_Risk_BIP.Common.truncate_list( STD.Str.ToUpperCase(le.Verification.sourcelist), MaxSASLength );
		SHARED addr_input_type_advo    := le.Input_Characteristics.InputAddrType;
		SHARED cons_record_match_addr  := le.Business_To_Person_Link.BusFEINPersonAddrOverlap;
		SHARED tin_match_cons_name     := le.Verification.FEINPersonNameMatch;
		SHARED sos_inc_filing_count    := le.SOS.SOSIncorporationCount;
		SHARED sbfe_business_structure := le.SBFE.SBFEFirmBusStructure;
		SHARED ver_src_id_count        := le.Verification.SourceCountID;
		SHARED sbfe_acct_cnt           := le.SBFE.SBFEAccountCount;

		// A BUSINESS IS NOT A SOLE PROP OR SOHO IF THE SELEID IS ON ANY OF THESE SOURCES
		SHARED _srcdf := Models.Common.findw_cpp(ver_src_list, 'DF' , ' ,', 'ie');
		SHARED _srci  := Models.Common.findw_cpp(ver_src_list,  'I' , ' ,', 'ie');
		SHARED _srcin := Models.Common.findw_cpp(ver_src_list, 'IN' , ' ,', 'ie');
		SHARED _srcos := Models.Common.findw_cpp(ver_src_list, 'OS' , ' ,', 'ie');
		SHARED _srcda := Models.Common.findw_cpp(ver_src_list, 'DA' , ' ,', 'ie');

		SHARED _srcexclude := (boolean)_srcdf or (boolean)_srci or (boolean)_srcin or (boolean)_srcos or (boolean)_srcda;

		// A BUSINESS MAY BE A SOLE PROP OR SOHO (Small Office / Home Office) IF,
		//   *  1. THERE IS A TIN AND NAME OR TIN AND ADDRESS MATCH ON THE CONSUMER HEADER, or
		//   *  2. THE INPUT BUSINESS ADDRESS APPEARS TO BE RESIDENTIAL
		SHARED _ResidentialAddr := addr_input_type_advo = 'A'; 
		SHARED _PersonNameSSN   := tin_match_cons_name = '1';
		SHARED _PersonAddrSSN   := cons_record_match_addr = '2';
				
		SHARED _PersonInd := _ResidentialAddr or _PersonNameSSN or _PersonAddrSSN;

		// A BUSINESS IS A SOHO IF IT APPEARS TO BE A PERSON WITH AN SOS REGISTRATION
		SHARED _ResidentialBusIndicator := 
			MAP(
				useSBFE AND (INTEGER)ver_src_id_count < 1 AND 
						(INTEGER)sbfe_acct_cnt < 1                               =>  '',
				NOT useSBFE AND (INTEGER)ver_src_id_count < 1                =>  '',
				_srcExclude                                                  => '0',         
				_PersonInd AND (INTEGER)sos_inc_filing_count > 0             => '2',   
				useSBFE AND sbfe_business_structure IN ['001','015'] AND 
						(INTEGER)sos_inc_filing_count > 0                        => '2',
				_PersonInd                                                   => '1',
				useSBFE AND sbfe_business_structure IN ['001','015']         => '1',
				/* default................................................. */  '0'
			);

		SHARED ResidentialBusDesc := 
			CASE( _ResidentialBusIndicator,
				'2'          => 'Potential SOHO',
				'1'          => 'Potential Sole Proprietor',
				'0'          => 'Commercial Address',
				/* default */   ''
			);
		
		EXPORT rw_ResidentialBusiness := 
			ROW( 
				{le.Seq, _ResidentialBusIndicator, ResidentialBusDesc }, 
				BusinessInstantID20_Services.Layouts.ResidentialBusLayout
			);

		EXPORT rw_null_ResidentialBusiness := 
			ROW( 
				{le.Seq, '', ''}, 
				BusinessInstantID20_Services.Layouts.ResidentialBusLayout
			);
		
	END;
		