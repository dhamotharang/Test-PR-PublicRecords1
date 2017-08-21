import mdr;
export Codes := module



export is_valid_vendor(string vendor = ''):= if(vendor in ['header','pcnsr', 'intrado', 'targus', 'gongh', 'cellphones', 'infutor', 'infutorcid'], true, false);


export vendor_code(string vendor = '')   := map(vendor = 'header' 		=> 'HD',
												vendor = 'pcnsr'  		=> 'PC',
												vendor = 'intrado'		=> 'IN',
												vendor = 'targus'		=> 'WP',
												vendor = 'gongh'		=> 'GH',
												vendor = 'infutor'   	=> 'IF',
												vendor = 'paw'   		=> 'PA',
												vendor = 'infutorcid'	=> 'IC',
												//cellphone vendors
												vendor = 'KROLL'	    => '01',
												vendor = 'TRAFFIX'	    => '02',
												vendor = 'NEXTONES'	    => '05',

												'');
												
export vendor_name(string vendor_code = ''):= map(vendor_code = 'HD' 	=> 'HEADER',
												vendor_code = 'PC'  	=> 'PCONSUMER',
												vendor_code = 'IN'		=> 'INTRADO',
												vendor_code = 'WP'		=> 'WHITE PAGES',
												vendor_code	= 'GH'		=> 'GONG HISTORY',
												vendor_code = 'IF'   	=> 'INFUTOR',
												vendor_code = 'IC'	    => 'INFUTOR CID',
												//cellphone vendors
												vendor_code = '01'	    => 'CELL - KROLL',
												vendor_code = '02'	    => 'CELL - TRAFFIX',
												vendor_code = '05'	    => 'CELL - NEXTONES',

												'??');



