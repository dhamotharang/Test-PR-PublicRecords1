import Prof_License_Mari, ut,lib_stringlib;


export fRemoveDBA_Contact := module

export DBA_pattern := '^(.*)(DBA)$';

export C_O_Ind := '(C/O |ATTN:| ATTN |ATTENTION:|ATT:|%|ATN:|^ATTN )';
export DBA_Ind := '( DBA$|D/B/A | D/B/A|/DBA | DBA |DBA:|/DBA|^DBA/|^DBA | A/K/A| AKA |^AKA |T/A |A/K/A |A/K/A$|^D B A|/DBA/)';

export AddrExceptions := '(PLAZA| PLZ|^BLDG |^BLGD | BLDG|BLDING|BUILDING | BLD |APARTMENT|ONE | AVE |AVENUE| AV |^AVE | TOWER| BLVD|GENERAL DELIVERY| ESTS|'+
									'ROAD|^R D | AND MAIN\\>| & MAIN\\>|^THREE |^THIRD |THOUSAND|^FOUR|^SIX |^SIXTH |^ELEVENTH|^FIFTH|^FIVE|^NINTH |^EIGHTH |^SEVENTH |^TENTH |^TWELFTH|^TWELVETH|RIVERWALK|'+
									' ALLEY|SECOND|FLOOR|PAVILION|PAVILLION| RD|TOWN$|LEVEL|LOWR LL|CREEK|ROUTE|^RTE|CENTRE| CTR\\>| CT\\>| DR\\>| PARK|DRIVE| SQUARE| SQ\\>| WAY|LOCATION|^UNIT |UNIT |'+
									'CLASSROOM|THE COLONADE|GARDEN|RIVERWALK|FAIRGROUND|FAIR GROUND| MALL| VILLA$|P M B|PMB | LODGE|^BOOTH |ACRES|AIRPORT|'+
									'UPPER|TRACE|#|LANE|LAGOONS|PENTHOUSE |POST OFFICE|^POST| STS\\>| AVES\\>| ST\\>|STREET|FRONT|FAIR GROUNDS|FAIRGROUNDS|BETWEEN|'+
									'APT.|APT |APT[.] |APT$|APARTMENT |P O |PO |POB |PO DRAWER|P O DRAWER|^DRAWER |BOX |BOX|ROOM |^RT | RT |HIGHWAY|HWY|RIDGE| PL\\>|'+
									'EXPRESSWAY| STE |^STE |^SUIT |STE |SUITE|SU | PKWY|CROSSING|CORNER OF|& MAINLAND| AT MAIN|MAIN AND|MAIN &|^HCR|MAIL STOP| LN\\>| MANOR\\>| MNR\\>| TPKE\\>|'+
									'METROPLEX|PARKWAY|^COURT |^PH |^RM | RM\\>|^ROOM |LBBY|^SPC |BSMT|OFC|TRLR|^LOT | LOT\\>|^FL | CENTER WEST| TERRACE\\>| TRAIL\\>| TR\\>| TRL\\>|'+
									'STUDIO|MARKETPLACE| COMMONS\\>|CORPORATE CENTER|COMMERCE CENTER|EXECUTIVE CENTER|PROFESSIONAL CEN|SHOPPING|SHOPPING CTR|CITY CENTER|SUBDIVISION|'+
									'SHOPPING CENTER|BUSINESS OFFICE|SHOP COMPLEX|NAVAL STATION|NAVAL AIR STATION|AIR FORCE BASE|PROFESSIONAL COMPLEX|VETERANS HOME|MARINA|RESIDENTIAL|'+
									'METROPOLITAN|^LAKE | LAKE\\>| TWP| CONDO|COTTAGE|RESORT|HALF DAY|FREEWAY| CIRCLE\\>| CIR\\>|HARBOR|^NORTHERN|^NORTH| COVE\\>|ARENA|CAFE|AISLE| PATH\\>)'; 

// Remove DBA/Contact Name from Address Field
export fn_getAddr(string field)	:=	function

			prepAddr	:=	if(trim(field,left,right) != '' and REGEXFIND(DBA_pattern,field)
															and not REGEXFIND(AddrExceptions,field), '',
												if(trim(field,left,right) != '' and  REGEXFIND(DBA_Ind,field),
																Prof_License_Mari.mod_clean_name_addr.GetCorpName(field),
													if(trim(field,left,right) != '' and  REGEXFIND(C_O_Ind,field),
															if(REGEXFIND(AddrExceptions,field), 
																			Prof_License_Mari.mod_clean_name_addr.GetDBAName(field),
																			Prof_License_Mari.mod_clean_name_addr.GetCorpName(field)
																					),
														trim(field,left,right)
													)));	
			return prepAddr;
	end;									


// Remove Corp Name from Field minus DBA/Contact Information
export GetCorpName(string field) := function
				prepCorpName	:= if(trim(field,left,right) != '' and  REGEXFIND(C_O_Ind,field),
																Prof_License_Mari.mod_clean_name_addr.GetCorpName(field),
														if(trim(field,left,right) != '' and  REGEXFIND(DBA_Ind,field),
																Prof_License_Mari.mod_clean_name_addr.GetCorpName(field),
														trim(field,left,right)
												));
				return prepCorpName;
		end;					


// Get DBA/Contact Name from field
export getDBAName(string field, string nametype) := function
					prepDBAName		:= if(nametype = 'DBA' and trim(field,left,right) != '' and REGEXFIND(DBA_pattern,field),
																		REGEXFIND(DBA_pattern,field,1),
															if(nametype = 'DBA' and trim(field,left,right) != '' and  REGEXFIND(DBA_Ind,field),
																		Prof_License_Mari.mod_clean_name_addr.GetDBAName(field),
																	if(nametype = 'CONTACT' and trim(field,left,right) != '' and  REGEXFIND(C_O_Ind,field)
																			and not regexfind(addrexceptions,field),
																				Prof_License_Mari.mod_clean_name_addr.GetDBAName(field),
													 '')
															));
					return prepDBAName;
			end;	
END;