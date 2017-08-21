import	ut;

dEntityCleanName	:=	distribute(Globalwatchlists.OrigFile,random());

GlobalWatchLists.Layouts.Temp.EntityCommon	tParty(dEntityCleanName	pInput)	:=
transform
	string	vClean2UpperComments	:=	GlobalWatchLists.Functions.strClean2Upper(pInput.comments);
	string	vCleanComments				:=	GlobalWatchLists.Functions.strClean(pInput.comments);
	
	string	vLang1 								:=	regexreplace(	'([^:,]*?)([:,])([ ]*)([^:,]*?)',
																									vCleanComments[StringLib.StringFind(vClean2UpperComments,'LANGUAGE:',1)..length(vClean2UpperComments)],
																									'$1$2$4'
																								);
	string	vLang2 								:=	regexreplace(	'([^:,]*?)([:,])([ ]*)([^:,]*?)',
																									(string)vCleanComments[StringLib.StringFind(vClean2UpperComments,'LANGUAGES:',1)..length(vClean2UpperComments)],
																									'$1$2$4'
																								);
	
	self.pty_key 													:=	pInput.recordid;
	self.source 													:=	pInput.watchlistname;
	self.orig_pty_name										:=	if(	ut.fnTrim2Upper(pInput.nametype)	=	'VESSEL',
																								'',
																								pInput.fullname
																							);
	self.orig_vessel_name 								:=	if(	ut.fnTrim2Upper(pInput.nametype)	=	'VESSEL',
																								pInput.fullname,
																								''
																							);
	self.name_type												:=	pInput.nametype;
	self.title 														:=	pInput.title2;
	self.fname 														:=	pInput.fname;
	self.mname 														:=	pInput.mname;
	self.lname 														:=	pInput.lname;
	self.suffix 													:=	pInput.name_suffix;
	self.a_score 													:=	pInput.name_score;
	self.entity_type 											:=	pInput.nametype;
	self.gender 													:=	pInput.gender;
	self.sanctions_program_1 							:=	if(	pInput.recordid[1..4] in ['OFAC'],
																								case(	GlobalWatchLists.Functions.strClean2Upper(pInput.reasonlisted),
																											'BALKANS'   => 'BALKANS - Balkans Sanctions',
																											'BELARUS'  	=> 'BELARUS - Belarus Sanctions',
																											'BPI-PA'   	=> 'BPI-PA - Blocked Pending Investigation - Palestinian Authority',
																											'BPI-SDNT' 	=> 'BPI-SDNT - Blocked Pending Investigation - Specially Designated Narcotics Traffickers',
																											'BPI-SDNTK'	=> 'BPI-SDNTK - Blocked Pending Investigation - Specially Designated Narcotic Trafficking Kingpins',
																											'BURMA'    	=> 'BURMA - Burma Sanctions',
																											'COTED'    	=> 'COTED - Cote d\'Ivoire (Ivory Coast) Sanctions',
																											'CUBA'     	=> 'CUBA - Cuba Sanctions',
																											'DARFUR'   	=> 'DARFUR - Darfur Sanctions',
																											'DRCONGO'  	=> 'DRCONGO - Democractic Republic of the Congo Sanction',
																											'FTO'      	=> 'FTO - Foreign Terrorists Organization',
																											'IRAN'     	=> 'IRAN - Iran Sanctions',
																											'IRAQ2'    	=> 'IRAQ2 - Iraq Sanctions',
																											'IRAQ3'    	=> 'IRAQ3 - Iraq Sanctions',
																											'LEBANON'  	=> 'LEBANON - Lebanon Sanctions',
																											'LIBERIA'  	=> 'LIBERIA - Liberia Sanctions',
																											'NKOREA'   	=> 'NKOREA - North Korea Sanctions',
																											'NPWMD'    	=> 'NPWMD - Non-proliferation Sanctions',
																											'NS-PLC'   	=> 'NS-PLC - NonSpecially Designated Terrorists Palestinian Legislative Council',
																											'SDGT'     	=> 'SDGT - Specially Designated Global Terrorists',
																											'SDNT'     	=> 'SDNT - Specially Designated Narcotics Traffickers',
																											'SDNTK'    	=> 'SDNTK - Specially Designated Narcotic Trafficking Kingpins',
																											'SDT'      	=> 'SDT - Specially Designated Terrorists',
																											'SUDAN'    	=> 'SUDAN - Sudan Sanctions',
																											'SYRIA'    	=> 'SYRIA - Syria Sanctions',
																											'ZIMB'     	=> 'ZIMB - Zimbabwe Sanctions',
																											''
																										),
																								''
																							);
	self.date_last_updated 									:=	if(	pInput.recordid[1..3]	=	'BES'	and	StringLib.StringFind(vClean2UpperComments,'LAST UPDATED:',1)	<>	0,
																									(string)vCleanComments[StringLib.StringFind(vClean2UpperComments,'LAST UPDATED:',1)+14..length(vClean2UpperComments)],
																									''
																								);
	self.date_added_to_list 								:=	if(	~regexfind('[A-Z]+',pInput.datelisted,nocase)	and	regexfind('[0-9]+',pInput.datelisted),
																									globalwatchlists.convMMDDYYYY(ut.fnTrim2Upper(pInput.datelisted)),
																									pInput.datelisted
																								);
	self.pname_clean												:=	pInput.pname_clean;
	
	self.language_1													:=	map(	pInput.recordid[1..2]	=	'FB'	and	StringLib.StringFind(vClean2UpperComments,'LANGUAGE:',1)	<>	0																								=>	GlobalWatchLists.Functions.strClean(vLang1[10..StringLib.StringFind(vLang1,' ',1)]),
																										pInput.recordid[1..2]	=	'FB'	and	StringLib.StringFind(vClean2UpperComments,'LANGUAGES:',1)	<>	0	and	stringlib.stringfind(vLang2,',',1)	<>	0	=>	GlobalWatchLists.Functions.strClean(vLang2[11..StringLib.StringFind(vLang2,',',1)-1]),
																										''
																									);
	self.language_2													:=	if(	pInput.recordid[1..2]	=	'FB'	and	StringLib.StringFind(vClean2UpperComments,'LANGUAGES:',1)	<>	0	and	stringlib.stringfind(vLang2,',',1)	<>	0,
																									GlobalWatchLists.Functions.strClean(vLang2[StringLib.StringFind(vLang2,',',1)+1..StringLib.StringFind(vLang2,' ',1)-1]),
																									''
																								);

	self.type_of_denial 										:=	map(	pInput.recordid[1..3]	=	'BIS'	and	regexfind('DENIAL:[ ]*STANDARD',GlobalWatchLists.Functions.strClean2Upper(pInput.comments),nocase)			=>	'STANDARD',
																										pInput.recordid[1..3]	=	'BIS'	and	regexfind('DENIAL:[ ]*NON STANDARD',GlobalWatchLists.Functions.strClean2Upper(pInput.comments),nocase)	=>	'NON STANDARD',
																										''
																									);
	self.registrant_terminated_flag					:=	if(	pInput.recordid[1..3]	=	'FAR'	and	GlobalWatchLists.Functions.strClean2Upper(pInput.reasonlisted)	in	['REGISTRANT','FOREIGN PRINCIPAL'],
																									'N',
																									''
																								);
	self.foreign_principal_terminated_flag	:=	if(	pInput.recordid[1..3]	=	'FAR'	and	GlobalWatchLists.Functions.strClean2Upper(pInput.reasonlisted)	in	['REGISTRANT','FOREIGN PRINCIPAL'],
																									'N',
																									''
																								);
	self.short_form_terminated_flag 				:=	if(	pInput.recordid[1..3]	=	'FAR'	and	GlobalWatchLists.Functions.strClean2Upper(pInput.reasonlisted)	=	'SHORT FORM NAME',
																									'N',
																									''
																								);
	self.caution														:=	if(	pInput.recordid[1..2]	=	'FB',
																									pInput.comments,
																									''
																								);
	self.comments														:=	GlobalWatchLists.Functions.removeLineFeeds(pInput.comments);
	self.remarks														:=	pInput.AddrComments;
	self																		:=	pInput;
	self																		:=	[];
