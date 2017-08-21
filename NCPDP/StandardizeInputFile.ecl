IMPORT Address, Ut, lib_stringlib, _Control, business_header,_Validate, idl_header;

EXPORT StandardizeInputFile := module
	
	EXPORT prov_info(DATASET(NCPDP.layouts.Input.prov_information) pRawFileInput, string pversion) := FUNCTION  
  
		ConvertLangCode(string code)	:=	function
				UpperCode	:=	StringLib.StringToUpperCase(code);
				
				result		:=	map(
													UpperCode	= 'OM' => '(AFAN) OROMO',
													UpperCode	= 'AB' => 'ABKHAZIAN',
													UpperCode	= 'AA' => 'AFAR',
													UpperCode	= 'AF' => 'AFRIKAANS',
													UpperCode	= 'SQ' => 'ALBANIAN',
													UpperCode	= 'AM' => 'AMHARIC',
													UpperCode	= 'AR' => 'ARABIC',
													UpperCode	= 'HY' => 'ARMENIAN',
													UpperCode	= 'AS' => 'ASSAMESE',
													UpperCode	= 'AY' => 'AYMARA',
													UpperCode	= 'AZ' => 'AZERBAIJANI',
													UpperCode	= 'BA' => 'BASHKIR',
													UpperCode	= 'EU' => 'BASQUE',
													UpperCode	= 'BN' => 'BENGALI',
													UpperCode	= 'DZ' => 'BHUTANI',
													UpperCode	= 'BH' => 'BIHARI',
													UpperCode	= 'BI' => 'BISLAMA',
													UpperCode	= 'BR' => 'BRETON',
													UpperCode	= 'BG' => 'BULGARIAN',
													UpperCode	= 'MY' => 'BURMESE',
													UpperCode	= 'BE' => 'BYELORUSSIAN',
													UpperCode	= 'KM' => 'CAMBODIAN',
													UpperCode	= 'CA' => 'CATALAN',
													UpperCode	= 'ZH' => 'CHINESE',
													UpperCode	= 'CO' => 'CORSICAN',
													UpperCode	= 'HR' => 'CROATIAN',
													UpperCode	= 'CS' => 'CZECH',
													UpperCode	= 'DA' => 'DANISH',
													UpperCode	= 'NL' => 'DUTCH',
													UpperCode	= 'EN' => 'ENGLISH',
													UpperCode	= 'EO' => 'ESPERANTO',
													UpperCode	= 'ET' => 'ESTONIAN',
													UpperCode	= 'FO' => 'FAEROESE',
													UpperCode	= 'FJ' => 'FIJI',
													UpperCode	= 'FI' => 'FINNISH',
													UpperCode	= 'FR' => 'FRENCH',
													UpperCode	= 'FY' => 'FRISIAN',
													UpperCode	= 'GL' => 'GALICIAN',
													UpperCode	= 'KA' => 'GEORGIAN',
													UpperCode	= 'DE' => 'GERMAN',
													UpperCode	= 'EL' => 'GREEK',
													UpperCode	= 'KL' => 'GREENLANDIC',
													UpperCode	= 'GN' => 'GUARANI',
													UpperCode	= 'GU' => 'GUJARATI',
													UpperCode	= 'HA' => 'HAUSA',
													UpperCode	= 'HE' => 'HEBREW',
													UpperCode	= 'HI' => 'HINDI',
													UpperCode	= 'HU' => 'HUNGARIAN',
													UpperCode	= 'IS' => 'ICELANDIC',
													UpperCode	= 'ID' => 'INDONESIAN',
													UpperCode	= 'IA' => 'INTERLINGUA',
													UpperCode	= 'IE' => 'INTERLINGUE',
													UpperCode	= 'IK' => 'INUPIAK',
													UpperCode	= 'IU' => 'INUKTITUT (ESKIMO)',
													UpperCode	= 'GA' => 'IRISH',
													UpperCode	= 'IT' => 'ITALIAN',
													UpperCode	= 'JA' => 'JAPANESE',
													UpperCode	= 'JW' => 'JAVANESE',
													UpperCode	= 'KN' => 'KANNADA',
													UpperCode	= 'KS' => 'KASHMIRI',
													UpperCode	= 'KK' => 'KAZAKH',
													UpperCode	= 'RW' => 'KINYARWANDA',
													UpperCode	= 'KY' => 'KIRGHIZ',
													UpperCode	= 'RN' => 'KIRUNDI',
													UpperCode	= 'KO' => 'KOREAN',
													UpperCode	= 'KU' => 'KURDISH',
													UpperCode	= 'LO' => 'LAOTHIAN',
													UpperCode	= 'LA' => 'LATIN',
													UpperCode	= 'LV' => 'LATVIAN, LETTISH',
													UpperCode	= 'LN' => 'LINGALA',
													UpperCode	= 'LT' => 'LITHUANIAN',
													UpperCode	= 'MK' => 'MACEDONIAN',
													UpperCode	= 'MG' => 'MALAGASY',
													UpperCode	= 'MS' => 'MALAY',
													UpperCode	= 'ML' => 'MALAYALAM',
													UpperCode	= 'MT' => 'MALTESE',
													UpperCode	= 'MI' => 'MAORI',
													UpperCode	= 'MR' => 'MARATHI',
													UpperCode	= 'MO' => 'MOLDAVIAN',
													UpperCode	= 'MN' => 'MONGOLIAN',
													UpperCode	= 'NA' => 'NAURU',
													UpperCode	= 'NE' => 'NEPALI',
													UpperCode	= 'NO' => 'NORWEGIAN',
													UpperCode	= 'OC' => 'OCCITAN',
													UpperCode	= 'OR' => 'ORIYA',
													UpperCode	= 'PS' => 'PASHTO, PUSHTO',
													UpperCode	= 'FA' => 'PERSIAN',
													UpperCode	= 'PL' => 'POLISH',
													UpperCode	= 'PT' => 'PORTUGUESE',
													UpperCode	= 'PA' => 'PUNJABI',
													UpperCode	= 'QU' => 'QUECHUA',
													UpperCode	= 'RM' => 'RHAETO-ROMANCE',
													UpperCode	= 'RO' => 'ROMANIAN',
													UpperCode	= 'RU' => 'RUSSIAN',
													UpperCode	= 'SM' => 'SAMOAN',
													UpperCode	= 'SG' => 'SANGRO',
													UpperCode	= 'SA' => 'SANSKRIT',
													UpperCode	= 'GD' => 'SCOTS GAELIC',
													UpperCode	= 'SR' => 'SERBIAN',
													UpperCode	= 'SH' => 'SERBO-CROATIAN',
													UpperCode	= 'ST' => 'SESOTHO',
													UpperCode	= 'TN' => 'SETSWANA',
													UpperCode	= 'SN' => 'SHONA',
													UpperCode	= 'SD' => 'SINDHI',
													UpperCode	= 'SI' => 'SINGHALESE',
													UpperCode	= 'SS' => 'SISWATI',
													UpperCode	= 'SK' => 'SLOVAK',
													UpperCode	= 'SL' => 'SLOVENIAN',
													UpperCode	= 'SO' => 'SOMALI',
													UpperCode	= 'ES' => 'SPANISH',
													UpperCode	= 'SU' => 'SUDANESE',
													UpperCode	= 'SW' => 'SWAHILI',
													UpperCode	= 'SV' => 'SWEDISH',
													UpperCode	= 'TL' => 'TAGALOG',
													UpperCode	= 'TG' => 'TAJIK',
													UpperCode	= 'TA' => 'TAMIL',
													UpperCode	= 'TT' => 'TATAR',
													UpperCode	= 'TE' => 'TEGULU',
													UpperCode	= 'TH' => 'THAI',
													UpperCode	= 'BO' => 'TIBETAN',
													UpperCode	= 'TI' => 'TIGRINYA',
													UpperCode	= 'TO' => 'TONGA',
													UpperCode	= 'TS' => 'TSONGA',
													UpperCode	= 'TR' => 'TURKISH',
													UpperCode	= 'TK' => 'TURKMEN',
													UpperCode	= 'TW' => 'TWI',
													UpperCode	= 'UG' => 'UIGUR',
													UpperCode	= 'UK' => 'UKRAINIAN',
													UpperCode	= 'UR' => 'URDU',
													UpperCode	= 'UZ' => 'UZBEK',
													UpperCode	= 'VI' => 'VIETNAMESE',
													UpperCode	= 'VO' => 'VOLAPUK',
													UpperCode	= 'CY' => 'WELCH',
													UpperCode	= 'WO' => 'WOLOF',
													UpperCode	= 'XH' => 'XHOSA',
													UpperCode	= 'YI' => 'YIDDISH',
													UpperCode	= 'YO' => 'YORUBA',
													UpperCode	= 'ZA' => 'ZHUANG',
													UpperCode	= 'ZU' => 'ZULU',
													''
													); 
													
				return result;
		end;
		
		ConvertDispensingTypeCode(string code)	:=	function
				UpperCode	:=	StringLib.StringToUpperCase(code);
				
				result		:=	map(UpperCode	= '01' => 'COMMUNITY/RETAIL PHARMACY',
													UpperCode	= '04' => 'LONG TERM CARE PHARMACY',
													UpperCode	= '05' => 'MAIL ORDER PHARMACY',
													UpperCode	= '06' => 'HOME INFUSION THERAPY PROVIDER',
													UpperCode	= '07' => 'NON-PHARMACY DISPENSING SITE',
													UpperCode	= '08' => 'INDIAN HEALTH SERVICE/TRIBAL/URBAN INDIAN HEALTH (I/T/U) PHARMACY',
													UpperCode	= '09' => 'DEPARTMENT OF VETERANS AFFAIRS (VA) PHARMACY',
													UpperCode	= '11' => 'INSTITUTIONAL PHARMACY',
													UpperCode	= '12' => 'MANAGED CARE ORGANIZATION PHARMACY',
													UpperCode	= '13' => 'DME',
													UpperCode	= '14' => 'CLINIC PHARMACY',
													UpperCode	= '15' => 'SPECIALTY PHARMACY',
													UpperCode	= '16' => 'NUCLEAR PHARMACY',
													UpperCode	= '17' => 'MILITARY/U.S. COAST GUARD PHARMACY',
													UpperCode	= '18' => 'COMPOUNDING PHARMACY',
													''
													); 
																										
				return result;
		end;		
		
		ConvertOperatingHours(string from, string to)	:=	function
				
				ConvertHours(string hour)	:=	function
				
						HourFormatted		:=	map(hour	= '01' => '1:00am',
																		hour	= '02' => '2:00am',
																		hour	= '03' => '3:00am',
																		hour	= '04' => '4:00am',
																		hour	= '05' => '5:00am',
																		hour	= '06' => '6:00am',
																		hour	= '07' => '7:00am',
																		hour	= '08' => '8:00am',
																		hour	= '09' => '9:00am',
																		hour	= '10' => '10:00am',
																		hour	= '11' => '11:00am',
																		hour	= '12' => '12:00pm',
																		hour	= '13' => '1:00pm',
																		hour	= '14' => '2:00pm',
																		hour	= '15' => '3:00pm',
																		hour	= '16' => '4:00pm',
																		hour	= '17' => '5:00pm',
																		hour	= '18' => '6:00pm',
																		hour	= '19' => '7:00pm',
																		hour	= '20' => '8:00pm',
																		hour	= '21' => '9:00pm',
																		hour	= '22' => '10:00pm',
																		hour	= '23' => '11:00pm',
																		hour	= '24' => '12:00am',
																		''
																		); 
				return HourFormatted;
			end;
			
			FromHour	:=	ConvertHours(from);
			ToHour		:=	ConvertHours(to);
			
			formatHours	:=	if(FromHour !='' and toHour !='',
														trim(fromHour) + '-' + trim(toHour),
														''
												);
			return formatHours;
		end;				

		NCPDP.layouts.Base.prov_information	tCleanRec(NCPDP.layouts.Input.prov_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.dea_expiration_date				:=	TRIM(Stringlib.StringCleanSpaces(L.dea_expiration_date), LEFT, RIGHT);
				self.clean_dea_expiration_date	:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.dea_expiration_date[5..8] + self.dea_expiration_date[1..2] + self.dea_expiration_date[3..4])
																								, false);
				self.phys_loc_store_open_date		:=	if ((integer)l.phys_loc_store_open_date = 0,
																									'',
																									l.phys_loc_store_open_date
																								);
				self.phys_loc_store_close_date	:=	if ((integer)l.phys_loc_store_close_date = 0,
																									'',
																									l.phys_loc_store_close_date
																								);
				self.SundayHours								:=	ConvertOperatingHours(l.phys_loc_provider_hours[2..3],		l.phys_loc_provider_hours[4..5]);
				self.MondayHours								:=	ConvertOperatingHours(l.phys_loc_provider_hours[7..8],		l.phys_loc_provider_hours[9..10]);
				self.TuesdayHours								:=	ConvertOperatingHours(l.phys_loc_provider_hours[12..13],	l.phys_loc_provider_hours[14..15]);
				self.WednesdayHours							:=	ConvertOperatingHours(l.phys_loc_provider_hours[17..18],	l.phys_loc_provider_hours[19..20]);
				self.ThursdayHours							:=	ConvertOperatingHours(l.phys_loc_provider_hours[7..8],		l.phys_loc_provider_hours[9..10]);
				self.FridayHours								:=	ConvertOperatingHours(l.phys_loc_provider_hours[12..13],	l.phys_loc_provider_hours[14..15]);
				self.SaturdayHours							:=	ConvertOperatingHours(l.phys_loc_provider_hours[17..18],	l.phys_loc_provider_hours[19..20]);
				self.languageCode1Desc  				:=	ConvertLangCode(l.phys_loc_language_code1);
				self.languageCode2Desc  				:=	ConvertLangCode(l.phys_loc_language_code2);
				self.languageCode3Desc  				:=	ConvertLangCode(l.phys_loc_language_code3);
				self.languageCode4Desc  				:=	ConvertLangCode(l.phys_loc_language_code4);	
				self.languageCode5Desc  				:=	ConvertLangCode(l.phys_loc_language_code5);	
				self.dispensingClassDesc				:=	map(
																								l.dispenser_class_code	=	'01'	=>	'INDEPENDENT PHARMACY',
																								l.dispenser_class_code	=	'02'	=>	'CHAIN PHARMACY',
																								l.dispenser_class_code	=	'05'	=>	'FRANCHISE PHARMACY',
																								l.dispenser_class_code	=	'06'	=>	'GOVERNMENT PHARMACY',
																								l.dispenser_class_code	=	'07'	=>	'ALTERNATE DISPENSING SITE',
																								''
																							  );
				self.PrimaryDispensingTypeDesc	:=	ConvertDispensingTypeCode(l.primary_dispenser_type_code);		
				self.SecondaryDispensingTypeDesc:=	ConvertDispensingTypeCode(l.secondary_dispenser_type_code);	
				self.TertiaryDispensingTypeDesc	:=	ConvertDispensingTypeCode(l.tertiary_dispenser_type_code);
				self.Append_PhyAddr1						:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.phys_loc_address1 + ' ' + l.phys_loc_address2));
				self.Append_PhyAddrLast					:= 	if (L.phys_loc_city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.phys_loc_city) + ', ' + l.phys_loc_state + ' ' + l.phys_loc_full_zip[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.phys_loc_state + ' ' + l.phys_loc_full_zip[1..5]))
																								);
				self.Append_MailAddr1						:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.address1 + ' ' + l.address2));
				self.Append_MailAddrLast				:= 	if (L.city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.city) + ', ' + l.state + ' ' + l.full_zip[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.state + ' ' + l.full_zip[1..5]))
																								);		
				self.reinstatement_date					:=	TRIM(Stringlib.StringCleanSpaces(L.reinstatement_date), LEFT, RIGHT);
				self.transaction_date						:=	TRIM(Stringlib.StringCleanSpaces(L.transaction_date), LEFT, RIGHT);
				self.clean_phys_loc_store_open_date		:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.phys_loc_store_open_date[5..8] + self.phys_loc_store_open_date[1..2] + self.phys_loc_store_open_date[3..4])
																								, false);
				self.clean_phys_loc_store_close_date	:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.phys_loc_store_close_date[5..8] + self.phys_loc_store_close_date[1..2] + self.phys_loc_store_close_date[3..4])
																								, false);
				self.clean_reinstatement_date		:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.reinstatement_date[5..8] + self.reinstatement_date[1..2] + self.reinstatement_date[3..4])
																								, false);
				self.clean_transaction_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.transaction_date[5..8] + self.transaction_date[1..2] + self.transaction_date[3..4])
																								, false);																				
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;

	EXPORT prov_relat(DATASET(NCPDP.layouts.Input.prov_relationship) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.prov_relationship	tCleanRec(NCPDP.layouts.Input.prov_relationship l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.effective_from_date				:=	TRIM(Stringlib.StringCleanSpaces(L.effective_from_date), LEFT, RIGHT);
				self.effective_through_date			:=	TRIM(Stringlib.StringCleanSpaces(L.effective_through_date), LEFT, RIGHT);
				self.clean_effect_from_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.effective_from_date[5..8] + self.effective_from_date[1..2] + self.effective_from_date[3..4])
																								, false);
				self.clean_effect_through_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.effective_through_date[5..8] + self.effective_through_date[1..2] + self.effective_through_date[3..4])
																								, false);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;

	EXPORT medicaid(DATASET(NCPDP.layouts.Input.medicaid_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.medicaid_information	tCleanRec(NCPDP.layouts.Input.medicaid_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT taxonomy(DATASET(NCPDP.layouts.Input.taxonomy_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.taxonomy_information	tCleanRec(NCPDP.layouts.Input.taxonomy_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT demographic(DATASET(NCPDP.layouts.Input.relationship_demographic) pRawFileInput, string pversion) := FUNCTION  
  					
		NCPDP.layouts.Base.relationship_demographic	tCleanRec(NCPDP.layouts.Input.relationship_demographic l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.effective_from_date				:=	TRIM(Stringlib.StringCleanSpaces(L.effective_from_date), LEFT, RIGHT);
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_effect_from_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.effective_from_date[5..8] + self.effective_from_date[1..2] + self.effective_from_date[3..4])
																								, false);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self.Append_Addr1								:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.address_1 + ' ' + l.address_2));
				self.Append_AddrLast						:= 	if (L.city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.city) + ', ' + l.state_code + ' ' + l.zip_code[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.state_code + ' ' + l.zip_code[1..5]))
																								);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput((trim(relationship_id)!='999') AND (trim(relationship_type)!='99')), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT pay_center(DATASET(NCPDP.layouts.Input.payment_center_information) pRawFileInput, string pversion) := FUNCTION  
  					
		NCPDP.layouts.Base.payment_center_information	tCleanRec(NCPDP.layouts.Input.payment_center_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self.Append_Addr1								:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.address_1 + ' ' + l.address_2));
				self.Append_AddrLast						:= 	if (L.city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.city) + ', ' + l.state_code + ' ' + l.zip_code[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.state_code + ' ' + l.zip_code[1..5]))
																								);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(id)!='999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT parent_org(DATASET(NCPDP.layouts.Input.parent_organization_information) pRawFileInput, string pversion) := FUNCTION  
  					
		NCPDP.layouts.Base.parent_organization_information	tCleanRec(NCPDP.layouts.Input.parent_organization_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self.Append_Addr1								:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.address_1 + ' ' + l.address_2));
				self.Append_AddrLast						:= 	if (L.city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.city) + ', ' + l.state_code + ' ' + l.zip_code[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.state_code + ' ' + l.zip_code[1..5]))
																								);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(id)!='999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT eprescribe(DATASET(NCPDP.layouts.Input.eprescribe_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.eprescribe_information	tCleanRec(NCPDP.layouts.Input.eprescribe_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.effective_from_date				:=	TRIM(Stringlib.StringCleanSpaces(L.effective_from_date), LEFT, RIGHT);
				self.effective_through_date			:=	TRIM(Stringlib.StringCleanSpaces(L.effective_through_date), LEFT, RIGHT);
				self.clean_effect_from_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.effective_from_date[5..8] + self.effective_from_date[1..2] + self.effective_from_date[3..4])
																								, false);
				self.clean_effect_through_date	:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.effective_through_date[5..8] + self.effective_through_date[1..2] + self.effective_through_date[3..4])
																								, false);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;

	EXPORT remit(DATASET(NCPDP.layouts.Input.remit_information) pRawFileInput, string pversion) := FUNCTION  
  					
		NCPDP.layouts.Base.remit_information	tCleanRec(NCPDP.layouts.Input.remit_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self.Append_Addr1								:= 	StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.address_1 + ' ' + l.address_2));
				self.Append_AddrLast						:= 	if (L.city!='',
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(trim(L.city) + ', ' + l.state_code + ' ' + l.zip_code[1..5])), 
																										StringLib.StringCleanSpaces(StringLib.StringToUpperCase(l.state_code + ' ' + l.zip_code[1..5]))
																								);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(id)!='999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT state_lic(DATASET(NCPDP.layouts.Input.state_license_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.state_license_information	tCleanRec(NCPDP.layouts.Input.state_license_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.expiration_date						:=	TRIM(Stringlib.StringCleanSpaces(L.expiration_date), LEFT, RIGHT);
				self.delete_date								:=	TRIM(Stringlib.StringCleanSpaces(L.delete_date), LEFT, RIGHT);
				self.clean_expiration_date			:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.expiration_date[5..8] + self.expiration_date[1..2] + self.expiration_date[3..4])
																								, false);
				self.clean_delete_date					:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.delete_date[5..8] + self.delete_date[1..2] + self.delete_date[3..4])
																								, false);
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	END;
	
	EXPORT services(DATASET(NCPDP.layouts.Input.services_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.services_information	tCleanRec(NCPDP.layouts.Input.services_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	end;
	
	EXPORT change_owner(DATASET(NCPDP.layouts.Input.change_ownership_information) pRawFileInput, string pversion) := FUNCTION  
  
		NCPDP.layouts.Base.change_ownership_information	tCleanRec(NCPDP.layouts.Input.change_ownership_information l) := transform
				self.record_type								:=	'C';
				self.dt_first_seen							:=	(integer)pversion;
				self.dt_last_seen								:=	(integer)pversion;
				self.old_store_close_date				:=	TRIM(Stringlib.StringCleanSpaces(L.old_store_close_date), LEFT, RIGHT);
				self.change_ownership_effective_date	:=	TRIM(Stringlib.StringCleanSpaces(L.change_ownership_effective_date), LEFT, RIGHT);
				self.clean_old_store_close_date	:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.old_store_close_date[5..8] + self.old_store_close_date[1..2] + self.old_store_close_date[3..4])
																								, false);
				self.clean_change_owner_effect_date	:= 	(unsigned)_validate.Date.fCorrectedDateString(
																								(string)(self.change_ownership_effective_date[5..8] + self.change_ownership_effective_date[1..2] + self.change_ownership_effective_date[3..4])
																								, false);

				self														:=	l;																				
				self														:=	[];
		END;

		dPreClean		:=	project(pRawFileInput(trim(NCPDP_provider_id)!='9999999'), tCleanRec(left));
		
		RETURN dPreClean;
	end;

END;