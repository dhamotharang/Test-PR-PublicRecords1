IMPORT corp2, corp2_raw_sc;
	
EXPORT Functions := MODULE

		//****************************************************************************
		//invalid_event_filing_cd: returns true or false based upon the incoming code.
		//****************************************************************************
		EXPORT invalid_event_filing_cd(STRING code) := FUNCTION
		
			 isValidCodeType := case(corp2.t2u(code),
															'ABR'									=> true,
															'ANP'									=> true,                             
															'FNE'									=> true,                             
															'MIL'									=> true,                             
															'RNW'									=> true,                             
															'ROA'									=> true,
															'AGT'									=> true,
														  'AMD'									=> true,
														  'ANG'									=> true,
														  'ASM'									=> true,
														  'AUT'									=> true,
														  'BAR'									=> true,
														  'BOR'									=> true,
														  'CDG'									=> true,
															'CON'									=> true,
														  'COP'									=> true,
														  'COR'									=> true,
														  'CPT'									=> true,
														  'DBA'									=> true,
														  'DIS'									=> true,
														  'DLC'									=> true,
														  'DLP'									=> true,
														  'ELA'									=> true,
														  'ELD'									=> true,
														  'ELE'									=> true,
														  'ELR'									=> true,
														  'ERR'									=> true,
														  'FAM'									=> true,
														  'FIC'									=> true,
														  'FLC'									=> true,
														  'FLP'									=> true,
														  'FOR'									=> true,
														  'GDS'									=> true,
														  'INC'									=> true,
														  'INT'									=> true,
															'JDN'									=> true, 
														  'LAR'									=> true,
														  'LIM'									=> true,
														  'LLC'									=> true,
														  'LLP'									=> true,	
														  'LPA'									=> true,
														  'LPR'									=> true,
														  'MER'									=> true,
														  'MSC'									=> true,
														  'NAG'									=> true,
															'NAL'									=> true,
															'NEW'									=> true, 
														  'PSC'									=> true,
														  'PSD'									=> true,
														  'REG'									=> true,																
														  'REI'									=> true,
														  'RES'									=> true,
														  'SHX'									=> true,
															'SPC'									=> true,
														  'SPD'									=> true,
														  'SPR'									=> true,
														  'WDR'									=> true,
															false
														 );

			 RETURN if(isValidCodeType,1,0);

		END;
		
END;