end;

dStandard			:=	project(dEntityCleanName,tParty(left));
dStandardDist	:=	distribute(dStandard,hash32(pty_key,source));

//Denorm Languages
dLang 		:=	GlobalWatchLists.Normalize_Languages(Language	<>	'');
dLangDist	:=	distribute(dLang,hash32(recordid,watchlistname));

GlobalWatchLists.Layouts.Temp.EntityCommon	tDenormLang(dStandardDist	le,dLangDist	ri,integer	cnt)	:=
transform
	self.NumRows 			:=	cnt;
	self.language_1 	:=	if(cnt	=	1,ri.language,le.language_1);
	self.language_2 	:=	if(cnt	=	2,ri.language,le.language_2);
	self.language_3 	:=	if(cnt	=	3,ri.language,le.language_3);
	self.language_4 	:=	if(cnt	=	4,ri.language,le.language_4);
	self.language_5 	:=	if(cnt	=	5,ri.language,le.language_5);
	self.language_6 	:=	if(cnt	=	6,ri.language,le.language_6);
	self.language_7 	:=	if(cnt	=	7,ri.language,le.language_7);
	self.language_8 	:=	if(cnt	=	8,ri.language,le.language_8);
	self.language_9 	:=	if(cnt	=	9,ri.language,le.language_9);
	self.language_10 	:=	if(cnt	=	10,ri.language,le.language_10);
	self 							:=	le;
