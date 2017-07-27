import AutoStandardI,iesp, ut;

export Functions := module
				
		export unicode CleanupUnicode(unicode str) := FUNCTION			
			s0 := UnicodeLib.UnicodeCleanSpaces(TRIM(UnicodeLib.UnicodeToUpperCase(str), left, right));
			s1 := UnicodeLib.UnicodeFindReplace(s0,u'Á' ,u'A');
			s2 := UnicodeLib.UnicodeFindReplace(s1,u'É' ,u'E');
			s3 := UnicodeLib.UnicodeFindReplace(s2,u'Í' ,u'I');
			s4 := UnicodeLib.UnicodeFindReplace(s3,u'Ó' ,u'O');																				
			s5 := UnicodeLib.UnicodeFindReplace(s4,u'Ã‘',u'N');																		
			s6 := UnicodeLib.UnicodeFindReplace(s5,u'Ñ' ,u'N');								
			// ??? do we need the lines below ???
			s7 := UnicodeLib.UnicodeFindReplace(s6,u'\301' ,u'A'); // Á in utf-8 octal																
			s8 := UnicodeLib.UnicodeFindReplace(s7,u'\311' ,u'E'); // É in utf-8 octal																
			s9 := UnicodeLib.UnicodeFindReplace(s8,u'\315' ,u'I'); // Í in utf-8 octal																
			s10 := UnicodeLib.UnicodeFindReplace(s9,u'\323' ,u'O'); // Ó in utf-8 octal																
			s11 := UnicodeLib.UnicodeFindReplace(s10,u'\321' ,u'N'); // Ñ in utf-8 octal																
			return s11; 
		end;
		
		export string CleanupUnicodeToString(unicode str) := FUNCTION			
			return transfer(fromunicode(CleanupUnicode(str), 'UTF-8'), string);
		end;

		export string20 stripPrefix(string20 name) := function
				prefix := '^'+MX_Services.Constants.NPConnectorRegexStr;
				return regexreplace(prefix, name, '');
		end;

		// A somehow rudimentary name parser. Uses a regular expression to split the name
		// parts, then assign a part indicator based on name position and some spanish naming
		// conventions.
		export ParseNameParts(dataset(MX_Services.Layouts.MXNameInput) ds_in) := function
		  
			ds_in_clean := project(ds_in, transform(MX_Services.Layouts.MXNameInput, 
																							self.name := CleanupUnicode(left.name), 
																							self.uid := left.uid));
			
			unicode connectorRegex := MX_Services.Constants.NPConnectorRegex;	
			rule possibleNames := MX_Services.Constants.NPName;		
			ds0 := parse(ds_in_clean,name, possibleNames, transform(MX_Services.Layouts.MXPersonNamePart,
										npt :=trim(matchunicode(possibleNames[1]),LEFT,RIGHT);
										cleannpt :=if (transfer(npt[1],unsigned1) > 32, npt, u'');
										rgx :=trim(regexreplace(connectorRegex,cleannpt,u''));
										self.name_part_text := cleannpt,
										self.stripped_name := trim(transfer(fromunicode(rgx, 'UTF-8'), string), left, right),
										self.name_part_position:=1,
										self.total_parts:=1,
										self.name_part_type:=0,
										SELF.name_id:=left.uid												
										), SCAN);

			ds1 := iterate(ds0, transform(MX_Services.Layouts.MXPersonNamePart,
															self.name_part_position := if(left.name_id=right.name_id, left.name_part_position+1, right.name_part_position),
															self.probable_name_part := MAP
																		(right.name_part_text in MX_Services.Constants.NameSuffixes => MX_Services.Constants.NamePartType.Suffix,
																		 right.name_part_text in MX_Services.Constants.NameTitles => MX_Services.Constants.NamePartType.Title,
																		0),
															self := right));

			// strip II, IIIs, JR, etc
			ds2 := ds1(probable_name_part <> MX_Services.Constants.NamePartType.Suffix, 
								 probable_name_part <> MX_Services.Constants.NamePartType.Title); 

			MX_Services.Layouts.MXPersonNamePart CheckNameParts(MX_Services.Layouts.MXPersonNamePart l, 
																													 MX_Services.Layouts.MXPersonNamePart r) := transform
				curr_de_indicator := r.name_part_text[1..3]=u'DE ';
				prev_de_indicator := l.name_part_text[1..3]=u'DE ';
				nparts := max(ds2(name_id = r.name_id), name_part_position);
				ppos := r.name_part_position;
				
				// Here's where we flag the probable part name, based mostly on name part position and some naming conventions.
				// Name format: FIRST [SECOND] PATRONYMIC MATRONYMIC 
				// Second name starting with DE|DEL indicates middle name, not patronymic. 
				// E.g: For MARIA DE LOURDES LOPEZ, DE LOURDES would be a middle name and LOPEZ would be a patronymic.
				prob_part := MAP(
					// 1st element is always first name
					ppos = 1 => MX_Services.Constants.NamePartType.FirstName,
					// 2nd element is always a middle name if we have 4 elements or if it's prefixed by 'DE'.
					ppos = 2 and (curr_de_indicator or nparts > 3) => MX_Services.Constants.NamePartType.MiddleName,
					// otherwise, 2nd element can only be a patronymic.
					ppos = 2 => MX_Services.Constants.NamePartType.Patronymic,
					// 3rd element is likely to be a matronymic only if we have only 3 names and previous is not a middle name (prefixed by 'DE').
					ppos = 3 and (nparts = 3 and ~prev_de_indicator) => MX_Services.Constants.NamePartType.Matronymic,
					// otherwise, 3rd element is likely to be a patronymic in a 4 part name.
					ppos = 3 => MX_Services.Constants.NamePartType.Patronymic,
					// 4th element should be a matronymic
					ppos = 4 => MX_Services.Constants.NamePartType.Matronymic,
					MX_Services.Constants.NamePartType.Unknown
				);
				self.total_parts := nparts,
				self.probable_name_part := prob_part,										
				self.name_part_type := prob_part,
				self.name_part_desc := MX_Services.Constants.NamePartTypeText[prob_part],
				self := r														
			end;

			ds3 := iterate(ds2,	CheckNameParts(left, right));	
			return ds3;
		end;
		
		shared getCommonSearchModule() := function
			input_params := AutoStandardI.GlobalModule();

			unicode100  fulname := u'' : STORED('FullName');
			unicode20 	firname := u'' : STORED('FirstName');
			unicode20 	midname := u'' : STORED('MiddleName');
			unicode20 	patname := u'' : STORED('PaternalName');
			unicode20 	matname := u'' : STORED('MaternalName');
			
			tfulname := trim(fulname, left, right);
			tfirname := trim(firname, left, right);
			tmidname := trim(midname, left, right);
			tpatname := trim(patname, left, right);
			tmatname := trim(matname, left, right);
			
			// clean unicode input 
			unicode100 ufulname := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(tfulname));
			unicode20  ufirname := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(tfirname));
			unicode20  umidname	:= UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(tmidname));
			unicode20  upatname := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(tpatname));
			unicode20  umatname := UnicodeLib.UnicodeCleanSpaces(UnicodeLib.UnicodeToUpperCase(tmatname));

			// convert to clean input strings
			string20 sfirname := transfer(fromunicode(CleanupUnicode(tfirname), 'UTF-8'), string);		
			string20 smidname	:= transfer(fromunicode(CleanupUnicode(tmidname), 'UTF-8'), string);
			string20 spatname := transfer(fromunicode(CleanupUnicode(tpatname), 'UTF-8'), string);
			string20 smatname := transfer(fromunicode(CleanupUnicode(tmatname), 'UTF-8'), string);
			
			// parse full name if necessary
			parsedName := ParseNameParts(dataset([{ufulname, 0}], Layouts.MXNameInput));							
			isParsedInput := fulname<>'';		
								
			in_mod:= MODULE(PROJECT(input_params, IParam.CommonParams, opt))		
				unsigned2 				_penalty_threshold := AutoStandardI.InterfaceTranslator.penalt_threshold_value.val(project(input_params,AutoStandardI.InterfaceTranslator.penalt_threshold_value.params)); ;
				export unsigned2 	penalty_threshold  := if(_penalty_threshold>0, _penalty_threshold, 10);
				export unicode100 uFullName 	:= ufulname;										
				export unicode20 uFirstName    	:= if(~isParsedInput, ufirname,
					parsedName(name_part_type=Constants.NamePartType.FirstName)[1].name_part_text);
				export unicode20 uMiddleName 	 	:= if(~isParsedInput, umidname,
					parsedName(name_part_type=Constants.NamePartType.MiddleName)[1].name_part_text);
				export unicode20 uPaternalName 	:= if(~isParsedInput, upatname,
					parsedName(name_part_type=Constants.NamePartType.Patronymic)[1].name_part_text);
				export unicode20 uMaternalName 	:= if(~isParsedInput, umatname,
					parsedName(name_part_type=Constants.NamePartType.Matronymic)[1].name_part_text);
				export string20 sFirstName    := if(~isParsedInput, stripPrefix(sfirname),
					parsedName(name_part_type=Constants.NamePartType.FirstName)[1].stripped_name);
				export string20 sMiddleName 	:= if(~isParsedInput, stripPrefix(smidname),
					parsedName(name_part_type=Constants.NamePartType.MiddleName)[1].stripped_name);
				export string20 sPaternalName := if(~isParsedInput, stripPrefix(spatname),
					parsedName(name_part_type=Constants.NamePartType.Patronymic)[1].stripped_name);
				export string20 sMaternalName := if(~isParsedInput, stripPrefix(smatname),
					parsedName(name_part_type=Constants.NamePartType.Matronymic)[1].stripped_name);
			end;								
			return in_mod;
		end;

		export getDocketSearchModule(iesp.internationaldocket.t_InternationalDocketSearchRequest request) := FUNCTION

			searchBy := global(request.searchBy);
			in_common_mod := getCommonSearchModule();			
			
			string1    in_Gender  			:= '' : STORED('Gender');
			string20   in_DocketType		:= '' : STORED('DocketType');		
			unsigned2  in_DocketPubYear := 0  : STORED('DocketPubYear');
			unsigned8	 in_UniqueId			:= 0  : STORED('UniqueId');
			unicode50	 in_UDocketNumber := u'' : STORED('DocketNumber');
			string50	 in_DocketNumber 	:= transfer(fromunicode(CleanupUnicode(in_UDocketNumber), 'UTF-8'), string);
			
			in_mod:= MODULE(PROJECT(in_common_mod, IParam.DocketSearchParams, opt))		
				export unsigned8  UniqueId			:= in_UniqueId;
				export string1    InputGender 	:= trim(StringLib.StringToUpperCase(in_gender),LEFT,RIGHT);
				export string20   DocketType 	 	:= trim(StringLib.StringToUpperCase(in_DocketType),LEFT,RIGHT);
				export unsigned2  DocketPubYear	:= in_DocketPubYear;
				export string50	 	DocketNumber	:= stringlib.stringfilter(in_DocketNumber,'0123456789ABCDEFGHIJKLMNOPQRSTUWXYZ');
				export set of string3	DocketStateCodes := set(searchBy.StateProvinceCodes(value<>''), StringLib.StringToUpperCase(trim(value,left,right)));
			end;					
			return in_mod;
		end;
		
		export getProfessionSearchModule(iesp.internationalproflicense.t_InternationalProfessionalLicenseSearchRequest request) := FUNCTION

			searchBy := global(request.searchBy);			
			in_common_mod := getCommonSearchModule();			
			unsigned8	 in_UniqueId		:= 0  : STORED('UniqueId');
			string1    in_Gender  		:= '' : STORED('Gender');
			string20   in_category		:= '' : STORED('Category');
			in_mod:= MODULE(PROJECT(in_common_mod, IParam.ProfessionSearchParams, opt))		
				export unsigned8  UniqueId			:= in_UniqueId;
				export string1    InputGender 	:= trim(StringLib.StringToUpperCase(in_gender),LEFT,RIGHT);
				export unsigned1  Category 	:= Constants.MapToCategoryType(StringLib.StringToUpperCase(trim(in_category, left, right)));
			end;					
			return in_mod;
	end;

	export unsigned1 calculateNamePenalty(unicode20 in_name, unicode20 out_name, unsigned1 max_pen) := function			
																					
		in_name_str 	:= CleanupUnicodeToString(in_name);
		out_name_str 	:= CleanupUnicodeToString(out_name);
		
		is_phonetic_match := 
			MetaphoneLib.DMetaphone1(in_name_str)[1..6]=MetaphoneLib.DMetaphone1(out_name_str)[1..6] and 
			MetaphoneLib.DMetaphone2(in_name_str)[1..6]=MetaphoneLib.DMetaphone2(out_name_str)[1..6];
		
		// namesimilar seems return either 0-6 or 99, so it is adjusted +3
		// metaphone appears to have too many false positives, so penalty is
		// calculated using both, with a cap of max_pen
		pen := ut.imin2((datalib.namesimilar(in_name_str,out_name_str,1)+ 3)/ IF(is_phonetic_match,2,1),max_pen);
		
		return map(
			in_name=u'' => 0,
			in_name=out_name=> 0,
			pen);
			
	end;
	
	export toFinalDocketOut(dataset(Layouts.MXDocketRecord) in_recs) := function
		
		iesp.internationaldocket.t_InternationalDocket 
		toDockets(Layouts.MXCourtDocket l) := transform
			self.FilingDate 				:= iesp.ECL2ESP.toDate(l.date_pub),
			self := l
		end;
		
		iesp.internationaldocket.t_InternationalDocketRecord 
		toOut(Layouts.MXDocketRecord l) := transform
			_akas 		:= choosen(l.akas, iesp.constants.INTERNATIONALDOCKET_MAX_COUNT_AKAS);
			_dockets 	:= choosen(l.dockets,iesp.constants.INTERNATIONALDOCKET_MAX_COUNT_DOCKETS);				
			self.UniqueId := l.entity_id,												
			self._penalty	:= l._penalty,
			self.Gender 	:= l.gender,
			self.FullName := l.fullname,				
			self.Akas 		:= project(_akas, iesp.internationaldocket.t_InternationalName),
			self.Dockets 	:= project(_dockets, toDockets(left))			
		end;
		
		recs := project(in_recs, toOut(left));
		return recs;
	end;	

	export toFinalProfessionOut(dataset(Layouts.MXProfessionRecord) in_recs) := function
		
		iesp.internationalprofcert.t_InternationalProfCertificationRecord 
		toOut(Layouts.MXProfessionRecord l) := transform
			_akas 		:= choosen(l.akas, iesp.constants.INTERNATIONALPROFCERT_MAX_COUNT_AKAS);
			_cert			:= choosen(l.certifications,iesp.constants.INTERNATIONALPROFCERT_MAX_COUNT_CERTIFICATIONS);				
			self.UniqueId := l.entity_id,			
			self._penalty	:= l._penalty,
			self.Gender 	:= l.gender,
			self.FullName := l.fullname,				
			self.Akas 		:= project(_akas, iesp.internationaldocket.t_InternationalName),
			self.Certifications := project(_cert, iesp.internationalprofcert.t_InternationalProfCertification)
		end;
		
		recs := project(in_recs, toOut(left));
		return recs;
	end;



end;		