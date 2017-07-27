export Update_Base(
										dataset(MXD_MXDocket.Layouts_build.NewChg)	pNewFile,
										dataset(MXD_MXDocket.Layouts_build.NewChg)	pUpdateFile,
										dataset(MXD_MXDocket.Layouts_build.Delete)	pDeleteFile,
										dataset(MXD_MXDocket.Layouts_build.Base)		pBaseFile,
										string pversion
									) := function
									
// TempBase	:=	PROJECT(pBaseFile, TRANSFORM(MXD_MXDocket.Layouts_build.temp,
														// self	:=	left;
														// self	:=	[];));									
									
dsNatures :=	dataset('~thor_data400::lookup::mxd_mxdocket::nature_classifier', MXD_MXDocket.Layouts_build.natureClass, CSV(UNICODE, HEADING(1), SEPARATOR('|'), TERMINATOR(['\n','\r\n','\n\r']), QUOTE('"')))(trim(nature)!='');

GetDocketNum(string docket) := FUNCTION
	holdDocket := regexfind('.*[/\\-_:; ]',docket,0);
	returnDocket :=
		IF(holdDocket='','',holdDocket[1..LENGTH(holdDocket)-1]);
	return returnDocket;
END;

GetDocketYear(string docket) := FUNCTION
	holdDocket := regexfind('[/\\-_:; ].*',docket,0);
	returnDocket :=
		IF(holdDocket='','',mxd_MXDocket.FN_ProcessDocketYear(holdDocket[2..]));
	return returnDocket;
END;

GetNatureTypeCode(unicode150 nature) := FUNCTION
	natureTypeCode	:=	MAP(nature = 'PENAL' 							=> MXD_MXDocket.Layouts_build.NatureType.PENAL, 
													nature = 'CONSTRUCTIVE PENAL' => MXD_MXDocket.Layouts_build.NatureType.CONSTRUCTIVE_PENAL,
													nature = 'AMBIDEXTROUS' 			=> MXD_MXDocket.Layouts_build.NatureType.AMBIDEXTROUS,
													nature = 'CIVIL' 							=> MXD_MXDocket.Layouts_build.NatureType.CIVIL, 
													nature = 'Q' 									=> MXD_MXDocket.Layouts_build.NatureType.Q, 
													nature = 'X' 									=> MXD_MXDocket.Layouts_build.NatureType.X, 
													nature = 'PENAL' 							=> MXD_MXDocket.Layouts_build.NatureType.PENAL, 
													nature = 'CONSTRUCTIVE PENAL' => MXD_MXDocket.Layouts_build.NatureType.CONSTRUCTIVE_PENAL, 
													nature = 'AMBIDEXTROUS' 			=> MXD_MXDocket.Layouts_build.NatureType.AMBIDEXTROUS, 
													nature = 'CIVIL' 							=> MXD_MXDocket.Layouts_build.NatureType.CIVIL, 
													nature = 'Q' 									=> MXD_MXDocket.Layouts_build.NatureType.Q, 
													nature = 'X' 									=> MXD_MXDocket.Layouts_build.NatureType.X, 
													MXD_MXDocket.Layouts_build.NatureType.UNKNOWN
												 );
												 
	return natureTypeCode;
end;