export initial_score(string vendor = '') := map(vendor = 'header' 		=> 3,
												vendor = 'pcnsr'  		=> 5,
												vendor = 'intrado'		=> 11,
												vendor = 'targus'		=> 6,
												vendor = 'gongh'		=> 3,
												vendor = 'cellphones'	=> 11,
												vendor = 'infutor'   	=> 0,
												vendor = 'infutorcid'  	=> 10,
												//Paw Sources
												vendor = 'ZM'   		=> 4,
												vendor = 'BR' 			=> 3,
												vendor = 'D'			=> 3,
												//Header Sources
												vendor = '!E' 			=> 3,
												vendor = '!W' 			=> 3,
												vendor = '#E' 			=> 3,
												vendor = '#W' 			=> 3,
												vendor = '$E' 			=> 3,
												vendor = '&E' 			=> 3,
												vendor = '+E' 			=> 3,
												vendor = '.E' 			=> 3,
												vendor = '1W' 			=> 3,
												vendor = '1X' 			=> 3,
												vendor = '2W' 			=> 3,
												vendor = '2X' 			=> 3,
												vendor = '3W' 			=> 3,
												vendor = '3X' 			=> 3,
												vendor = '4W' 			=> 3,
												vendor = '4X' 			=> 3,
												vendor = '5W' 			=> 3,
												vendor = '5X' 			=> 3,
												vendor = '6W' 			=> 3,
												vendor = '6X' 			=> 3,
												vendor = '7W' 			=> 3,
												vendor = '7X' 			=> 3,
												vendor = '8X' 			=> 3,
												vendor = '9W' 			=> 3,
												vendor = '9X' 			=> 3,
												vendor = '?E' 			=> 3,
												vendor = '@E' 			=> 3,
												vendor = '@W' 			=> 3,
												vendor = 'AD' 			=> 3,
												vendor = 'AE' 			=> 3,
												vendor = 'AK' 			=> 3,
												vendor = 'AM' 			=> 3,
												vendor = 'AR' 			=> 3,
												vendor = 'AV' 			=> 3,
												vendor = 'BA' 			=> 3,
												vendor = 'BE' 			=> 3,
												vendor = 'BX' 			=> 3,
												vendor = 'CD' 			=> 3,
												vendor = 'CE' 			=> 3,
												vendor = 'CG' 			=> 3,
												vendor = 'CW' 			=> 3,
												vendor = 'CY' 			=> 3,
												vendor = 'DA' 			=> 3,
												vendor = 'DD' 			=> 3,
												vendor = 'DS' 			=> 3,
												vendor = 'DW' 			=> 3,
												vendor = 'E1' 			=> 3,
												vendor = 'E2' 			=> 3,
												vendor = 'E3' 			=> 3,
												vendor = 'E4' 			=> 3,
												vendor = 'EB' 			=> 3,
												vendor = 'ED' 			=> 3,
												vendor = 'EE' 			=> 3,
												vendor = 'EM' 			=> 3,
												vendor = 'EQ' 			=> 3,
												vendor = 'EV' 			=> 3,
												vendor = 'EW' 			=> 3,
												vendor = 'FA' 			=> 3,
												vendor = 'FB' 			=> 3,
												vendor = 'FD' 			=> 3,
												vendor = 'FE' 			=> 3,
												vendor = 'FF' 			=> 3,
												vendor = 'FP' 			=> 3,
												vendor = 'FR' 			=> 3,
												vendor = 'FV' 			=> 3,
												vendor = 'FW' 			=> 3,
												vendor = 'GE' 			=> 3,
												vendor = 'GW' 			=> 3,
												vendor = 'HE' 			=> 3,
												vendor = 'HW' 			=> 3,
												vendor = 'ID' 			=> 3,
												vendor = 'IE' 			=> 3,
												vendor = 'IV' 			=> 3,
												vendor = 'IW' 			=> 3,
												vendor = 'JE' 			=> 3,
												vendor = 'JW' 			=> 3,
												vendor = 'KD' 			=> 3,
												vendor = 'KE' 			=> 3,
												vendor = 'KV' 			=> 3,
												vendor = 'KW' 			=> 3,
												vendor = 'L2' 			=> 3,
												vendor = 'LA' 			=> 3,
												vendor = 'LE' 			=> 3,
												vendor = 'LI' 			=> 3,
												vendor = 'LP' 			=> 3,
												vendor = 'LV' 			=> 3,
												vendor = 'LW' 			=> 3,
												vendor = 'ME' 			=> 3,
												vendor = 'MU' 			=> 3,
												vendor = 'MV' 			=> 3,
												vendor = 'MW' 			=> 3,
												vendor = 'ND' 			=> 3,
												vendor = 'NE' 			=> 3,
												vendor = 'NV' 			=> 3,
												vendor = 'NW' 			=> 3,
												vendor = 'OD' 			=> 3,
												vendor = 'OE' 			=> 3,
												vendor = 'OV' 			=> 3,
												vendor = 'OW' 			=> 3,
												vendor = 'PD' 			=> 3,
												vendor = 'PE' 			=> 3,
												vendor = 'PL' 			=> 3,
												vendor = 'PV' 			=> 3,
												vendor = 'PW' 			=> 3,
												vendor = 'PQ' 			=> 3,
												vendor = 'QE' 			=> 3,
												vendor = 'QV' 			=> 3,
												vendor = 'QW' 			=> 3,
												vendor = 'RE' 			=> 3,
												vendor = 'RV' 			=> 3,
												vendor = 'RW' 			=> 3,
												vendor = 'SD' 			=> 3,
												vendor = 'SE' 			=> 3,
												vendor = 'SL' 			=> 3,
												vendor = 'SW' 			=> 3,
												vendor = 'TD' 			=> 3,
												vendor = 'TE' 			=> 3,
												vendor = 'TS' 			=> 0,
												vendor = 'TV' 			=> 3,
												vendor = 'TW' 			=> 3,
												vendor = 'UE' 			=> 3,
												vendor = 'UT' 			=> 3,
												vendor = 'UW' 			=> 3,
												vendor = 'VD' 			=> 3,
												vendor = 'VE' 			=> 3,
												vendor = 'VO' 			=> 3,
												vendor = 'VW' 			=> 3,
												vendor = 'WD' 			=> 3,
												vendor = 'WE' 			=> 3,
												vendor = 'WP' 			=> 3,
												vendor = 'WV' 			=> 3,
												vendor = 'WW' 			=> 3,
												vendor = 'XE' 			=> 3,
												vendor = 'XV' 			=> 3,
												vendor = 'XW' 			=> 3,
												vendor = 'XX' 			=> 3,
												vendor = 'YD' 			=> 3,
												vendor = 'YV' 			=> 3,
												vendor = 'YW' 			=> 3,
												vendor = 'ZE' 			=> 3,
												vendor = 'ZW' 			=> 3,
												vendor = 'ZX' 			=> 3,
												vendor = '[W' 			=> 3,
												vendor = '^W' 			=> 3,
												0);
					  
