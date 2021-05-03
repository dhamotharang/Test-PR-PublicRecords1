IMPORT SANCTN, Address, lib_stringlib,ut,Prof_License_Mari,std,nid;

export clean_party(string filedate) := function

#uniquename(cluster);

SANCTN_party      := SANCTN.file_in_party;
SANCTN_party_text := SANCTN.file_in_party_varying;

layout_combined := RECORD
   SANCTN.layout_SANCTN_party_in;
   string255 party_text;   
end;

layout_combined  party_combined(SANCTN_party L, SANCTN_party_text R) := TRANSFORM
   self.party_text   := R.PARTY_TEXT;
   self.ORDER_NUMBER := R.ORDER_NUMBER;
   self := L;
end;

j_party := JOIN(SANCTN_party, SANCTN_party_text,
								left.BATCH_NUMBER    = right.BATCH_NUMBER 		AND
								left.INCIDENT_NUMBER = right.INCIDENT_NUMBER 	AND
								left.PARTY_NUMBER    = right.PARTY_NUMBER,
								party_combined(left,right)
							 ,LEFT OUTER
							 ,LOCAL);


//Remove nonprintable characters
other_names_filter := '[^-[:alnum:].,\'&/" ]';
else_filter := '[^[:print:]]';

DBApattern	:= '^(.*)(DBA - |/ DBA | DBA/|DBA | DBA:|D/B/A:| D/B/A |D/B/A | DBA\\)| DBA| D/B/A| AKA |^AKA | A/K/A | A/K/A|T/A )(.*)';
c_o_pattern :=  '(.*)(C/O |C/0 |ATTN:|ATT:|ATTN - |ATTN |ATTENTION:|ATN:)(.*)';
// c_o_addr := '^(C/O[A-Za-z \\,\\-\\&\\.]+)([0-9A-Za-z \\.\\#\\,]+)';
c_o_addr := '^((C/O|ATTN:)[A-Za-z \\,\\-\\&\\.]+)([0-9A-Za-z \\.\\#\\,]+)$';
co_addr_po := '^(C/O[A-Za-z \\-\\&][^\\,]+)[, ]([0-9A-Za-z \\.\\#\\,]+)';
alpha_pattern := '^(C/O[A-Za-z \\,\\-\\&\\.]+)$';
paren_dba := '^([A-Za-z \\-\\&\\,]+)[ ]([\\(][A-Za-z \\,\\)]+)';
single_paren := '^(.*)[\\(](.*)$';

positionpattern := '^(.*)(EXECUTIVE|SECURITIES AGENT|SALESPERSON|APPRAISER|^CFA$|AGENT|ASSISTANT|SPECIALIST|REAL ESTATE BROKER|'+
													'PRINCIPAL BROKER|OFFICER|PRESIDENT|ASSOCIATE|SECRETARY|OWNER|CHAIRMAN|REPRESENTATIVE|PROFESSOR|ATTORNEY|PRINCIPAL)(.*)';
city := '^(.*)(TAMPA|STATEN ISLAND|ST\\. GEORGE|MANATEE COUNTY|OF NEVADA|DEL|ATLANTA|ATLANTIC|N\\.Y\\.|LOS ANGELES|BOSTON)(.*)';
country := '^(.*)(^USA$|GUAM|EUROPE|^U\\.S\\.$|^U\\.S\\.A\\.$|^US|CANADA|GRENADA|BAHAMAS|AMERICA|AMERICAS|MELCHIZEDEK|LUXEMBOURG|SAUDI ARABIA|'+
									'GRENADA|CALGARY|NAURU|BERMUDA|^UK$|SUISSE|CAYMAN|IRELAND|PERSERO|CHINA|HONG KONG|FRANCE|GERMANY|SUDAN|'+
									'VANUATU|ENCANA|BELIZE|CZECH REPUBLIC|INDONESIA|BOLIVIA|CHANNEL ISLANDS|PEZMAR|IRAN|SOUTH AFRICA|ASIA PACIFIC|'+
									'BAGAN|MAOIST|MYANMAR|NGWE SAUNG|NGAPALI|PASDARAN|ASIA|ANGOLA|^U\\.K\\.$|MALTA|DALIAN|MALAYSIA|ONTARIO|SWITZERLAND|'+
									'EUROPA|SHANGHAI|CHANGSHA|NIGERIA|ARGENTINA|PANAMA|MELCHIZEDEK)(.*)';
