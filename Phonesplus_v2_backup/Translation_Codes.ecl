import lib_stringlib, ut;
export Translation_Codes := module

export toll_free_area_codes := ['800','811','822','833','844','855','866','877','888','899'];
//-----Source Codes for data sources in phonesplus
export source_code(string source = '')	 	  := map(	   		
													source = 'infutorcid'  		=> 'IC',
													source = 'kroll'			=> '01',
													source = 'traffix'			=> '02',
													source = 'nextones'			=> '05',
													source = 'intrado		'	=> 'IN',
													source = 'targuswp'			=> 'WP',
													source = 'pcnsr'			=> 'PC',
													source = 'gongh'  		 	=> 'GH',
													source = 'infutortracker'   => 'IF',
													source = 'optincellphones'  => 'OP',
													'');
//-----Bit map for data sources in phonesplus													
export source_bitmap_code(string source = '')  := map(
													//Sources other than header
													source = 'IC'  	  => ut.bit_set(0,0),
													source = '01'		  => ut.bit_set(0,1),
													source = '02'		  => ut.bit_set(0,2),
													source = '05'		  => ut.bit_set(0,3),
													source = 'IN'		  => ut.bit_set(0,4),
													source = 'WP'		  => ut.bit_set(0,5),
													source = 'PC'		  => ut.bit_set(0,6),
													source = 'GH'   	=> ut.bit_set(0,7),
													source = 'IF'  		=> ut.bit_set(0,8),
													//Header sources
													source = 'EQ'  		=> ut.bit_set(0,9),
													source = 'UT'  		=> ut.bit_set(0,10),
													source = 'FA'  		=> ut.bit_set(0,11),
													source = 'VO'  		=> ut.bit_set(0,12),
													source = 'UW'  		=> ut.bit_set(0,13),
													source = 'SL'  		=> ut.bit_set(0,14),
													source = 'PL'  		=> ut.bit_set(0,15),
													source = 'CY'  		=> ut.bit_set(0,16),
													source = 'E1'  		=> ut.bit_set(0,17),
													source = 'EM'  		=> ut.bit_set(0,18),
													source = 'LP'  		=> ut.bit_set(0,19),
													source = 'LA'  		=> ut.bit_set(0,20),
													source = 'KW'  		=> ut.bit_set(0,21),
													source = 'EB'  		=> ut.bit_set(0,22),
													source = 'VW'  		=> ut.bit_set(0,23),
													source = 'NW'  		=> ut.bit_set(0,24),
													source = 'TS'  		=> ut.bit_set(0,25),
													source = 'E4'  		=> ut.bit_set(0,26),
													source = 'FF'  		=> ut.bit_set(0,27),
													source = 'E2'  		=> ut.bit_set(0,28),
													source = 'FE'  		=> ut.bit_set(0,29),
													source = 'DW'  		=> ut.bit_set(0,30),
													source = 'PQ'     => ut.bit_set(0,31),
													source = 'SV'     => ut.bit_set(0,32),
													source = 'MD'  		=> ut.bit_set(0,33),
													source = 'YE'  		=> ut.bit_set(0,34),
													source = 'EN'  		=> ut.bit_set(0,35),
													source = 'BW'  		=> ut.bit_set(0,36),
													source = 'OP'		  => ut.bit_set(0,37),
													source = 'ZK'		  => ut.bit_set(0,38),
													source = 'ZT'		  => ut.bit_set(0,39),
													0);

//-----Bit map translation for EQ											
export	string	fGet_eq_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code('EQ')),			' EQ',''));
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;

//-----Bit map translation for Other header sources									
export	string	fGet_other_hdr_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code('UT')),			' UT','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('FA')),			' FA','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('VO')),			' VO','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('UW')),			' UW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('SL')),			' SL','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('PL')),			' PL','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('CY')),			' CY','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('E1')),			' E1','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('EM')),			' EM','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('LP')),			' LP','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('LA')),			' LA','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('KW')),			' KW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('EB')),			' EB','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('VW')),			' VW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('NW')),			' NW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('TS')),			' TS','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('E4')),			' E4','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('FF')),			' FF','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('E2')),			' E2','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('FE')),			' FE','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('DW')),			' DW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('PQ')),			' PQ','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('SV')),			' SV','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('MD')),			' MD','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('YE')),			' YE','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('EN')),			' EN','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('BW')),			' BW','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('ZK')),			' ZK','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('ZT')),			' ZT','')
											  );
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;	