end;
	
dLangDenorm	:=	denormalize(	dStandardDist,
															dLangDist,
															left.pty_key	=	right.recordid	and
															left.source		=	right.watchlistname,
															tDenormLang(left,right,counter),
															local
														);

// Denorm Linked With
dLinkedWith			:=	GlobalWatchLists.Normalize_LinkedWith(LinkedWith	<>	'');
dLinkedWithDist	:=	distribute(dLinkedWith,hash32(recordid,watchlistname));

GlobalWatchLists.Layouts.Temp.EntityCommon tDenormLinkedWith(dLangDenorm	le,dLinkedWithDist	ri,integer	cnt)	:=
transform
	self.NumRows 					:=	cnt;
	self.linked_with_1 		:=	if(cnt	=	1,ri.linkedwith,le.linked_with_1);
	self.linked_with_2 		:=	if(cnt	=	2,ri.linkedwith,le.linked_with_2);
	self.linked_with_3 		:=	if(cnt	=	3,ri.linkedwith,le.linked_with_3);
	self.linked_with_4 		:=	if(cnt	=	4,ri.linkedwith,le.linked_with_4);
	self.linked_with_5 		:=	if(cnt	=	5,ri.linkedwith,le.linked_with_5);
	self.linked_with_6 		:=	if(cnt	=	6,ri.linkedwith,le.linked_with_6);
	self.linked_with_7 		:=	if(cnt	=	7,ri.linkedwith,le.linked_with_7);
	self.linked_with_8 		:=	if(cnt	=	8,ri.linkedwith,le.linked_with_8);
	self.linked_with_9 		:=	if(cnt	=	9,ri.linkedwith,le.linked_with_9);
	self.linked_with_10 	:=	if(cnt	=	10,ri.linkedwith,le.linked_with_10);
	self 									:=	le;
end;
	
dLinkedWithDenorm	:=	denormalize(	dLangDenorm,
																		dLinkedWithDist,
																		left.pty_key	=	right.recordid	and
																		left.source		=	right.watchlistname,
																		tDenormLinkedWith(left,right,counter),
																		local
																	);

// Combine all the comments (even language, linked with in the remarks sections)
dOrigFileDist	:=	distribute(globalwatchlists.OrigFile,hash32(recordid,watchlistname));