filings := '^(.*)(FAILED|DEFUNCT|INSOLVENT|GROUP|IN RECEIVERSHIP|OVERSEAS|BRANCH|FIRM|MERGED|CONVERTED|SOLD|'+
								'SUCCESS|MAIN OFFICE|MULTIFAMILY|AGGRESSIVE MORTGAGE|PTY|PVT|PRIVATE|INTER\\. DIV\\.|GOVERNMENT|'+
								'NATIONAL ASSOCIATION|HOLDING|WORLDWIDE|GIS|^BVI$|^SIC$|^NVF$|^BOF$|^FZE$|^OVE$|DECEASED|^V\\.P\\.$)(.*)';
set_numeric_conv := ['FIRST','SECOND','THREE','NORTH','SQUARE'];
set_exception := ['N.A.','L.P.','LLC','CO.','THE','CORPORATION','IMC','SECURITIES','INC','FINANCIAL','INCORPORATED'];



layout_party_clean := RECORD
SANCTN.layout_SANCTN_party_clean;
end;

layout_party_clean 	clean_SANCTN_party(j_party input) := TRANSFORM

	// Trim Uppercase fields
	 trimPartyName 	:= ut.CleanSpacesAndUpper(input.party_name);
	 trimFirmName 	:= ut.CleanSpacesAndUpper(input.party_firm);
	 trimPosition  	:= ut.CleanSpacesAndUpper(input.party_position);
	 trimVocation  	:= ut.CleanSpacesAndUpper(input.party_vocation);
	 trimAddress 		:= ut.CleanSpacesAndUpper(input.inaddress);
	 
   // Set the local values
   // is_company   := SANCTN.fIsCompany(input.PARTY_NAME);
	 is_company      := trimPartyName[1..25] = trimFirmName[1..25] or 
													(SANCTN.fIsCompany(trimPartyName) and not regexfind(positionpattern,trimPosition) 
														and not regexfind(positionpattern,trimVocation));
   
	 prepFirm	:= map(stringlib.stringfind(trimFirmName,'A.K.A.',1) > 0 => STD.Str.FindReplace(trimFirmName,'A.K.A.','A/K/A'),
									 trimFirmName[1..4] = 'DBA ' => trimFirmName[5..],
									 trimFirmName[1..8] = 'T/D/B/A ' => trimFirmName[9..],
									 regexfind('( DB$)',trim(trimFirmName)) => trim(trimFirmName) + 'A)',
															trimFirmNAME);	
															
	 prepParty	:= map(STD.Str.Find(trimPartyName,'A.K.A.',1) > 0 => STD.Str.FindReplace(trimPartyName,'A.K.A.','A/K/A'),
										trimPartyName[1..4] = 'DBA ' => trimPartyName[5..],
										trimPartyName[1..8] = 'T/D/B/A ' => trimPartyName[9..],
										regexfind('( DB$)',trim(trimPartyName)) => trim(trimPartyName) + 'A)',
														trimPartyName);
														
			// Retrieving DBA Names with paren)
	vNickParty := if(prepParty[1] = '"','',
										if(STD.Str.Find(prepParty,'(',1) > 0 and STD.Str.Find(prepParty,')',1) <= 0, 
															 regexfind(single_paren,prepParty,2),
																	Prof_License_Mari.fGetNickname(prepParty,'nick')));
	vNickFirm  := if(prepFirm[1] = '"','',
										if(STD.Str.Find(prepFirm,'(',1) > 0 and STD.Str.Find(prepFirm,')',1) <= 0, 
															 regexfind(single_paren,prepFirm,2),
																	Prof_License_Mari.fGetNickname(prepFirm,'nick')));
		
		// Stripping DBA Name from field
	vPartyName := if(prepParty[1] = '"',prepParty,
									 if(STD.Str.Find(prepParty,'(',1) > 0 and STD.Str.Find(prepParty,')',1) <= 0, 
															 regexfind(single_paren,prepParty,1),
																		Prof_License_Mari.fGetNickname(prepParty,'strip_nick')));
	vFirmName	 := if(prepFirm[1] = '"',prepFirm,
										if(STD.Str.Find(prepFirm,'(',1) > 0 and STD.Str.Find(prepFirm,')',1) <= 0, 
															 regexfind(single_paren,prepFirm,1),
																		Prof_License_Mari.fGetNickname(prepFirm,'strip_nick')));
	
	getPartyName := MAP(regexfind(DBApattern,prepParty) and regexfind(paren_dba,prepParty)=> regexfind(paren_dba,prepParty,1),
												regexfind(DBApattern,prepParty) and not regexfind('(^AKA)',prepParty) => SANCTN.mod_clean_name_addr.GetCorpName(prepParty),
												regexfind(c_o_pattern,prepParty)=> SANCTN.mod_clean_name_addr.GetCorpName(prepParty),
												vNickParty != '' and vNickParty not in set_exception and length(trim(vNickParty)) > 2 => vPartyname,
														prepParty);
	
	getFirmName  := MAP(regexfind(paren_dba,prepFirm)=> regexfind(paren_dba,prepFirm,1),
											 regexfind(DBApattern,prepFirm) and  not regexfind('(^AKA)',prepFirm)=> SANCTN.mod_clean_name_addr.GetCorpName(prepFirm),
											 regexfind(c_o_pattern,prepFirm)=> SANCTN.mod_clean_name_addr.GetCorpName(prepFirm),
											 vNickFirm != '' and vNickFirm not in set_exception and length(trim(vNickFirm)) > 2 => vFirmName,
													prepFirm);
	
	
	getFirmNick := IF(vNickFirm not in ut.Set_State_Names 	and vNickFirm not in ut.Set_State_Abbrev
										and not regexfind(country,trim(vNickFirm)) and not regexfind(city,trim(vNickFirm))
										and not regexfind(filings,trim(vNickFirm)) and vNickFirm not in set_numeric_conv
										and not regexfind('([0-9]+)',vNickFirm) and vNickFirm not in set_exception
										and length(trim(vNickFirm,left,right)) > 2,vNickFirm,'');
										

	getPartyNick := IF(vNickParty not in ut.Set_State_Names 	and vNickParty not in ut.Set_State_Abbrev
											and not regexfind(country,trim(vNickParty)) and not regexfind(city,trim(vNickParty))
											and not regexfind(filings,trim(vNickParty)) and not vNickParty in set_numeric_conv
											and not regexfind('([0-9]+)',vNickParty) 		and vNickParty not in set_exception
											and length(trim(vNickParty,left,right)) > 2,vNickParty,'');
											
	 getDBA_PARTY  := if(regexfind(DBApattern,prepParty) and regexfind(paren_dba,prepParty), regexfind(paren_dba,prepParty,2),
													if(regexfind(DBApattern,prepParty) and not regexfind('(^AKA)',prepParty),
																			SANCTN.mod_clean_name_addr.GetDBAName(prepParty),
														 		if(getPartyNick != '', getPartyNick, '')));
																			
	 getDBA_FIRM   := if(regexfind(DBApattern,prepFirm)and regexfind(paren_dba,prepFirm), regexfind(paren_dba,prepFirm,2),
												if(regexfind(DBApattern,prepFirm) and not regexfind('(^AKA)',prepFirm),
																					SANCTN.mod_clean_name_addr.GetDBAName(prepFirm),
																if(getFirmNick != '', getFirmNick, '')));	
	 
	 tempDBA_Party	:= if(length(trim(getDBA_PARTY)) > 2 and not regexfind(filings,getDBA_PARTY),getDBA_PARTY,'');
	 tempDBA_Firm	:= if(length(trim(getDBA_FIRM)) > 2 and not regexfind(filings,getDBA_FIRM),getDBA_FIRM,'');
	 self.DBA_name := if(tempDBA_Party = tempDBA_Firm, tempDBA_Firm,
												if(tempDBA_Party != '' and tempDBA_Firm = '',tempDBA_Party,
														tempDBA_Firm));
	 
   tempPName    := if(is_company,'',
												if(STD.Str.Find(trim(getPartyName), ' ', 1) = 0,'',
														NID.CleanPerson73(getPartyName)
														));
													
  											
   CleanPName   := if(NOT(is_company), tempPName,'');
   CleanCName   := if(is_company or STD.Str.Find(trim(getPartyName), ' ', 1) = 0, getPartyName, '');
																								