GetGeoCode(unicode60 Geo) := FUNCTION
	GeoCode	:=	MAP(Geo = 'AGUASCALIENTES'						=> 'AGU', 
									Geo = 'BAJA CALIFORNIA'						=> 'BCN', 
									Geo = 'BAJA CALIFORNIA SUR'				=> 'BCS', 
									Geo = 'CAMPECHE'									=> 'CAM', 
									Geo = 'CHIAPAS'										=> 'CHP', 
									Geo = 'CHIHUAHUA'									=> 'CHH', 
									Geo = 'COAHUILA'									=> 'COA', 
									Geo = 'COLIMA'										=> 'COL', 
									Geo = 'DISTRITO FEDERAL'					=> 'DIF', 
									Geo = 'DURANGO'										=> 'DUR', 
									Geo = 'GUANAJUATO'								=> 'GUA', 
									Geo = 'GUERRERO'									=> 'GRO', 
									Geo = 'HIDALGO'										=> 'HID', 
									Geo = 'JALISCO'										=> 'JAL', 
									Geo = 'MEXICO'										=> 'MEX', 
									Geo = 'MICHOACAN'									=> 'MIC', 
									Geo = 'MORELOS'										=> 'MOR', 
									Geo = 'NAYARIT'										=> 'NAY', 
									Geo = 'NUEVO LEON'								=> 'NLE', 
									Geo = 'OAXACA'										=> 'OAX', 
									Geo = 'PUEBLA'										=> 'PUE', 
									Geo = 'QUERETARO'									=> 'QUE', 
									Geo = 'QUINTANA ROO'							=> 'ROO', 
									Geo = 'SAN LUIS POTOSI'						=> 'SLP', 
									Geo = 'SINALOA'										=> 'SIN', 
									Geo = 'SONORA'										=> 'SON', 
									Geo = 'TABASCO'										=> 'TAB', 
									Geo = 'TAMAULIPAS'								=> 'TAM', 
									Geo = 'TLAXCALA'									=> 'TLA', 
									Geo = 'VERACRUZ'									=> 'VER', 
									Geo = 'YUCATAN'										=> 'YUC', 
									Geo = 'ZACATECAS'									=> 'ZAC', 
									Geo = 'STATE OF MEXICO (EDOMEX)'	=> 'MEX', 
									Geo = 'STATE OF MEXICO - EDOMEX'	=> 'MEX', 
									Geo = 'STATE OF MEXICO EDOMEX'		=> 'MEX',
									Geo = 'EDOMEX'										=> 'MEX',
									Geo = 'ESTADO DE MEXICO'					=> 'MEX', 
									Geo = 'FEDERAL TAX, ADMINISTRATION, AND PATENT COURTS'	=>	'MEX',  // not really sure what 'state' this would be
									Geo = 'MEXICAN FEDERAL TAX, ADMINISTRATION, AND'				=> 	'MEX',  // not really sure what 'state' this would be
									Geo = 'MEXICAN FEDERAL TAX, ADMINISTR'									=> 	'MEX',  // not really sure what 'state' this would be
									Geo = 'FEDERAL ARBITRATION PANEL'												=> 	'MEX',  // not really sure what 'state' this would be
									Geo = 'MEXICO-DF'																				=> 	'DIF', 
									Geo = 'MEXICO - DF'																			=> 	'DIF',
									Geo = 'MEXICO DF'																				=>	'DIF',
									Geo = 'MEXICO - DF'																			=> 	'DIF',
									''
									);
											 
	return GeoCode;
end;

// Macro used to convert the data into the proper layout.
MAC_ConvertLayout(ds, result) := MACRO
#uniquename(d1)
#uniquename(p1)
#uniquename(p2)
#uniquename(p3)
#uniquename(p4)
#uniquename(p5)
#uniquename(p6)
#uniquename(p7)
#uniquename(p8)
	%d1% := DISTRIBUTE(ds, HASH(item_id));
	mxd_MXDocket.MAC_StripSynonyms(%d1%, geography, item_id, %p1%)
	mxd_MXDocket.MAC_StripSynonyms(%p1%, court, item_id, %p2%)
	mxd_MXDocket.MAC_StripSynonyms(%p2%, court_local, item_id, %p3%)
	mxd_MXDocket.MAC_StripSynonyms(%p3%, caption, item_id, %p4%)
	mxd_MXDocket.MAC_StripSynonyms(%p4%, nature, item_id, %p5%)
	mxd_MXDocket.MAC_StripSynonyms(%p5%, comment, item_id, %p6%)
	mxd_MXDocket.MAC_StripSynonyms(%p6%, party1, item_id, %p7%)
	mxd_MXDocket.MAC_StripSynonyms(%p7%, party2, item_id, %p8%)