GlobalWatchLists.Layouts.Temp.EntityCommon	tRemarks(dLinkedWithDenorm	pInput)	:=
transform
	self.remarks_1		:=	pInput.comments[1..75];
	self.remarks_2		:=	pInput.comments[76..150];
	self.remarks_3		:=	pInput.comments[151..225];
	self.remarks_4		:=	pInput.comments[226..300];
	self.remarks_5		:=	pInput.comments[301..375];
	self.remarks_6		:=	pInput.comments[376..450];
	self.remarks_7		:=	pInput.comments[451..525];
	self.remarks_8		:=	pInput.comments[526..600];
	self.remarks_9		:=	pInput.comments[601..675];
	self.remarks_10		:=	pInput.comments[676..750];
	self.remarks_11		:=	pInput.comments[751..825];
	self.remarks_12		:=	pInput.comments[826..900];
	self.remarks_13		:=	pInput.comments[901..975];
	self.remarks_14		:=	pInput.comments[976..1050];
	self.remarks_15		:=	pInput.comments[1051..1125];
	self.remarks_16		:=	pInput.comments[1126..1200];
	self.remarks_17		:=	pInput.comments[1201..1275];
	self.remarks_18		:=	pInput.comments[1276..1350];
	self.remarks_19		:=	pInput.comments[1351..1425];
	self.remarks_20		:=	pInput.comments[1426..1500];
	self.remarks_21		:=	pInput.comments[1501..1575];
	self.remarks_22		:=	pInput.comments[1576..1650];
	self.remarks_23		:=	pInput.comments[1651..1725];
	self.remarks_24		:=	pInput.comments[1726..1800];
	self.remarks_25		:=	pInput.comments[1801..1875];
	self.remarks_26		:=	pInput.comments[1876..1950];
	self.remarks_27		:=	pInput.comments[1951..2025];
	self.remarks_28		:=	pInput.comments[2026..2100];
	self.remarks_29		:=	pInput.comments[2101..2175];
	self.remarks_30		:=	pInput.comments[2176..2250];
	self							:=	pInput;
end;
	
dRemarks	:=	project(dLinkedWithDenorm,tRemarks(left));

// Join Effective Date
dEffectiveDateComments			:=	GlobalWatchLists.Normalize_Comments(regexfind('EFFECTIVE DATE:',comments,nocase));

GlobalWatchLists.Layouts.Temp.EntityCommon	tEffectiveDt(dRemarks	le,dEffectiveDateComments	ri)	:=
transform
	
	string	vEffectiveDateStr	:=	GlobalWatchLists.Functions.strClean2Upper(regexreplace('EFFECTIVE DATE:',ri.comments,'',nocase));
	string	vEffectiveDate		:=	ut.Word(vEffectiveDateStr,1);
	
	self.effective_date	:=	if(	vEffectiveDate	<>	'',
															regexreplace('[A-Z]+|:',vEffectiveDate,'',nocase),
															''
														);
	self								:=	le;
end;
	
dEffectiveDate	:=	join(	dRemarks,
													dEffectiveDateComments,
													left.pty_key 	=	right.recordid and
													left.source 	=	right.watchlistname,
													tEffectiveDt(left,right),
													left outer,
													lookup
												);

// Other Effective Date
dWBIFEffectiveDateComments			:=	GlobalWatchLists.Normalize_Comments(	recordid[1..4]	=	'WBIF'	and
																																					regexfind('FROM:',comments,nocase)
																																				);

GlobalWatchLists.Layouts.Temp.EntityCommon	tWBIFEffectiveDt(dEffectiveDate	le,dWBIFEffectiveDateComments	ri)	:=
transform
	string	vEffectiveDateStr	:=	GlobalWatchLists.Functions.strClean2Upper(regexreplace('FROM ',ri.comments,'',nocase));
	
	self.effective_date	:=	if(	ri.recordid[1..4]	=	'WBIF'	and	regexfind('FROM:',ri.comments,nocase),
															ut.word(vEffectiveDateStr,1),
															le.effective_date
														);
	self								:=	le;
end;

dWBIFEffectiveDate	:=	join(	dEffectiveDate,
															dWBIFEffectiveDateComments,
															left.pty_key	=	right.recordid	and
															left.source		=	right.watchlistname,
															tWBIFEffectiveDt(left,right),
															left outer,
															lookup
														);

