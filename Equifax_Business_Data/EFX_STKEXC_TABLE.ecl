IMPORT Codes;

EXPORT EFX_STKEXC_TABLE :=
MODULE
	EXPORT VARSTRING STKEXC(STRING code) :=
	  MAP(
		   code='1' => 'NYSE',
       code='2' => 'ASE',
       code='3' => 'NASDAQ',
       code='4' => 'XETRA',
       code='5' => 'COPENHAGEN STOCK EXCHANGE',
       code='6' => 'FRANKFURT STOCK EXCHANGE',
       code='7' => 'VIENNA STOCK EXCHANGE',
       code='8' => 'EURONEXT BRUSSELS',
       code='9' => 'OTHER',
       code='A' => 'STOCKHOLM STOCK EXCHANGE',
       code='B' => 'LISBON STOCK EXCHANGE',
       code='C' => 'TOKYO STOCK EXCHANGE',
       code='D' => 'DUSSELDORF STOCK EXCHANGE',
       code='E' => 'BARCELONA/MADRID/MADRID FLOOR STOCK EXCHANGE',
       code='F' => 'HELSINKI STOCK EXCHANGE',
       code='G' => 'PRAGUE STOCK EXCHANGE',
       code='H' => 'IRISH STOCK EXCHANGE',
       code='I' => 'ITALIAN CONTINUOUS MARKET',
       code='J' => 'AUSTRALIAN STOCK EXCHANGE',
       code='K' => 'CNSX (Canadian National Stock Exchange)',
       code='L' => 'LONDON STOCK EXCHANGE/LONDON STOCK EXCHANGE SETS',
       code='M' => 'MUNICH STOCK EXCHANGE',
       code='N' => 'OSLO STOCK EXCHANGE',
       code='O' => 'TORONTO STOCK EXCHANGE',
       code='P' => 'EURONEXT PARIS',
       code='R' => 'RUSSIAN TRADING SYSTEM',
       code='S' => 'SWISS ELECTRONIC STOCK EXCHANGE/SWISS EXCHANGE',
       code='T' => 'ATHENS STOCK EXCHANGE',
       code='U' => 'BUDAPEST STOCK EXCHANGE',
       code='V' => 'TSX VENTURE EXCHANGE(TORONTO)',
       code='W' => 'WARSAW STOCK EXCHANGE',
       code='X' => 'LUXEMBOURG STOCK EXCHANGE',
       code='Y' => 'OVER THE COUNTER BULLETIN BOARD EXCHANGE',
       code='Z' => 'OVER THE COUNTER EXCHANGE',       
			 code='' => '',
			 'INVALID');	 
			
export checkChanges :=
	FUNCTION
		
	codes.Layout_Codes_V3 trans(codes.File_Codes_V3_in le) :=
		TRANSFORM
			translation := 
				MAP(le.field_name = 'STKEXC' =>	STKEXC(le.code),
				    '');
	
			SELF.code := IF(stringlib.StringCleanSpaces(le.long_desc)=
                               stringlib.StringCleanSpaces(translation),SKIP,le.code);
						 
			SELF := le;
		END;
	
	p := PROJECT(codes.File_Codes_V3_in(file_name='STKEXC',field_name in ['STKEXC']
	),trans(LEFT));
	RETURN p;
		
	END;			 			 

END;