#uniquename(converted)
	%converted% :=
		PROJECT(%p8%,
					 TRANSFORM(MXD_MXDocket.Layouts_build.temp,
										SELF.rec_id 					:= (unsigned8)LEFT.item_id;
										SELF.entity_id 				:=	0;
										SELF.date_pub 				:= 	mxd_MXDocket.FN_ProcessDate(LEFT.date_pub);
										SELF.date_hearing 		:= 	mxd_MXDocket.FN_ProcessDate(LEFT.date_hearing);
										SELF.nature_type 			:= 	MXD_MXDocket.Layouts_build.NatureType.UNKNOWN;
										SELF.party1_original	:= 	LEFT.party1;
										SELF.party1_occ1 			:= 	mxd_MXDocket.FN_PartyName(LEFT.party1,1);
										SELF.party1_occ2 			:= 	mxd_MXDocket.FN_PartyName(LEFT.party1,2);
										SELF.party1_type 			:= 	mxd_MXDocket.FN_GetPartyType(LEFT.party1);
										SELF.party1_multiple	:=	mxd_MXDocket.FN_MultipleNames(LEFT.party1);
										SELF.party2_original	:=	LEFT.party2;
										SELF.party2_occ1			:=	mxd_MXDocket.FN_PartyName(LEFT.party2,1);
										SELF.party2_occ2			:=	mxd_MXDocket.FN_PartyName(LEFT.party2,2);
										SELF.party2_type			:=	mxd_MXDocket.FN_GetPartyType(LEFT.party2);
										SELF.party2_multiple	:=	mxd_MXDocket.FN_MultipleNames(LEFT.party2);
										SELF.docket_num				:=	(unicode)GetDocketNum((string)trim(LEFT.docket,all));
										SELF.docket_year			:=	(unsigned3)GetDocketYear((string)trim(LEFT.docket,all));
										SELF := LEFT;
										self := []));
	result :=
		JOIN(DISTRIBUTE(%converted%,RANDOM()), dsNatures,
				 LEFT.nature=RIGHT.nature,
				 TRANSFORM(MXD_MXDocket.Layouts_build.temp,
										SELF.nature_type :=	MAP(RIGHT.us_class = 'PENAL' 							=> MXD_MXDocket.Layouts_build.NatureType.PENAL,
																						RIGHT.us_class = 'CONSTRUCTIVE PENAL' => MXD_MXDocket.Layouts_build.NatureType.CONSTRUCTIVE_PENAL,
																						RIGHT.us_class = 'AMBIDEXTROUS' 			=> MXD_MXDocket.Layouts_build.NatureType.AMBIDEXTROUS,
																						RIGHT.us_class = 'CIVIL' 							=> MXD_MXDocket.Layouts_build.NatureType.CIVIL,
																						RIGHT.us_class = 'Q' 									=> MXD_MXDocket.Layouts_build.NatureType.Q,
																						RIGHT.us_class = 'X' 									=> MXD_MXDocket.Layouts_build.NatureType.X,
																						RIGHT.mx_class = 'PENAL' 							=> MXD_MXDocket.Layouts_build.NatureType.PENAL,
																						RIGHT.mx_class = 'CONSTRUCTIVE PENAL' => MXD_MXDocket.Layouts_build.NatureType.CONSTRUCTIVE_PENAL,
																						RIGHT.mx_class = 'AMBIDEXTROUS' 			=> MXD_MXDocket.Layouts_build.NatureType.AMBIDEXTROUS,
																						RIGHT.mx_class = 'CIVIL' 							=> MXD_MXDocket.Layouts_build.NatureType.CIVIL,
																						RIGHT.mx_class = 'Q' 									=> MXD_MXDocket.Layouts_build.NatureType.Q,
																						RIGHT.mx_class = 'X' 									=> MXD_MXDocket.Layouts_build.NatureType.X,
																						MXD_MXDocket.Layouts_build.NatureType.UNKNOWN);
										SELF.GeoCode			:=	GetGeoCode(StringLib.StringToUpperCase(StringLib.StringCleanSpaces(TRIM((string)UnicodeLib.UnicodeFindReplace(left.geography,u'Ã‘',u'N'),LEFT,RIGHT))));
										SELF := LEFT;),
					LEFT OUTER, LOOKUP);
ENDMACRO;

// Convert the layout.
MAC_ConvertLayout(pNewFile, dsNew);
MAC_ConvertLayout(pUpdateFile, dsUpdate);
dsDelete :=	PROJECT(pDeleteFile, TRANSFORM(MXD_MXDocket.Layouts_build.temp,
											self	:=	left;
											self	:=	[];));

// Apply the updates
dsAllData_2 := dsNew+dsUpdate;
dsAllData_3 := DEDUP(SORT(DISTRIBUTE(dsAllData_2,rec_id),rec_id,LOCAL),rec_id,LOCAL);

// Apply the deletes
dsAllData_4 :=
	JOIN(dsAllData_3, DISTRIBUTE(dsDelete,rec_id),
			 LEFT.rec_id=RIGHT.rec_id,
			 TRANSFORM(MXD_MXDocket.Layouts_build.temp, SELF := LEFT),
			 LEFT ONLY, LOCAL);