// Join Expiration Date
dExpirationDateComments			:=	GlobalWatchLists.Normalize_Comments(regexfind('EXPIRATION DATE:',comments,nocase));

GlobalWatchLists.Layouts.Temp.EntityCommon	tExpirationDt(dWBIFEffectiveDate	le,dExpirationDateComments	ri)	:=
transform
	integer	vExpirationDateIndex	:=	stringlib.stringfind(GlobalWatchLists.Functions.strClean2Upper(ri.comments),'EXPIRATION DATE:',1);
	string	vExpirationDateStr		:=	ut.fnTrim2Upper(GlobalWatchLists.Functions.strClean2Upper(ri.comments)[vExpirationDateIndex+16..]);
	
	self.expiration_date 	:=	stringlib.stringcleanspaces(ut.Word(regexfind('.*?$|.*? ',vExpirationDateStr,0),1));
	self									:=	le;	
end;
	
dExpirationDate	:=	join(	dWBIFEffectiveDate,
													dExpirationDateComments,
													left.pty_key 	=	right.recordid and
													left.source		=	right.watchlistname,
													tExpirationDt(left,right),
													left outer,
													lookup
												);
	
// Other Expiration Date
dWBIFExpirationDateComments			:=	GlobalWatchLists.Normalize_Comments(	recordid[1..4]	=	'WBIF'						and
																																					regexfind(u'FROM:',comments,nocase)	and
																																					regexfind(u'TO:',comments,nocase)
																																				);

GlobalWatchLists.Layouts.Temp.EntityCommon	tWBIFExpirationDt(dExpirationDate	le,dWBIFExpirationDateComments	ri)	:=
transform
	unsigned	vToIndex						:=	stringlib.stringfind(GlobalWatchLists.Functions.strClean2Upper(ri.comments),'TO:',1);
	string		vExpirationDateStr	:=	GlobalWatchLists.Functions.strClean2Upper(ri.comments)[vToIndex+3..];
	
	self.expiration_date	:=	if(	ri.recordid[1..4]	=	'WBIF'	and	regexfind(u'FROM',ri.comments,nocase)	and	regexfind(u'TO',ri.comments,nocase),
																ut.Word(vExpirationDateStr,1),
																le.expiration_date
															);
	self									:=	le;
end;

dWBIFExpirationDate	:=	join(	dExpirationDate,
															dWBIFExpirationDateComments,
															left.pty_key	=	right.recordid	and
															left.source		=	right.watchlistname,
															tWBIFExpirationDt(left,right),
															left outer,
															lookup
														);

// Grounds
dWBIFGuidelines			:=	GlobalWatchLists.Normalize_Comments(	recordid[1..4]	=	'WBIF'	and
																															regexfind(u'CONSULTANT|PROCUREMENT',comments,nocase)
																														);

