import corrections, CrimSrch, hygenics_crim, crim_common,ut;

string8 fMinDate2(string8 pDate1, string8 pDate2)
 := if(if((integer4)pDate1=0,'99999999',pDate1) < if((integer4)pDate2=0,'99999999',pDate2),
	   if((integer4)pDate1=0,'',pDate1),
	   if((integer4)pDate2=0,'',pDate2));

string8 fMinDate(string8 pDate1, string8 pDate2, string8 pDate3='', string8 pDate4='', string8 pDate5='', string8 pDate6='')
 := fMinDate2(pDate1,fMinDate2(pDate2,fMinDate2(pDate3,fMinDate2(pDate4,fMinDate2(pDate5,pDate6)))));

//Updated using LN Crim DOC Source Info
string1 fMapOffenseTypeToScore(string5 pVendor, string1 pOffenseType)
 := map(
        
    pVendor = 'DB' and pOffenseType = '	' => 'U',
		pVendor = 'DB' and pOffenseType = 'F' => 'F',
		pVendor = 'DB' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DA' and pOffenseType = '	' => 'U', //AL
		pVendor = 'DA' and pOffenseType = 'F' => 'F',
		pVendor = 'DA' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DD' and pOffenseType = '	' => 'U',
		pVendor = 'DD' and pOffenseType = 'F' => 'F',
		pVendor = 'DD' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DH' and pOffenseType = '	' => 'U',
		pVendor = 'DH' and pOffenseType = 'F' => 'F',
		pVendor = 'DH' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DG' and pOffenseType = 'F' => 'F',
		pVendor = 'DG' and pOffenseType = 'M' => 'M',
		pVendor = 'DG' and pOffenseType = '	' => 'U',
		
		pVendor = 'EQ' and pOffenseType = '	' => 'U',
		pVendor = 'EQ' and pOffenseType = 'F' => 'F',
		pVendor = 'EQ' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DI' and pOffenseType = '	' => 'U',
		pVendor = 'DI' and pOffenseType = 'M' => 'M',
		pVendor = 'DI' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EX' and pOffenseType = '	' => 'U',
		pVendor = 'EX' and pOffenseType = 'M' => 'M',
		pVendor = 'EX' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DJ' and pOffenseType = 'F' => 'F',
		pVendor = 'DJ' and pOffenseType = 'M' => 'M',
		pVendor = 'DJ' and pOffenseType = '	' => 'U',
		
		pVendor = 'DO' and pOffenseType = '	' => 'U',
		pVendor = 'DO' and pOffenseType = 'F' => 'F',
		pVendor = 'DO' and pOffenseType = 'M' => 'M',
				
		pVendor = 'DM' and pOffenseType = 'F' => 'F',
		pVendor = 'DM' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DQ' and pOffenseType = '	' => 'U',
		pVendor = 'DQ' and pOffenseType = 'F' => 'F',
		pVendor = 'DQ' and pOffenseType = 'M' => 'M',
		
		pVendor = 'DN' and pOffenseType = 'F' => 'F',
		pVendor = 'DN' and pOffenseType = 'M' => 'M',
		pVendor = 'DN' and pOffenseType = '	' => 'U',
		
		pVendor = 'SB' and pOffenseType = '	' => 'U',
		pVendor = 'SB' and pOffenseType = 'M' => 'M',
		pVendor = 'SB' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DR' and pOffenseType = '	' => 'U',
		pVendor = 'DR' and pOffenseType = 'M' => 'M',
		pVendor = 'DR' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DU' and pOffenseType = '	' => 'U',
		pVendor = 'DU' and pOffenseType = 'M' => 'M',
		pVendor = 'DU' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DT' and pOffenseType = '	' => 'U',
		pVendor = 'DT' and pOffenseType = 'M' => 'M',
		pVendor = 'DT' and pOffenseType = 'F' => 'F',
		
		
		pVendor = 'DV' and pOffenseType = '	' => 'U',
		pVendor = 'DV' and pOffenseType = 'M' => 'M',
		pVendor = 'DV' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DZ' and pOffenseType = '	' => 'U',
		pVendor = 'DZ' and pOffenseType = 'M' => 'M',
		pVendor = 'DZ' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EU' and pOffenseType = '	' => 'U',
		pVendor = 'EU' and pOffenseType = 'M' => 'M',
		pVendor = 'EU' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DY' and pOffenseType = '	' => 'U',
		pVendor = 'DY' and pOffenseType = 'M' => 'M',
		pVendor = 'DY' and pOffenseType = 'F' => 'F',
		
		pVendor = 'DX' and pOffenseType = '	' => 'U',
		pVendor = 'DX' and pOffenseType = 'M' => 'M',
		pVendor = 'DX' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EV' and pOffenseType = '	' => 'U',
		pVendor = 'EV' and pOffenseType = 'M' => 'M',
		pVendor = 'EV' and pOffenseType = 'U' => 'U',
		pVendor = 'EV' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EX' and pOffenseType = 'M' => 'M',
		pVendor = 'EX' and pOffenseType = 'F' => 'F',
		pVendor = 'EX' and pOffenseType = '	' => 'U',
		
		pVendor = 'EY' and pOffenseType = '	' => 'U',
		
		pVendor = 'EA' and pOffenseType = '	' => 'U',
		
		pVendor = 'EB' and pOffenseType = '	' => 'U',
		pVendor = 'EB' and pOffenseType = 'F' => 'F',
		pVendor = 'EB' and pOffenseType = 'M' => 'M',
		
		pVendor = 'EC' and pOffenseType = '	' => 'U',
		pVendor = 'EC' and pOffenseType = 'F' => 'F',
		pVendor = 'EC' and pOffenseType = 'M' => 'M',
		
		pVendor = 'ED' and pOffenseType = 'F' => 'F',
		pVendor = 'ED' and pOffenseType = 'M' => 'M',
		pVendor = 'ED' and pOffenseType = '	' => 'U',
		
		pVendor = 'EE' and pOffenseType = '	' => 'U',
		pVendor = 'EE' and pOffenseType = 'F' => 'F',
		pVendor = 'EE' and pOffenseType = 'M' => 'M',
		
		pVendor = 'EF' and pOffenseType = 'F' => 'F',
		pVendor = 'EF' and pOffenseType = 'M' => 'M',
		pVendor = 'EF' and pOffenseType = '	' => 'U',
		
		pVendor = 'EG' and pOffenseType = 'M' => 'M',
		pVendor = 'EG' and pOffenseType = 'F' => 'F',
		pVendor = 'EG' and pOffenseType = '	' => 'U',
		//pVendor = 'EG' and pOffenseType = 'C' => 'U', OR DOC
		
		pVendor = 'EH' and pOffenseType = '	' => 'U',
		pVendor = 'EH' and pOffenseType = 'M' => 'M',
		pVendor = 'EH' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EI' and pOffenseType = '	' => 'U',
		pVendor = 'EI' and pOffenseType = 'M' => 'M',
		pVendor = 'EI' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EJ' and pOffenseType = '	' => 'U',
		pVendor = 'EJ' and pOffenseType = 'M' => 'M',
		pVendor = 'EJ' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EK' and pOffenseType = '	' => 'U',
		pVendor = 'EK' and pOffenseType = 'M' => 'M',
		pVendor = 'EK' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EL' and pOffenseType = '	' => 'U',
		pVendor = 'EL' and pOffenseType = 'M' => 'M',
		pVendor = 'EL' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EM' and pOffenseType = 'U' => 'U',
		pVendor = 'EM' and pOffenseType = 'F' => 'F',
		pVendor = 'EM' and pOffenseType = 'D' => 'U',
		pVendor = 'EM' and pOffenseType = 'M' => 'M',
		pVendor = 'EM' and pOffenseType = 'I' => 'I', // VC 20151030 :New offense score
		pVendor = 'EM' and pOffenseType = 'S' => 'S',
		
		pVendor = 'EN' and pOffenseType = '	' => 'U',
		pVendor = 'EN' and pOffenseType = 'M' => 'M',
		pVendor = 'EN' and pOffenseType = 'F' => 'F',
		
		pVendor = 'EP' and pOffenseType = '	' => 'U',
		pVendor = 'EP' and pOffenseType = 'M' => 'M',
		pVendor = 'EP' and pOffenseType = 'F' => 'F',
		
		pVendor = 'ER' and pOffenseType = '	' => 'U',
		pVendor = 'ER' and pOffenseType = 'M' => 'M',
		pVendor = 'ER' and pOffenseType = 'F' => 'F',
		
		//LN Sources included until HD fixes their source
		pVendor = 'MI' and pOffenseType = '	' => 'U',
		pVendor = 'MT' and pOffenseType = '	' => 'U',
		pVendor = 'NC' and pOffenseType = '	' => 'U',
		pVendor = 'NC' and pOffenseType = 'M' => 'M',
		pVendor = 'NC' and pOffenseType = 'U' => 'U',
		pVendor = 'NC' and pOffenseType = 'F' => 'F',
		pVendor = 'OH' and pOffenseType = '	' => 'U',
		pVendor = 'OK' and pOffenseType = '	' => 'U',
		pVendor = 'OR' and pOffenseType = 'M' => 'M',
		pVendor = 'OR' and pOffenseType = 'F' => 'F',
		pVendor = 'OR' and pOffenseType = '	' => 'U',
		pVendor = 'OR' and pOffenseType = 'C' => 'U',
		pVendor = 'WA' and pOffenseType = '	' => 'U',
		pOffenseType = 'F' => 'F',
		pOffenseType = 'M' => 'M',
		
		'U');