export score_type(string vendor = '') 	 := map(vendor = 'header' 		=> 'HEADER OTHER',
												vendor = 'pcnsr'  		=> 'PCNSR OTHER',
												vendor = 'intrado'		=> 'INTRADO',
												vendor = 'targus'		=> 'TARGUS OTHER',
												vendor = 'gongh'		=> 'DISCONN',
												vendor = 'cellphones' 	=> 'CELLSOURCE',
												vendor = 'infutor'		=> 'INFUTOR',
												vendor = 'ZM'			=> 'PAW ZM',
												vendor = 'BR'			=> 'PAW BR',
												vendor = 'D'			=> 'PAW D',
												vendor = 'infutorcid'	=> 'INFUTOR CID',
												'');
							
							
export source_file(string vendor = '')   := map(vendor = 'header' 		=> 'Headers',
												vendor = 'pcnsr'  		=> 'PConsumer',
												vendor = 'intrado'		=> 'INTRADO-BNA',
												vendor = 'targus'		=> 'TargusWP',
												vendor = 'gongh'		=> 'Gong History',
												vendor = 'infutor'		=> 'Infutor',
												vendor = 'paw'			=> 'Paw',
												vendor = 'infutorcid'	=> 'Infutor CID',
												//cellphone vendors
												vendor = 'andrew'		=> 'TRAFFIX-ANDREW',
												vendor = 'cell900'		=> 'TRAFFIX-CELL900',
												vendor = 'cell1000'		=> 'TRAFFIX-CELL1000',
												vendor = 'cell1mm'		=> 'TRAFFIX-CELL1MM',
												vendor = 'linksconsumer'=> 'KROLL-CELL LINKS CONSUMER',
												vendor = 'consumer'		=> 'KROLL-CELL LINKS CONSUMER',
												vendor = 'cellmillion'	=> 'TRAFFIX-CELLMILLION',
												vendor = 'dsi'			=> 'KROLL_DSI',
												vendor = 'entre'		=> 'KROLL_ENTREPRENUERICELL',
												vendor = 'advantage'	=> 'KROLL-ADVTG MOBILE',
												vendor = 'marigold' 	=> 'KROLL-MARIGOLD',
												vendor = 'wirelessclean'=> 'KROLL-MASTER WIRELESS CLEAN',
												vendor = 'nexttones'	=> 'NEXTONES',
												vendor = 'cellusers'	=> 'KROLL-WIRELESS CELL USERS',
												'');							
							
export curr_discon_score(string vendor = ''):= if(vendor = 'intrado' OR vendor = 'targus', 11, 10);

export discon_type 					:= 'DISCONN';	

export neverseen_score 				:= 10;

export neverseen_type 				:= 'NEVERSEEN';	

export utility_score 				:= 10;

export utility_type 				:= 'UTILITY';

export utility_src 					:= [MDR.sourceTools.src_Utilities, MDR.sourceTools.src_Util_Work_Phone];

export utility_phones_flag_codes 	:= ['W', 'X'];	

export TDSMatch_score 				:=  10;	

export portability_dt 				:= 200412;

export yr_threshold 				:= '2001';

export dt_range_months 				:= 3;

export paw_src						:= [MDR.sourceTools.src_Zoom, MDR.sourceTools.src_Business_Registration, MDR.sourceTools.src_Dunn_Bradstreet];

export nonpub_score					:= 11;

export nonpub_active_deleted        := ['0x8c_20090421'];

export land_line_type				:= 'POTS';

end;