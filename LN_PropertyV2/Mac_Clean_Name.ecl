export	Mac_Clean_Name(	pInDataset,
												pOutDataset,
												pAssesDataset	=	'dataset([],LN_Propertyv2.layout_property_common_model_base)',
												pIsFares			=	false
											)	:=
macro
	import	Address,idl_header,ut;
	
	// Layout containing fields to help the name parsing
	#uniquename(rAppendName_Layout)
	%rAppendName_Layout%	:=
	record(pInDataset),
		string1			Append_ConjunctiveNameSeq;
		unsigned1		Append_NumTokens;
		string80		Append_Nameasis;
		string80		Append_Nameasis_NoSuffix;
		string3			Append_NameOrder;
		string12		Append_LNamePct;
		string80		Append_FirstConjunctiveName;
		string3			Append_FirstConjunctiveNameOrder;
		decimal6_3	Append_FirstConjunctiveNameLNamePct;
	end;
	
	#uniquename(tPrepName)
	%rAppendName_Layout%	%tPrepName%(pInDataset	pInput)	:=
	transform
		self.nameasis	:=	LN_PropertyV2.Prep_Name.fnPrepName(pInput.nameasis);
		self					:=	pInput;
		self					:=	[];
	end;
	
	#uniquename(dSearchPrepName)
	%dSearchPrepName%	:=	project(pInDataset,%tPrepName%(left));
	
	// Check if the name is a business using the isCompany function before sending to the isBusiness macro
	#uniquename(tCheckBusiness)
	%rAppendName_Layout%	%tCheckBusiness%(%dSearchPrepName%	pInput)	:=
	transform
		self.name_type	:=	if(	pInput.nameasis	=	'',
														'',
														if(	LN_PropertyV2.isCompany.fnIsCompany(pInput.nameasis),
																'B',
																''
															)
													);
		self						:=	pInput;
	end;
	
	#uniquename(dSearchCheckBusiness)
	%dSearchCheckBusiness%	:=	project(%dSearchPrepName%,%tCheckBusiness%(left));
	
	// Filter business and individuals
	#uniquename(dBusiness)
	#uniquename(dNotBusiness)
	%dBusiness%			:=	%dSearchCheckBusiness%(name_type	=	'B');
	%dNotBusiness%	:=	%dSearchCheckBusiness%(name_type	!=	'B');
	
	// Pass the dataset which didn't come out as business to the isBusiness macro to check if any of them come out as businesses
	#uniquename(dSearchNameInd)
	Address.Mac_Is_Business(%dNotBusiness%,nameasis,%dSearchNameInd%,name_type);
	
	// Distribute the dataset by faresid
	#uniquename(dSearchNameIndDist)
	%dSearchNameIndDist%	:=	distribute(%dSearchNameInd%,hash32(ln_fares_id));
	
	#uniquename(dBusinessAll)
	%dBusinessAll%	:=	distribute(%dBusiness%,hash32(ln_fares_id))	+	%dSearchNameIndDist%(name_type	=	'B');
	
	// Populate the cname field if the name is a business
	#uniquename(tPopulateCName)
	recordof(pInDataset)	%tPopulateCName%(%dBusinessAll%	pInput)	:=
	transform
		string	vStandardizeName	:=	LN_PropertyV2.Prep_Name.fnStandardizeName(pInput.nameasis);
		
		self.cname				:=	LN_PropertyV2.Prep_Name.fnClean2Upper(vStandardizeName);
		self.title				:=	'';
		self.fname				:=	'';
		self.mname				:=	'';
		self.lname				:=	'';
		self.name_suffix	:=	'';
		self.conjunctive_name_seq := if(pInput.conjunctive_name_seq <>'', pInput.conjunctive_name_seq,'1'); 
		self							:=	pInput;
	end;
	
	#uniquename(dSearchBusiness)
	%dSearchBusiness%	:=	project(%dBusinessAll%,%tPopulateCName%(left));
	
	// Remove duplicates
	#uniquename(dSearchBusinessDedup)
	%dSearchBusinessDedup%	:=	dedup(%dSearchBusiness%,except	title,fname,lname,name_suffix,all,local);
	
	// Records which weren't identified as business
	#uniquename(dPersons)
	%dPersons%	:=	project(	%dSearchNameIndDist%(name_type	!=	'B'),
														transform(	%rAppendName_Layout%,
																				string	vStandardizeName	:=	LN_PropertyV2.Prep_Name.fnStandardizeName(left.nameasis);
																				
																				self.nameasis	:=	regexreplace(' AND ',vStandardizeName,' & ');
																				self					:=	left;
																			)
													);
	
	// LN Assessments file	
	#uniquename(dLNAssessments)
	%dLNAssessments%	:=	pAssesDataset;
	
	// Append the name order
	#uniquename(tFaresAppendNameOrder)
	%rAppendName_Layout%	%tFaresAppendNameOrder%(%dPersons%	pInput)	:=
	transform		
		self.Append_NameOrder	:=	'LFM';
		self									:=	pInput;
		self									:=	[];
	end;
	
	#uniquename(dPersonNameOrderFares)
	%dPersonNameOrderFares%	:=	project(%dPersons%,%tFaresAppendNameOrder%(left));
	
	#uniquename(tLNAppendNameOrder)
	%rAppendName_Layout%	%tLNAppendNameOrder%(%dPersons%	le,%dLNAssessments%	ri)	:=
	transform			
		self.Append_NameOrder	:=	map(	le.which_orig	=	'1'	and	le.source_code[1]	!=	'C'	=>	LN_PropertyV2.Prep_Name.fnLNNameOrder(ri.assessee_name_type_code),
																		le.which_orig	=	'1'	and	le.source_code[1]	=		'C'	=>	LN_PropertyV2.Prep_Name.fnLNNameOrder(ri.mail_care_of_name_type_code),
																		le.which_orig	=	'2'																=>	LN_PropertyV2.Prep_Name.fnLNNameOrder(ri.second_assessee_name_type_code),
																		''
																	);
		self									:=	le;
		self									:=	[];
	end;
	
	#uniquename(dPersonNameOrderLN)
	%dPersonNameOrderLN%	:=	join(	%dPersons%,
																	distribute(%dLNAssessments%,hash32(ln_fares_id)),
																	left.ln_fares_id	=	right.ln_fares_id,
																	%tLNAppendNameOrder%(left,right),
																	left outer,
																	local
																);
	
	#uniquename(dPersonNameOrder)
	%dPersonNameOrder%	:=	if(	pIsFares,
															%dPersonNameOrderFares%,
															%dPersonNameOrderLN%
														);
	
	// Keep only one record per faresid, name and address combination (removing records where conjunctive name > 1)
	#uniquename(dPersonsDedup)
	%dPersonsDedup%	:=	dedup(%dPersonNameOrder%,except conjunctive_name_seq,title,fname,mname,lname,name_suffix,cname,all,local);
	
	// Distribute the dataset on name and dedup
	#uniquename(dPersonsNameDist)
	#uniquename(dPersonsNameDedup)
	%dPersonsNameDist%	:=	distribute(%dPersonsDedup%,hash32(nameasis));
	%dPersonsNameDedup%	:=	dedup(%dPersonsNameDist%,nameasis,all,local);
	
	// Populate the first conjunctive name indicator
	#uniquename(tFirstConjunctiveName)
	%rAppendName_Layout%	%tFirstConjunctiveName%(%dPersonsNameDedup%	pInput)	:=
	transform
		string		vCleanName	:=	LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.nameasis);
		string		vNameSep		:=	map(	stringlib.stringfind(vCleanName,'&',1)	!=	0	=>	'&',
																		stringlib.stringfind(vCleanName,';',1)	!=	0	=>	';',
																		'~'
																	);
		unsigned	vHighIndex	:=	stringlib.stringfind(vCleanName,vNameSep,1);
		
		string	vFirstConjunctiveName	:=	if(	stringlib.stringfind(vCleanName,vNameSep,1)	!=	0,
																					LN_PropertyV2.Prep_Name.fnClean2Upper(vCleanName[1..vHighIndex-1]),
																					LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.nameasis)
																				);
		string	vNameasisNoSuffix			:=	LN_PropertyV2.Prep_Name.fnClean2Upper(regexreplace(LN_PropertyV2.Prep_Name.NamesuffixPattern,LN_PropertyV2.Prep_Name.fnClean2Upper(vFirstConjunctiveName),''));
		integer	vNumTokens						:=	ut.NoWords(vNameasisNoSuffix);
		
		self.Append_FirstConjunctiveName			:=	vFirstConjunctiveName;
		self.Append_FirstConjunctiveNameOrder	:=	map(	~pIsFares	and	vNumTokens	=		3	and	regexfind('[A-Z]{2,}[ ][A-Z]{1}[ ][A-Z]{2,}',LN_PropertyV2.Prep_Name.fnClean2Upper(vNameasisNoSuffix),nocase)			=>	'FML',
																										~pIsFares	and	vNumTokens	>		3	and	regexfind('([A-Z]{2,}[ ][A-Z]{1}[ ][A-Z]{2,})$',LN_PropertyV2.Prep_Name.fnClean2Upper(vNameasisNoSuffix),nocase)	=>	'LFM',
																										~pIsFares	and	vNumTokens	>=	3	and	regexfind('[A-Z]{2,}[ ][A-Z]{2,}[ ][A-Z]{1}$',LN_PropertyV2.Prep_Name.fnClean2Upper(vNameasisNoSuffix),nocase)		=>	'LFM',
																										pInput.Append_NameOrder
																									);
		self																	:=	pInput;
	end;
	
	#uniquename(dFirstConjunctiveName)
	%dFirstConjunctiveName%	:=	project(%dPersonsNameDedup%,%tFirstConjunctiveName%(left));
	
	// Insurance name header
	#uniquename(dInsNameHeader)
	%dInsNameHeader%	:=	distribute(	idl_header.name_count_ds(length(stringlib.stringcleanspaces(name))	>	1),
																		hash32(name)
																	);
	
	// Transform to get the percentage for last name
	#uniquename(tGetFirstConjunctivePctLNames)
	%rAppendName_Layout%	%tGetFirstConjunctivePctLNames%(%rAppendName_Layout%	le,recordof(%dInsNameHeader%)	ri)	:=
	transform
		self.Append_FirstConjunctiveNameLNamePct	:=	ri.Pct_LName;
		self																			:=	le;
	end;
	
	// Get the lname percentage for the first name token
	#uniquename(dFirstConjunctiveNameTokenLNamePct)
	%dFirstConjunctiveNameTokenLNamePct%	:=	join(	distribute(%dFirstConjunctiveName%,hash32(ut.Word(Append_FirstConjunctiveName,1))),
																									%dInsNameHeader%,
																									LN_PropertyV2.Prep_Name.fnClean2Upper(ut.Word(left.Append_FirstConjunctiveName,1))	=	right.name,
																									%tGetFirstConjunctivePctLNames%(left,right),
																									left outer,
																									keep(1),
																									local
																								);
	
	#uniquename(dFirstConjunctiveNameDist)
	%dFirstConjunctiveNameDist%	:=	distribute(%dFirstConjunctiveNameTokenLNamePct%,hash32(nameasis));
	
	// Normalize the dataset by name
	#uniquename(tNormalizeName)
	%rAppendName_Layout%	%tNormalizeName%(%dFirstConjunctiveNameDist%	pInput,integer	cnt)	:=
	transform
		string		vCleanName	:=	LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.nameasis);
		string		vNameSep		:=	map(	stringlib.stringfind(vCleanName,'&',1)	!=	0	=>	'&',
																		stringlib.stringfind(vCleanName,';',1)	!=	0	=>	';',
																		// stringlib.stringfind(vCleanName,' ',2)	!=	0	and	stringlib.stringfind(vCleanName,',',1)	>	stringlib.stringfind(vCleanName,' ',2)	=>	',',
																		'~'
																	);
		unsigned	vLowIndex		:=	stringlib.stringfind(vCleanName,vNameSep,cnt-1);
		unsigned	vHighIndex	:=	stringlib.stringfind(vCleanName,vNameSep,cnt);
		
		self.Append_Nameasis						:=	if(	stringlib.stringfind(vCleanName,vNameSep,1)	!=	0,
																						if(	cnt	=	1,
																								LN_PropertyV2.Prep_Name.fnClean2Upper(vCleanName[1..vHighIndex-1]),
																								if(	vHighIndex	!=	0,
																										LN_PropertyV2.Prep_Name.fnClean2Upper(vCleanName[vLowIndex+1..vHighIndex-1]),
																										LN_PropertyV2.Prep_Name.fnClean2Upper(vCleanName[vLowIndex+1..])
																									)
																							),
																						LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.nameasis)
																					);
		self.Append_Nameasis_NoSuffix		:=	LN_PropertyV2.Prep_Name.fnClean2Upper(regexreplace(LN_PropertyV2.Prep_Name.NamesuffixPattern,LN_PropertyV2.Prep_Name.fnClean2Upper(self.Append_Nameasis),''));
		self.Append_NumTokens						:=	ut.NoWords(self.Append_Nameasis_NoSuffix);
		self.Append_NameOrder						:=	map(	cnt	=	1																																																																																			=>	pInput.Append_FirstConjunctiveNameOrder,
																							~pIsFares	and	self.Append_NumTokens	=		3	and	regexfind('[A-Z]{2,}[ ][A-Z]{1}[ ][A-Z]{2,}',LN_PropertyV2.Prep_Name.fnClean2Upper(self.Append_Nameasis_NoSuffix),nocase)			=>	'FML',
																							~pIsFares	and	self.Append_NumTokens	>		3	and	regexfind('([A-Z]{2,}[ ][A-Z]{1}[ ][A-Z]{2,})$',LN_PropertyV2.Prep_Name.fnClean2Upper(self.Append_Nameasis_NoSuffix),nocase)	=>	'LFM',
																							~pIsFares	and	self.Append_NumTokens	>=	3	and	regexfind('[A-Z]{2,}[ ][A-Z]{2,}[ ][A-Z]{1}$',LN_PropertyV2.Prep_Name.fnClean2Upper(self.Append_Nameasis_NoSuffix),nocase)		=>	'LFM',
																							pInput.Append_NameOrder
																						);
		self.Append_ConjunctiveNameSeq	:=	(string1)cnt;
		self														:=	pInput;
	end;
	
	#uniquename(dPersonsNormalize)
	%dPersonsNormalize%	:=	normalize(	%dFirstConjunctiveNameDist%,
																			map(	stringlib.stringfind(left.nameasis,'&',1)	!=	0	=>	ut.NoWords(left.nameasis,'&'),
																						stringlib.stringfind(left.nameasis,';',1)	!=	0	=>	ut.NoWords(left.nameasis,';'),
																						1
																					),
																			%tNormalizeName%(left,counter),
																			local
																		);
	
	// Transform to get the percentage for last name
	#uniquename(tGetPctLNames)
	%rAppendName_Layout%	%tGetPctLNames%(%rAppendName_Layout%	le,recordof(%dInsNameHeader%)	ri)	:=
	transform
		self.Append_LNamePct	:=	if(	le.Append_LNamePct	!=	'',
																	le.Append_LNamePct	+	'~'	+	(string)ri.Pct_LName,
																	(string)ri.Pct_LName
																);
		self									:=	le;
	end;
	
	// Get the lname percentage for the first name token
	#uniquename(dFirstTokenLNamePct)
	%dFirstTokenLNamePct%	:=	join(	distribute(%dPersonsNormalize%,hash32(ut.Word(Append_Nameasis_NoSuffix,1))),
																	%dInsNameHeader%,
																	LN_PropertyV2.Prep_Name.fnClean2Upper(ut.Word(left.Append_Nameasis_NoSuffix,1))	=	right.name,
																	%tGetPctLNames%(left,right),
																	left outer,
																	keep(1),
																	local
																);
	
	// Filter records which have ambiguous names (names with two tokens which can't be identified as first last or first middle)
	#uniquename(dPersonAmbiguousNames)
	%dPersonAmbiguousNames%			:=	%dFirstTokenLNamePct%(	(	Append_NumTokens	=	2	and
																														~regexfind('^[A-Z][ ]|[ ][A-Z]$',LN_PropertyV2.Prep_Name.fnClean2Upper(Append_Nameasis_NoSuffix),nocase)
																													)
																												);
	
	#uniquename(dPersonDisambiguousNames)
	%dPersonDisambiguousNames%	:=	%dFirstTokenLNamePct%(	~(	(	Append_NumTokens	=	2	and
																																~regexfind('^[A-Z][ ]|[ ][A-Z]$',LN_PropertyV2.Prep_Name.fnClean2Upper(Append_Nameasis_NoSuffix),nocase)
																															)
																														)
																												);
	
	#uniquename(dSecondTokenLNamePct)
	%dSecondTokenLNamePct%	:=	join(	distribute(%dPersonAmbiguousNames%,hash32(ut.Word(Append_Nameasis_NoSuffix,2))),
																		%dInsNameHeader%,
																		ut.Word(left.Append_Nameasis_NoSuffix,2)	=	right.name,
																		%tGetPctLNames%(left,right),
																		left outer,
																		keep(1),
																		local
																	);
	
	// Combine the disambiguous names and ambiguous names
	#uniquename(dPersonCombined)
	%dPersonCombined%	:=	distribute(%dSecondTokenLNamePct%	+	%dPersonDisambiguousNames%,hash32(nameasis));
																	
	
	// Populate the last name to the normalized name fields if it doesn't exist
	#uniquename(tPrepCleanNames)
	%rAppendName_Layout%	%tPrepCleanNames%(%dPersonCombined%	pInput)	:=
	transform
		string	vCleanNameasis						:=	LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.nameasis);
		string	vCleanAppendNameasis			:=	LN_PropertyV2.Prep_Name.fnClean2Upper(pInput.Append_Nameasis);
		
		decimal6_3	vFirstTokenLNamePct		:=	if(	stringlib.stringfind(pInput.Append_LNamePct,'~',1)	!=	0,
																							(decimal6_3)ut.Word(pInput.Append_LNamePct,1,'~'),
																							(decimal6_3)pInput.Append_LNamePct
																						);
		decimal6_3	vSecondTokenLNamePct	:=	if(	stringlib.stringfind(pInput.Append_LNamePct,'~',1)	!=	0,
																							(decimal6_3)ut.Word(pInput.Append_LNamePct,2,'~'),
																							0
																						);
		
		string	vFirstConjunctiveName			:=	pInput.Append_FirstConjunctiveName;
		
		vFirstConjunctiveCleanName				:=	map(	pInput.Append_FirstconjunctiveNameOrder	=	'LFM'	or	stringlib.stringfind(vFirstConjunctiveName,',',1)	!=	0	=>	Address.CleanPersonLFM73_Fields(vFirstConjunctiveName).CleanNameRecord,
																								pInput.Append_FirstconjunctiveNameOrder	=	'FML'																															=>	Address.CleanPersonFML73_Fields(vFirstConjunctiveName).CleanNameRecord,
																								pInput.Append_FirstConjunctiveNameLNamePct	>=	0.85																												=>	Address.CleanPersonLFM73_Fields(vFirstConjunctiveName).CleanNameRecord,
																								Address.CleanPerson73_Fields(vFirstConjunctiveName).CleanNameRecord
																							);
		
		string	vFirstConjunctiveLName		:=	vFirstConjunctiveCleanName.lname;
		string	vFirstConjunctiveFName		:=	vFirstConjunctiveCleanName.fname;
		
		boolean	vLNameExists							:=	stringlib.stringfind(vCleanAppendNameasis,',',1)	!=	0	or
																					stringlib.stringfind(vCleanAppendNameasis,';',1)	!=	0	or
																					pInput.Append_NumTokens	>=	3														or
																					vFirstTokenLNamePct			>=	0.9													or
																					vSecondTokenLNamePct		>=	0.9;
		
		string	vName											:=	if(	vLNameExists,
																							pInput.Append_Nameasis,
																							LN_PropertyV2.Prep_Name.fnPrepConjunctiveNames(vCleanAppendNameasis,vFirstConjunctiveLName,vFirstConjunctiveFName)
																						);
		
		string	vNameOrder								:=	map(	pInput.Append_NameOrder	=	'LFM'	or	stringlib.stringfind(vName,',',1)	!=	0	=>	'LFM',
																								pInput.Append_NameOrder	=	'FML'																							=>	'FML',
																								stringlib.stringfind(vCleanNameasis,',',1)	!=	0														=>	'LFM',
																								pInput.Append_ConjunctiveNameSeq	=	'1'	and	vFirstTokenLNamePct	>=	0.85		=>	'LFM',
																								pInput.Append_ConjunctiveNameSeq	>	'1'	and	~vLNameExists										=>	'LFM',
																								pInput.Append_NameOrder
																							);
		
		// Clean names
		vCleanName	:=	case(	vNameOrder,
													'LFM'	=>	Address.CleanPersonLFM73_Fields(vName).CleanNameRecord,
													'FML'	=>	Address.CleanPersonFML73_Fields(vName).CleanNameRecord,
													Address.CleanPerson73_Fields(vName).CleanNameRecord
												);
		
		// Clean name mappings
		self.title				:=	vCleanName.title;
		self.lname				:=	if(	stringlib.stringfindcount(vCleanName.lname,vFirstConjunctiveLName)	>	1,
															vCleanName.lname[1..stringlib.stringfind(vCleanName.lname,vFirstConjunctiveLName,2)-1],
															vCleanName.lname
														);
		self.fname				:=	if(	stringlib.stringfindcount(vCleanName.fname,vFirstConjunctiveFName)	>	1,
															vCleanName.fname[1..stringlib.stringfind(vCleanName.fname,vFirstConjunctiveFName,2)-1],
															vCleanName.fname
														);
		self.mname				:=	vCleanName.mname;
		self.name_suffix	:=	vCleanName.name_suffix;
		self							:=	pInput;
	end;
	
	#uniquename(dCleanNames)
	%dCleanNames%	:=	project(%dPersonCombined%,%tPrepCleanNames%(left));
	
	// Join the cleaned name file to the original search file
	#uniquename(tPopulateCleanName)
	recordof(pInDataset)	%tPopulateCleanName%(%dPersonsNameDist%	le,%dCleanNames%	ri)	:=
	transform
		self.conjunctive_name_seq	:=	ri.Append_ConjunctiveNameSeq;
		self.title								:=	ri.title;
		self.fname								:=	ri.fname;
		self.mname								:=	ri.mname;
		self.lname								:=	ri.lname;
		self.name_suffix					:=	ri.name_suffix;
		self.cname								:=	'';
		self											:=	le;
	end;
	
	#uniquename(dSearchCleanName)
	%dSearchCleanName%	:=	join(	%dPersonsNameDist%,
																%dCleanNames%,
																LN_PropertyV2.Prep_Name.fnClean2Upper(left.nameasis)	=	LN_PropertyV2.Prep_Name.fnClean2Upper(right.nameasis),
																%tPopulateCleanName%(left,right),
																left outer,
																local
															);
	
	// Remove duplicate records which were created by the join
	#uniquename(dSearchCleanNameDedup)
	%dSearchCleanNameDedup%	:=	dedup(distribute(%dSearchCleanName%,hash32(ln_fares_id)),except	cname,all,local);
	
	/* Debug - Output
	output(choosen(dSearchPrepName,1000),named('SearchIn'),extend);
	output(choosen(dPersonNameOrder,1000),named('PersonNameOrder'),extend);
	output(choosen(dSearchBusinessDedup,1000),named('Business'),extend);
	output(choosen(dPersons,1000),named('Persons'),extend);
	output(choosen(dPersonsNormalize,1000),named('PersonNormalize'),extend);
	output(choosen(dPersonAmbiguousNames,1000),named('PersonAmbiguousNames'),extend);
	output(choosen(dFirstTokenLNamePct,1000),named('PctLNamefirstToken'),extend);
	output(choosen(dSecondTokenLNamePct,1000),named('PctLNameSecondtoken'),extend);
	output(choosen(dCleanNames,1000),named('CleanName'),extend);
	output(choosen(dSearchCleanNameDedup,1000),named('CleanSearchName'),extend);
	*/
	pOutDataset	:=	%dSearchBusinessDedup%	+	%dSearchCleanNameDedup%;
endmacro;