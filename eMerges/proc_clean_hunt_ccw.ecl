import Address, AID, ut;

export proc_clean_hunt_ccw(	dataset(emerges.layout_hunt_ccw.rHuntCCWIn_layout) dHuntCCW_In,
														string	version_date,
														string	file_type
													)	:=
function
	
	fnCleanName(string fname, string mname, string lname, string suffix)	:=
	function
	
		unsigned4 orig_fname_words	:=	if(FName	= '', 0, length(stringlib.stringfilter(trim(regexreplace('[ ]+', FName, ' '), left, right), ' ')) + 1);
		unsigned4 orig_mname_words	:=	if(MName	= '', 0, length(stringlib.stringfilter(trim(regexreplace('[ ]+', MName, ' '), left, right), ' ')) + 1);
		unsigned4 orig_lname_words	:=	if(LName	= '', 0, length(stringlib.stringfilter(trim(regexreplace('[ ]+', LName, ' '), left, right), ' ')) + 1);
		
		unsigned4 orig_words				:=	orig_fname_words + orig_mname_words + orig_lname_words;

		string76 temp_clean_name		:=	if(	orig_fname_words > 2 and orig_mname_words = 0 and orig_lname_words = 0,
																				if(	regexfind('[a-zA-Z]+[ ][a-zA-Z][.][ ][a-zA-Z]+', FName),
																						Address.CleanPersonFML73(regexreplace('[0-9|:/\\_{}[\'"*()#+.-]', FName, ''))	+	'FML',
																						Address.CleanPersonLFM73(regexreplace('[0-9|:/\\_{}[\'"*()#+.-]', FName, ''))	+	'LFM'
																					),
																				if(	orig_lname_words > 2 and orig_fname_words = 0 and orig_mname_words = 0,
																						if(	regexfind('[a-zA-Z]+[ ][a-zA-Z][.][ ][a-zA-Z]+', LName),
																								Address.CleanPersonFML73(regexreplace('[0-9|:/\\_{}[\'"*()#+.-]', LName, ''))	+	'FML',
																								Address.CleanPersonLFM73(regexreplace('[0-9|:/\\_{}[\'"*()#+.-]', LName, ''))	+	'LFM'
																							),
																						Address.CleanPersonLFM73(regexreplace(	'[0-9|:/\\_{}[\'"*()#+.-]',
																																												trim(LName, left, right) + ', ' +
																																												trim(FName, left, right) + ' ' +
																																												trim(MName, left, right) + ' ' +
																																												trim(Suffix, left, right), 
																																												''
																																											)
																																					)	+	'LFM'
																					)
																			);

		unsigned4	clean_words			:=	length(stringlib.stringfilter(trim(regexreplace('[ ]+', temp_clean_name[6..60], ' '), left, right), ' ')) + 1;
		
		string76 clean_name				:=	if(	clean_words < orig_words,
																			Address.CleanPersonFML73(	regexreplace(	'[0-9|:/\\_{}[\'"*()#+.-]',
																																										trim(FName, left, right) + ' ' +
																																										trim(MName, left, right) + ' ' +
																																										trim(LName, left, right) + ' ' +
																																										trim(Suffix, left, right), 
																																										''
																																									)
																																		)	+	'FML',
																			Address.CleanPersonLFM73(regexreplace(	'[0-9|:/\\_{}[\'"*()#+.-]',
																																									trim(LName, left, right) + ', ' +
																																									trim(FName, left, right) + ' ' +
																																									trim(MName, left, right) + ' ' +
																																									trim(suffix, left, right), 
																																									''
																																								)
																																		)	+	'LFM'
																		);

		return clean_name;
	end;
	

	//Append Record_ID	
	rHuntCCWAppendID_layout	:=
	record
		emerges.layout_hunt_ccw.rHuntCCWIn_layout;
	  unsigned8 persistent_record_id 	:= 0;

	end;
	
	rHuntCCWAppendID_layout	tAppendRecordID(dHuntCCW_In pInput)	:=
	transform
		self.persistent_record_id := HASH64(ut.fnTrim2Upper(pInput.EMIDNumber)
																				+ ut.fnTrim2Upper(pInput.state_code)
																				+ ut.fnTrim2Upper(pInput.source_code)
																				+ ut.fnTrim2Upper(pInput.file_acquired_date)
																				+ ut.fnTrim2Upper(pInput.use_code)
																				+ ut.fnTrim2Upper(pInput.prefix_title)
																				+ ut.fnTrim2Upper(pInput.last_name)
																				+ ut.fnTrim2Upper(pInput.first_name)
																				+ ut.fnTrim2Upper(pInput.middle_name)
																				+ ut.fnTrim2Upper(pInput.maiden_prior)
																				+ ut.fnTrim2Upper(pInput.suffix)
																				+ ut.fnTrim2Upper(pInput.DateOfBirth)
																				+ ut.fnTrim2Upper(pInput.AgeCat)
																				+ ut.fnTrim2Upper(pInput.HeadHousehold)
																				+ ut.fnTrim2Upper(pInput.place_of_birth)
																				+ ut.fnTrim2Upper(pInput.occupation)
																				+ ut.fnTrim2Upper(pInput.regSource)
																				+ ut.fnTrim2Upper(pInput.RegDate)
																				+ ut.fnTrim2Upper(pInput.race)
																				+ ut.fnTrim2Upper(pInput.gender)
																				+ ut.fnTrim2Upper(pInput.VoterHomePhone)
																				+ ut.fnTrim2Upper(pInput.VoterWorkPhone)
																				+ ut.fnTrim2Upper(pInput.ActiveOrInactive)
																				+ ut.fnTrim2Upper(pInput.ResAddr1)
																				+ ut.fnTrim2Upper(pInput.ResAddr2)
																				+ ut.fnTrim2Upper(pInput.Res_city)
																				+ ut.fnTrim2Upper(pInput.Res_state)
																				+ ut.fnTrim2Upper(pInput.Res_zip)
																				+ ut.fnTrim2Upper(pInput.Res_county)
																				+ ut.fnTrim2Upper(pInput.MailAddr1)
																				+ ut.fnTrim2Upper(pInput.MailAddr2)
																				+ ut.fnTrim2Upper(pInput.mail_city)
																				+ ut.fnTrim2Upper(pInput.mail_state)
																				+ ut.fnTrim2Upper(pInput.mail_zip)
																				+ ut.fnTrim2Upper(pInput.mail_county)
																				+ ut.fnTrim2Upper(pInput.CASS_County)
																				+ ut.fnTrim2Upper(pInput.ContributorParty)
																				+ ut.fnTrim2Upper(pInput.RecipientParty)
																				+ ut.fnTrim2Upper(pInput.DateOfCont)
																				+ ut.fnTrim2Upper(pInput.DollarAmt)
																				+ ut.fnTrim2Upper(pInput.OfficeContributedTo)
																				+ ut.fnTrim2Upper(pInput.CumulDollarAmt)
																				+ ut.fnTrim2Upper(pInput.ContFiller1)
																				+ ut.fnTrim2Upper(pInput.ContFiller2)
																				+ ut.fnTrim2Upper(pInput.ContType)
																				+ ut.fnTrim2Upper(pInput.ContFiller3)
																				+ ut.fnTrim2Upper(pInput.HuntFishPerm)
																				+ ut.fnTrim2Upper(pInput.DateLicense)
																				+ ut.fnTrim2Upper(pInput.HomeState)
																				+ ut.fnTrim2Upper(pInput.Resident)
																				+ ut.fnTrim2Upper(pInput.NonResident)
																				+ ut.fnTrim2Upper(pInput.Hunt)
																				+ ut.fnTrim2Upper(pInput.Fish)
																				+ ut.fnTrim2Upper(pInput.ComboSuper)
																				+ ut.fnTrim2Upper(pInput.Sportsman)
																				+ ut.fnTrim2Upper(pInput.Trap)
																				+ ut.fnTrim2Upper(pInput.Archery)
																				+ ut.fnTrim2Upper(pInput.Muzzle)
																				+ ut.fnTrim2Upper(pInput.Drawing)
																				+ ut.fnTrim2Upper(pInput.Day1)
																				+ ut.fnTrim2Upper(pInput.Day3)
																				+ ut.fnTrim2Upper(pInput.Day7)
																				+ ut.fnTrim2Upper(pInput.Day14to15)
																				+ ut.fnTrim2Upper(pInput.DayFiller) //Guides
																				+ ut.fnTrim2Upper(pInput.SeasonAnnual)
																				+ ut.fnTrim2Upper(pInput.LifeTimePermit)
																				+ ut.fnTrim2Upper(pInput.LandOwner)
																				+ ut.fnTrim2Upper(pInput.Family)
																				+ ut.fnTrim2Upper(pInput.Junior)
																				+ ut.fnTrim2Upper(pInput.SeniorCitizen)
																				+ ut.fnTrim2Upper(pInput.CrewMemeber)
																				+ ut.fnTrim2Upper(pInput.Retarded)
																				+ ut.fnTrim2Upper(pInput.Indian)
																				+ ut.fnTrim2Upper(pInput.Serviceman)
																				+ ut.fnTrim2Upper(pInput.Disabled)
																				+ ut.fnTrim2Upper(pInput.LowIncome)
																				+ ut.fnTrim2Upper(pInput.RegionCounty)
																				+ ut.fnTrim2Upper(pInput.HuntType)		//Blind
																				+ ut.fnTrim2Upper(pInput.HuntFiller)	//Location
																				+ ut.fnTrim2Upper(pInput.Salmon)
																				+ ut.fnTrim2Upper(pInput.Freshwater)
																				+ ut.fnTrim2Upper(pInput.Saltwater)
																				+ ut.fnTrim2Upper(pInput.LakesandResevoirs)
																				+ ut.fnTrim2Upper(pInput.SetLineFish)
																				+ ut.fnTrim2Upper(pInput.Trout)
																				+ ut.fnTrim2Upper(pInput.FallFishing)
																				+ ut.fnTrim2Upper(pInput.SteelHead)
																				+ ut.fnTrim2Upper(pInput.WhiteJubHerring)
																				+ ut.fnTrim2Upper(pInput.Sturgeon)   //otter
																				+ ut.fnTrim2Upper(pInput.ShellfishCrab) //MussleRoe
																				+ ut.fnTrim2Upper(pInput.ShellfishLobster) //ShellFish
																				+ ut.fnTrim2Upper(pInput.Deer)
																				+ ut.fnTrim2Upper(pInput.Bear)
																				+ ut.fnTrim2Upper(pInput.Elk)
																				+ ut.fnTrim2Upper(pInput.Moose)
																				+ ut.fnTrim2Upper(pInput.Buffalo)
																				+ ut.fnTrim2Upper(pInput.Antelope)
																				+ ut.fnTrim2Upper(pInput.SikeBull)
																				+ ut.fnTrim2Upper(pInput.BighornSheep) //SheepGoat
																				+ ut.fnTrim2Upper(pInput.Javelina)
																				+ ut.fnTrim2Upper(pInput.Cougar)
																				+ ut.fnTrim2Upper(pInput.Anterless)
																				+ ut.fnTrim2Upper(pInput.Pheasant)
																				+ ut.fnTrim2Upper(pInput.Goose)
																				+ ut.fnTrim2Upper(pInput.Duck)
																				+ ut.fnTrim2Upper(pInput.Turkey)
																				+ ut.fnTrim2Upper(pInput.Snowmobile) //Subscriber
																				+ ut.fnTrim2Upper(pInput.BigGame)
																				+ ut.fnTrim2Upper(pInput.MigratoryBirds)
																				+ ut.fnTrim2Upper(pInput.SmallGame)
																				+ ut.fnTrim2Upper(pInput.Sturgeon2)
																				+ ut.fnTrim2Upper(pInput.Gun)
																				+ ut.fnTrim2Upper(pInput.Bonus)
																				+ ut.fnTrim2Upper(pInput.ApplicantLottery)
																				+ ut.fnTrim2Upper(pInput.OtherBirds) //Waterfowl
																				+ ut.fnTrim2Upper(pInput.huntfill1)		//email
																				+ ut.fnTrim2Upper(pInput.BoatIndexNum) //ParkLake
																				+ ut.fnTrim2Upper(pInput.BoatCoOwner)	//CCWPermitee
																				+ ut.fnTrim2Upper(pInput.Len)					//TempHuntFish
																				+ ut.fnTrim2Upper(pInput.HullConstruction)  //ComboSuperLifetime
																				+ ut.fnTrim2Upper(pInput.RegExpiryDate)
																				+ ut.fnTrim2Upper(pInput.BoatFill3)				//CCWRejectReason
																				+ ut.fnTrim2Upper(pInput.CCWPermNum)
																				+ ut.fnTrim2Upper(pInput.CCWWeaponType)
																				+ ut.fnTrim2Upper(pInput.CCWRegDate)
																				+ ut.fnTrim2Upper(pInput.CCWExpiryDate)
																				+ ut.fnTrim2Upper(pInput.CCWPermType)
																				+ ut.fnTrim2Upper(pInput.MiscFill5)
																				+ ut.fnTrim2Upper(pInput.FillerOther1)   	//SourceCounty
																				+ ut.fnTrim2Upper(pInput.FillerOther2)			//MailCountry
																				+ ut.fnTrim2Upper(pInput.FillerOther4));			//ResZipPlusFour
	
	self								:=	pInput;
	
	end;
	
	dHuntCCW_RecordID	:=	project(dHuntCCW_In,tAppendRecordID(left));
	
	// Clean name and other fields
	emerges.layout_hunt_ccw.rHuntCCWClean_layout	tCleanNameAddr(dHuntCCW_RecordID pInput)	:=
	transform
		name_clean												:=	fnCleanName(pInput.first_name,
																											pInput.middle_name,
																											pInput.last_name,
																											pInput.Suffix
																											);
    // self.persistent_record_id					:= 0;
		self.process_date									:=	version_date;
		self.score												:=	'';
		self.best_ssn											:=	'';
		self.file_id											:=	stringlib.stringtouppercase(file_type);
		self.Source												:=	'EMERGES';
		self.did_out											:=	'';
		self.vendor_id										:=	pInput.EMIDNumber;
		self.source_state									:=	pInput.state_code;
		self.file_acquired_date						:=	regexreplace('^[0]+$', pInput.File_Acquired_Date, '');
		self._use													:=	pInput.use_code;
		self.title_in											:=	pInput.prefix_title;
		self.lname_in											:=	pInput.last_name;
		self.fname_in											:=	pInput.first_name;
		self.mname_in											:=	pInput.middle_name;
		self.maiden_prior									:=	pInput.maiden_prior;
		self.name_suffix_in								:=	pInput.Suffix;
		self.dob_str_in										:=	regexreplace('^[0]+$', pInput.DateOfBirth, '');
		self.RegDate_in										:=	regexreplace('^[0]+$', pInput.RegDate, '');
		self.poliparty										:=	pInput.PoliticalParty;
		self.Phone												:=	stringlib.stringfilter(pInput.VoterHomePhone, '0123456789');
		self.Work_Phone										:=	stringlib.stringfilter(pInput.VoterWorkPhone, '0123456789');
		self.Other_Phone									:=	stringlib.stringfilter(pInput.VoterOtherPhone, '0123456789');
		self.active_status								:=	pInput.ActiveOrInactive;
		self.mail_addr1										:=	pInput.MailAddr1;
		self.mail_addr2										:=	pInput.MailAddr2;
		self.cass_addr1										:=	pInput.CASSAddr1;
		self.cass_addr2										:=	pInput.CASSAddr2;
		self.cass_city										:=	pInput.CASS_City;
		self.cass_state										:=	pInput.CASS_State;
		self.cass_zip											:=	pInput.CASS_Zip;
		self.cass_county									:=	pInput.CASS_County;
		self.distcode											:=	pInput.DistrictCode;
		self.DateOfContr_in								:=	regexreplace('^[0]+$', pInput.DateOfCont, '');
		self.RecptParty										:=	pInput.RecipientParty;
		self.OfficeContTo									:=	pInput.OfficeContributedTo;
		self.LastDayVote_in								:=	regexreplace('^[0]+$', pInput.LastDateVote, '');
		self.DateLicense_in								:=	regexreplace('^[0]+$', pInput.DateLicense, '');
		self.SeniorCit										:=	pInput.SeniorCitizen;
		self.Blind												:=	pInput.HuntType;
		self.Bighorn											:=	pInput.BigHornSheep;
		self.MigBird											:=	pInput.MigratoryBirds;
		self.Lottery											:=	pInput.ApplicantLottery;
		self.Lengt												:=	pInput.Len;
		self.HullConstruct								:=	pInput.HullConstruction;
		self.RegExpDate_in								:=	regexreplace('^[0]+$', pInput.RegExpiryDate, '');
		self.StPrimUse										:=	pInput.StatePrimaryUse;
		self.SpecReg											:=	pInput.SpecialRegistration;
		self.CCWRegDate_in								:=	regexreplace('^[0]+$', pInput.CCWRegDate, '');
		self.CCWExpDate_in								:=	if(	(pInput.DateOfBirth = pInput.CCWExpiryDate) or (pInput.CCWRegDate = '' and pInput.DateOfBirth = ''),
																							'',
																							regexreplace('^[0]+$', pInput.CCWExpiryDate, '')
																						);
		self.FillerOther1									:=	'';
		self.FillerOther2									:=	'';
		self.FillerOther3									:=	'';
		self.FillerOther4									:=	'';
		self.FillerOther5									:=	'';
		self.FillerOther6									:=	'';
		self.FillerOther7									:=	'';
		self.FillerOther8									:=	'';
		self.FillerOther9									:=	'';
		self.FillerOther10								:=	'';
		self.EOR													:=	'';
		
		string8 v_cens_date	  						:= if((self.RegDate_in between '19500101' and ut.GetDate) and
																						length(trim(self.RegDate_in)) = 8,
																						self.RegDate_in,
																						''
																						);
		string8 v_ccw_date								:= if((self.CCWRegDate_in between '19500101' and ut.GetDate) and
																						length(trim(self.CCWRegDate_in)) = 8,
																						self.CCWRegDate_in,
																						''
																						);
		string8 v_vote_date								:= if((self.LastDayVote_in	between '19500101' and ut.GetDate) and
																						length(trim(self.LastDayVote_in)) = 8,
																						self.LastDayVote_in,
																						if(	(self.RegDate_in between '19500101' and ut.GetDate) and
																								length(trim(self.RegDate_in)) = 8,
																								self.RegDate_in,
																								''
																							)
																						);
		string8 v_hunt_date								:= if((self.DateLicense_in between '19500101' and ut.GetDate) and
																						length(trim(self.DateLicense_in)) = 8,
																						self.DateLicense_in,
																						if(	(self.RegDate_in between '19500101' and ut.GetDate) and
																								length(trim(self.RegDate_in)) = 8,
																								self.RegDate_in,
																								''
																							)
																						);
		string8 v_fish_date								:= if((self.DateLicense_in between '19500101' and ut.GetDate) and
																						length(trim(self.DateLicense_in)) = 8,
																						self.DateLicense_in,
																						''
																						);
		
		self.date_first_seen							:=	case(	stringlib.stringtouppercase(trim(self.file_id)),
																								'HUNT'	=>	'',
																								'FISH'	=>	'',
																								'CENS'	=>	'',
																								'VOTE'	=>	v_vote_date,
																								'CCW'		=>	'',
																								''
																							);
		self.date_last_seen								:=	case(	stringlib.stringtouppercase(trim(self.file_id)),
																								'HUNT'	=>	'',
																								'FISH'	=>	'',
																								'CENS'	=>	'',
																								'VOTE'	=>	v_vote_date,
																								'CCW'		=>	'',
																								''
																							);
		self.dob_str											:=	pInput.DateOfBirth;
		self.regDate											:=	pInput.RegDate;
		self.DateOfContr									:=	regexreplace('^[0]+$', pInput.DateOfCont, '');
		self.LastDayVote									:=	regexreplace('^[0]+$', pInput.LastDateVote, '');
		self.DateLicense									:=	regexreplace('^[0]+$', pInput.DateLicense, '');
		self.RegExpDate										:=	regexreplace('^[0]+$', pInput.RegExpiryDate, '');
		self.CCWRegDate										:=	regexreplace('^[0]+$', pInput.CCWRegDate, '');
		self.CCWExpDate										:=	regexreplace('^[0]+$', pInput.CCWExpiryDate, '');
		
		self.title												:=	name_clean[1..5];
		self.fname												:=	name_clean[6..25];
		self.mname												:=	name_clean[26..45];
		self.lname												:=	name_clean[46..65];
		self.name_suffix									:=	name_clean[66..70];
		self.score_on_input								:=	name_clean[71..73];
		self.cleaner_type									:=	name_clean[74..76];
		
		self															:=	pInput;
	end;

	dHuntCCW_Clean	:=	project(dHuntCCW_RecordID, tCleanNameAddr(left));
	
	// Due to new name cleaner issues, some of the names are cleaning incorrectly
	// For these records, pass them through a different cleaner
	dHuntCCW_BadCleanNames	:=	dHuntCCW_Clean(length(trim(fname,left,right))	=	1	or	length(trim(lname,left,right))	=	1);
	dHuntCCW_GoodCleanNames	:=	dHuntCCW_Clean(~(length(trim(fname,left,right))	=	1	or	length(trim(lname,left,right))	=	1));
	
	emerges.layout_hunt_ccw.rHuntCCWClean_layout	tRecleanName(dHuntCCW_BadCleanNames	pInput)	:=
	transform
		string73	name_clean	:=	if(	pInput.cleaner_type	=	'LFM',
																	Address.CleanPersonFML73(regexreplace(	'[0-9|:/\\_{}[\'"*()#+.-]',
																																							trim(pInput.fname_in,left,right) + ' ' +
																																							trim(pInput.mname_in,left,right) + ' ' +
																																							trim(pInput.lname_in,left,right) + ' ' +
																																							trim(pInput.name_suffix_in,left,right), 
																																							''
																																						)
																																),
																	Address.CleanPersonLFM73(regexreplace(	'[0-9|:/\\_{}[\'"*()#+.-]',
																																							trim(pInput.lname_in,left,right) + ', ' +
																																							trim(pInput.fname_in,left,right) + ' ' +
																																							trim(pInput.mname_in,left,right) + ' ' +
																																							trim(pInput.name_suffix_in,left,right), 
																																							''
																																						)
																																)
																);
		self.title						:=	name_clean[1..5];
		self.fname						:=	name_clean[6..25];
		self.mname						:=	name_clean[26..45];
		self.lname						:=	name_clean[46..65];
		self.name_suffix			:=	name_clean[66..70];
		self.score_on_input		:=	name_clean[71..73];
		
		self									:=	pInput;
	end;
	
	dHuntCCW_RecleanNames	:=	project(dHuntCCW_BadCleanNames,tRecleanName(left))	+	dHuntCCW_GoodCleanNames;
	
	// Append sequence number before normalizing
	rHuntCCWAppendAID_layout	:=
	record
		emerges.layout_hunt_ccw.rHuntCCWClean_layout	and not	[cleaner_type];
	  string1		addressInd						:=	'';
		string100	Append_Prep_Address1	:=	'';
		string50	Append_Prep_Address2	:=	'';
		AID.Common.xAID	Append_RawAID		:=	0;
	end;
	
	rHuntCCWAppendAID_layout	tAppendPrepAddr(dHuntCCW_RecleanNames pInput)	:=
	transform
		self	:=	pInput;
	end;
	
	dHuntCCW_AppendPrepAddr	:=	project(dHuntCCW_RecleanNames, tAppendPrepAddr(left));
	
	ut.MAC_Sequence_Records(dHuntCCW_AppendPrepAddr, Append_SeqNum, dHuntCCW_AppendPrepAddr_SeqNum);
	
	// Normalize records on address
	rHuntCCWAppendAID_layout	tNormalizeAddr(dHuntCCW_AppendPrepAddr_SeqNum pInput, integer addrCount)	:=
	transform
		self.addressInd						:=	choose(addrCount, 'R', 'M', 'C');
		self.Append_Prep_Address1	:=	choose(	addrCount,
																					trim(StringLib.StringToUpperCase(trim(pInput.ResAddr1, left, right) + ' ' + trim(pInput.ResAddr2, left, right)),left,right),
																					trim(StringLib.StringToUpperCase(trim(pInput.Mail_Addr1, left, right) + ' ' + trim(pInput.Mail_Addr2, left, right)),left,right),
																					trim(StringLib.StringToUpperCase(trim(pInput.CASS_Addr1, left, right) + ' ' + trim(pInput.CASS_Addr2, left, right)),left,right)
																				);
		self.Append_Prep_Address2	:=	choose(	addrCount,
																					trim(	StringLib.StringToUpperCase(		trim(pInput.Res_City, left, right)
																																							+	if(	pInput.Res_City != '', ', '	+	trim(pInput.Res_State, left, right), trim(pInput.Res_State, left, right))
																																							+ ' '
																																							+ trim(pInput.Res_Zip, left, right)
																																						),
																								left,right
																							),
																					trim(	StringLib.StringToUpperCase(		trim(pInput.Mail_City, left, right)
																																							+	if(	pInput.Mail_City != '', ', '	+	trim(pInput.Mail_State, left, right), trim(pInput.Mail_State, left, right))
																																							+ ' '
																																							+ trim(pInput.Mail_Zip, left, right)
																																						),
																								left,right
																							),
																					trim(	StringLib.StringToUpperCase(		trim(pInput.CASS_City, left, right)
																																							+	if(	pInput.CASS_City != '', ', '	+	trim(pInput.CASS_State, left, right), trim(pInput.CASS_State, left, right))
																																							+ ' '
																																							+ trim(pInput.CASS_Zip, left, right)
																																							),
																								left,right
																							)
																				);
		self											:=	pInput;
	end;
	
	dHuntCCW_StandardizeAddr	:=	normalize(dHuntCCW_AppendPrepAddr_SeqNum, 3, tNormalizeAddr(left, counter));	
	
	dHuntCCW_AddrPopulated		:=	dHuntCCW_StandardizeAddr(Append_Prep_Address2	!=	'');
	dHuntCCW_AddrNotPopulated	:=	dHuntCCW_StandardizeAddr(Append_Prep_Address2	=		'');

	// Pass to the AddressID macro and get back the raw addressID
	AID.MacAppendFromRaw_2Line(dHuntCCW_AddrPopulated, Append_Prep_Address1, Append_Prep_Address2, Append_RawAID, dHuntCCW_AppendAID, AID.Common.eReturnValues.RawAID);

	rHuntCCWAppendAID_layout	tAppendAID(dHuntCCW_AppendAID	pInput)	:=
	transform
		self.Append_RawAID	:=	pInput.AIDWork_RawAID;
		self								:=	pInput;
	end;
	
	dHuntCCW_AID	:=	project(dHuntCCW_AppendAID,tAppendAID(left));
	
	// Combine the records which were not passed to the Address ID macro before denormalizing
	dHuntCCW_AIDCombined	:=	dHuntCCW_AID	+	dHuntCCW_AddrNotPopulated;
		
	// Denormalize on addresses once the AID is appended
	emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout	tReformatBase(dHuntCCW_AIDCombined pInput)	:=
	transform
		self	:=	pInput;
		self	:=	[];
	end;
	
	dHuntCCW_ReformatBase				:=	project(dHuntCCW_AIDCombined, tReformatBase(left));
	dHuntCCW_ReformatBase_Dist	:=	distribute(dHuntCCW_ReformatBase,hash(Append_SeqNum));
	dHuntCCW_ReformatBase_Dedup	:=	dedup(sort(dHuntCCW_ReformatBase_Dist,Append_SeqNum,local),Append_SeqNum,local);
	
	emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout	tDenormAddr(dHuntCCW_ReformatBase_Dedup le, dHuntCCW_AIDCombined ri)	:=
	transform
		self.Append_Prep_ResAddress1	:=	if(ri.addressInd = 'R', ri.Append_Prep_Address1, le.Append_Prep_ResAddress1);
		self.Append_Prep_ResAddress2	:=	if(ri.addressInd = 'R', ri.Append_Prep_Address2, le.Append_Prep_ResAddress2);
		self.Append_ResRawAID					:=	if(ri.addressInd = 'R', ri.Append_RawAID, le.Append_ResRawAID);
		self.Append_Prep_MailAddress1	:=	if(ri.addressInd = 'M', ri.Append_Prep_Address1, le.Append_Prep_MailAddress1);
		self.Append_Prep_MailAddress2	:=	if(ri.addressInd = 'M', ri.Append_Prep_Address2, le.Append_Prep_MailAddress2);
		self.Append_MailRawAID				:=	if(ri.addressInd = 'M', ri.Append_RawAID, le.Append_MailRawAID);
		self.Append_Prep_CASSAddress1	:=	if(ri.addressInd = 'C', ri.Append_Prep_Address1, le.Append_Prep_CASSAddress1);
		self.Append_Prep_CASSAddress2	:=	if(ri.addressInd = 'C', ri.Append_Prep_Address2, le.Append_Prep_CASSAddress2);
		self.Append_CassRawAID				:=	if(ri.addressInd = 'C', ri.Append_RawAID, le.Append_CassRawAID);
		
		self													:=	le;
		self													:=	[];
	end;
	
	dHuntCCW_CleanAddr	:=	denormalize(dHuntCCW_ReformatBase_Dedup,
																			dHuntCCW_AIDCombined,
																			left.Append_SeqNum	=	right.Append_SeqNum,
																			tDenormAddr(left, right)
																			);

	// add functions to fix regdate
	string8 fixregdate(string8 date, string8 mydob, integer4 legal_age) :=
		map(date <> '18000101' and date <> '19000101' and date <> '' and
				length(stringlib.StringFilterOut(date, '0123456789 ')) = 0 =>
				map((integer)(date[1..4]) >= ((integer)(mydob[1..4]) + legal_age) and 
						date[1..8] <= stringlib.getdateyyyymmdd()[1..8] and date[1..4] >= '1776' =>
						map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
								map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 =>
										stringlib.StringFindReplace(date,' ','0'),
										stringlib.StringFindReplace(date[1..6] + '00',' ','0')
										),
								date[1..4] + '0000'
								),
						map((integer)(date[5..8]) >= ((integer)(mydob[1..4]) + legal_age) and 
								(date[5..8] + date[1..4]) <= stringlib.getdateyyyymmdd()[1..8] and date[5..8] >= '1776' =>
								map((integer)(date[1..2]) >= 1 and (integer)(date[1..2]) <= 12 =>
										map((integer)(date[3..4]) >= 1 and (integer)(date[3..4]) <= 31 =>
												stringlib.StringFindReplace(date[5..8] + date[1..4], ' ','0'),
												stringlib.StringFindReplace(date[5..8] + date[1..2] + '00',' ','0')
												),
										date[5..8] + '0000'
										),
								'        '
								)
						),
					'        '
					);

	string8 fixdobdate(string8 date) :=
		map((integer)(date[1..4]) >= 1776 and date[1..8] <= stringlib.getdateyyyymmdd()[1..8] and
				length(stringlib.StringFilterOut(date, '0123456789')) = 0 =>
				map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
						map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 =>
								stringlib.StringFindReplace(date,' ','0'),
								stringlib.StringFindReplace(date[1..6] + '00',
								' ',
								'0')
								),
						date[1..4] + '0000'
						),
				map((integer)(date[5..8]) >= 1776 and (date[5..8] + date[1..4]) <= stringlib.getdateyyyymmdd()[1..8] and
						length(stringlib.StringFilterOut(date, '0123456789')) = 0 =>
						map((integer)(date[1..2]) >= 1 and (integer)(date[1..2]) <= 12 =>
								map((integer)(date[3..4]) >= 1 and (integer)(date[3..4]) <= 31 =>
										stringlib.StringFindReplace(date[5..8] + date[1..4], ' ', '0'),
										stringlib.StringFindReplace(date[5..8] + date[1..2] + '00',' ','0')
										),
								date[5..8] + '0000'
								),
						'        '
						)
				);

	string8 fixotherdate(string8 date, string8 mydob, integer4 legal_age) :=
		map(date <> '18000101' and date <> '19000101' and date <> '' and
				length(stringlib.StringFilterOut(date, '0123456789 ')) = 0 =>
				map((integer)(date[1..4]) >= ((integer)(mydob[1..4]) + legal_age) and date[1..4] >= '1776' and 
						date[1..8] <= stringlib.getdateyyyymmdd()[1..8] => 
						map((integer)(date[5..6]) >= 1 and (integer)(date[5..6]) <= 12 =>
								map((integer)(date[7..8]) >= 1 and (integer)(date[7..8]) <= 31 => 
										date, 
										stringlib.StringFindReplace(date[1..6] + '00',' ','0')
										),
								date[1..4]
							),
						' '
						),
				'        '
				);

	emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout tFormatDates(emerges.layout_hunt_ccw.rHuntCCWCleanAddr_layout pInput)	:=
	transform
		self.regDate			:=	fixregdate(	pInput.regDate_in,
																			fixdobdate(pInput.dob_str_in), 
																			map(trim(pInput.file_id) = 'VOTE' => 17,
																					trim(pInput.file_id) = 'HUNT' => 0,
																					trim(pInput.file_id) = 'CCW' => 17,
																					trim(pInput.file_id) = 'CENS' => 0,
																					0
																					)
																		);
		self.dob_str  		:=	fixdobdate(pInput.dob_str_in);
		self.DateOfContr	:=	fixotherdate(	pInput.DateOfContr_in,
																				fixdobdate(pInput.dob_str_in), 
																				map(trim(pInput.file_id) = 'VOTE' => 17,
																						trim(pInput.file_id) = 'HUNT' => 0,
																						trim(pInput.file_id) = 'CCW' => 17,
																						trim(pInput.file_id) = 'CENS' => 0,
																						0
																						)
																			);
		self.LastDayVote	:=	fixotherdate(	pInput.LastDayVote_in,
																				fixdobdate(pInput.dob_str_in), 
																				map(trim(pInput.file_id) = 'VOTE' => 17,
																						trim(pInput.file_id) = 'HUNT' => 0,
																						trim(pInput.file_id) = 'CCW' => 17,
																						trim(pInput.file_id) = 'CENS' => 0,
																						0
																						)
																			);
		self.DateLicense	:=	fixotherdate(	pInput.DateLicense_in,
																				fixdobdate(pInput.dob_str_in), 
																				map(trim(pInput.file_id) = 'VOTE' => 17,
																						trim(pInput.file_id) = 'HUNT' => 0,
																						trim(pInput.file_id) = 'CCW' => 17,
																						trim(pInput.file_id) = 'CENS' => 0,
																						0
																						)
																			);
		self.RegExpDate		:=	pInput.RegExpDate_in;
		self.CCWRegDate		:=	fixotherdate(	pInput.CCWRegDate_in,
																				fixdobdate(pInput.dob_str_in), 
																				map(trim(pInput.file_id) = 'VOTE' => 17,
																						trim(pInput.file_id) = 'HUNT' => 0,
																						trim(pInput.file_id) = 'CCW' => 17,
																						trim(pInput.file_id) = 'CENS' => 0,
																						0
																						)
																			);
		self.CCWExpDate		:=	pInput.CCWExpDate_in;
		self							:=	pInput;
	end;

	dHuntCCW_CleanAddr_FixDates	:= project(dHuntCCW_CleanAddr,	tFormatDates(left));
	
	dHuntCCW_CleanOut			:=	output(dHuntCCW_CleanAddr_FixDates, , '~thor_data400::in::emerges::' + version_date + '::'	+	stringlib.stringtolowercase(file_type), __compressed__);

	addHuntCCW_CleanSuper	:=	sequential(	fileservices.startsuperfiletransaction(),
																				fileservices.addsuperfile('~thor_data400::in::emerges::hunt_ccw', '~thor_data400::in::emerges::' + version_date + '::'	+	stringlib.stringtolowercase(file_type)),
																				fileservices.finishsuperfiletransaction()
																			);
	
	return	sequential(dHuntCCW_CleanOut, addHuntCCW_CleanSuper);
end;