// Persist these results as the interim results.
dsAllData := dsAllData_4 : INDEPENDENT;

dsParsedPeople	:=	MXD_MXDocket.fParseNames(dsAllData);

ParsedBase	:=	join(	dsAllData,
											DISTRIBUTE(dsParsedPeople,rec_id),
											left.rec_id = right.rec_id,
											TRANSFORM(MXD_MXDocket.Layouts_build.parsed, SELF := LEFT; self	:=	right;),
											LEFT OUTER, LOCAL);
										
MXD_MXDocket.Layouts_build.parsed	trfSetBusiness(	MXD_MXDocket.Layouts_build.parsed pINput)	:=transform
		self.full_name	:=	if (pInput.is_org,
															'',
															pInput.full_name
														);
		self.OrgName		:=	if (pInput.is_org,
															pInput.full_name,
															''
														);
		self						:=	pInput;
end;
										
// dsRelationships :=	mxd_MXDocket.FN_GetRelationships(dsParsedPeople);

setOrgs	:=	project(ParsedBase, trfSetBusiness(left));

ds	:=	distribute(setOrgs,hash(rec_id));

dsParty1	:= 	ds(isParty1);

dsParty2	:=	ds(isParty2);

MXD_MXDocket.Layouts_build.base tNormalizeNames(MXD_MXDocket.Layouts_build.parsed l, unsigned4 cnt) := transform
		self.natureTypeDesc		:=	map(l.nature_type	= 1	=>	'PENAL',
																	l.nature_type = 2 =>	'CONSTRUCTIVE_PENAL',
																	l.nature_type = 3 => 	'AMBIDEXTROUS', 
																	l.nature_type = 4 => 	'CIVIL',
																	l.nature_type = 5 => 	'Q',
																	l.nature_type = 6 => 	'X',
																	l.nature_type = 7 => 	'UNKNOWN',
																	''
																	);
				self.partyOriginal		:=	if (l.isParty1, 
																												l.Party1_original,
																												l.Party2_original
																											);
		_partyName				:=	choose(cnt,	if	(	l.isParty1, 
																																							l.Party1_occ1,
																																							l.Party2_occ1
																																						 ),
																																				if	(	l.isParty1, 
																																							l.Party1_occ2,
																																							l.Party2_occ2
																																						 ));

    _aliasPos							:= 	UnicodeLib.UnicodeFind(_partyName,u' ALIAS ',1);																
		_partyType				:=	if (l.isParty1, l.Party1_type, l.Party2_type);
		
		self.partyName			:= if(_aliasPos>0 and _partyType = 1 // alias only for person type
																													, _partyName[1.._aliasPos-1], _partyName),																		
		self.partyAlias				:= if(_aliasPos>0 and _partyType = 1, _partyName[_aliasPos+7..], ''),																																				
		
		self.partyNumber	:=	if	(	l.isParty1, '1', '2' );
																			
		self.PartyOcc					:=	(string)cnt;
		
		self.partyType				:= _partyType;



		self.partyTypeDesc		:=	map(self.PartyType = 1 =>	'PERSON', 
																	self.PartyType= 2 =>	'ESTATE', 
																	self.PartyType= 3 =>	'BUSINESS', 
																	self.PartyType= 4 =>	'NONPROFIT', 
																	self.PartyType= 5 =>	'COOP', 
																	self.PartyType= 6 =>	'CREDITUNION', 
																	self.PartyType= 7 =>	'GOVERNMENT', 
																	self.PartyType= 8 =>	'UNKNOWN',
																	''
																	);

		self.ethnicityDesc		:=	map(l.ethnicity = 1 => 'WESTERN',
																	l.ethnicity = 2 => 'ASIAN',
																	l.ethnicity = 3 => 'LATIN_AMERICAN',
																	''
																	);
		self.process_date			:=	pVersion;
		self.dt_first_seen		:=	(string)l.date_pub;
		self.dt_last_seen			:=	(string)l.date_pub;		
		self									:=	l;
end;
				
dParty1Prep			:= 	normalize(dsParty1, 2, tNormalizeNames(left,counter),local);
dParty2Prep			:= 	normalize(dsParty2, 2, tNormalizeNames(left,counter),local);

PartyBase				:=	dParty1Prep + dParty2Prep;

dRollupBase			:= 	Rollup_Base (PartyBase);

return dRollupBase(partyName!='');

end;