GlobalWatchLists.Layouts.Temp.EntityCommon	tGrounds(dWBIFExpirationDate	le,dWBIFGuidelines	ri)	:=
transform
	string		vCleanComments		:=	GlobalWatchLists.Functions.strClean2Upper(ri.comments);
	unsigned	vConsultantIndex	:=	StringLib.StringFind(vCleanComments,'CONSULTANT',1);
	unsigned	vProcurementIndex	:=	StringLib.StringFind(vCleanComments,'PROCUREMENT',1);
	unsigned	vUNSCIndex				:=	StringLib.StringFind(vCleanComments,'UNSC',1);
	unsigned	vCCIndex					:=	StringLib.StringFind(vCleanComments,'CC',1);
	unsigned	vRIUNRSTIndex			:=	StringLib.StringFind(vCleanComments,'RIUNRST',1);
	
	self.grounds	:=	map(	ri.recordid[1..4]	=	'WBIF'	and	regexfind('CONSULTANT',ri.comments,nocase)		=>	GlobalWatchLists.Functions.strClean(ri.comments[vConsultantIndex..]),
													ri.recordid[1..4]	=	'WBIF'	and	regexfind('PROCUREMENT',ri.comments,nocase)		=>	GlobalWatchLists.Functions.strClean(ri.comments[vProcurementIndex..]),
													le.pty_key[1..3]	=	'OCC'		and	regexfind('OCC ALERT',le.referenceid,nocase)	=>	GlobalWatchLists.Functions.strClean(le.referenceid[stringlib.stringfind(le.referenceid,'OCC ALERT',1)..]),
													ri.recordid[1..3]	=	'OCC'		and	regexfind('OCC ALERT',ri.comments,nocase)			=>	regexreplace('[)]$',GlobalWatchLists.Functions.strClean(ri.comments[StringLib.StringFind(vCleanComments,'OCC ALERT',1)..]),''),
													ri.recordid[1..5]	=	'OSFIL'	and	regexfind('UNSC',ri.comments,nocase)					=>	GlobalWatchLists.Functions.strClean(ri.comments[vUNSCIndex..]),
													ri.recordid[1..5]	=	'OSFIL'	and	regexfind('CC ',ri.comments,nocase)						=>	GlobalWatchLists.Functions.strClean(ri.comments[vCCIndex..]),
													ri.recordid[1..5]	=	'OSFIL'	and	regexfind('RIUNRST',ri.comments,nocase)				=>	GlobalWatchLists.Functions.strClean(ri.comments[vRIUNRSTIndex..]),
													le.grounds
												);
	self					:=	le;
end;

dGrounds	:=	join(	dWBIFExpirationDate,
										dWBIFGuidelines,
										left.pty_key	=	right.recordid	and
										left.source		=	right.watchlistname,
										tGrounds(left,right),
										left outer,
										lookup
									);

// Join Offenses
dOffenseComments			:=	GlobalWatchLists.Normalize_Comments(regexfind('OFFENCES:',comments,nocase));

GlobalWatchLists.Layouts.Temp.EntityCommon	tOffenses(dGrounds	le,dOffenseComments	ri)	:=
transform
	self.offenses	:=	if(	regexfind('OFFENCES:',ri.comments,nocase),
												GlobalWatchLists.Functions.strClean2Upper(regexreplace('OFFENCES:',ri.comments,'',nocase)),
												''
											);
	self					:=	le;	
end;
	
dOffenses	:=	join(	dGrounds,
										dOffenseComments,
										left.pty_key 	=	right.recordid	and
										left.source 	=	right.watchlistname,
										tOffenses(left,right),
										left outer,
										lookup
									);

// Join Warrant By
dWarrantComments			:=	GlobalWatchLists.Normalize_Comments(regexfind('ARREST WARRANT ISSUED BY:',comments,nocase));
dWarrantCommentsDist  :=	distribute(dWarrantComments,hash32(recordid,watchlistname));

GlobalWatchLists.Layouts.Temp.EntityCommon	tArrestWarrant(dOffenses	le,dWarrantCommentsDist	ri)	:=
transform
	self.warrant_by	:=	if(	regexfind('ARREST WARRANT ISSUED BY:',ri.comments,nocase),
													regexreplace('ARREST WARRANT ISSUED BY:',ri.comments,'',nocase),
													le.warrant_by
												);
	self 						:=	le;	
end;
	
dArrestWarrant	:=	join(	dOffenses,
													dWarrantCommentsDist,
													left.pty_key 	=	right.recordid	and
													left.source 	=	right.watchlistname,
													tArrestWarrant(left,right),
													left outer,
													local
												);

// Join Membership
dMermbershipComments			:=	GlobalWatchLists.Normalize_Comments(regexfind('REGIME:|REGISTRANT:',comments,nocase));

GlobalWatchLists.Layouts.Temp.EntityCommon	tMembership(dArrestWarrant	le,dMermbershipComments	ri)	:=
transform
	self.membership_1	:=	map(	regexfind('REGIME:',ri.comments,nocase)																	=>	regexreplace('REGIME:',ri.comments,'',nocase),
															regexfind('REGISTRANT:',ri.comments,nocase)															=>	regexreplace('REGISTRANT:',ri.comments,'',nocase),
															le.pty_key[1..3]	=	'FAR'		and	le.comments	<>	''											=>	le.comments,
															le.pty_key[1..5]	=	'OSFIL'	and	regexfind('TALIBAN',le.comments,nocase)	=>	'Taliban',
															''
														);
	self 							:=	le;	