string1 fMapOffenseLevelToScore(string5 pVendor, string2 pOffenseLevel, string8 pdate)
 := map(		
    //pVendor = 'DB' and pOffenseLevel = '  ' => 'U',		
		//pVendor = 'DD' and pOffenseLevel = '  ' => 'U',
		//pVendor = 'DH' and pOffenseLevel = '  ' => 'U', //
		// pVendor = 'DG' and pOffenseLevel = 'AF' => 'F', //CT
		// pVendor = 'DG' and pOffenseLevel = 'BF' => 'F', //
		// pVendor = 'DG' and pOffenseLevel = 'CF' => 'F', //
		// pVendor = 'DG' and pOffenseLevel = 'DF' => 'F', //
		// pVendor = 'DG' and pOffenseLevel = 'AM' => 'M', //
		// pVendor = 'DG' and pOffenseLevel = 'BM' => 'M', //
		// pVendor = 'DG' and pOffenseLevel = 'CM' => 'M', //
		// pVendor = 'DG' and pOffenseLevel = 'F ' => 'F', //
		// pVendor = 'DG' and pOffenseLevel = 'M ' => 'M', //
		// pVendor = 'DG' and pOffenseLevel = '  ' => 'U', //
		// pVendor = 'EQ' and pOffenseLevel = 'F ' => 'F',
		// pVendor = 'EQ' and pOffenseLevel = 'M ' => 'M',
		// pVendor = 'EQ' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'DI' and pOffenseLevel = 'P ' => 'M', //FL
		// pVendor = 'DI' and pOffenseLevel = '5 ' => 'F',
		// pVendor = 'DI' and pOffenseLevel = 'C ' => 'U',
		// pVendor = 'DI' and pOffenseLevel = '1 ' => 'F',
		// pVendor = 'DI' and pOffenseLevel = '2 ' => 'F',
		// pVendor = 'DI' and pOffenseLevel = 'L ' => 'U',
		// pVendor = 'DI' and pOffenseLevel = '3 ' => 'F',
		// pVendor = 'DI' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'DJ' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'DO' and pOffenseLevel = 'M ' => 'M',
		// pVendor = 'DO' and pOffenseLevel = 'F ' => 'F',

		// pVendor = 'DQ' and pOffenseLevel = 'A ' => 'F', //IL
		// pVendor = 'DQ' and pOffenseLevel = 'U ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = '2 ' => 'F',
		//pVendor = 'DQ' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'DQ' and pOffenseLevel = 'B ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = 'X ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = '1 ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = '4 ' => 'F',
		// pVendor = 'DQ' and pOffenseLevel = 'M ' => 'M',
		// pVendor = 'DQ' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'DN' and pOffenseLevel = 'FD' => 'F',
		pVendor = 'DN' and pOffenseLevel = 'MC' => 'M',
		pVendor = 'DN' and pOffenseLevel = 'CC' => 'U',
		pVendor = 'DN' and pOffenseLevel = 'FB' => 'F',
		pVendor = 'DN' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'DN' and pOffenseLevel = 'MA' => 'M',
		pVendor = 'DN' and pOffenseLevel = 'XX' => 'U',
		pVendor = 'DN' and pOffenseLevel = 'MB' => 'M',
		pVendor = 'DN' and pOffenseLevel = 'HO' => 'U',
		pVendor = 'DN' and pOffenseLevel = 'FA' => 'F',
		pVendor = 'DN' and pOffenseLevel = 'FC' => 'F',
		// pVendor = 'SB' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'SB' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'SB' and pOffenseLevel = 'D ' => 'F',
		// pVendor = 'SB' and pOffenseLevel = 'B ' => 'F',
		// pVendor = 'SB' and pOffenseLevel = 'E ' => 'F',
		// pVendor = 'SB' and pOffenseLevel = 'A ' => 'F',
		// pVendor = 'SB' and pOffenseLevel = 'U ' => 'U',
		pVendor = 'DR' and pOffenseLevel = 'FA' => 'F',
		pVendor = 'DR' and pOffenseLevel = 'FB' => 'F',
		pVendor = 'DR' and pOffenseLevel = 'FC' => 'F',
		pVendor = 'DR' and pOffenseLevel = 'FD' => 'F',
		pVendor = 'DR' and pOffenseLevel = 'FX' => 'F',
		pVendor = 'DU' and pOffenseLevel = '  ' => 'U', //added 20110317
		pVendor = 'DT' and pOffenseLevel = '  ' => 'U',
		pVendor = 'EU' and pOffenseLevel = '  '	=> 'U',
		pVendor = 'DX' and pOffenseLevel = 'F ' => 'F', //MT
		pVendor = 'DX' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'DX' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EV' and pOffenseLevel = 'B ' => 'F', //NC ok
		// pVendor = 'EV' and pOffenseLevel = '2 ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'A1' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'A ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'B2' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'F ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EV' and pOffenseLevel = 'B1' => 'F',
		// pVendor = 'EV' and pOffenseLevel = '1 ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'D ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'I ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'G ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = '3 ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'H ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'J ' => 'F',
		// pVendor = 'EV' and pOffenseLevel = 'E ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = '  ' => 'U', //NE may be ok 
		// pVendor = 'EX' and pOffenseLevel = 'I ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'A ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'E ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'F ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'B ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'D ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'H ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'EX' and pOffenseLevel = 'G ' => 'F',
		// pVendor = 'EY' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EA' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EB' and pOffenseLevel = 'F ' => 'F',
		// pVendor = 'EB' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EB' and pOffenseLevel = 'M ' => 'M',
		// pVendor = 'EB' and pOffenseLevel = 'CA' => 'F',
		// pVendor = 'EC' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EE' and pdate[1..4] >='1996' => 'F',		
		// pVendor = 'EG' and pOffenseLevel = 'B ' => 'F', //OR
		// pVendor = 'EG' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EG' and pOffenseLevel = 'A ' => 'F',
		// pVendor = 'EG' and pOffenseLevel = 'U ' => 'F',
		// pVendor = 'EG' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'EG' and pOffenseLevel = 'O ' => 'F',
		pVendor = 'EH' and pOffenseLevel = '  ' => 'U', //PA
		pVendor = 'EI' and pOffenseLevel = '  ' => 'U', //RI
		pVendor = 'EJ' and pOffenseLevel = '  ' => 'U',	//SC
		pVendor = 'EL' and pOffenseLevel = 'F'  => 'F',
		pVendor = 'EL' and pOffenseLevel = 'M'  => 'M',
		pVendor = 'EL' and pOffenseLevel = ' '  => 'U',
		// pVendor = 'EM' and pOffenseLevel = 'N ' => 'F', //UT
		// pVendor = 'EM' and pOffenseLevel = '1 ' => 'F',
		// pVendor = 'EM' and pOffenseLevel = '3 ' => 'F',
		// pVendor = 'EM' and pOffenseLevel = 'A ' => 'F',
		// pVendor = 'EM' and pOffenseLevel = 'M ' => 'M',
		// pVendor = 'EM' and pOffenseLevel = '  ' => 'U',
		// pVendor = 'EM' and pOffenseLevel = 'B ' => 'F',
		// pVendor = 'EM' and pOffenseLevel = 'C ' => 'F',
		// pVendor = 'EM' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'EN' and pOffenseLevel = '  ' => 'U',
		pVendor = 'EP' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'EP' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'ER' and pOffenseLevel = '  ' => 'U',
		pVendor = 'ES' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'ES' and pOffenseLevel = 'M ' => 'M',
		//pVendor = 'DA' and pOffenseLevel = '  ' => 'F', // AL
		//pVendor = 'ED'                          => 'F', // NY
		//pVendor = 'EF' 							            => 'F', // OK ask HD
		//pVendor = 'DV' and pOffenseLevel = '  ' => 'F', // MI 
		//pVendor = 'DM' and pOffenseLevel = '  ' => 'F', // ID ask
		//pVendor = 'DZ' and pOffenseLevel = '  ' => 'F',   // MN remove once HD fixed the data
		//pVendor = 'DY' and pOffenseLevel = '  ' => 'F',   // MS remove once HD fixed the data
		//pVendor = 'EK'                          => 'F',   // TN remove once HD fixes data
		
		//LN sources
		pVendor = 'MI' and pOffenseLevel = '  ' => 'F',
		pVendor = 'MT' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'MT' and pOffenseLevel = 'M ' => 'M',
		pVendor = 'MT' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NC' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '2 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A1' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'B2' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '  ' => 'U',
		pVendor = 'NC' and pOffenseLevel = 'B1' => 'F',
		pVendor = 'NC' and pOffenseLevel = '1 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'D ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'I ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'G ' => 'F',
		pVendor = 'NC' and pOffenseLevel = '3 ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'H ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'J ' => 'F',
		pVendor = 'NC' and pOffenseLevel = 'E ' => 'F',
		pVendor = 'OH' and pdate[1..4] >='1996' => 'F',
		pVendor = 'OK' 													=> 'F',
		pVendor = 'OR' and pOffenseLevel = 'B ' => 'F',
		pVendor = 'OR' and pOffenseLevel = '  ' => 'U',
		pVendor = 'OR' and pOffenseLevel = 'A ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'U ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'C ' => 'F',
		pVendor = 'OR' and pOffenseLevel = 'O ' => 'F',
		pVendor = 'WA' and pOffenseLevel = 'F ' => 'F',
		pVendor = 'WA' and pOffenseLevel = 'M ' => 'M',
		'U');
		
