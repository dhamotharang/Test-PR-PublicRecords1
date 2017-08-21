export Functions := module;

 export fTranslate_CorpCode(string in_val) := function
   ret_val := case(in_val,
                   'AN' => 'ASSUMED NAME',
                   'BL' => 'BUSINESS LICENSE',
                   'CP' => 'SECRETARY OF STATE',
                   'DB' => 'DBA',
                   'LL' => 'LIQUOR LICENSE',
                   'FN' => 'FICTITIOUS NAME',
									 'ML' => 'MERCHANTS LICENSE',
                   'OL' => 'OCCUPATIONAL LICENSE',
                   'TL' => 'TAX LICENSE',
                   'TN' => 'TRADE NAME',
                   'VL' => 'VENDOR LICENSE',
                   'UNKNOWN'
									);

   return ret_val;
	end;

 export fTranslate_SOSCode(string in_val) := function
   ret_val := case(in_val,
                   'AN'   => 'ASSUMED NAME',
                   'AG'   => 'AGRICULTURE',
                   'AT'   => 'AUTHORITY',
                   'BT'   => 'BUSINESS TRUST',
                   'CTY'  => 'CITY',
                   'COL'  => 'COLLECTION AGENCY',
                   'COOP' => 'COOPERATIVE',
                   'CP'   => 'CORPORATION',
                   'DB'   => 'DBA NAME',
                   'FARM' => 'FARM',
                   'FIN'  => 'FINANCIAL INSTITUTION (BANKS)',
                   'FIRE' => 'FIRE PROTECTION',
                   'FN'   => 'FICTITIOUS NAME',
                   'FP'   => 'FOR PROFIT',
                   'GP'   => 'GENERAL PARTNER',
                   'HOS'  => 'HOSPITAL',
                   'HW'   => 'HUSBAND & WIFE',
									 'INC'  => 'INCORPORATION',
                   'IND'  => 'INDIVIDUAL',
                   'INS'  => 'INSURANCE',
                   'JV'   => 'JOINT VENTURE',
                   'LLC'  => 'LIMITED LIABILITY COMPANY',
                   'LLP'  => 'LIMITED LIABILITY PARTNERSHIP',
									 'LLLP' => 'LIMITED LIABILITY LIMITED PARTNERSHIP',
                   'LP'   => 'LIMITED PARTNER',
                   'NP'   => 'NON PROFIT',
                   'NR'   => 'NAME RESERVATION',
                   'NRG'  => 'NAME REGISTRATION',
                   'PCP'  => 'PROFESSIONAL CORPORATION',
                   'PLLC' => 'PROFESSIONAL LLC',
                   'PLLP' => 'PROFESSIONAL LLP',
                   'PTR'  => 'PARTNER',
                   'RCP'  => 'RESERVED CORPORATION',
                   'RNP'  => 'RESERVED NON PROFIT',
                   'RLLC' => 'RESERVED LLC',
                   'RLLP' => 'RESERVED LLP',
                   'RLP'  => 'RESERVED LP',
                   'REL'  => 'RELIGIOUS',
                   'RR'   => 'RAILROAD',
                   'SAN'  => 'SANITARY',
                   'SCH'  => 'SCHOOL',
                   'SM'   => 'SERVICE MARK',
                   'SP'   => 'SOLE PROPRIETOR',
                   'SOIL' => 'SOIL',
                   'TM'   => 'TRADE MARK',
                   'TN'   => 'TRADE NAME',
                   'TR'   => 'TRUST',
                   'UTY'  => 'UTILITY',
                   'WTR'  => 'WATER',
									 'U'    => 'UNKNOWN', 
		               'UNKNOWN'
		              );

   return ret_val;
  end;

export fTranslate_Status(string in_val) := function
   ret_val := case(in_val,
                   'AB' => 'ABANDONMENT',
                   'AC' => 'ACTIVE, ACCEPTED, CURRENT',
                   'AD' => 'AMENDED',
                   'AR' => 'ANNUAL REPORT',
                   'CA' => 'ADDRESS CHANGE',
                   'BR' => 'BANKRUPTCY',
                   'CC' => 'CANCELLED',
                   'CH' => 'CHANGE',
                   'CL' => 'CLOSED',
                   'CN' => 'NAME CHANGE',
                   'CO' => 'OWNER CHANGE',
                   'CR' => 'CORRECTION',
                   'DL' => 'DELINQUENT',
                   'DS' => 'DISCONTINUED, DISSOLVED',
                   'EN' => 'ENTRY',
                   'EP' => 'EXPUNGED',
                   'EX' => 'EXPIRED',
                   'FR' => 'FORFEITURE',
                   'GS' => 'GOODSTANDING',
                   'IA' => 'INACTIVE',
                   'IN' => 'INCOMPLETE',
                   'MG' => 'MERGED IN',
                   'MO' => 'MERGED OUT',
                   'MS' => 'MERGED SURVIVOR',
                   'NW' => 'NEW',
                   'PD' => 'PENDING',
                   'RF' => 'REFILE, RENEWAL',
                   'RG' => 'REGISTRATION',
                   'RJ' => 'REJECTED',
                   'RV' => 'REVOKED',
                   'RS' => 'REINSTATED',
                   'SS' => 'SUSPENDED',
                   'TF' => 'TRANSFER',
                   'TR' => 'TERMINATED',
                   'WD' => 'WITHDRAWAL',
                   'UNKNOWN'
                  );

   return ret_val;
	end;

end;