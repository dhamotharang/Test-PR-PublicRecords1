EXPORT Constants := module

	export invalid_prim_name := ['NONE','UNKNOWN','UNKNWN','UNKNOWEN','UNKNONW','UNKNON','UNKNWON','UNKONWN','UNEKNOWN','UN KNOWN','GENERAL DELIVERY'];

	export pob       := 'POBOX|PO BOX| PO |.P O|P O|^(.*?)(.*p.*o.*box.*)(.*?)$';
	export digit1    := '([0-9]{1})';
	export alpha0    := '[a-zA-Z]+';
	export badname   := ['#','%','&','+','*','-','.','/'];
	export badname2  := '[*=%&+*/\'#]';
	export hyphen    := '--';
	export aptset    := ['APT','UNIT','STE','BLDG','LOT','#','APTS'];
	export selsource := ['#W',	'@W',	'[W',	'^W',	'1W',	'2W',	'4W',	'7W',	'AK',	'AM',	'AR',	'AY',	'BA',	'CG',	'CW',	'CY',	'DA',	
              'DE',	'DS',	'DU',	'E1',	'E2',	'E3',	'E4',	'EB',	'EW',	'FA',	'FC',	'FD',	'FE',	'FF',	'FR',	'GO',	'GW',	'HW',
              'IF',	'IW',	'JW',	'L2',	'LA',	'LI',	'LP',	'LT',	'LW',	'MW',	'NW',	'OW',	'PL',	'PN',	'PW',	'QW',	'RW',	
              'SL',	'SW',	'TS',	'TU',	'TW',	'VO',	'VW',	'WP',	'WW',	'YW',	'ZW'];						
	export junk     :=
									'%|ATTN|ATTENTION|ACCOUNTING|DEPARTMENT|DEPT|UNIVERSITY OF FLORIDA|CARE OF'
									+'|BAD ADDRESS|BADADDRESS|C/O|RESEARCH|CENTER OF|CENTER FOR|COLLEGE OF'
									+'|CHEMISTRY|CHEMICAL|MEDICINE|MEDICAL|EDUCATION'
									+'|COLL OF|COLLEDGE OF| OF |BUILDING|BLDG|PROGRAM|DIVISION|DIV OF|MUSEUM'
									+'|GAINESVILLE|OFFICE|GROUND|FLOOR|COMPLEX|HOUSING|MEDICAL|FRATERNITY'
									;

end;