corrections.layout_offense tDOCOffensesandDOCOffendertoOffenses(corrections.layout_offense pDOCOffenses, corrections.layout_offender pDOCOffender)
 := transform
	self.offender_key					:= pDOCOffenses.offender_key;
	self.vendor								:= pDOCOffenses.vendor;
	self.fcra_offense_key			:= trim(pDOCOffenses.offender_key)+pDOCOffenses.offense_key;
	self.fcra_conviction_flag	:= if(pDOCOffenses.Vendor in sDOC_Vendors_Conviction_Unknown,'U','D');		// accommodate states where conviction unknown
	self.fcra_traffic_flag		:= 'N';
	
	/*self.fcra_date						:= fMinDate(pDOCOffenses.inc_adm_dt,pDOCOffenses.stc_dt,pDOCOffenses.ct_disp_dt,pDOCOffender.case_date);
	self.fcra_date_type				:= case(self.fcra_date,
																pDOCOffenses.inc_adm_dt => 'I',
																pDOCOffenses.stc_dt => 'S',
																pDOCOffenses.ct_disp_dt => 'D',
																pDOCOffender.case_date => 'F',
																'U'
																);
	*/															
	
  sent_begin_date	          := regexreplace('(Sent Start Date: )([0-9]+)[ ]*',pDOCOffenses.stc_desc_2,'$2');
	self.fcra_date	          := Map(hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.ct_disp_dt)     = 'Y' => pDOCOffenses.ct_disp_dt,
	                                 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.convict_dt)     = 'Y' => pDOCOffenses.convict_dt,
																	 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.stc_dt)         = 'Y' => pDOCOffenses.stc_dt,
																	 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.inc_adm_dt)     = 'Y' => pDOCOffenses.inc_adm_dt,
																	 hygenics_crim._functions.Is_valid(ut.getdate, sent_begin_date)             = 'Y' => sent_begin_date,
                                   '');
  self.fcra_date_type	      := Map(hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.ct_disp_dt)     = 'Y' => 'D',
	                                 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.convict_dt)     = 'Y' => 'C',
																	 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.stc_dt)         = 'Y' => 'S',
																	 hygenics_crim._functions.Is_valid(ut.getdate, pDOCOffenses.inc_adm_dt)     = 'Y' => 'I',
																	 hygenics_crim._functions.Is_valid(ut.getdate, sent_begin_date)             = 'Y' => 'B',
                                   '');																	
	self.conviction_override_date		:= if(pDOCOffenses.Vendor in sDOC_Vendors_Conviction_Unknown,
																' ',
															if((integer4)pDOCOffenses.ct_disp_dt<>0,
																pDOCOffenses.ct_disp_dt,
															if((integer4)pDOCOffenses.inc_adm_dt<>0,
																pDOCOffenses.inc_adm_dt,
															if((integer4)pDOCOffenses.off_date<>0,
																pDOCOffenses.off_date,
																pDOCOffenses.arr_date
																)
																)
																)
																);
	self.conviction_override_date_type	:= if(pDOCOffenses.Vendor in sDOC_Vendors_Conviction_Unknown,
											  ' ',
											  case(self.conviction_override_date,
												   pDOCOffenses.ct_disp_dt => 'D',
												   pDOCOffenses.inc_adm_dt => 'I',
												   pDOCOffenses.off_date => 'O',
												   pDOCOffenses.arr_date => 'A',
												   'U'
											      )
														);
	self.offense_score			:= 'U';
	self 										:= pDOCOffenses;
	self										:= pDOCOffender;
	self 										:= [];
