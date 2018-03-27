IMPORT PRTE2_PropertyInfo, PRTE2_Common;

EXPORT Files := MODULE

	EXPORT Add_Foreign_prod					:= PRTE2_Common.Constants.Add_Foreign_prod;	
	// EXPORT Add_Old_Dataland					:= PRTE2_Common.Constants.Add_Old_Dataland;	

	EXPORT GATEWAY_NAME							:= PRTE2_PropertyInfo.Files.GATEWAY_NAME;
	EXPORT SUFFIX_NAME_XREF 				:= 'PROPERTY_XREF';
	EXPORT ENHANCED_NAME_BASE 			:= 'ENHANCED_XREF';
	EXPORT ENHANCED_COUNTERS_NAME 	:= 'ENHANCED_XREF_W_Counters';
	
	EXPORT Orig_50k_name						:= 'Orig_50k_Base';	
	EXPORT IN_PREFIX_NAME						:= '~PRCT::in::propertyscramble_custtest';
	EXPORT IN_PREFIX_NAME_XREF			:= '~PRCT::in::propertyscramble_custtest::xref';
	EXPORT BASE_PREFIX_NAME					:= '~PRCT::base::propertyscramble_custtest';
	EXPORT BASE_PREFIX_NAME_XRef		:= '~PRCT::base::propertyscramble_custtest::xref';
	EXPORT BASE_PREFIX_NAME_AAXRef	:= '~PRCT::base::propertyscramble_custtest::xref::addraddr';
	EXPORT BASE_PREFIX_NAME_NAXRef	:= '~PRCT::base::propertyscramble_custtest::xref::nameaddr';
	EXPORT BASE_PREFIX_NAME_ENXRef	:= '~PRCT::base::propertyscramble_custtest::xref::enhanced';

	EXPORT KEY_PREFIX_NAME        	:= '~PRCT::KEY::propertyscramble_custtest';
	EXPORT KEY_PREFIX_NAME_XRef    	:= '~PRCT::KEY::propertyscramble_custtest::xref';
	EXPORT SPRAYED_PREFIX_NAME    	:= '~PRCT::SPRAYED::propertyscramble_custtest';
	EXPORT XRef_CSV_FILE						:= BASE_PREFIX_NAME_XRef + '::CSV::' + SUFFIX_NAME_XREF;
	EXPORT CSV_1										:= IN_PREFIX_NAME + '::CSV_1';
	EXPORT CSV_1a										:= IN_PREFIX_NAME + '::CSV_1a';
	EXPORT CSV_1b										:= IN_PREFIX_NAME + '::CSV_1b';
	EXPORT CSV_2a										:= IN_PREFIX_NAME + '::CSV_2a';
	EXPORT CSV_2										:= IN_PREFIX_NAME + '::CSV_2';
	EXPORT CSV_3										:= IN_PREFIX_NAME + '::CSV_3';
	
	EXPORT FILE_SPRAY_XREF					:= SPRAYED_PREFIX_NAME + '::PROP_SCRAMBLE_XREF' + '_' + ThorLib.Wuid();

	// EXPORT SPRAYED_XREF_DS					:= DATASET(FILE_SPRAY_XREF, Layouts.Layout_Base_XRef,
	                                                 // CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	EXPORT SPRAYED_XREF_DS					:= DATASET(FILE_SPRAY_XREF, Layouts.Layout_Base_XRef_Enhanced,
	                                                 CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

