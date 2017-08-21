import std;

EXPORT CleanDOB(DATASET(rOutLayout) ds_in) := FUNCTION

	rOutLayout xFormDOB(rOutLayout L) := TRANSFORM
		
		string20 v_temp_dob_1 := regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_1), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_2 := regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_2), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_3 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_3), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_4 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_4), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_5 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_5), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_6 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_6), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_7 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_7), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_8 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_8), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_9 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_9), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');
		string20 v_temp_dob_10 :=	regexreplace(' Dec | December | DECEMBER ',
																regexreplace(' Nov | November | NOVEMBER ',
																	regexreplace(' Oct | October | OCTOBER ',
																		regexreplace(' Sep | Sept | September | SEPTEMBER ',
																			regexreplace(' Aug | August | AUGUST ',
																				regexreplace(' Jul | July | JULY ',
																					regexreplace(' Jun | June | JUNE ',
																						regexreplace(' May | MAY ',
																							regexreplace(' Apr | April | APRIL ',
																								regexreplace(' Mar | March | MARCH ',
																									regexreplace(' Feb | February | FEBRUARY ',
																										regexreplace(' Jan | January | JANUARY ', STD.Str.FilterOut(TRIM(L.orig_dob_10), '.')
																										,'/01/')
																									,'/02/')
																								,'/03/')
																							,'/04/')
																						,'/05/')
																					,'/06/')
																				,'/07/')
																			,'/08/')
																		,'/09/')
																	,'/10/')
																,'/11/')
															,'/12/');

		self.orig_dob_1 := if(length(STD.Str.FilterOut(v_temp_dob_1, '/')) = 2, fSlashedDMYtoYMD(v_temp_dob_1), L.orig_dob_1);  /*Record 1*/
		self.orig_dob_2 := if(length(STD.Str.FilterOut(v_temp_dob_2, '/')) = 2, fSlashedDMYtoYMD(v_temp_dob_2), L.orig_dob_2);  /*Record 2*/
		self.orig_dob_3 := if(length(STD.Str.FilterOut(v_temp_dob_3, '/')) = 2, fSlashedDMYtoYMD(v_temp_dob_3), L.orig_dob_3);  /*Record 3*/
		self.orig_dob_4 := if(length(STD.Str.FilterOut(v_temp_dob_4, '/')) = 2, fSlashedDMYtoYMD(v_temp_dob_4), L.orig_dob_4);  /*Record 4*/
		self.orig_dob_5 := if(length(STD.Str.FilterOut(v_temp_dob_5, '/')) = 2, fSlashedDMYtoYMD(v_temp_dob_5), L.orig_dob_5);  /*Record 5*/
		self.orig_dob_6 := if(length(STD.Str.FilterOut(L.orig_dob_6, '/')) = 2 
													and length(TRIM(L.orig_dob_6)) - STD.Str.Find(L.orig_dob_6, '/', STD.Str.FindCount(L.orig_dob_6, '/')) = 4
												,fSlashedDMYtoYMD(L.orig_dob_6)
												,if(length(STD.Str.FilterOut(L.orig_dob_6, '/')) = 2
														and length(TRIM(L.orig_dob_6)) - STD.Str.Find(L.orig_dob_6, '/', STD.Str.FindCount(L.orig_dob_6, '/')) = 2
													,fSlashedDMYtoYMD(L.orig_dob_6
																[1
																..length(TRIM(L.orig_dob_6))-2] + '19' + TRIM(L.orig_dob_6)[length(TRIM(L.orig_dob_6))-1..2+length(TRIM(L.orig_dob_6))-1-1])
													,if(length(TRIM(L.orig_dob_6)) > 4
															and length(TRIM(L.orig_dob_6)) < 9
														,regexreplace('^00',
															regexreplace('01$', fSlashedDMYtoYMD(STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(
																																					STD.Str.FindReplace(
																																						STD.Str.FindReplace(
																																							STD.Str.FindReplace(
																																								STD.Str.FindReplace(
																																									STD.Str.FindReplace(TRIM(L.orig_dob_6)
																																									,'JAN ','01/01/')
																																								,'FEB ','01/02/')
																																							,'MAR ','01/03/')
																																						,'APR ','01/04/')
																																					,'MAY ','01/05/')
																																				,'JUN ','01/06/')
																																			,'JUL ','01/07/')
																																		,'AUG ','01/08/')
																																	,'SEP ','01/09/')
																																,'OCT ','01/10/')
																															,'NOV ','01/11/')
																														,'DEC ','01/12/'))
																													,'00')
																												,'19')
														,if(length(TRIM(L.orig_dob_6)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(
																														STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(TRIM(L.orig_dob_6)
																																				,'JAN ','01/')
																																			,'FEB ','02/')
																																		,'MAR ','03/')
																																	,'APR ','04/')
																																,'MAY ','05/')
																															,'JUN ','06/')
																														,'JUL ','07/')
																													,'AUG ','08/')
																												,'SEP ','09/')
																											,'OCT ','10/')
																										,'NOV ','11/')
																									,'DEC ','12/')
																								,' ','/'))
															,L.orig_dob_6))));  /*Record 6*/
		self.orig_dob_7 := if(length(STD.Str.FilterOut(L.orig_dob_7, '/')) = 2
													and length(TRIM(L.orig_dob_7)) - STD.Str.Find(L.orig_dob_7, '/', STD.Str.FindCount(L.orig_dob_7, '/')) = 4
												,fSlashedDMYtoYMD(L.orig_dob_7)
												,if(length(STD.Str.FilterOut(L.orig_dob_7, '/')) = 2
														and length(TRIM(L.orig_dob_7)) - STD.Str.Find(L.orig_dob_6, '/', STD.Str.FindCount(L.orig_dob_6, '/')) = 2
													,fSlashedDMYtoYMD(L.orig_dob_7
																[1
																..length(TRIM(L.orig_dob_7))-2] + '19' + TRIM(L.orig_dob_7)[length(TRIM(L.orig_dob_7))-1..2+length(TRIM(L.orig_dob_7))-1-1])
													,if(length(TRIM(L.orig_dob_7)) > 4
															and length(TRIM(L.orig_dob_7)) < 9
														,regexreplace('^00',
															regexreplace('01$', fSlashedDMYtoYMD(STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(
																																					STD.Str.FindReplace(
																																						STD.Str.FindReplace(
																																							STD.Str.FindReplace(
																																								STD.Str.FindReplace(
																																									STD.Str.FindReplace(TRIM(L.orig_dob_7)
																																									,'JAN ','01/01/')
																																								,'FEB ','01/02/')
																																							,'MAR ','01/03/')
																																						,'APR ','01/04/')
																																					,'MAY ','01/05/')
																																				,'JUN ','01/06/')
																																			,'JUL ','01/07/')
																																		,'AUG ','01/08/')
																																	,'SEP ','01/09/')
																																,'OCT ','01/10/')
																															,'NOV ','01/11/')
																														,'DEC ','01/12/'))
																													,'00')
																												,'19')
														,if(length(TRIM(L.orig_dob_7)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(
																														STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(TRIM(L.orig_dob_7)
																																				,'JAN ','01/')
																																			,'FEB ','02/')
																																		,'MAR ','03/')
																																	,'APR ','04/')
																																,'MAY ','05/')
																															,'JUN ','06/')
																														,'JUL ','07/')
																													,'AUG ','08/')
																												,'SEP ','09/')
																											,'OCT ','10/')
																										,'NOV ','11/')
																									,'DEC ','12/')
																								,' ','/'))
															,L.orig_dob_7))));  /*Record 7*/
		self.orig_dob_8 := if(length(STD.Str.FilterOut(L.orig_dob_8, '/')) = 2
													and length(TRIM(L.orig_dob_8)) - STD.Str.Find(L.orig_dob_8, '/', STD.Str.FindCount(L.orig_dob_8, '/')) = 4
												,fSlashedDMYtoYMD(L.orig_dob_8)
												,if(length(STD.Str.FilterOut(L.orig_dob_8, '/')) = 2
														and length(TRIM(L.orig_dob_8)) - STD.Str.Find(L.orig_dob_8, '/', STD.Str.FindCount(L.orig_dob_8, '/')) = 2
													,fSlashedDMYtoYMD(L.orig_dob_8
																[1
																..length(TRIM(L.orig_dob_8))-2] + '19' + TRIM(L.orig_dob_8)[length(TRIM(L.orig_dob_8))-1..2+length(TRIM(L.orig_dob_8))-1-1])
													,if(length(TRIM(L.orig_dob_8)) > 4
															and length(TRIM(L.orig_dob_8)) < 9
														,regexreplace('^00',
															regexreplace('01$', fSlashedDMYtoYMD(STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(
																																					STD.Str.FindReplace(
																																						STD.Str.FindReplace(
																																							STD.Str.FindReplace(
																																								STD.Str.FindReplace(
																																									STD.Str.FindReplace(
																																										STD.Str.FindReplace(
																																											STD.Str.FindReplace(
																																												STD.Str.FindReplace(TRIM(L.orig_dob_8)
																																												,'JAN ','01/01/')
																																											,'FEB ','01/02/')
																																										,'MAR ','01/03/')
																																									,'APR ','01/04/')
																																								,'MAY ','01/05/')
																																							,'JUN ','01/06/')
																																						,'JUL ','01/07/')
																																					,'AUG ','01/08/')
																																				,'SEP ','01/09/')
																																			,'OCT ','01/10/')
																																		,'NOV ','01/11/')
																																	,'DEC ','01/12/'))
																																,'00')
																															,'19')
														,if(length(TRIM(L.orig_dob_8)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(
																														STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(TRIM(L.orig_dob_8)
																																				,'JAN ','01/')
																																			,'FEB ','02/')
																																		,'MAR ','03/')
																																	,'APR ','04/')
																																,'MAY ','05/')
																															,'JUN ','06/')
																														,'JUL ','07/')
																													,'AUG ','08/')
																												,'SEP ','09/')
																											,'OCT ','10/')
																										,'NOV ','11/')
																									,'DEC ','12/')
																								,' ','/'))
															,L.orig_dob_8))));  /*Record 8*/
		self.orig_dob_9 := if(length(STD.Str.FilterOut(L.orig_dob_9, '/')) = 2
													and length(TRIM(L.orig_dob_9)) - STD.Str.Find(L.orig_dob_9, '/', STD.Str.FindCount(L.orig_dob_9, '/')) = 4
												,fSlashedDMYtoYMD(L.orig_dob_9)
												,if(length(STD.Str.FilterOut(L.orig_dob_9, '/')) = 2
														and length(TRIM(L.orig_dob_9)) - STD.Str.Find(L.orig_dob_9, '/', STD.Str.FindCount(L.orig_dob_9, '/')) = 2
													,fSlashedDMYtoYMD(L.orig_dob_9
																[1
																..length(TRIM(L.orig_dob_9))-2] + '19' + TRIM(L.orig_dob_9)[length(TRIM(L.orig_dob_9))-1..2+length(TRIM(L.orig_dob_9))-1-1])
													,if(length(TRIM(L.orig_dob_9)) > 4
															and length(TRIM(L.orig_dob_9)) < 9
														,regexreplace('^00',
															regexreplace('01$', fSlashedDMYtoYMD(STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(
																																					STD.Str.FindReplace(
																																						STD.Str.FindReplace(
																																							STD.Str.FindReplace(
																																								STD.Str.FindReplace(
																																									STD.Str.FindReplace(TRIM(L.orig_dob_9)
																																									,'JAN ','01/01/')
																																								,'FEB ','01/02/')
																																							,'MAR ','01/03/')
																																						,'APR ','01/04/')
																																					,'MAY ','01/05/')
																																				,'JUN ','01/06/')
																																			,'JUL ','01/07/')
																																		,'AUG ','01/08/')
																																	,'SEP ','01/09/')
																																,'OCT ','01/10/')
																															,'NOV ','01/11/')
																														,'DEC ','01/12/'))
																													,'00')
																												,'19')
														,if(length(TRIM(L.orig_dob_9)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(
																														STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(TRIM(L.orig_dob_9)
																																				,'JAN ','01/')
																																			,'FEB ','02/')
																																		,'MAR ','03/')
																																	,'APR ','04/')
																																,'MAY ','05/')
																															,'JUN ','06/')
																														,'JUL ','07/')
																													,'AUG ','08/')
																												,'SEP ','09/')
																											,'OCT ','10/')
																										,'NOV ','11/')
																									,'DEC ','12/')
																								,' ','/'))
															,L.orig_dob_9))));  /*Record 9*/
		self.orig_dob_10 := if(length(STD.Str.FilterOut(L.orig_dob_10, '/')) = 2
													and length(TRIM(L.orig_dob_10)) - STD.Str.Find(L.orig_dob_10, '/', STD.Str.FindCount(L.orig_dob_10, '/')) = 4
												,fSlashedDMYtoYMD(L.orig_dob_10)
												,if(length(STD.Str.FilterOut(L.orig_dob_10, '/')) = 2
														and length(TRIM(L.orig_dob_10)) - STD.Str.Find(L.orig_dob_10, '/', STD.Str.FindCount(L.orig_dob_10, '/')) = 2
													,fSlashedDMYtoYMD(L.orig_dob_10
																[1
																..length(TRIM(L.orig_dob_10))-2] + '19' + TRIM(L.orig_dob_10)[length(TRIM(L.orig_dob_10))-1..2+length(TRIM(L.orig_dob_10))-1-1])
													,if(length(TRIM(L.orig_dob_10)) > 4
															and length(TRIM(L.orig_dob_10)) < 9
														,regexreplace('^00',
															regexreplace('01$', fSlashedDMYtoYMD(STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(
																																					STD.Str.FindReplace(
																																						STD.Str.FindReplace(
																																							STD.Str.FindReplace(
																																								STD.Str.FindReplace(
																																									STD.Str.FindReplace(TRIM(L.orig_dob_10)
																																									,'JAN ','01/01/')
																																								,'FEB ','01/02/')
																																							,'MAR ','01/03/')
																																						,'APR ','01/04/')
																																					,'MAY ','01/05/')
																																				,'JUN ','01/06/')
																																			,'JUL ','01/07/')
																																		,'AUG ','01/08/')
																																	,'SEP ','01/09/')
																																,'OCT ','01/10/')
																															,'NOV ','01/11/')
																														,'DEC ','01/12/'))
																													,'00')
																												,'19')
														,if(length(TRIM(L.orig_dob_10)) > 8
															,fSlashedMDYtoYMD(STD.Str.FindReplace(
																									STD.Str.FindReplace(
																										STD.Str.FindReplace(
																											STD.Str.FindReplace(
																												STD.Str.FindReplace(
																													STD.Str.FindReplace(
																														STD.Str.FindReplace(
																															STD.Str.FindReplace(
																																STD.Str.FindReplace(
																																	STD.Str.FindReplace(
																																		STD.Str.FindReplace(
																																			STD.Str.FindReplace(
																																				STD.Str.FindReplace(TRIM(L.orig_dob_10)
																																				,'JAN ','01/')
																																			,'FEB ','02/')
																																		,'MAR ','03/')
																																	,'APR ','04/')
																																,'MAY ','05/')
																															,'JUN ','06/')
																														,'JUL ','07/')
																													,'AUG ','08/')
																												,'SEP ','09/')
																											,'OCT ','10/')
																										,'NOV ','11/')
																									,'DEC ','12/')
																								,' ','/'))
															,L.orig_dob_10))));  /*Record 10*/		 
		self := L;

	END;
	
	return PROJECT(ds_in, xFormDOB(LEFT));

END;