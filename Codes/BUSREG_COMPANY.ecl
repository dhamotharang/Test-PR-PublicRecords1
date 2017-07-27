export BUSREG_COMPANY := 
MODULE
	export VARSTRING FILING_COD(string code) := MAP(
		code='D' => 'Domestic',  
		code='F' => 'Foreign',  
		'');

	export varstring STATUS(string code) := MAP(
		code = 'AB' => 'Abandonment',
		code = 'AC' => 'Active',
		code = 'AD' => 'Amended',
		code = 'AR' => 'Annual Report',
		code = 'BR' => 'Bankruptcy',
		code = 'CA' => 'Address Change',
		code = 'CC' => 'Cancelled',
		code = 'CH' => 'Change',
		code = 'CL' => 'Closed',
		code = 'CN' => 'Name Change',
		code = 'CO' => 'Owner Change',
		code = 'CR' => 'Correction',
		code = 'CTY' => 'Change Rate',
		code = 'DL' => 'Delinquent',
		code = 'DS' => 'Discontinued',
		code = 'EN' => 'Entry',
		code = 'EP' => 'Expunged',
		code = 'EX' => 'Expired',		
		code = 'FR' => 'Forfeiture',
		code = 'GS' => 'Good Standing',
		code = 'IA' => 'Inactive',
		code = 'IN' => 'Incomplete',
		code = 'MG' => 'Merged In',
		code = 'MO' => 'Merged Out',
		code = 'MS' => 'Merged Survivor',
		code = 'NW' => 'New',
		code = 'PD' => 'Pending',
		code = 'RE' => 'Resignation',
		code = 'RF' => 'Refile',
		code = 'RG' => 'Registration',
		code = 'RJ' => 'Rejected',
		code = 'RS' => 'Reinstated',
		code = 'RT' => 'Restricted',
		code = 'RV' => 'Revoked',
		code = 'SS' => 'Suspended',
		code = 'TF' => 'Transfer',
		code = 'TR' => 'Terminated',
		code = 'WD' => 'Withdrawal',
		'');
				
	export VARSTRING CORPCODE(string code) := MAP(
		code='AN' => 'Assumed Name',
		code='BL' => 'Business License',
		code='CP' => 'Secretary of State',
		code='DB' => 'DBA',
		code='FN' => 'Fictitious Name',
		code='OL' => 'Occupational License',
		code='TL' => 'Tax License',
		code='TN' => 'Trade Name',
		code='VL' => 'Vendor License',
		'');

	export VARSTRING SOS_CODE(string code) := MAP(
		code='AT' => 'Authority',
		code='BT' => 'Business Trust',
		code='CTY' => 'City',
		code='COL' => 'Collection Agency',
		code='COOP' => 'Cooperative',
		code='CP' => 'Corporation',
		code='CSO' => 'Credit Service Organization',
		code='DB' => 'DBA Name',
		code='EC' => 'Exempt Corp',
		code='FARM' => 'Farm',
		code='FIN' => 'Financial Institution (banks)',
		code='FIRE' => 'Fire Protection',
		code='FN' => 'Fictitious Name',
		code='FP' => 'For Profit',
		code='GP' => 'General Partner',
		code='HOS' => 'Hospital',
		code='HW' => 'Husband & Wife',
		code='IND' => 'Individual',
		code='INS' => 'Insurance',
		code='JV' => 'Joint Venture',
		code='LLC' => 'Limited Liability Company',
		code='LLP' => 'Limited Liability Partnership',
		code='LP' => 'Limited Partner',
		code='NP' => 'Non Profit',
		code='NR' => 'Name Reservation',
		code='NRG' => 'Name Registration',
		code='PCP' => 'Professional Corporation',
		code='PFP' => 'Purchaser of Future Payments',
		code='PLLC' => 'Professional LLC',
		code='PLLP' => 'Professional LLP',
		code='PTR' => 'Partner',
		code='RCP' => 'Reserved Corporation',
		code='RNP' => 'Reserved Non Profit',
		code='RLLC' => 'Reserved LLC',
		code='RLLP' => 'Reserved LLP',
		code='RLP' => 'Reserved LP',
		code='REL' => 'Religious',
		code='RR' => 'Railroad',
		code='SAN' => 'Sanitary',
		code='SCH' => 'School',
		code='SM' => 'Service Mark',
		code='SP' => 'Sole Proprietor',
		code='SOIL' => 'Soil',
		code='TM' => 'Trade Mark',
		code='TN' => 'Trade Name',
		code='TR' => 'Trust',
		code='UTY' => 'Utility',
		code='WTR' => 'Water',
		code='AN' => 'Assumed Name',
		code='AG' => 'Agriculture',
		code='BL' => 'Business License',
		code='LL' => 'Liquor License',
		code='OL' => 'Occupational License',
		code='TL' => 'Tax License',
		code='VL' => 'Vendor License',
		'');

export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'CORPCODE'	=>	CORPCODE(le.code),
				    le.field_name = 'SOS_CODE'	=>	SOS_CODE(le.code),
				    le.field_name = 'FILING_COD'	=>	FILING_COD(le.code),
                        le.field_name = 'STATUS'		=>   STATUS(le.code),
				    '');
				  
			SELF.code := IF(le.long_desc=translation,SKIP,le.code);
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='BUSREG_COMPANY', 
																		  field_name in ['CORPCODE','SOS_CODE','FILING_COD']),trans(LEFT));
	RETURN p;
		
	END;

END;