/*
SF: thor::base::propertyscramble_custtest::xref::qa::property_xref - this is equivalent to the contents of the CSV used for input.
SF: thor::base::propertyscramble_custtest::xref::addraddr::qa::property_xref - RECNUM, address, is_property, is_condo, mapped address
SF: thor::base::propertyscramble_custtest::xref::nameaddr::qa::property_xref - RECNUM, name, address, is_custom, is_property, is_condo, mapped address
*/
	// This is the full XRef Format
	EXPORT XRef_Base_SF							:= BASE_PREFIX_NAME_XRef + '::qa::' + SUFFIX_NAME_XREF;
	EXPORT XRef_Base_SFPARTIAL					:= BASE_PREFIX_NAME_XRef + '_' + SUFFIX_NAME_XREF+'_Partial';
	EXPORT XRef_Base_SFNEW_SF					:= BASE_PREFIX_NAME_XRef + '::' + SUFFIX_NAME_XREF;
	EXPORT XRef_Base_SF_DS					:= DATASET(XRef_Base_SF, Layouts.Layout_Base_XRef, THOR);

	EXPORT XRef_Enhanced_SF					:= BASE_PREFIX_NAME_ENXRef + '::qa::' + ENHANCED_NAME_BASE;
	EXPORT XRef_Enhanced_SFPARTIAL					:= BASE_PREFIX_NAME_ENXRef + '_' + ENHANCED_NAME_BASE+'_Partial';
	EXPORT XRef_Enhanced_SFNEW_SF					:= BASE_PREFIX_NAME_ENXRef + '::' + ENHANCED_NAME_BASE;
	EXPORT XRef_Enhanced_SF_DS			:= DATASET(XRef_Enhanced_SF, Layouts.Layout_Base_XRef_Enhanced, THOR);

	EXPORT XRef_Enhanced_CNT_SF					:= BASE_PREFIX_NAME_ENXRef + '::qa::' + ENHANCED_COUNTERS_NAME;
	EXPORT XRef_Enhanced_CNT_SFPARTIAL					:= BASE_PREFIX_NAME_ENXRef + '_' + ENHANCED_COUNTERS_NAME+'_Partial';
	EXPORT XRef_Enhanced_CNT_SFNEW_SF					:= BASE_PREFIX_NAME_XRef + '::' + SUFFIX_NAME_XREF;
	EXPORT XRef_Enhanced_CNT_SF_DS			:= DATASET(XRef_Enhanced_CNT_SF, Layouts.Layout_Enhanced_with_Counters, THOR);


	EXPORT XRef_Base_SF_Father			:= BASE_PREFIX_NAME_XRef + '::father::' + SUFFIX_NAME_XREF;
	EXPORT XRef_Base_SF_DS_Father		:= DATASET(XRef_Base_SF_Father, Layouts.Layout_Base_XRef, THOR);

	// This is the Full Name-Addr Format with a RECNUM
	EXPORT XRef_NameAddrXRef				:= BASE_PREFIX_NAME_NAXRef + '::qa::' + SUFFIX_NAME_XREF;
	EXPORT XRef_NameAddrXRefPARTIAL				:= BASE_PREFIX_NAME_NAXRef + '_' + SUFFIX_NAME_XREF+'_Partial';
	EXPORT XRef_NameAddrXRefNEW_SF					:= BASE_PREFIX_NAME_XRef + '::' + SUFFIX_NAME_XREF;
	EXPORT XRef_NameAddrXRef_SF_DS	:= DATASET(XRef_NameAddrXRef, Layouts.Layout_NameAddr_XRef, THOR);
	
	// This is the thin Addr-Addr Format with a RECNUM (left the name off)
	EXPORT XRef_AddrAddrXRef				:= BASE_PREFIX_NAME_AAXRef + '::qa::' + SUFFIX_NAME_XREF;
	EXPORT XRef_AddrAddrXRefPARTIAL				:= BASE_PREFIX_NAME_AAXRef + '_' + SUFFIX_NAME_XREF+'_Partial';
	EXPORT XRef_AddrAddrXRefNEW_SF					:= BASE_PREFIX_NAME_XRef + '::' + SUFFIX_NAME_XREF;
	EXPORT XRef_AddrAddrXRef_SF_DS	:= DATASET(XRef_AddrAddrXRef, Layouts.Layout_AddrAddr_XRef, THOR);
	
	// MOVED scramble definitions out of PropertyInfo because they should not be there.
	SHARED SCRAMBLE_PREFIX_NAME := PRTE2_PropertyInfo.Files.SCRAMBLE_PREFIX_NAME;
	SHARED GATEWAY_SCRAMBLE 		:= PRTE2_PropertyInfo.Files.GATEWAY_SCRAMBLE;
	SHARED FILE_SPRAY 					:= PRTE2_PropertyInfo.Files.FILE_SPRAY;

	// EXPORT PII_Gateway_Scramble1				:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_1';
	// EXPORT PII_Gateway_Scramble1_DS			:= DATASET(PII_Gateway_Scramble1, Layouts_PII.PII_XRef_Layout1, THOR);
	// EXPORT PII_Gateway_Scramble2				:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_2';
	// EXPORT PII_Gateway_Scramble2_DS			:= DATASET(PII_Gateway_Scramble2, Layouts_PII.PII_XRef_Layout2, THOR);
	EXPORT SPRAYED_DS_X2								:= DATASET(FILE_SPRAY, Layouts_PII.PII_XRef_Layout2,
	                                   CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

	// EXPORT LNP_Gateway_Scramble1		:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_1';
	// EXPORT LNP_Gateway_Scramble1_DS	:= DATASET(LNP_Gateway_Scramble1, Layouts_LNP.LNP_XRef_Layout1, THOR);
	// EXPORT LNP_Gateway_Scramble2		:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_2';
	// EXPORT LNP_Gateway_Scramble2_DS	:= DATASET(LNP_Gateway_Scramble2, Layouts_LNP.LNP_XRef_Layout2, THOR);


	// EXPORT FRCL_Gateway_Scramble1				:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_1';
	// EXPORT FRCL_Gateway_Scramble1_DS		:= DATASET(FRCL_Gateway_Scramble1, Layouts_Foreclosures.FRCL_XRef_Layout1, THOR);
	// EXPORT FRCL_Gateway_Scramble2				:= SCRAMBLE_PREFIX_NAME + '::' + GATEWAY_SCRAMBLE+'_2';
	// EXPORT FRCL_Gateway_Scramble2_DS		:= DATASET(FRCL_Gateway_Scramble2, Layouts_Foreclosures.FRCL_XRef_Layout2, THOR);

		EXPORT SPRAY_50_Name		:=  SPRAYED_PREFIX_NAME+'::'+Orig_50k_name+ '_' + ThorLib.Wuid();
		EXPORT SPRAY_50_DS			:=	DATASET(SPRAY_50_Name,layouts.Original_50k_Layout,
	                                CSV(HEADING(1), SEPARATOR(','), TERMINATOR(['\n','\r\n']), QUOTE('"')));	

		EXPORT BASE_50k_Name		:=  BASE_PREFIX_NAME+'::'+Orig_50k_name;
		EXPORT BASE_50k_DS			:=	DATASET(BASE_50k_Name,layouts.Original_50k_Layout,THOR);

END;