end;

dDOCOffenderNoAKA	:= hygenics_crim.File_Offenders(data_type='1' and pty_typ='0');
dDOCOffensesDist 	:= distribute(hygenics_search.File_DOC_Offenses,hash(Offender_Key));
dDOCOffenderDist	:= distribute(dDOCOffenderNoAKA,hash(Offender_Key));
dDOCOffensesSort	:= sort(dDOCOffensesDist,	Offender_Key,local);
dDOCOffenderSort	:= sort(dDOCOffenderDist,	Offender_Key,local);
dDOCOffenderDedup	:= dedup(dDOCOffenderSort,Offender_Key,local);

dDOCOffensesJoined	:= join(dDOCOffensesSort,dDOCOffenderDedup,
												left.Offender_Key = right.Offender_Key,
												tDOCOffensesandDOCOffendertoOffenses(left,right),
												left outer,
												local
												);

corrections.layout_offense tScoreOffenseOnType(corrections.layout_offense pInput) := transform
	self.offense_score		:= fMapOffenseTypeToScore(pInput.vendor,pInput.off_typ);
	self									:= pInput;
end;

dDOCOffensesScoredOnType	:= project(dDOCOffensesJoined,tScoreOffenseOnType(left));

corrections.layout_offense tScoreOffenseOnLevel(corrections.layout_offense pInput) := transform
	self.offense_score		:= if(pInput.offense_score<>'U',pInput.offense_score,fMapOffenseLevelToScore(pInput.vendor,pInput.off_lev,pInput.inc_adm_dt));
	self									:= pInput;
end;

dDOCOffensesScoredOnLevel	:= project(dDOCOffensesScoredOnType,tScoreOffenseOnLevel(left));	

//Set Traffic Flag
set_off := ['V',/*'I',*/'C','T'];

	dDOCOffensesScoredOnLevel trecs(dDOCOffensesScoredOnLevel L) := transform
		self.fcra_traffic_flag 	:= if(L.offense_score in set_Off,
																	'Y',
																	L.fcra_traffic_flag );
		self 										:= L;
	end;								

#if(CrimSrch.Switch_ShouldUsePersists = CrimSrch.Switch_YesValue)
export DOC_Offenses_as_CrimSrch_Offenses
 := project(dDOCOffensesScoredOnLevel,trecs(left))
 : persist('persist::DOC_Offenses_as_CrimSrch_Offenses')
 ;
#else
export DOC_Offenses_as_CrimSrch_Offenses
 := dDOCOffensesScoredOnLevel : persist('persist::DOC_Offenses_as_CrimSrch_Offenses')
 ;
#end