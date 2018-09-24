IMPORT Codes, ut, lib_stringlib;

EXPORT EFX_STKEXC_TABLE :=
MODULE
	EXPORT VARSTRING STKEXC(STRING code) := ut.CleanSpacesAndUpper(
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
       StringLib.StringToUppercase(code)='A' => 'STOCKHOLM STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='B' => 'LISBON STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='C' => 'TOKYO STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='D' => 'DUSSELDORF STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='E' => 'BARCELONA/MADRID/MADRID FLOOR STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='F' => 'HELSINKI STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='G' => 'PRAGUE STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='H' => 'IRISH STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='I' => 'ITALIAN CONTINUOUS MARKET',
       StringLib.StringToUppercase(code)='J' => 'AUSTRALIAN STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='K' => 'CNSX (Canadian National Stock Exchange)',
       StringLib.StringToUppercase(code)='L' => 'LONDON STOCK EXCHANGE/LONDON STOCK EXCHANGE SETS',
       StringLib.StringToUppercase(code)='M' => 'MUNICH STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='N' => 'OSLO STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='O' => 'TORONTO STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='P' => 'EURONEXT PARIS',
       StringLib.StringToUppercase(code)='R' => 'RUSSIAN TRADING SYSTEM',
       StringLib.StringToUppercase(code)='S' => 'SWISS ELECTRONIC STOCK EXCHANGE/SWISS EXCHANGE',
       StringLib.StringToUppercase(code)='T' => 'ATHENS STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='U' => 'BUDAPEST STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='V' => 'TSX VENTURE EXCHANGE(TORONTO)',
       StringLib.StringToUppercase(code)='W' => 'WARSAW STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='X' => 'LUXEMBOURG STOCK EXCHANGE',
       StringLib.StringToUppercase(code)='Y' => 'OVER THE COUNTER BULLETIN BOARD EXCHANGE',
       StringLib.StringToUppercase(code)='Z' => 'OVER THE COUNTER EXCHANGE',       
			 code='' => '',
			 'INVALID'));	 

END;