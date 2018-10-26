export cviScore(INTEGER1 p, INTEGER1 s, Layout_Output l, STRING9 corrected_ssn, STRING50 corrected_address, STRING10 corrected_phone, STRING5 inTweak, STRING50 veraddr, STRING20 verlast, 
								BOOLEAN OFAC=TRUE) := 
FUNCTION

BOOLEAN isPOTS := l.isPOTS;
tweak := trim(inTweak);

cvi := __COMMON__(CASE(p,
		0 => MAP(s IN [0,1] => '00',
			    s IN [2,3,4] => '10',
			    s IN [5,6,7,8,9,10] => '20',
			    '40'),																// s of 12 will now be 40
		1 => MAP(s IN [0,1] => '00',
			    s IN [2,3,4,5,6,7,8,9,10] => '10',
			    '30'),
		2 => MAP(s IN [0,1,2,3,4,7,9] => '10',
			    s IN [5,6,8,10] => '20',
			    s IN [12] AND ~isPOTS => '50',
			    '40'),
		3 => MAP(s IN [0,1,2,3,4,9] => '10',
			    s IN [5,6,7,8,10] => '20',
			    s IN [12] AND ~isPOTS => '50',
			    '40'),
		4 => MAP(s IN [0,1,2,3,4] => '10',
			    s IN [5,6,7,8,9,10] => '20',					// 5, 6, 7 and 9 will now be 20
			    s In [12] AND ~isPOTS => '50',
			    '40'),
		5 => MAP(s IN [1] => '10',
			    s IN [0,2,3,4,5,6] => '20',
			    s IN [7,8,10] => '30',
			    s IN [9,12] AND ~isPOTS => '50',
			    '40'),																// 11 will now be 40
		6 => MAP(s IN [0,1,2,3,4] => '10',
			    s IN [6,7,9,10] => '20',
			    s IN [5,8] => '30',
			    s IN [11] => '40',
			    '50'),
		7 => MAP(s IN [1,2,3] => '10',
			    s IN [0,4,6,10] => '20',
			    s IN [5,7,8,9] => '30',
					s IN [12] => '50',										// 12 will now be 50
			    '40'),
		8 => MAP(s IN [1,2,3] => '10',
			    s IN [0,4,6] => '20',
			    s IN [5,7,10] => '30',
			    s IN [9,11,12] AND ~isPOTS => '50',
			    '40'),
		9 => MAP(s IN [1,2,3] => '10',
			    s IN [0,4,6,10] => '20',
			    s IN [5,7,8,9] => '30',
			    '40'),
		10 => MAP(s IN [0,1,2,3] => '10',
				s IN [4,6] => '20',
				s IN [5,7,8,9,10] => '30',
				s IN [11] => '40',
				'50'),
		11 => MAP(s IN [1] => '20',
				s IN [0,2,3,4,5,6] => '30',
				s IN [7,8,10,11] => '40',
				'50'),																	// 9 will now be 50
		12 => MAP(s IN [1] => '20',
				s IN [0,2,3,4,5,6] => '30',
				s IN [7,8,10,11] => '40',  							// 11 will now be a 40
				'50'),																	// 9 will now be 50
				'00'));
				
	
	// determine if we need to override to 10
	override1 := __COMMON__(((	rcSet.isCode02(l.decsflag) OR 
									rcSet.isCode03(l.socsdobflag) OR 
									((rcSet.isCode06(l.socsvalflag, l.ssn) OR rcSet.isCodeIS(l.ssn, l.socsvalflag, l.socllowissue, l.socsRCISflag)) AND ~rcSet.isCode29(l.socsmiskeyflag)) OR 
									(rcSet.isCode08(l.phonetype,l.phone10) AND rcSet.isCode11(l.addrvalflag, l.in_streetAddress, l.in_city, l.in_state, l.in_zipCode) AND ~rcSet.isCode30(l.addrmiskeyflag) AND ~rcSet.isCode31(l.hphonemiskeyflag))) AND
								cvi>'10') OR 
								(OFAC and rcSet.isCode32(l.watchlist_table, l.watchlist_record_number )));
	
				
	cviAdj2 := __COMMON__(IF(override1,'10',cvi));
			   
	// special logic for ecvi and ddvi and svi
	cviAdj3 := __COMMON__(MAP(tweak = 'ecvi' =>
					MAP(cviAdj2 <= '20' => 
							MAP(l.socsverlevel IN [4,7,9] and l.dobcount>0 and l.hriskphoneflag<>'5' and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    l.socsverlevel IN [4,7,9] and ga(l.combo_addrscore) and l.combo_prim_range=l.prim_range and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    verlast<>'' and ga(l.combo_addrscore) and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    cviAdj2),
					    cviAdj2 = '30' => IF(l.decsflag = '1' or l.socsdobflag = '1' or l.socsvalflag = '1', '20',cviAdj2),
				         cviAdj2),
			     tweak = 'ddvi' =>
					MAP(cviAdj2 = '30' and l.socsverlevel in [11,12] => '40',
					    cviAdj2 = '20' and l.socsverlevel = 9 and (l.phoneverlevel in [6,8,10,11,12]) => '40',
					    cviAdj2 = '20' and l.socsverlevel = 9 => '30',
					    cviAdj2 = '30' and l.socsverlevel = 9 and l.phoneverlevel in [6,7,8,9,10,11,12] => '40',
					    cviAdj2),
			     tweak = 'svi' => 
					MAP(cviAdj2 = '10' and ((rcSet.isCode02(l.decsflag) OR rcSet.isCode03(l.socsdobflag) OR 
										((rcSet.isCode06(l.socsvalflag, l.ssn) OR rcSet.isCodeIS(l.ssn, l.socsvalflag, l.socllowissue, l.socsRCISflag)) AND ~rcSet.isCode29(l.socsmiskeyflag)) OR 
										(rcSet.isCode08(l.phonetype,l.phone10) AND rcSet.isCode11(l.addrvalflag, l.in_streetAddress, l.in_city, l.in_state, l.in_zipCode) AND 
												~rcSet.isCode30(l.addrmiskeyflag) AND ~rcSet.isCode31(l.hphonemiskeyflag))) OR 
									    (OFAC and rcSet.isCode32(l.watchlist_table, l.watchlist_record_number))) => '10',
					    cviAdj2 <= '20' =>
							MAP(l.socsverlevel IN [4,7,9] and l.dobcount>0 and l.hriskphoneflag<>'5' and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    l.socsverlevel IN [4,7,9] and ga(l.combo_addrscore) and l.combo_prim_range=l.prim_range and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    l.socsverlevel <> 1 and l.combo_lastcount>0 and l.combo_addrcount>0 and (l.addrvalflag<>'N' OR veraddr<>'') => '30',
							    cviAdj2),
					    cviAdj2 = '30' => IF(l.decsflag='1' or l.socsdobflag='1' or l.socsvalflag='1' or ((INTEGER)(l.socllowissue)>=1999),'20',cviAdj2),
					    cviAdj2),
			     cviAdj2));
				
	cviAdj4 := __COMMON__(IF(tweak='svi',IF((rcSet.isCode02(l.decsflag) OR rcSet.isCode03(l.socsdobflag) OR ((rcSet.isCode06(l.socsvalflag, l.ssn) OR rcSet.isCodeIS(l.ssn, l.socsvalflag, l.socllowissue, l.socsRCISflag)) AND ~rcSet.isCode29(l.socsmiskeyflag)) OR 
	              (rcSet.isCode08(l.phonetype,l.phone10) AND rcSet.isCode11(l.addrvalflag, l.in_streetAddress, l.in_city, l.in_state, l.in_zipCode) AND ~rcSet.isCode30(l.addrmiskeyflag) AND ~rcSet.isCode31(l.hphonemiskeyflag)) AND
			     cvi>'10'),'10',cviAdj3),cviAdj3));
					 
	override2 := __COMMON__(cviAdj4 > '20' and l.ssnexists and l.socscount = 0 and ~l.lastssnmatch2 and LENGTH(Stringlib.StringFilter(l.ssn,'0123456789'))=9);	// ssn does not belong to this last and it belongs to someone else
	override3 := __COMMON__(cviAdj4 > '20' and l.socsvalflag != '1' and ~l.ssnexists and l.socscount = 0 and l.versocs <> '' and LENGTH(Stringlib.StringFilter(l.ssn,'0123456789'))=9);	// ssn does not belong to anybody, but there is a social for this person				 

	cviAdj5 := __COMMON__(IF(override2, '20', cviAdj4));	
	cviAdj6 := __COMMON__(IF(override3, '20', cviAdj5));	
	
	// for american express add custom cvi override logic
	cviAdj7 := __COMMON__(IF(tweak='amxvi' and cviAdj6 > '30',
															MAP(rcSet.isCode11(l.addrvalflag, l.in_streetAddress, l.in_city, l.in_state, l.in_zipCode) and rcSet.isCode30(l.addrmiskeyflag) => '25',
																	rcSet.isCodeCL(l.ssn, l.bestssn, l.socsverlevel, l.combo_ssn) and ~rcSet.isCode29(l.socsmiskeyflag) => '15',
																	cviAdj6),
															cviAdj6));
															

RETURN (cviAdj7);

END;