//-----Bit map translation for Other sources
export	string	fGet_other_sources_from_bitmap(unsigned bitmap_src) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_src)	:=	pValue & bitmap_src = bitmap_src;
		string		translated_value		:=	if(bitmap_src = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_src, source_bitmap_code('IC')),			' IC','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('01')),			' 01','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('02')),			' 02','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('05')),			' 05','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('IN')),			' IN','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('WP')),			' WP','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('PC')),			' PC','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('GH')),			' GH','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('IF')),			' IF','')
										+	   if(fFlagIsOn(bitmap_src, source_bitmap_code('OP')),			' OP','')										
										);
		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),'  ',' ');
end;
	
//-----Bit map translation for EDA match indicator
export	string	fGet_eda_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Phone','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Did-Lphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,2)),		  ' Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,3)),		  ' Lname-Addr-Lphone7','')
                    +	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,4)),		' Lname-Addr','')
											  );

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Bit map translation for Non-pub match indicator
export	string	fGet_nonpub_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Gong-Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Gong-LName-Addr','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,2)),		' Gong-LName-Addr-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,3)),		' Gong-Did-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,4)),		' Targ-Did','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,5)),		' Targ-LName-Addr','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,6)),	' Targ-LName-Addr-Fphone7','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,7)),	' Targ-Did-Fphone7','')
											  );
								

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Bit map translation for Ported indicator
export	string	fGet_ported_match_bitmap(unsigned bitmap_match) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
		string		translated_value		:=	if(bitmap_match = 0,
											   '',	
											   if(fFlagIsOn(bitmap_match, ut.bit_set(0,0)),			' Phone10','')
										+	   if(fFlagIsOn(bitmap_match, ut.bit_set(0,1)),			' Phone7','')
											  );

		return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ',',');
end;

//-----Vendor/ source confidence score
export source_conf(string source = '')  := map(
													//Sources other than header
													source = 'IC'  		=> 10,
													source = '01'		=> 9,
													source = '02'		=> 9,
													source = '05'		=> 9,
													source = 'IN'		=> 5,
													source = 'WP'		=> 6,
													source = 'PC'		=> 5,
													source = 'GH'   	=> 5,
													source = 'IF'  		=> 0,
													//Header sources
													source = 'EQ'  		=> 5,
													source = 'UT'  		=> 9,
													source = 'FA'  		=> 5,
													source = 'VO'  		=> 5,
													source = 'UW'  		=> 9,
													source = 'SL'  		=> 5,
													source = 'PL'  		=> 5,
													source = 'CY'  		=> 5,
													source = 'E1'  		=> 5,
													source = 'EM'  		=> 5,
													source = 'LP'  		=> 5,
													source = 'LA'  		=> 5,
													source = 'KW'  		=> 5,
													source = 'EB'  		=> 5,
													source = 'VW'  		=> 5,
													source = 'NW'  		=> 5,
													source = 'TS'  		=> 0,
													source = 'E4'  		=> 5,
													source = 'FF'  		=> 5,
													source = 'E2'  		=> 5,
													source = 'FE'  		=> 5,
													source = 'DW'  		=> 5,
													source = 'PQ'       => 5,
													source = 'SV'       => 5,
													source = 'MD'       => 5,
													source = 'YE'       => 5,
													source = 'EN'  		=> 5,
													source = 'BW'  		=> 5,
													source = 'OP'		=> 10,
													source = 'ZT'		=> 9,
													source = 'ZK'		=> 9,
													0);

