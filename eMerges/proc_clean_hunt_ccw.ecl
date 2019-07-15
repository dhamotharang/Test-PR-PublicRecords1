import Address, AID, ut, mdr, STD;

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
		Self.source_code := If(version_date = '20140520', MDR.sourceTools.src_EMerge_CCW_NY, pInput.Source_code);
		DATA temp_persistent_record_id := HASHMD5(ut.CleanSpacesAndUpper(pInput.EMIDNumber)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.state_code)
																				+ ',' + ut.CleanSpacesAndUpper(Self.source_code)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.file_acquired_date)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.use_code)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.prefix_title)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.last_name)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.first_name)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.middle_name)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.maiden_prior)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.suffix)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.DateOfBirth)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.AgeCat)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HeadHousehold)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.place_of_birth)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.occupation)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.regSource)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.RegDate)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.race)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.gender)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.VoterHomePhone)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.VoterWorkPhone)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ActiveOrInactive)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ResAddr1)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ResAddr2)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Res_city)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Res_state)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Res_zip)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Res_county)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.MailAddr1)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.MailAddr2)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.mail_city)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.mail_state)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.mail_zip)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.mail_county)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CASS_County)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ContributorParty)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.RecipientParty)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.DateOfCont)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.DollarAmt)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.OfficeContributedTo)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CumulDollarAmt)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ContFiller1)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ContFiller2)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ContType)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ContFiller3)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HuntFishPerm)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.DateLicense)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HomeState)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Resident)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.NonResident)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Hunt)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Fish)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ComboSuper)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Sportsman)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Trap)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Archery)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Muzzle)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Drawing)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Day1)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Day3)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Day7)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Day14to15)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.DayFiller) //Guides
																				+ ',' + ut.CleanSpacesAndUpper(pInput.SeasonAnnual)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.LifeTimePermit)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.LandOwner)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Family)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Junior)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.SeniorCitizen)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CrewMemeber)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Retarded)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Indian)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Serviceman)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Disabled)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.LowIncome)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.RegionCounty)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HuntType)		//Blind
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HuntFiller)	//Location
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Salmon)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Freshwater)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Saltwater)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.LakesandResevoirs)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Trout)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.FallFishing)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.SteelHead)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.WhiteJubHerring)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Sturgeon)   //otter
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ShellfishCrab) //MussleRoe
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ShellfishLobster) //ShellFish
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Deer)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Bear)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Elk)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Moose)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Buffalo)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Antelope)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.SikeBull)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.BighornSheep) //SheepGoat
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Javelina)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Cougar)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Anterless)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Pheasant)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Goose)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Duck)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Turkey)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Snowmobile) //Subscriber
																				+ ',' + ut.CleanSpacesAndUpper(pInput.BigGame)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.MigratoryBirds)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.SmallGame)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Sturgeon2)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Gun)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Bonus)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.ApplicantLottery)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.OtherBirds) //Waterfowl
																				+ ',' + ut.CleanSpacesAndUpper(pInput.huntfill1)		//email
																				+ ',' + ut.CleanSpacesAndUpper(pInput.BoatIndexNum) //ParkLake
																				+ ',' + ut.CleanSpacesAndUpper(pInput.BoatCoOwner)	//CCWPermitee
																				+ ',' + ut.CleanSpacesAndUpper(pInput.Len)					//TempHuntFish
																				+ ',' + ut.CleanSpacesAndUpper(pInput.HullConstruction)  //ComboSuperLifetime
																				+ ',' + ut.CleanSpacesAndUpper(pInput.RegExpiryDate)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.BoatFill3)				//CCWRejectReason
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CCWPermNum)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CCWWeaponType)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CCWRegDate)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CCWExpiryDate)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.CCWPermType)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.MiscFill5)
																				+ ',' + ut.CleanSpacesAndUpper(pInput.FillerOther1)   	//SourceCounty
																				+ ',' + ut.CleanSpacesAndUpper(pInput.FillerOther2)			//MailCountry
																				+ ',' + ut.CleanSpacesAndUpper(pInput.FillerOther4));
	self.persistent_record_id := 	HASH64(temp_persistent_record_id);																		
	self											:=	pInput;
	
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
		
		string8 v_cens_date	  						:= if((self.RegDate_in between '19500101' and (STRING8)STD.Date.Today()) and
																						length(trim(self.RegDate_in)) = 8,
																						self.RegDate_in,
																						''
																						);
		string8 v_ccw_date								:= if((self.CCWRegDate_in between '19500101' and (STRING8)STD.Date.Today()) and
																						length(trim(self.CCWRegDate_in)) = 8,
																						self.CCWRegDate_in,
																						''
																						);
		string8 v_vote_date								:= if((self.LastDayVote_in	between '19500101' and (STRING8)STD.Date.Today()) and
																						length(trim(self.LastDayVote_in)) = 8,
																						self.LastDayVote_in,
																						if(	(self.RegDate_in between '19500101' and (STRING8)STD.Date.Today()) and
																								length(trim(self.RegDate_in)) = 8,
																								self.RegDate_in,
																								''
																							)
																						);
		string8 v_hunt_date								:= if((self.DateLicense_in between '19500101' and (STRING8)STD.Date.Today()) and
																						length(trim(self.DateLicense_in)) = 8,
																						self.DateLicense_in,
																						if(	(self.RegDate_in between '19500101' and (STRING8)STD.Date.Today()) and
																								length(trim(self.RegDate_in)) = 8,
																								self.RegDate_in,
																								''
																							)
																						);
		string8 v_fish_date								:= if((self.DateLicense_in between '19500101' and (STRING8)STD.Date.Today()) and
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
		Self.ResAddr1 :=If(regexfind('NULL',pinput.ResAddr1), RegexReplace('^NULL$', Trim(pinput.ResAddr1, left, right), ''), pinput.ResAddr1) ;
		Self.Mail_Addr1 := If(regexfind('NULL',pinput.Mail_Addr1), RegexReplace('^NULL$', Trim(pinput.Mail_Addr1, left, right), ''), pinput.Mail_Addr1) ;
		Self.CASS_Addr1 := If(regexfind('NULL',pinput.CASS_Addr1), RegexReplace('^NULL$', Trim(pinput.CASS_Addr1, left, right), ''), pinput.CASS_Addr1) ;
		
		Self.Res_City := If(regexfind('NULL',pinput.Res_City), RegexReplace('^NULL$', Trim(pinput.Res_City, left, right), ''), pinput.Res_City) ;
		Self.Mail_City := If(regexfind('NULL',pinput.Mail_City), RegexReplace('^NULL$', Trim(pinput.Mail_City, left, right), ''), pinput.Mail_City) ;
		Self.CASS_City := If(regexfind('NULL',pinput.CASS_City), RegexReplace('^NULL$', Trim(pinput.CASS_City, left, right), ''), pinput.CASS_City) ;
		
		Self.Res_State := If(regexfind('NULL',pinput.Res_State), RegexReplace('^NULL$', Trim(pinput.Res_State, left, right), ''), pinput.Res_State) ;
		Self.Mail_State := If(regexfind('NULL',pinput.Mail_State), RegexReplace('^NULL$', Trim(pinput.Mail_State, left, right), ''), pinput.Mail_State) ;
		Self.CASS_State := If(regexfind('NULL',pinput.CASS_State), RegexReplace('^NULL$', Trim(pinput.CASS_State, left, right), ''), pinput.CASS_State) ;
		
		Self.Res_Zip := If(regexfind('NULL',pinput.Res_Zip), RegexReplace('^NULL$', Trim(pinput.Res_Zip, left, right), ''), pinput.Res_Zip) ;
		Self.Mail_Zip := If(regexfind('NULL',pinput.Mail_Zip), RegexReplace('^NULL$', Trim(pinput.Mail_Zip, left, right), ''), pinput.Mail_Zip) ;
		Self.CASS_Zip := If(regexfind('NULL',pinput.CASS_Zip), RegexReplace('^NULL$',Trim(pinput.CASS_Zip, left, right), ''), pinput.CASS_Zip) ;
		Self	:=	pInput;
	end;
	
	dHuntCCW_AppendPrepAddr	:=	project(dHuntCCW_RecleanNames, tAppendPrepAddr(left));
	
	ut.MAC_Sequence_Records(dHuntCCW_AppendPrepAddr, Append_SeqNum, dHuntCCW_AppendPrepAddr_SeqNum);
	
	// Normalize records on address
	rHuntCCWAppendAID_layout	tNormalizeAddr(dHuntCCW_AppendPrepAddr_SeqNum pInput, integer addrCount)	:=
	transform
		self.addressInd						 :=	choose(addrCount, 'R', 'M', 'C');
		Append_Prep_Address1_tmp	 :=	choose(	addrCount,
																					trim(StringLib.StringToUpperCase(trim(pInput.ResAddr1, left, right) + ' ' + trim(pInput.ResAddr2, left, right)),left,right),
																					trim(StringLib.StringToUpperCase(trim(pInput.Mail_Addr1, left, right) + ' ' + trim(pInput.Mail_Addr2, left, right)),left,right),
																					trim(StringLib.StringToUpperCase(trim(pInput.CASS_Addr1, left, right) + ' ' + trim(pInput.CASS_Addr2, left, right)),left,right)
																				);
    //Convert some invalid address chars to spaces		
		Append_Prep_Address1_tmp2 := StringLib.StringTranslate(Address.fn_addr_clean_prep(Append_Prep_Address1_tmp,'first'), '|?()*_', '      ');
		Append_Prep_Address2_tmp	:=	choose(	addrCount,
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
    //Convert some invalid address chars to spaces		
		Append_Prep_Address2_tmp2 := StringLib.StringTranslate(Address.fn_addr_clean_prep(Append_Prep_Address2_tmp,'last'), '|?()*_', '      ');
		clean_addr					      := Address.CleanAddress182(Append_Prep_Address1_tmp2, Append_Prep_Address2_tmp2);
    self.Append_Prep_Address1 := Address.Addr1FromComponents(clean_addr[1..10],       //prim_range
		                                                         clean_addr[11..12],      //predir
																														 clean_addr[13..40],      //prim_name
                                                             clean_addr[41..44],      //addr_suffix
																														 clean_addr[45..46],      //postdir 
																														 clean_addr[47..56],      //unit_desig 
																														 clean_addr[57..64]);     //sec_range
    self.Append_Prep_Address2 := Address.Addr2FromComponents(clean_addr[65..89],      //p_city_name
		                                                         clean_addr[115..116],    //st
																														 clean_addr[117..121]);   //zip		
		self											:= pInput;
	end;
	dHuntCCW_StandardizeAddr	:=	normalize(dHuntCCW_AppendPrepAddr_SeqNum, 3, tNormalizeAddr(left, counter));
		
	dHuntCCW_AddrPopulated		:=	dHuntCCW_StandardizeAddr(Append_Prep_Address2	!=	'');
	dHuntCCW_AddrNotPopulated	:=	dHuntCCW_StandardizeAddr(Append_Prep_Address2	=		'');

  Countries := ['AHO', 'ALB', 'AND', 'ANT', 'ARG', 'ARU', 'ASA', 'AUS', 'AUT', 'BAH', 'BAN', 'BAR', 'BEL', 'BEN',
                'BER', 'BIH', 'BLR', 'BOL', 'BOT', 'BRA', 'BRU', 'BUL', 'BUR', 'CAF', 'CAN', 'CAY', 'CHA', 'CHI',
	 						  'CHN', 'COL', 'CPV', 'CRC', 'CRO', 'CYP', 'CZE', 'DEN', 'DMA', 'DOM', 'ECU', 'ERI', 'ESA', 'ESP',
								'EST', 'FIN', 'FRA', 'FRG', 'FSM', 'GAB', 'GAM', 'GBR', 'GEO', 'GER', 'GHA', 'GRE', 'GUA', 'GUM',
								'HKG', 'HOL', 'HUN', 'INA', 'IND', 'IRL', 'ISL', 'ISR', 'ITA', 'IVB', 'JAM', 'JOR', 'JPN', 'KAZ',
								'KEN', 'KOR', 'KSA', 'KUW', 'LAO', 'LAT', 'LAW', 'LIE', 'LTU', 'LUX', 'MAL', 'MAR', 'MAS', 'MDA',
								'MDV', 'MEX', 'MKD', 'MLI', 'MLT', 'MON', 'MYA', 'NAM', 'NCA', 'NED', 'NEP', 'NGR', 'NIG', 'NOR',
								'NZL', 'OMA', 'PAK', 'PAN', 'PAR', 'PER', 'PHI', 'PLE', 'POL', 'POR', 'PRK', 'PUR', 'QAT', 'ROM',
								'ROU', 'RSA', 'RUS', 'SAF', 'SAU', 'SEN', 'SIN', 'SKN', 'SLO', 'SRB', 'SRI', 'STP', 'SUI', 'SUR',
								'SVK', 'SWE', 'SWZ', 'TAI', 'THA', 'TOG', 'TPE', 'TRI', 'TUR', 'UAE', 'UGA', 'UKR', 'URS', 'URU',
								'UZB', 'VAN', 'VEN', 'VIE', 'VIN', 'YAR', 'ZAI', 'ZAM', 'ZIM'];

	dHuntCCW_AddrPopulated_nonUS	:=	dHuntCCW_AddrPopulated(TRIM(mail_county, ALL) IN Countries,
                                                           TRIM(res_state, ALL) NOT IN ut.Set_State_Abbrev,
																                           (UNSIGNED3)res_zip[1..5] NOT BETWEEN 1001 AND 99929,
																                           TRIM(mail_addr1 + mail_city + mail_state + mail_zip, ALL) = '');

	dHuntCCW_AddrPopulated_US	    :=	JOIN(dHuntCCW_AddrPopulated, dHuntCCW_AddrPopulated_nonUS,
	                                       LEFT = RIGHT,
																				 TRANSFORM(RECORDOF(dHuntCCW_AddrPopulated), SELF := LEFT),
																				 LEFT ONLY);
	
// Pass to the AddressID macro and get back the raw addressID
	AID.MacAppendFromRaw_2Line(dHuntCCW_AddrPopulated_US, Append_Prep_Address1, Append_Prep_Address2, Append_RawAID, dHuntCCW_AppendAID, AID.Common.eReturnValues.RawAID);

	rHuntCCWAppendAID_layout	tAppendAID(dHuntCCW_AppendAID	pInput)	:=
	transform
		self.Append_RawAID	:=	pInput.AIDWork_RawAID;
		self								:=	pInput;
	end;
	
	dHuntCCW_AID	:=	project(dHuntCCW_AppendAID,tAppendAID(left));
	
	// Combine the records which were not passed to the Address ID macro before denormalizing
	dHuntCCW_AIDCombined	:=	dHuntCCW_AID	+	dHuntCCW_AddrNotPopulated + dHuntCCW_AddrPopulated_nonUS;
		
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