end;
	
dMembership	:=	join(	dArrestWarrant,
											dMermbershipComments,
											left.pty_key 	=	right.recordid	and
											left.source 	=	right.watchlistname,
											tMembership(left,right),
											left outer,
											lookup
										);

// Other Membership
GlobalWatchLists.Layouts.Temp.EntityCommon	tUNMembership(dMembership	pInput)	:=
transform
	self.membership_1	:=	map(	pInput.pty_key[1..4]	=	'UNNT'	and	regexfind('TI|TE',pInput.referenceid[1..2],nocase)	=>	'Taliban',
															pInput.pty_key[1..4]	=	'UNNT'	and	regexfind('QI|QE',pInput.referenceid[1..2],nocase)	=>	'Al-Qaida',
															pInput.membership_1
														);
	self							:=	pInput;
end;

dUNMembership	:=	project(dMembership,tUNMembership(left));

// Join Federal Register Citation
dFedCitationComments	:=	GlobalWatchLists.Normalize_Comments(regexfind('REGISTER',comments,nocase)	and	(recordid[1..3]	in	['DTC','BIS']	or	recordid[1..4]	=	'NPRS'));

GlobalWatchLists.Layouts.Temp.EntityCommon	tFedCitations(dUNMembership	le,dFedCitationComments	ri)	:=
transform
	string	vCleanComments						:=	GlobalWatchLists.Functions.strClean(ri.comments);
	string	vCleanComments2Upper			:=	GlobalWatchLists.Functions.strClean2Upper(ri.comments);
	
	integer	vDTCFedRegisterLowIndex		:=	StringLib.StringFind(vCleanComments2Upper,'FEDERAL REGISTER',1);
	integer	vDTCFedRegisterHighIndex	:=	StringLib.StringFind(vCleanComments2Upper,'FEDERAL REGISTER',2);
	string	vDTCFedRegister						:=	GlobalWatchLists.Functions.strClean(vCleanComments[1..StringLib.StringFind(vCleanComments,',',1)-1]);
	string	vDTCFedRegisterDate				:=	if(	vDTCFedRegisterHighIndex	=	0,
																						GlobalWatchLists.Functions.strClean(vCleanComments[StringLib.StringFind(vCleanComments,',',1)+1..]),
																						GlobalWatchLists.Functions.strClean(vCleanComments[StringLib.StringFind(vCleanComments,',',1)+1..StringLib.StringFind(vCleanComments,',',3)-1])
																					);
	
	string	vNPRSFedRegister					:=	regexreplace(	'FEDERAL REGISTER NOTICE:',
																											GlobalWatchLists.Functions.strClean(vCleanComments[1..StringLib.StringFind(vCleanComments,';',1)-1]),
																											'',
																											nocase
																										);
	string	vNPRSFedRegisterDate			:=	GlobalWatchLists.Functions.strClean(vCleanComments[StringLib.StringFind(vCleanComments,';',1)+1..]);
	
	string	vBISFedRegisterStrStr			:=	GlobalWatchLists.Functions.strClean(	regexreplace(	'([0-9]+) (F.R.) ([0-9]+)',
																																														regexreplace('FEDERAL REGISTER CITATIONS:|AND',vCleanComments,'',nocase),
																																														'$1$2$3',
																																														nocase
																																													)
																																						);

	self.federal_register_citation_1 				:=	map(	ri.recordid[1..3]	=	'DTC'		=>	vDTCFedRegister,
																										ri.recordid[1..4]	=	'NPRS'	=>	vNPRSFedRegister,
																										ri.recordid[1..3]	=	'BIS'		=>	regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,1),'$1 $2 $3',nocase),
																										le.federal_register_citation_1
																									);
	self.federal_register_citation_2				:=	map(	ri.recordid[1..3]	=	'DTC'	and	vDTCFedRegisterHighIndex	<>	0	=>	GlobalWatchLists.Functions.strClean(vCleanComments[StringLib.StringFind(vCleanComments,',',3)+1..StringLib.StringFind(vCleanComments,',',4)-1]),
																										ri.recordid[1..3]	=	'BIS'																			=>	regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,3),'$1 $2 $3',nocase),
																										le.federal_register_citation_2
																									);
	self.federal_register_citation_3				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,5),'$1 $2 $3',nocase),
																									le.federal_register_citation_3
																								);
	self.federal_register_citation_4				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,7),'$1 $2 $3',nocase),
																									le.federal_register_citation_4
																								);
	self.federal_register_citation_5				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,9),'$1 $2 $3',nocase),
																									le.federal_register_citation_5
																								);
	self.federal_register_citation_6				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,11),'$1 $2 $3',nocase),
																									le.federal_register_citation_6
																								);
	self.federal_register_citation_7				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,13),'$1 $2 $3',nocase),
																									le.federal_register_citation_7
																								);
	self.federal_register_citation_8				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,15),'$1 $2 $3',nocase),
																									le.federal_register_citation_8
																								);
	self.federal_register_citation_9				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,17),'$1 $2 $3',nocase),
																									le.federal_register_citation_9
																								);
	self.federal_register_citation_10				:=	if(	ri.recordid[1..3]	=	'BIS',
																									regexreplace('([0-9]+)(F.R.)([0-9]+)',ut.Word(vBISFedRegisterStrStr,19),'$1 $2 $3',nocase),
																									le.federal_register_citation_10
																								);
	self.federal_register_citation_date_1		:=	map(	ri.recordid[1..3]	=	'DTC'		=>	vDTCFedRegisterDate,
																										ri.recordid[1..4]	=	'NPRS'	=>	vNPRSFedRegisterDate,
																										ri.recordid[1..3]	=	'BIS'		=>	ut.Word(vBISFedRegisterStrStr,2),
																										le.federal_register_citation_date_1
																									);
	self.federal_register_citation_date_2		:=	map(	ri.recordid[1..3]	=	'DTC'	and	vDTCFedRegisterHighIndex	<>	0	=>	GlobalWatchLists.Functions.strClean(vCleanComments[StringLib.StringFind(vCleanComments,',',4)+1..]),
																										ri.recordid[1..3]	=	'BIS' 																		=>	ut.Word(vBISFedRegisterStrStr,4),
																										le.federal_register_citation_date_2
																									);
	self.federal_register_citation_date_3		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,6),
																									le.federal_register_citation_date_3
																								);
	self.federal_register_citation_date_4		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,8),
																									le.federal_register_citation_date_4
																								);
	self.federal_register_citation_date_5		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,10),
																									le.federal_register_citation_date_5
																								);
	self.federal_register_citation_date_6		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,12),
																									le.federal_register_citation_date_6
																								);
	self.federal_register_citation_date_7		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,14),
																									le.federal_register_citation_date_7
																								);
	self.federal_register_citation_date_8		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,16),
																									le.federal_register_citation_date_8
																								);
	self.federal_register_citation_date_9		:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,18),
																									le.federal_register_citation_date_9
																								);
	self.federal_register_citation_date_10	:=	if(	ri.recordid[1..3]	=	'BIS',
																									ut.Word(vBISFedRegisterStrStr,20),
																									le.federal_register_citation_date_10
																								);
	self 																		:=	le;	
end;

dFedCitations	:=	join(	dUNMembership,
												dFedCitationComments,
												left.pty_key 	=	right.recordid	and
												left.source 	=	right.watchlistname,
												tFedCitations(left,right),
												left outer,
												lookup
											);

dFedCitationsDedup	:=	dedup(dFedCitations,record,all);

export	Mapping_GlobalWatchLists_Entity_Common	:=	sort(dFedCitationsDedup,pty_key,source)	:	persist('~thor_200::persist::globalwatchlists::entity_common');