//------Caption for Basic Rules...In the future this will be converted to a bit map
export rules_bitmap_code(string rules = '')  := map(
															rules = 'Active-EDA-Phone' 				 => ut.bit_set(0,0),
															rules = 'Active-EDA-Record'	       => ut.bit_set(0,1),
															rules = 'Disconnected-EDA'         => ut.bit_set(0,2),
															rules = 'Non-pub' 								 => ut.bit_set(0,3),
															rules = 'Ported-Neustar' 					 => ut.bit_set(0,4),
															rules = 'Seen-Once'                => ut.bit_set(0,5),
															rules = 'High-Vendor-Conf'         => ut.bit_set(0,6),
															rules = 'Low-Vendor-Conf'          => ut.bit_set(0,7),
															rules = 'Cellphone-Latest'         => ut.bit_set(0,8),
															rules = 'Non-pub-for-someone-else' => ut.bit_set(0,9),

															//------Caption for Last resort rules
															rules = 'Targ-Non-pub' 						 => ut.bit_set(0,10),
															rules = 'Ported-Cell-Type'         => ut.bit_set(0,11),
															rules = 'Ported-Best-No-Active'    => ut.bit_set(0,12),
															rules = 'Source-Latest'            => ut.bit_set(0,13),
															rules = 'Med-Vendor-Conf-Cell'     => ut.bit_set(0,14),
															rules = 'Last-Resort-Cell'         => ut.bit_set(0,15),
															rules = 'Household'                => ut.bit_set(0,16),
															rules = 'Hdr-Household'            => ut.bit_set(0,17),
															rules = 'Included-for-someone-else'=> ut.bit_set(0,18),
		
															0b);
															
export	string	fGet_rules_caption_from_bitmap(unsigned bitmap_rules) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_rules)	:=	pValue & bitmap_rules = bitmap_rules;
		string		translated_value		:=	if(bitmap_rules = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Phone')),			' Active-EDA-Phone','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Record')),			' Active-EDA-Record','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Disconnected-EDA')),			' Disconnected-EDA','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub')),					' Non-pub','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Neustar')),				' Ported-Neustar','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Seen-Once')),					' Seen-Once','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('High-Vendor-Conf')),			' High-Vendor-Conf','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Low-Vendor-Conf')),			' Low-Vendor-Conf','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Cellphone-Latest')),			' Cellphone-Latest','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub-for-someone-else')),	' Non-pub-for-someone-else','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Targ-Non-pub' )),				' Targ-Non-pub','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Cell-Type')),			' Ported-Cell-Type','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Best-No-Active')),		' Ported-Best-No-Active','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Source-Latest')),				' Source-Latest','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Med-Vendor-Conf-Cell')),		' Med-Vendor-Conf-Cell','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Last-Resort-Cell')),			' Last-Resort-Cell','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Household')),					' Household','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Hdr-Household')),				' Hdr-Household','')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Included-for-someone-else')),	' Included-for-someone-else','')
																			
										);
return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ','/');
end;


															
export	string	fGet_rules_caption_as_bitmap(unsigned bitmap_rules) := function
		boolean		fFlagIsOn(unsigned pValue, unsigned bitmap_rules)	:=	pValue & bitmap_rules = bitmap_rules;
		string		translated_value		:=	if(bitmap_rules = 0,
											   '',											   
											   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Phone')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Active-EDA-Record')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Disconnected-EDA')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Neustar')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Seen-Once')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('High-Vendor-Conf')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Low-Vendor-Conf')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Cellphone-Latest')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Non-pub-for-someone-else')),	'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Targ-Non-pub' )),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Cell-Type')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Ported-Best-No-Active')),		'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Source-Latest')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Med-Vendor-Conf-Cell')),		'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Last-Resort-Cell')),			'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Household')),					'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Hdr-Household')),				'X','0')
										+	   if(fFlagIsOn(bitmap_rules, rules_bitmap_code('Included-for-someone-else')),	'X','0')
										);
return		lib_stringlib.stringlib.stringfindreplace(trim(lib_stringlib.stringlib.stringcleanspaces(translated_value),left,right),' ','');
end;

//-----Vendor/ source File name
export source_file(string vendor = '')   := map(vendor = 'PC'  		=> 'PConsumer',
												vendor = 'IN'		=> 'INTRADO-BNA',
												vendor = 'WP'		=> 'TargusWP',
												vendor = 'GH'		=> 'Gong History',
												vendor = 'IF'		=> 'Infutor',
												vendor = 'IC'		=> 'Infutor CID',
												//cellphone vendors
												vendor = '01'		=> 'KROLL',
												vendor = '02'		=> 'TRAFFIX',
												vendor = '05'		=> 'NEXTONES',
												vendor = 'OP'		=> 'OptinCellphones',
												'Header');
												
export fFlagIsOn(unsigned pValue, unsigned bitmap_match)	:=	pValue & bitmap_match = bitmap_match;
													
end;