// Set the person and company name values
   self.title 			:= CleanPName[1..5];
   self.fname 			:= CleanPName[6..25];
   self.mname 			:= CleanPName[26..45];
   self.lname 			:= CleanPName[46..65];
   self.name_suffix := CleanPName[66..70];
   self.name_score 	:= CleanPName[71..73]; 
   self.cname       := IF(CleanCName <> '', CleanCName,
                          If(NOT(is_company) AND getFirmName <> '', getFirmName,''));										
	 
		getAddress := If(regexfind(c_o_addr,trimAddress) and regexfind('(P.O.|PO BOX)',trimAddress), regexfind(co_addr_po,trimAddress,2),
										If(regexfind(c_o_addr,trimAddress) and regexfind('(PRISON|PLAZA|CENTURY)',trimAddress), trimAddress[5..],
											  IF(regexfind(c_o_addr,trimAddress) and not regexfind('[^0-9]',trimAddress), '',		
													IF(regexfind(c_o_addr,trimAddress), regexfind(c_o_addr,trimAddress,3),
														IF(trimAddress[1..4] = 'C/O ', trimAddress[5..], trimAddress)))));
		
		getContactInfo := 		if(regexfind(c_o_pattern,prepFirm),SANCTN.mod_clean_name_addr.GetDBAName(prepFirm),
													 If(regexfind(c_o_addr,trimAddress) and regexfind('(P.O.|PO BOX)',trimAddress), regexfind(co_addr_po,trimAddress,1),
													   IF(regexfind(c_o_addr,trimAddress) and regexfind('(PRISON|PLAZA|CENTURY)',trimAddress),'',
																IF(regexfind(c_o_addr,trimAddress) and not regexfind('[^0-9]',trimAddress), regexfind(alpha_pattern,trimAddress,0),		
																	IF(regexfind(c_o_addr,trimAddress), regexfind(c_o_addr,trimAddress,1),
																				'')))));  																
   
	  self.CONTACT_NAME := if(length(getContactInfo) = 1, '',
													if(getContactInfo[1..3] = 'C/O',getContactInfo[5..],
															if(regexfind(c_o_pattern,getAddress),SANCTN.mod_clean_name_addr.GetDBAName(getAddress),
																	getContactInfo)));
																	
	 prepAddress := if(regexfind(c_o_pattern,getAddress),SANCTN.mod_clean_name_addr.GetCorpName(getAddress),getAddress);										 	 
	 
   CleanAddress := Address.CleanAddress182(trim(prepAddress,left,right)
                                          ,trim(input.inCITY,left,right) + ' ' + trim(input.inSTATE,left,right) + ' ' + trim(input.inZIP,left,right));
   //Remove nonprintable characters
   self.party_text := IF(regexfind('\242',input.party_text),input.party_text,
		                            regexreplace(other_names_filter,input.party_text,'',NOCASE));
 
	 // Set the address values
   self.prim_range 		:= CleanAddress[1..10]; 
   self.predir 				:= CleanAddress[11..12];					   
   self.prim_name 		:= CleanAddress[13..40];
   self.addr_suffix 	:= CleanAddress[41..44];
   self.postdir 			:= CleanAddress[45..46];
   self.unit_desig 	  := CleanAddress[47..56];
   self.sec_range 		:= CleanAddress[57..64];
   self.p_city_name 	:= CleanAddress[65..89];
   self.v_city_name 	:= CleanAddress[90..114];
   self.st 			    	:= if(CleanAddress[115..116]='',ziplib.ZipToState2(CleanAddress[117..121])
															,CleanAddress[115..116]);
   self.zip5 					:= CleanAddress[117..121];
   self.zip4 					:= CleanAddress[122..125];
   self.cart 					:= CleanAddress[126..129];
   self.cr_sort_sz 		:= CleanAddress[130];
   self.lot 					:= CleanAddress[131..134];
   self.lot_order 		:= CleanAddress[135];
   self.dpbc 					:= CleanAddress[136..137];
   self.chk_digit 		:= CleanAddress[138];
   self.addr_rec_type := CleanAddress[139..140];
   self.fips_state		:= CleanAddress[141..142];
   self.fips_county   := CleanAddress[143..145];
   self.geo_lat 			:= CleanAddress[146..155];
   self.geo_long 			:= CleanAddress[156..166];
   self.cbsa 					:= CleanAddress[167..170];
   self.geo_blk 			:= CleanAddress[171..177];
   self.geo_match 		:= CleanAddress[178];
   self.err_stat 			:= CleanAddress[179..182];

   self := input;
   self:=[];
   
end;

clean_data := sort(PROJECT(j_party, clean_SANCTN_party(LEFT)) ,batch_number,incident_number, party_number, order_number);

clean_data_suppress := clean_data ((trim(batch_number,left,right)+trim(incident_number,left,right) not in SANCTN.SuppressBatchIncident));

output('Party data: ' + count(clean_data));

clean_data_deduped := output(dedup(clean_data_suppress,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::party_cleaned');

//Clear the history of the incident clean and party clean superfiles since it is full file replacement
add_super := sequential(STD.File.StartSuperFileTransaction()
                       ,STD.File.ClearSuperFile(SANCTN.cluster_name + 'out::sanctn::party_cleaned',true)
                       ,STD.File.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::party_cleaned', SANCTN.cluster_name + 'out::sanctn::' + filedate + '::party_cleaned')
											 ,STD.File.FinishSuperFileTransaction());

return sequential(clean_data_deduped,add_super);

end;