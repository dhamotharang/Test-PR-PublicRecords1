import AID, address,lib_stringLib;

export Update_Base(

	 dataset(layouts.Input.Sprayed	)	pUpdateFile
	,dataset(Layouts.Base.AID			)		pBaseFile
	,string														pversion

) :=
function

		export fParseAddr (string instr) := MODULE
			shared instring := lib_stringLib.StringLib.StringFindReplace(
														lib_stringLib.StringLib.StringFindReplace(
																lib_stringLib.StringLib.StringFindReplace(trim(instr, left,right),'(',' ')
																	,')',' ')
																		,'*','');
			shared streetAbbr := ' STR EET | AVE | AVE. | AVE.,| RD | RD. | RD, | ROAD | ROAD, | ST | ST. | CIR | CIRCLE | CT | CT. | DR | DR. | PL | PL. | BLVD | BLVD. | LN | LN. | HWY | HWY. ';
			
			shared comma_sep_cnt := lib_stringLib.StringLib.stringfindcount(instring,',');
			
			shared scnt := lib_stringLib.StringLib.stringfindcount(instring,' ');

			shared pos  := lib_stringLib.StringLib.stringfind(instring,' ',scnt);

			shared token_first  := trim(instring[1..pos-1]);
			
			shared token_last   := trim(instring[pos+1..]);
			
			shared token_first_sep := regexreplace(streetAbbr, token_first, '|');
			
			shared token_first_sep_cnt   := lib_stringLib.StringLib.stringfindcount(token_first_sep, '|');
			
			shared token_first_num := if (token_first_sep_cnt > 1,
																		regexreplace('[[:digit:]]',token_first,'@'),token_first);
														 
			shared token_sep_cnt := if (token_first_sep_cnt > 1,
																	lib_stringLib.StringLib.stringfindcount(token_first_num,'@'),0);
													 
			shared token_first_last_digit_pos := if (token_first_sep_cnt > 1,
																							lib_stringLib.StringLib.stringfind(token_first_num,'@',token_sep_cnt),0);
																
			shared token_first_new := if (token_first_sep_cnt > 1,
																		token_first[token_first_last_digit_pos+1..],token_first_sep);
														 
			shared zip :=	if (comma_sep_cnt =3,
												StringLib.StringFilter(instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..], '1234567890'),
												if (comma_sep_cnt =2,
													 StringLib.StringFilter(instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..], '1234567890'),
													 if((integer)token_last > 0 and length(token_last) >=5, StringLib.StringFilter(token_last,'1234567890'),
															if(length(StringLib.StringFilter(token_last,'1234567890')) >=5, StringLib.StringFilter(token_last,'1234567890'), ''))));
									 
			shared st  := if (comma_sep_cnt =3,
												if (regexfind('[[:alpha:]]',instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..]),
														StringLib.StringFilter(instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),
														StringLib.StringFilter(instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt-1)+1..lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)-1], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ ')),
												if (comma_sep_cnt =2,
														StringLib.StringFilter(instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '),
														if (trim(zip) = '',
															 if(regexfind('[[:alpha:]]',token_last) and length(trim(token_last)) = 2, trim(token_last),''),
															 if (length(trim(token_first[lib_stringLib.StringLib.stringfind(instring,' ',scnt-1)+1..])) = 2, 
																			trim(token_first[lib_stringLib.StringLib.stringfind(instring,' ',scnt-1)+1..]),
																			if(length(StringLib.StringFilter(token_last,'ABCDEFGHIJKLMNOPQRSTUVWXYZ ')) = 2, StringLib.StringFilter(token_last,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), ''))
															))
												);
				
			shared temp_city := if (comma_sep_cnt =3,
															if (regexfind('[[:alpha:]]',instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..]),
																	instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt-1)+1..lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)-1],
																	instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt-2)+1..lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt-1)-1]),
															if (comma_sep_cnt =2,
																	instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt-1)+1..lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)-1],
																	map (token_first_sep_cnt = 0 =>  if (trim(zip) <> '', 
																																				if (trim(st) <>'',regexreplace(' '+trim(st),token_first_sep[lib_stringLib.StringLib.stringfind(token_first_sep,' ',if(scnt>2, 0, scnt-2))+1..],''),
																																						token_first_sep),
																																				if(trim(st) <> '',token_first_sep, token_first_sep + ' ' + token_last)),
																			 token_first_sep_cnt = 1 =>  if ((integer)token_last = 0 and length(token_last) > 2, 
																																			 trim(token_first_sep[lib_stringLib.StringLib.stringfind(token_first_sep,'|',1)+1..]) + ' ' +token_last,
																																			 regexreplace(' '+trim(st),trim(token_first_sep[lib_stringLib.StringLib.stringfind(token_first_sep,'|',1)+1..]),'')),
																			 token_first_sep_cnt > 1 =>  token_first_new,
																			 token_first																		
																			))
															);
															
			shared city_with_nums    := regexreplace('[[:digit:]]',temp_city,'@');
			
			shared city_with_num_cnt := lib_stringLib.StringLib.stringfindcount(city_with_nums,'@');
				
			shared city_last_num_pos := if (city_with_num_cnt > 0,
																			lib_stringLib.StringLib.stringfind(city_with_nums,'@',city_with_num_cnt),0);
				
			shared city_new := if (city_with_num_cnt > 0,
															temp_city[city_last_num_pos+1..],temp_city);
															
			shared city := if (city_with_num_cnt > 0,
												 if (lib_stringLib.StringLib.stringfind(city_new, ' ',1) > 1,
														 city_new[lib_stringLib.StringLib.stringfind(city_new, ' ',1)+1..],
														 city_new),
												 city_new);
			
			shared street := if (comma_sep_cnt =3,
														if (regexfind('[[:alpha:]]',instring[lib_stringLib.StringLib.stringfind(instring,',',comma_sep_cnt)+1..]),
																instring[1..lib_stringLib.StringLib.stringfind(instring,',',2)-1],
																instring[1..lib_stringLib.StringLib.stringfind(instring,',',1)-1]),								
														if (comma_sep_cnt =2,
																instring[1..lib_stringLib.StringLib.stringfind(instring,',',1)-1],
																if ((integer)token_last = 0 and length(token_last) > 2,
																		instring[1..lib_stringLib.StringLib.stringfind(instring,City,1)-1]
																		,token_first[1..lib_stringLib.StringLib.stringfind(token_first,City,1)-1]
																	 )
																)
													 );

			export Var_Street := trim(lib_stringLib.StringLib.StringFindReplace(Street,',',''),left,right);
			export Var_City 	:= trim(lib_stringLib.StringLib.StringFindReplace(City,',',''),left,right);
			export Var_st 		:= trim(St,left,right);
			export Var_Zip 		:= trim(zip,left,right);
		end;

	dStandardizedInputFile	:= Standardize_Input.fAll	(pUpdateFile						, pversion);
	
	base_file := project(pBaseFile, transform(Layouts.Base.AID, self.record_type := 'H'; self := left));
	
	update_combined					:= if(_Flags.Update
																,dStandardizedInputFile + base_file
																,dStandardizedInputFile
															);
															
	busReg.Layouts.Temporary.StandardizeInput tPreProcess(busReg.layouts.Base.AID l, unsigned4 cnt) :=	transform
	
		self.unique_id								:=	cnt;
		self.br_id										:= 	cnt;
	
		// For bug# 121734
		string mail_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.mail_add,			'STRE ET','STREET'),left,right);
		string loc_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.loc_add,				'STRE ET','STREET'),left,right);
		string ofc1_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc1_add,			'STRE ET','STREET'),left,right);
		string ra_add							:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ra_add,				'STRE ET','STREET'),left,right);
		string ofc2_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc2_add,			'STRE ET','STREET'),left,right);
		string ofc3_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc3_add,			'STRE ET','STREET'),left,right);
		string ofc4_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc4_add,			'STRE ET','STREET'),left,right);
		string ofc5_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc5_add,			'STRE ET','STREET'),left,right);	
		string ofc6_add						:=	trim(lib_stringLib.StringLib.StringFindReplace(l.rawfields.ofc6_add,			'STRE ET','STREET'),left,right);
		string mailing_address1		:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_mailing_address1,	'STRE ET','STREET'),left,right);
		string location_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_location_address1,	'STRE ET','STREET'),left,right);
		string officer1_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer1_address1,	'STRE ET','STREET'),left,right);
		string officer2_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer2_address1,	'STRE ET','STREET'),left,right);
		string officer3_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer3_address1,	'STRE ET','STREET'),left,right);
		string officer4_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer4_address1,	'STRE ET','STREET'),left,right);
		string officer5_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer5_address1,	'STRE ET','STREET'),left,right);
		string officer6_address1	:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_officer6_address1,	'STRE ET','STREET'),left,right);	
		string ra_address1				:=	trim(lib_stringLib.StringLib.StringFindReplace(l.Clean_ra_address1,				'STRE ET','STREET'),left,right);
	
		self.Clean_mailing_address1		:=	if (trim(mailing_address1,left,right) ='',
																						StringLib.StringCleanSpaces(trim(mail_add,left,right) + ' ' + 
																																				trim(l.rawfields.mail_suite,left,right)),
																						trim(mailing_address1,left,right)
																					); 
																		
		self.Clean_mailing_address2		:=	if (trim(l.Clean_mailing_address2,left,right) ='',
																						if (trim(l.rawfields.mail_city,left,right)	!= '',
																									StringLib.StringCleanSpaces(trim(l.rawfields.mail_city,left,right)	+	', ' 	+
																																							trim(l.rawfields.mail_state,left,right)+	' ' 	+
																																							trim(l.rawfields.mail_zip,left,right)[1..5]),
																									StringLib.StringCleanSpaces(trim(l.rawfields.mail_state,left,right)+	' '		+
																																							trim(l.rawfields.mail_zip,left,right)[1..5])
																							 ),
																						trim(l.Clean_mailing_address2,left,right)
																					);
																		
		self.Clean_location_address1 	:=	if (trim(location_address1,left,right) ='',
																						StringLib.StringCleanSpaces(trim(loc_add,left,right)	+ ' ' + 
																																				trim(l.rawfields.loc_suite,left,right)),
																						trim(location_address1,left,right)
																					);
																		
		self.Clean_location_address2 	:=	if (trim(l.Clean_location_address2,left,right) ='',
																						if (trim(l.rawfields.loc_city,left,right)		!=	'',
																									StringLib.StringCleanSpaces(trim(l.rawfields.loc_city,left,right)	+ 	', '	+
																																							trim(l.rawfields.loc_state,left,right)	+ 	' ' 	+ 
																																							trim(l.rawfields.loc_zip,left,right)[1..5]),
																									StringLib.StringCleanSpaces(trim(l.rawfields.loc_state,left,right) + 	' '		+ 
																																							trim(l.rawfields.loc_zip,left,right)[1..5])
																								),
																						trim(l.Clean_location_address2,left,right)
																					);

		self.Clean_officer1_address1 	:= 	if (trim(officer1_address1,left,right) = '',
																						StringLib.StringCleanSpaces(trim(ofc1_add,left,right)	+ ' ' + 
																																				trim(l.rawfields.ofc1_suite,left,right)),
																						trim(officer1_address1,left,right)
																					);
																		
		self.Clean_officer1_address2 	:=	if (trim(l.Clean_officer1_address2,left,right) = '',
																						if (trim(l.rawfields.ofc1_city,left,right)	!=	'',
																									StringLib.StringCleanSpaces(trim(l.rawfields.ofc1_city,left,right)		+		', ' 	+ 
																																							trim(l.rawfields.ofc1_state,left,right)	+		' ' 	+ 
																																							trim(l.rawfields.ofc1_zip,left,right)[1..5]),
																									StringLib.StringCleanSpaces(trim(l.rawfields.ofc1_state,left,right) 	+ 	' '		+ 
																																							trim(l.rawfields.ofc1_zip,left,right)[1..5])
																								),
																						trim(l.Clean_officer1_address2,left,right)
																					);
																					
		self.Clean_ra_address1 				:= 	if (trim(ra_address1,left,right) = '',
																						StringLib.StringCleanSpaces(trim(ra_add,left,right)	+ ' ' + 
																																				trim(l.rawfields.ra_suite,left,right)),
																						trim(ra_address1,left,right)
																					);
																		
		self.Clean_ra_address2 				:=	if (trim(l.Clean_ra_address2,left,right) = '',
																						if (trim(l.rawfields.ra_city,left,right)	!=	'',
																									StringLib.StringCleanSpaces(trim(l.rawfields.ra_city,left,right)		+		', ' 	+ 
																																							trim(l.rawfields.ra_state,left,right)	+		' ' 	+ 
																																							trim(l.rawfields.ra_zip,left,right)[1..5]),
																									StringLib.StringCleanSpaces(trim(l.rawfields.ra_state,left,right) 	+ 	' '		+ 
																																							trim(l.rawfields.ra_zip,left,right)[1..5])
																								),
																						trim(l.Clean_ra_address2,left,right)
																					);																					

		self.Clean_officer2_address1 	:=	if (trim(officer2_address1,left,right) = '',
																						trim(ofc2_add	,left,right),
																						trim(officer2_address1,left,right)
																					);        
		self.Clean_officer2_address2 	:= 	if (trim(l.Clean_officer2_address2,left,right) = '',
																						regexreplace(',$',StringLib.StringCleanSpaces(
																															fParseAddr(trim(l.rawfields.ofc2_csz,left,right)).Var_city + ', '+
																															fParseAddr(trim(l.rawfields.ofc2_csz,left,right)).Var_st + ' '+
																															fParseAddr(trim(l.rawfields.ofc2_csz,left,right)).Var_zip[1..5]),''
																												),
																						trim(l.Clean_officer2_address2,left,right)
																					);
		self.Clean_officer3_address1 	:=	if (trim(officer3_address1,left,right) = '',
																						trim(ofc3_add	,left,right),
																						trim(officer3_address1,left,right)
																					);        
		self.Clean_officer3_address2 	:= 	if (trim(l.Clean_officer3_address2,left,right) = '',
																						regexreplace(',$',StringLib.StringCleanSpaces(
																															fParseAddr(trim(l.rawfields.ofc3_csz,left,right)).Var_city + ', '+
																															fParseAddr(trim(l.rawfields.ofc3_csz,left,right)).Var_st + ' '+
																															fParseAddr(trim(l.rawfields.ofc3_csz,left,right)).Var_zip[1..5]),''
																												),
																						trim(l.Clean_officer3_address2,left,right)
																					);
		self.Clean_officer4_address1 	:=	if (trim(officer4_address1,left,right) = '',
																						trim(ofc4_add	,left,right),
																						trim(officer4_address1,left,right)
																					);
		self.Clean_officer4_address2 	:= 	if (trim(l.Clean_officer4_address2,left,right) = '',
																						regexreplace(',$',StringLib.StringCleanSpaces(
																															fParseAddr(trim(l.rawfields.ofc4_csz,left,right)).Var_city + ', '+
																															fParseAddr(trim(l.rawfields.ofc4_csz,left,right)).Var_st + ' '+
																															fParseAddr(trim(l.rawfields.ofc4_csz,left,right)).Var_zip[1..5]),''
																												),		
																						trim(l.Clean_officer4_address2,left,right)
																					);
		self.Clean_officer5_address1 	:=	if (trim(officer5_address1,left,right) = '',
																						trim(ofc5_add	,left,right),   
																						trim(officer5_address1,left,right)
																					);
		self.Clean_officer5_address2 	:= 	if (trim(l.Clean_officer5_address2,left,right) = '',
																						regexreplace(',$',StringLib.StringCleanSpaces(
																															fParseAddr(trim(l.rawfields.ofc5_csz,left,right)).Var_city + ', '+
																															fParseAddr(trim(l.rawfields.ofc5_csz,left,right)).Var_st + ' '+
																															fParseAddr(trim(l.rawfields.ofc5_csz,left,right)).Var_zip[1..5]),''
																												),		
																						trim(l.Clean_officer5_address2,left,right)
																					);
		self.Clean_officer6_address1 	:=	if (trim(officer6_address1,left,right) = '',
																						trim(ofc6_add	,left,right), 
																						trim(officer6_address1,left,right)
																					);
		self.Clean_officer6_address2 	:= 	if (trim(l.Clean_officer6_address2,left,right) = '',
																						regexreplace(',$',StringLib.StringCleanSpaces(
																															fParseAddr(trim(l.rawfields.ofc6_csz,left,right)).Var_city + ', '+
																															fParseAddr(trim(l.rawfields.ofc6_csz,left,right)).Var_st + ' '+
																															fParseAddr(trim(l.rawfields.ofc6_csz,left,right)).Var_zip[1..5]),''
																												),		
																						trim(l.Clean_officer6_address2,left,right)
																				 );
		self													:=	l;
		self													:=	[];
	end;
	
	dPreProcess := distribute(project(update_combined, tPreProcess(left,counter)),hash(unique_Id));
		
	addresslayout :=	record
		unsigned8										unique_id			;	//to tie back to original record
		unsigned4										address_type	;	// contact or mailing
		string100										Append_Prep_Address1;
		string50										Append_Prep_AddressLast;
		AID.Common.xAID							Append_RawAID;	
		AID.Common.xAID							Append_ACEAID;		
	end;
				
	cleanedAddrLayout :=	record
		addresslayout;
		address.Layout_Clean182		Clean_Address;
	end;
				
	addresslayout tNormalizeAddress(busReg.Layouts.Temporary.StandardizeInput l, unsigned4 cnt) := transform
		
		self.unique_id								:= l.unique_id;
		self.address_type							:= cnt;
		self.Append_Prep_Address1			:= choose(cnt	,l.Clean_mailing_address1
																								,l.Clean_location_address1
																								,l.Clean_ra_address1
																								,l.Clean_officer1_address1
																								,l.Clean_officer2_address1
																								,l.Clean_officer3_address1
																								,l.Clean_officer4_address1
																								,l.Clean_officer5_address1
																								,l.Clean_officer6_address1
																						);              
		self.Append_Prep_AddressLast	:= choose(cnt	,l.Clean_mailing_address2
																								,l.Clean_location_address2
																								,l.Clean_ra_address2
																								,l.Clean_officer1_address2
																								,l.Clean_officer2_address2
																								,l.Clean_officer3_address2
																								,l.Clean_officer4_address2
																								,l.Clean_officer5_address2
																								,l.Clean_officer6_address2
																						); 
		self.Append_RawAID						:=	choose(cnt,l.Append_MailRawAID
																								,l.Append_LocRawAID
																								,l.Append_RARawAID
																								,l.Append_Off1RawAID
																								,l.Append_Off2RawAID
																								,l.Append_Off3RawAID
																								,l.Append_Off4RawAID
																								,l.Append_Off5RawAID
																								,l.Append_Off6RawAID
																						);
		self.Append_ACEAID						:=	choose(cnt,l.Append_MailACEAID
																								,l.Append_LocACEAID
																								,l.Append_RAACEAID
																								,l.Append_Off1ACEAID
																								,l.Append_Off2ACEAID
																								,l.Append_Off3ACEAID
																								,l.Append_Off4ACEAID
																								,l.Append_Off5ACEAID
																								,l.Append_Off6ACEAID
																						);		
																							 
	end;
				
	dAddressPrep			:= 	normalize(dPreProcess, 9, tNormalizeAddress(left,counter),local);
		
	HasAddress				:= 	trim(dAddressPrep.Append_Prep_Address1, left,right) != ''	and 
												trim(dAddressPrep.Append_Prep_AddressLast, left,right) != '';
												
	dWith_address			:= 	dAddressPrep(HasAddress);
	dWithout_address	:= 	dAddressPrep(not(HasAddress));
										
				
	dStandardizeNameInput_dist 	:= distribute(dPreProcess	,unique_id);
						
	unsigned4		lAIDAppendFlags	:=	AID.Common.eReturnValues.ACEAIDs | AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;	
				
	AID.MacAppendFromRaw_2Line(dWith_address, Append_Prep_Address1, Append_Prep_AddressLast, Append_RawAID, dAddressCleaned, lAIDAppendFlags);
		
	cleanedAddrLayout	tCleancontactAddressAppended(dAddressCleaned pInput)	:=	transform
		self.Append_RawAID			:=	pInput.AIDWork_RawAID;
		self.Append_ACEAID			:=	pInput.aidwork_acecache.aid;		
		self.clean_address.zip	:=	pInput.AIDWork_ACECache.zip5;
		self.clean_address			:=	pInput.AIDWork_ACECache;
		self										:=	pInput;
	end;
					
	dCleancontactAddressAppended				:=	project(dAddressCleaned,tCleancontactAddressAppended(left));	
				
	dCleancontactAddressAppended_dist		:= distribute(dCleancontactAddressAppended	,unique_id);
		
	busReg.Layouts.Temporary.StandardizeInput tGetStandardizedAddress(busReg.Layouts.Temporary.StandardizeInput l	,cleanedAddrLayout r) :=	transform
		self.Append_MailRawAID									:= if(r.address_type = 1	,r.Append_RawAID							,l.Append_MailRawAID);
		self.Append_MailACEAID									:= if(r.address_type = 1	,r.Append_ACEAID							,l.Append_MailACEAID);		
		self.Clean_mailing_address.prim_range		:= if(r.address_type = 1	,r.Clean_address.prim_range		,l.Clean_mailing_address.prim_range);
		self.Clean_mailing_address.predir				:= if(r.address_type = 1	,r.Clean_address.predir				,l.Clean_mailing_address.predir);
		self.Clean_mailing_address.prim_name		:= if(r.address_type = 1	,r.Clean_address.prim_name		,l.Clean_mailing_address.prim_name);
		self.Clean_mailing_address.addr_suffix	:= if(r.address_type = 1	,r.Clean_address.addr_suffix	,l.Clean_mailing_address.addr_suffix);
		self.Clean_mailing_address.postdir			:= if(r.address_type = 1	,r.Clean_address.postdir			,l.Clean_mailing_address.postdir);
		self.Clean_mailing_address.unit_desig		:= if(r.address_type = 1	,r.Clean_address.unit_desig		,l.Clean_mailing_address.unit_desig);
		self.Clean_mailing_address.sec_range		:= if(r.address_type = 1	,r.Clean_address.sec_range		,l.Clean_mailing_address.sec_range);
		self.Clean_mailing_address.p_city_name	:= if(r.address_type = 1	,r.Clean_address.p_city_name	,l.Clean_mailing_address.p_city_name);
		self.Clean_mailing_address.v_city_name	:= if(r.address_type = 1	,r.Clean_address.v_city_name	,l.Clean_mailing_address.v_city_name);
		self.Clean_mailing_address.st						:= if(r.address_type = 1	,r.Clean_address.st						,l.Clean_mailing_address.st);
		self.Clean_mailing_address.zip					:= if(r.address_type = 1	,r.Clean_address.zip					,l.Clean_mailing_address.zip);
		self.Clean_mailing_address.zip4					:= if(r.address_type = 1	,r.Clean_address.zip4					,l.Clean_mailing_address.zip4);		
		self.Clean_mailing_address.cart					:= if(r.address_type = 1	,r.Clean_address.cart					,l.Clean_mailing_address.cart);
		self.Clean_mailing_address.cr_sort_sz		:= if(r.address_type = 1	,r.Clean_address.cr_sort_sz		,l.Clean_mailing_address.cr_sort_sz);
		self.Clean_mailing_address.lot					:= if(r.address_type = 1	,r.Clean_address.lot					,l.Clean_mailing_address.lot);
		self.Clean_mailing_address.lot_order		:= if(r.address_type = 1	,r.Clean_address.lot_order		,l.Clean_mailing_address.lot_order);
		self.Clean_mailing_address.dbpc					:= if(r.address_type = 1	,r.Clean_address.dbpc					,l.Clean_mailing_address.dbpc);
		self.Clean_mailing_address.chk_digit		:= if(r.address_type = 1	,r.Clean_address.chk_digit		,l.Clean_mailing_address.chk_digit);
		self.Clean_mailing_address.rec_type			:= if(r.address_type = 1	,r.Clean_address.rec_type			,l.Clean_mailing_address.rec_type);
		self.Clean_mailing_address.fips_state		:= if(r.address_type = 1	,r.Clean_address.county[1..2]	,l.Clean_mailing_address.fips_state);
		self.Clean_mailing_address.fips_county	:= if(r.address_type = 1	,r.Clean_address.county[3..5]	,l.Clean_mailing_address.fips_county);
		self.Clean_mailing_address.geo_lat			:= if(r.address_type = 1	,r.Clean_address.geo_lat			,l.Clean_mailing_address.geo_lat);
		self.Clean_mailing_address.geo_long			:= if(r.address_type = 1	,r.Clean_address.geo_long			,l.Clean_mailing_address.geo_long);
		self.Clean_mailing_address.msa					:= if(r.address_type = 1	,r.Clean_address.msa					,l.Clean_mailing_address.msa);
		self.Clean_mailing_address.geo_blk			:= if(r.address_type = 1	,r.Clean_address.geo_blk			,l.Clean_mailing_address.geo_blk);
		self.Clean_mailing_address.geo_match		:= if(r.address_type = 1	,r.Clean_address.geo_match		,l.Clean_mailing_address.geo_match);
		self.Clean_mailing_address.err_stat			:= if(r.address_type = 1	,r.Clean_address.err_stat			,l.Clean_mailing_address.err_stat);
		
		self.Append_LocRawAID										:= if(r.address_type = 2	,r.Append_RawAID							,l.Append_LocRawAID);
		self.Append_LocACEAID										:= if(r.address_type = 2	,r.Append_ACEAID							,l.Append_LocACEAID);
		self.Clean_location_address.prim_range	:= if(r.address_type = 2	,r.Clean_address.prim_range		,l.Clean_location_address.prim_range);
		self.Clean_location_address.predir			:= if(r.address_type = 2	,r.Clean_address.predir				,l.Clean_location_address.predir);
		self.Clean_location_address.prim_name		:= if(r.address_type = 2	,r.Clean_address.prim_name		,l.Clean_location_address.prim_name);
		self.Clean_location_address.addr_suffix	:= if(r.address_type = 2	,r.Clean_address.addr_suffix	,l.Clean_location_address.addr_suffix);
		self.Clean_location_address.postdir			:= if(r.address_type = 2	,r.Clean_address.postdir			,l.Clean_location_address.postdir);
		self.Clean_location_address.unit_desig	:= if(r.address_type = 2	,r.Clean_address.unit_desig		,l.Clean_location_address.unit_desig);
		self.Clean_location_address.sec_range		:= if(r.address_type = 2	,r.Clean_address.sec_range		,l.Clean_location_address.sec_range);
		self.Clean_location_address.p_city_name	:= if(r.address_type = 2	,r.Clean_address.p_city_name	,l.Clean_location_address.p_city_name);
		self.Clean_location_address.v_city_name	:= if(r.address_type = 2	,r.Clean_address.v_city_name	,l.Clean_location_address.v_city_name);
		self.Clean_location_address.st					:= if(r.address_type = 2	,r.Clean_address.st						,l.Clean_location_address.st);
		self.Clean_location_address.zip					:= if(r.address_type = 2	,r.Clean_address.zip					,l.Clean_location_address.zip);
		self.Clean_location_address.zip4				:= if(r.address_type = 2	,r.Clean_address.zip4					,l.Clean_location_address.zip4);		
		self.Clean_location_address.cart				:= if(r.address_type = 2	,r.Clean_address.cart					,l.Clean_location_address.cart);
		self.Clean_location_address.cr_sort_sz	:= if(r.address_type = 2	,r.Clean_address.cr_sort_sz		,l.Clean_location_address.cr_sort_sz);
		self.Clean_location_address.lot					:= if(r.address_type = 2	,r.Clean_address.lot					,l.Clean_location_address.lot);
		self.Clean_location_address.lot_order		:= if(r.address_type = 2	,r.Clean_address.lot_order		,l.Clean_location_address.lot_order);
		self.Clean_location_address.dbpc				:= if(r.address_type = 2	,r.Clean_address.dbpc					,l.Clean_location_address.dbpc);
		self.Clean_location_address.chk_digit		:= if(r.address_type = 2	,r.Clean_address.chk_digit		,l.Clean_location_address.chk_digit);
		self.Clean_location_address.rec_type		:= if(r.address_type = 2	,r.Clean_address.rec_type			,l.Clean_location_address.rec_type);
		self.Clean_location_address.fips_state	:= if(r.address_type = 2	,r.Clean_address.county[1..2]	,l.Clean_location_address.fips_state);
		self.Clean_location_address.fips_county	:= if(r.address_type = 2	,r.Clean_address.county[3..5]	,l.Clean_location_address.fips_county);
		self.Clean_location_address.geo_lat			:= if(r.address_type = 2	,r.Clean_address.geo_lat			,l.Clean_location_address.geo_lat);
		self.Clean_location_address.geo_long		:= if(r.address_type = 2	,r.Clean_address.geo_long			,l.Clean_location_address.geo_long);
		self.Clean_location_address.msa					:= if(r.address_type = 2	,r.Clean_address.msa					,l.Clean_location_address.msa);
		self.Clean_location_address.geo_blk			:= if(r.address_type = 2	,r.Clean_address.geo_blk			,l.Clean_location_address.geo_blk);
		self.Clean_location_address.geo_match		:= if(r.address_type = 2	,r.Clean_address.geo_match		,l.Clean_location_address.geo_match);
		self.Clean_location_address.err_stat		:= if(r.address_type = 2	,r.Clean_address.err_stat			,l.Clean_location_address.err_stat);
		
		self.Append_RARawAID										:= if(r.address_type = 3	,r.Append_RawAID							,l.Append_RARawAID);
		self.Append_RAACEAID										:= if(r.address_type = 3	,r.Append_ACEAID							,l.Append_RAACEAID);		
		self.Clean_ra_address.prim_range				:= if(r.address_type = 3	,r.Clean_address.prim_range		,l.Clean_ra_address.prim_range);
		self.Clean_ra_address.predir						:= if(r.address_type = 3	,r.Clean_address.predir				,l.Clean_ra_address.predir);
		self.Clean_ra_address.prim_name					:= if(r.address_type = 3	,r.Clean_address.prim_name		,l.Clean_ra_address.prim_name);
		self.Clean_ra_address.addr_suffix				:= if(r.address_type = 3	,r.Clean_address.addr_suffix	,l.Clean_ra_address.addr_suffix);
		self.Clean_ra_address.postdir						:= if(r.address_type = 3	,r.Clean_address.postdir			,l.Clean_ra_address.postdir);
		self.Clean_ra_address.unit_desig				:= if(r.address_type = 3	,r.Clean_address.unit_desig		,l.Clean_ra_address.unit_desig);
		self.Clean_ra_address.sec_range					:= if(r.address_type = 3	,r.Clean_address.sec_range		,l.Clean_ra_address.sec_range);
		self.Clean_ra_address.p_city_name				:= if(r.address_type = 3	,r.Clean_address.p_city_name	,l.Clean_ra_address.p_city_name);
		self.Clean_ra_address.v_city_name				:= if(r.address_type = 3	,r.Clean_address.v_city_name	,l.Clean_ra_address.v_city_name);
		self.Clean_ra_address.st								:= if(r.address_type = 3	,r.Clean_address.st						,l.Clean_ra_address.st);
		self.Clean_ra_address.zip								:= if(r.address_type = 3	,r.Clean_address.zip					,l.Clean_ra_address.zip);
		self.Clean_ra_address.zip4							:= if(r.address_type = 3	,r.Clean_address.zip4					,l.Clean_ra_address.zip4);		
		self.Clean_ra_address.cart							:= if(r.address_type = 3	,r.Clean_address.cart					,l.Clean_ra_address.cart);
		self.Clean_ra_address.cr_sort_sz				:= if(r.address_type = 3	,r.Clean_address.cr_sort_sz		,l.Clean_ra_address.cr_sort_sz);
		self.Clean_ra_address.lot								:= if(r.address_type = 3	,r.Clean_address.lot					,l.Clean_ra_address.lot);
		self.Clean_ra_address.lot_order					:= if(r.address_type = 3	,r.Clean_address.lot_order		,l.Clean_ra_address.lot_order);
		self.Clean_ra_address.dbpc							:= if(r.address_type = 3	,r.Clean_address.dbpc					,l.Clean_ra_address.dbpc);
		self.Clean_ra_address.chk_digit					:= if(r.address_type = 3	,r.Clean_address.chk_digit		,l.Clean_ra_address.chk_digit);
		self.Clean_ra_address.rec_type					:= if(r.address_type = 3	,r.Clean_address.rec_type			,l.Clean_ra_address.rec_type);
		self.Clean_ra_address.fips_state				:= if(r.address_type = 3	,r.Clean_address.county[1..2]	,l.Clean_ra_address.fips_state);
		self.Clean_ra_address.fips_county				:= if(r.address_type = 3	,r.Clean_address.county[3..5]	,l.Clean_ra_address.fips_county);
		self.Clean_ra_address.geo_lat						:= if(r.address_type = 3	,r.Clean_address.geo_lat			,l.Clean_ra_address.geo_lat);
		self.Clean_ra_address.geo_long					:= if(r.address_type = 3	,r.Clean_address.geo_long			,l.Clean_ra_address.geo_long);
		self.Clean_ra_address.msa								:= if(r.address_type = 3	,r.Clean_address.msa					,l.Clean_ra_address.msa);
		self.Clean_ra_address.geo_blk						:= if(r.address_type = 3	,r.Clean_address.geo_blk			,l.Clean_ra_address.geo_blk);
		self.Clean_ra_address.geo_match					:= if(r.address_type = 3	,r.Clean_address.geo_match		,l.Clean_ra_address.geo_match);
		self.Clean_ra_address.err_stat					:= if(r.address_type = 3	,r.Clean_address.err_stat			,l.Clean_ra_address.err_stat);
		
		self.Append_Off1RawAID									:= if(r.address_type = 4	,r.Append_RawAID							,l.Append_Off1RawAID);
		self.Append_Off1ACEAID									:= if(r.address_type = 4	,r.Append_ACEAID							,l.Append_Off1ACEAID);
		self.Clean_officer1_address.prim_range	:= if(r.address_type = 4	,r.Clean_address.prim_range		,l.Clean_officer1_address.prim_range);
		self.Clean_officer1_address.predir			:= if(r.address_type = 4	,r.Clean_address.predir				,l.Clean_officer1_address.predir);
		self.Clean_officer1_address.prim_name		:= if(r.address_type = 4	,r.Clean_address.prim_name		,l.Clean_officer1_address.prim_name);
		self.Clean_officer1_address.addr_suffix	:= if(r.address_type = 4	,r.Clean_address.addr_suffix	,l.Clean_officer1_address.addr_suffix);
		self.Clean_officer1_address.postdir			:= if(r.address_type = 4	,r.Clean_address.postdir			,l.Clean_officer1_address.postdir);
		self.Clean_officer1_address.unit_desig	:= if(r.address_type = 4	,r.Clean_address.unit_desig		,l.Clean_officer1_address.unit_desig);
		self.Clean_officer1_address.sec_range		:= if(r.address_type = 4	,r.Clean_address.sec_range		,l.Clean_officer1_address.sec_range);
		self.Clean_officer1_address.p_city_name	:= if(r.address_type = 4	,r.Clean_address.p_city_name	,l.Clean_officer1_address.p_city_name);
		self.Clean_officer1_address.v_city_name	:= if(r.address_type = 4	,r.Clean_address.v_city_name	,l.Clean_officer1_address.v_city_name);
		self.Clean_officer1_address.st					:= if(r.address_type = 4	,r.Clean_address.st						,l.Clean_officer1_address.st);
		self.Clean_officer1_address.zip					:= if(r.address_type = 4	,r.Clean_address.zip					,l.Clean_officer1_address.zip);
		self.Clean_officer1_address.zip4				:= if(r.address_type = 4	,r.Clean_address.zip4					,l.Clean_officer1_address.zip4);		
		self.Clean_officer1_address.cart				:= if(r.address_type = 4	,r.Clean_address.cart					,l.Clean_officer1_address.cart);
		self.Clean_officer1_address.cr_sort_sz	:= if(r.address_type = 4	,r.Clean_address.cr_sort_sz		,l.Clean_officer1_address.cr_sort_sz);
		self.Clean_officer1_address.lot					:= if(r.address_type = 4	,r.Clean_address.lot					,l.Clean_officer1_address.lot);
		self.Clean_officer1_address.lot_order		:= if(r.address_type = 4	,r.Clean_address.lot_order		,l.Clean_officer1_address.lot_order);
		self.Clean_officer1_address.dbpc				:= if(r.address_type = 4	,r.Clean_address.dbpc					,l.Clean_officer1_address.dbpc);
		self.Clean_officer1_address.chk_digit		:= if(r.address_type = 4	,r.Clean_address.chk_digit		,l.Clean_officer1_address.chk_digit);
		self.Clean_officer1_address.rec_type		:= if(r.address_type = 4	,r.Clean_address.rec_type			,l.Clean_officer1_address.rec_type);
		self.Clean_officer1_address.fips_state	:= if(r.address_type = 4	,r.Clean_address.county[1..2]	,l.Clean_officer1_address.fips_state);
		self.Clean_officer1_address.fips_county	:= if(r.address_type = 4	,r.Clean_address.county[3..5]	,l.Clean_officer1_address.fips_county);
		self.Clean_officer1_address.geo_lat			:= if(r.address_type = 4	,r.Clean_address.geo_lat			,l.Clean_officer1_address.geo_lat);
		self.Clean_officer1_address.geo_long		:= if(r.address_type = 4	,r.Clean_address.geo_long			,l.Clean_officer1_address.geo_long);
		self.Clean_officer1_address.msa					:= if(r.address_type = 4	,r.Clean_address.msa					,l.Clean_officer1_address.msa);
		self.Clean_officer1_address.geo_blk			:= if(r.address_type = 4	,r.Clean_address.geo_blk			,l.Clean_officer1_address.geo_blk);
		self.Clean_officer1_address.geo_match		:= if(r.address_type = 4	,r.Clean_address.geo_match		,l.Clean_officer1_address.geo_match);
		self.Clean_officer1_address.err_stat		:= if(r.address_type = 4	,r.Clean_address.err_stat			,l.Clean_officer1_address.err_stat);
		
		self.Append_Off2RawAID									:= if(r.address_type = 5	,r.Append_RawAID							,l.Append_Off2RawAID);
		self.Append_Off2ACEAID									:= if(r.address_type = 5	,r.Append_ACEAID							,l.Append_Off2ACEAID);		
		self.Clean_officer2_address.prim_range	:= if(r.address_type = 5	,r.Clean_address.prim_range		,l.Clean_officer2_address.prim_range);
		self.Clean_officer2_address.predir			:= if(r.address_type = 5	,r.Clean_address.predir				,l.Clean_officer2_address.predir);
		self.Clean_officer2_address.prim_name		:= if(r.address_type = 5	,r.Clean_address.prim_name		,l.Clean_officer2_address.prim_name);
		self.Clean_officer2_address.addr_suffix	:= if(r.address_type = 5	,r.Clean_address.addr_suffix	,l.Clean_officer2_address.addr_suffix);
		self.Clean_officer2_address.postdir			:= if(r.address_type = 5	,r.Clean_address.postdir			,l.Clean_officer2_address.postdir);
		self.Clean_officer2_address.unit_desig	:= if(r.address_type = 5	,r.Clean_address.unit_desig		,l.Clean_officer2_address.unit_desig);
		self.Clean_officer2_address.sec_range		:= if(r.address_type = 5	,r.Clean_address.sec_range		,l.Clean_officer2_address.sec_range);
		self.Clean_officer2_address.p_city_name	:= if(r.address_type = 5	,r.Clean_address.p_city_name	,l.Clean_officer2_address.p_city_name);
		self.Clean_officer2_address.v_city_name	:= if(r.address_type = 5	,r.Clean_address.v_city_name	,l.Clean_officer2_address.v_city_name);
		self.Clean_officer2_address.st					:= if(r.address_type = 5	,r.Clean_address.st						,l.Clean_officer2_address.st);
		self.Clean_officer2_address.zip					:= if(r.address_type = 5	,r.Clean_address.zip					,l.Clean_officer2_address.zip);
		self.Clean_officer2_address.zip4				:= if(r.address_type = 5	,r.Clean_address.zip4					,l.Clean_officer2_address.zip4);		
		self.Clean_officer2_address.cart				:= if(r.address_type = 5	,r.Clean_address.cart					,l.Clean_officer2_address.cart);
		self.Clean_officer2_address.cr_sort_sz	:= if(r.address_type = 5	,r.Clean_address.cr_sort_sz		,l.Clean_officer2_address.cr_sort_sz);
		self.Clean_officer2_address.lot					:= if(r.address_type = 5	,r.Clean_address.lot					,l.Clean_officer2_address.lot);
		self.Clean_officer2_address.lot_order		:= if(r.address_type = 5	,r.Clean_address.lot_order		,l.Clean_officer2_address.lot_order);
		self.Clean_officer2_address.dbpc				:= if(r.address_type = 5	,r.Clean_address.dbpc					,l.Clean_officer2_address.dbpc);
		self.Clean_officer2_address.chk_digit		:= if(r.address_type = 5	,r.Clean_address.chk_digit		,l.Clean_officer2_address.chk_digit);
		self.Clean_officer2_address.rec_type		:= if(r.address_type = 5	,r.Clean_address.rec_type			,l.Clean_officer2_address.rec_type);
		self.Clean_officer2_address.fips_state	:= if(r.address_type = 5	,r.Clean_address.county[1..2]	,l.Clean_officer2_address.fips_state);
		self.Clean_officer2_address.fips_county	:= if(r.address_type = 5	,r.Clean_address.county[3..5]	,l.Clean_officer2_address.fips_county);
		self.Clean_officer2_address.geo_lat			:= if(r.address_type = 5	,r.Clean_address.geo_lat			,l.Clean_officer2_address.geo_lat);
		self.Clean_officer2_address.geo_long		:= if(r.address_type = 5	,r.Clean_address.geo_long			,l.Clean_officer2_address.geo_long);
		self.Clean_officer2_address.msa					:= if(r.address_type = 5	,r.Clean_address.msa					,l.Clean_officer2_address.msa);
		self.Clean_officer2_address.geo_blk			:= if(r.address_type = 5	,r.Clean_address.geo_blk			,l.Clean_officer2_address.geo_blk);
		self.Clean_officer2_address.geo_match		:= if(r.address_type = 5	,r.Clean_address.geo_match		,l.Clean_officer2_address.geo_match);
		self.Clean_officer2_address.err_stat		:= if(r.address_type = 5	,r.Clean_address.err_stat			,l.Clean_officer2_address.err_stat);
		
		self.Append_Off3RawAID									:= if(r.address_type = 6	,r.Append_RawAID							,l.Append_Off3RawAID);
		self.Append_Off3ACEAID									:= if(r.address_type = 6	,r.Append_ACEAID							,l.Append_Off3ACEAID);		
		self.Clean_officer3_address.prim_range	:= if(r.address_type = 6	,r.Clean_address.prim_range		,l.Clean_officer3_address.prim_range);
		self.Clean_officer3_address.predir			:= if(r.address_type = 6	,r.Clean_address.predir				,l.Clean_officer3_address.predir);
		self.Clean_officer3_address.prim_name		:= if(r.address_type = 6	,r.Clean_address.prim_name		,l.Clean_officer3_address.prim_name);
		self.Clean_officer3_address.addr_suffix	:= if(r.address_type = 6	,r.Clean_address.addr_suffix	,l.Clean_officer3_address.addr_suffix);
		self.Clean_officer3_address.postdir			:= if(r.address_type = 6	,r.Clean_address.postdir			,l.Clean_officer3_address.postdir);
		self.Clean_officer3_address.unit_desig	:= if(r.address_type = 6	,r.Clean_address.unit_desig		,l.Clean_officer3_address.unit_desig);
		self.Clean_officer3_address.sec_range		:= if(r.address_type = 6	,r.Clean_address.sec_range		,l.Clean_officer3_address.sec_range);
		self.Clean_officer3_address.p_city_name	:= if(r.address_type = 6	,r.Clean_address.p_city_name	,l.Clean_officer3_address.p_city_name);
		self.Clean_officer3_address.v_city_name	:= if(r.address_type = 6	,r.Clean_address.v_city_name	,l.Clean_officer3_address.v_city_name);
		self.Clean_officer3_address.st					:= if(r.address_type = 6	,r.Clean_address.st						,l.Clean_officer3_address.st);
		self.Clean_officer3_address.zip					:= if(r.address_type = 6	,r.Clean_address.zip					,l.Clean_officer3_address.zip);
		self.Clean_officer3_address.zip4				:= if(r.address_type = 6	,r.Clean_address.zip4					,l.Clean_officer3_address.zip4);		
		self.Clean_officer3_address.cart				:= if(r.address_type = 6	,r.Clean_address.cart					,l.Clean_officer3_address.cart);
		self.Clean_officer3_address.cr_sort_sz	:= if(r.address_type = 6	,r.Clean_address.cr_sort_sz		,l.Clean_officer3_address.cr_sort_sz);
		self.Clean_officer3_address.lot					:= if(r.address_type = 6	,r.Clean_address.lot					,l.Clean_officer3_address.lot);
		self.Clean_officer3_address.lot_order		:= if(r.address_type = 6	,r.Clean_address.lot_order		,l.Clean_officer3_address.lot_order);
		self.Clean_officer3_address.dbpc				:= if(r.address_type = 6	,r.Clean_address.dbpc					,l.Clean_officer3_address.dbpc);
		self.Clean_officer3_address.chk_digit		:= if(r.address_type = 6	,r.Clean_address.chk_digit		,l.Clean_officer3_address.chk_digit);
		self.Clean_officer3_address.rec_type		:= if(r.address_type = 6	,r.Clean_address.rec_type			,l.Clean_officer3_address.rec_type);
		self.Clean_officer3_address.fips_state	:= if(r.address_type = 6	,r.Clean_address.county[1..2]	,l.Clean_officer3_address.fips_state);
		self.Clean_officer3_address.fips_county	:= if(r.address_type = 6	,r.Clean_address.county[3..5]	,l.Clean_officer3_address.fips_county);
		self.Clean_officer3_address.geo_lat			:= if(r.address_type = 6	,r.Clean_address.geo_lat			,l.Clean_officer3_address.geo_lat);
		self.Clean_officer3_address.geo_long		:= if(r.address_type = 6	,r.Clean_address.geo_long			,l.Clean_officer3_address.geo_long);
		self.Clean_officer3_address.msa					:= if(r.address_type = 6	,r.Clean_address.msa					,l.Clean_officer3_address.msa);
		self.Clean_officer3_address.geo_blk			:= if(r.address_type = 6	,r.Clean_address.geo_blk			,l.Clean_officer3_address.geo_blk);
		self.Clean_officer3_address.geo_match		:= if(r.address_type = 6	,r.Clean_address.geo_match		,l.Clean_officer3_address.geo_match);
		self.Clean_officer3_address.err_stat		:= if(r.address_type = 6	,r.Clean_address.err_stat			,l.Clean_officer3_address.err_stat);
		
		self.Append_Off4RawAID									:= if(r.address_type = 7	,r.Append_RawAID							,l.Append_Off4RawAID);
		self.Append_Off4ACEAID									:= if(r.address_type = 7	,r.Append_ACEAID							,l.Append_Off4ACEAID);		
		self.Clean_officer4_address.prim_range	:= if(r.address_type = 7	,r.Clean_address.prim_range		,l.Clean_officer4_address.prim_range);
		self.Clean_officer4_address.predir			:= if(r.address_type = 7	,r.Clean_address.predir				,l.Clean_officer4_address.predir);
		self.Clean_officer4_address.prim_name		:= if(r.address_type = 7	,r.Clean_address.prim_name		,l.Clean_officer4_address.prim_name);
		self.Clean_officer4_address.addr_suffix	:= if(r.address_type = 7	,r.Clean_address.addr_suffix	,l.Clean_officer4_address.addr_suffix);
		self.Clean_officer4_address.postdir			:= if(r.address_type = 7	,r.Clean_address.postdir			,l.Clean_officer4_address.postdir);
		self.Clean_officer4_address.unit_desig	:= if(r.address_type = 7	,r.Clean_address.unit_desig		,l.Clean_officer4_address.unit_desig);
		self.Clean_officer4_address.sec_range		:= if(r.address_type = 7	,r.Clean_address.sec_range		,l.Clean_officer4_address.sec_range);
		self.Clean_officer4_address.p_city_name	:= if(r.address_type = 7	,r.Clean_address.p_city_name	,l.Clean_officer4_address.p_city_name);
		self.Clean_officer4_address.v_city_name	:= if(r.address_type = 7	,r.Clean_address.v_city_name	,l.Clean_officer4_address.v_city_name);
		self.Clean_officer4_address.st					:= if(r.address_type = 7	,r.Clean_address.st						,l.Clean_officer4_address.st);
		self.Clean_officer4_address.zip					:= if(r.address_type = 7	,r.Clean_address.zip					,l.Clean_officer4_address.zip);
		self.Clean_officer4_address.zip4				:= if(r.address_type = 7	,r.Clean_address.zip4					,l.Clean_officer4_address.zip4);		
		self.Clean_officer4_address.cart				:= if(r.address_type = 7	,r.Clean_address.cart					,l.Clean_officer4_address.cart);
		self.Clean_officer4_address.cr_sort_sz	:= if(r.address_type = 7	,r.Clean_address.cr_sort_sz		,l.Clean_officer4_address.cr_sort_sz);
		self.Clean_officer4_address.lot					:= if(r.address_type = 7	,r.Clean_address.lot					,l.Clean_officer4_address.lot);
		self.Clean_officer4_address.lot_order		:= if(r.address_type = 7	,r.Clean_address.lot_order		,l.Clean_officer4_address.lot_order);
		self.Clean_officer4_address.dbpc				:= if(r.address_type = 7	,r.Clean_address.dbpc					,l.Clean_officer4_address.dbpc);
		self.Clean_officer4_address.chk_digit		:= if(r.address_type = 7	,r.Clean_address.chk_digit		,l.Clean_officer4_address.chk_digit);
		self.Clean_officer4_address.rec_type		:= if(r.address_type = 7	,r.Clean_address.rec_type			,l.Clean_officer4_address.rec_type);
		self.Clean_officer4_address.fips_state	:= if(r.address_type = 7	,r.Clean_address.county[1..2]	,l.Clean_officer4_address.fips_state);
		self.Clean_officer4_address.fips_county	:= if(r.address_type = 7	,r.Clean_address.county[3..5]	,l.Clean_officer4_address.fips_county);
		self.Clean_officer4_address.geo_lat			:= if(r.address_type = 7	,r.Clean_address.geo_lat			,l.Clean_officer4_address.geo_lat);
		self.Clean_officer4_address.geo_long		:= if(r.address_type = 7	,r.Clean_address.geo_long			,l.Clean_officer4_address.geo_long);
		self.Clean_officer4_address.msa					:= if(r.address_type = 7	,r.Clean_address.msa					,l.Clean_officer4_address.msa);
		self.Clean_officer4_address.geo_blk			:= if(r.address_type = 7	,r.Clean_address.geo_blk			,l.Clean_officer4_address.geo_blk);
		self.Clean_officer4_address.geo_match		:= if(r.address_type = 7	,r.Clean_address.geo_match		,l.Clean_officer4_address.geo_match);
		self.Clean_officer4_address.err_stat		:= if(r.address_type = 7	,r.Clean_address.err_stat			,l.Clean_officer4_address.err_stat);
		
		self.Append_Off5RawAID									:= if(r.address_type = 8	,r.Append_RawAID							,l.Append_Off5RawAID);
		self.Append_Off5ACEAID									:= if(r.address_type = 8	,r.Append_ACEAID							,l.Append_Off5ACEAID);		
		self.Clean_officer5_address.prim_range	:= if(r.address_type = 8	,r.Clean_address.prim_range		,l.Clean_officer5_address.prim_range);
		self.Clean_officer5_address.predir			:= if(r.address_type = 8	,r.Clean_address.predir				,l.Clean_officer5_address.predir);
		self.Clean_officer5_address.prim_name		:= if(r.address_type = 8	,r.Clean_address.prim_name		,l.Clean_officer5_address.prim_name);
		self.Clean_officer5_address.addr_suffix	:= if(r.address_type = 8	,r.Clean_address.addr_suffix	,l.Clean_officer5_address.addr_suffix);
		self.Clean_officer5_address.postdir			:= if(r.address_type = 8	,r.Clean_address.postdir			,l.Clean_officer5_address.postdir);
		self.Clean_officer5_address.unit_desig	:= if(r.address_type = 8	,r.Clean_address.unit_desig		,l.Clean_officer5_address.unit_desig);
		self.Clean_officer5_address.sec_range		:= if(r.address_type = 8	,r.Clean_address.sec_range		,l.Clean_officer5_address.sec_range);
		self.Clean_officer5_address.p_city_name	:= if(r.address_type = 8	,r.Clean_address.p_city_name	,l.Clean_officer5_address.p_city_name);
		self.Clean_officer5_address.v_city_name	:= if(r.address_type = 8	,r.Clean_address.v_city_name	,l.Clean_officer5_address.v_city_name);
		self.Clean_officer5_address.st					:= if(r.address_type = 8	,r.Clean_address.st						,l.Clean_officer5_address.st);
		self.Clean_officer5_address.zip					:= if(r.address_type = 8	,r.Clean_address.zip					,l.Clean_officer5_address.zip);
		self.Clean_officer5_address.zip4				:= if(r.address_type = 8	,r.Clean_address.zip4					,l.Clean_officer5_address.zip4);		
		self.Clean_officer5_address.cart				:= if(r.address_type = 8	,r.Clean_address.cart					,l.Clean_officer5_address.cart);
		self.Clean_officer5_address.cr_sort_sz	:= if(r.address_type = 8	,r.Clean_address.cr_sort_sz		,l.Clean_officer5_address.cr_sort_sz);
		self.Clean_officer5_address.lot					:= if(r.address_type = 8	,r.Clean_address.lot					,l.Clean_officer5_address.lot);
		self.Clean_officer5_address.lot_order		:= if(r.address_type = 8	,r.Clean_address.lot_order		,l.Clean_officer5_address.lot_order);
		self.Clean_officer5_address.dbpc				:= if(r.address_type = 8	,r.Clean_address.dbpc					,l.Clean_officer5_address.dbpc);
		self.Clean_officer5_address.chk_digit		:= if(r.address_type = 8	,r.Clean_address.chk_digit		,l.Clean_officer5_address.chk_digit);
		self.Clean_officer5_address.rec_type		:= if(r.address_type = 8	,r.Clean_address.rec_type			,l.Clean_officer5_address.rec_type);
		self.Clean_officer5_address.fips_state	:= if(r.address_type = 8	,r.Clean_address.county[1..2]	,l.Clean_officer5_address.fips_state);
		self.Clean_officer5_address.fips_county	:= if(r.address_type = 8	,r.Clean_address.county[3..5]	,l.Clean_officer5_address.fips_county);
		self.Clean_officer5_address.geo_lat			:= if(r.address_type = 8	,r.Clean_address.geo_lat			,l.Clean_officer5_address.geo_lat);
		self.Clean_officer5_address.geo_long		:= if(r.address_type = 8	,r.Clean_address.geo_long			,l.Clean_officer5_address.geo_long);
		self.Clean_officer5_address.msa					:= if(r.address_type = 8	,r.Clean_address.msa					,l.Clean_officer5_address.msa);
		self.Clean_officer5_address.geo_blk			:= if(r.address_type = 8	,r.Clean_address.geo_blk			,l.Clean_officer5_address.geo_blk);
		self.Clean_officer5_address.geo_match		:= if(r.address_type = 8	,r.Clean_address.geo_match		,l.Clean_officer5_address.geo_match);
		self.Clean_officer5_address.err_stat		:= if(r.address_type = 8	,r.Clean_address.err_stat			,l.Clean_officer5_address.err_stat);
		
		
		self.Append_Off6RawAID									:= if(r.address_type = 9	,r.Append_RawAID							,l.Append_Off6RawAID);	
		self.Append_Off6ACEAID									:= if(r.address_type = 9	,r.Append_ACEAID							,l.Append_Off6ACEAID);	
		self.Clean_officer6_address.prim_range	:= if(r.address_type = 9	,r.Clean_address.prim_range		,l.Clean_officer6_address.prim_range);
		self.Clean_officer6_address.predir			:= if(r.address_type = 9	,r.Clean_address.predir				,l.Clean_officer6_address.predir);
		self.Clean_officer6_address.prim_name		:= if(r.address_type = 9	,r.Clean_address.prim_name		,l.Clean_officer6_address.prim_name);
		self.Clean_officer6_address.addr_suffix	:= if(r.address_type = 9	,r.Clean_address.addr_suffix	,l.Clean_officer6_address.addr_suffix);
		self.Clean_officer6_address.postdir			:= if(r.address_type = 9	,r.Clean_address.postdir			,l.Clean_officer6_address.postdir);
		self.Clean_officer6_address.unit_desig	:= if(r.address_type = 9	,r.Clean_address.unit_desig		,l.Clean_officer6_address.unit_desig);
		self.Clean_officer6_address.sec_range		:= if(r.address_type = 9	,r.Clean_address.sec_range		,l.Clean_officer6_address.sec_range);
		self.Clean_officer6_address.p_city_name	:= if(r.address_type = 9	,r.Clean_address.p_city_name	,l.Clean_officer6_address.p_city_name);
		self.Clean_officer6_address.v_city_name	:= if(r.address_type = 9	,r.Clean_address.v_city_name	,l.Clean_officer6_address.v_city_name);
		self.Clean_officer6_address.st					:= if(r.address_type = 9	,r.Clean_address.st						,l.Clean_officer6_address.st);
		self.Clean_officer6_address.zip					:= if(r.address_type = 9	,r.Clean_address.zip					,l.Clean_officer6_address.zip);
		self.Clean_officer6_address.zip4				:= if(r.address_type = 9	,r.Clean_address.zip4					,l.Clean_officer6_address.zip4);		
		self.Clean_officer6_address.cart				:= if(r.address_type = 9	,r.Clean_address.cart					,l.Clean_officer6_address.cart);
		self.Clean_officer6_address.cr_sort_sz	:= if(r.address_type = 9	,r.Clean_address.cr_sort_sz		,l.Clean_officer6_address.cr_sort_sz);
		self.Clean_officer6_address.lot					:= if(r.address_type = 9	,r.Clean_address.lot					,l.Clean_officer6_address.lot);
		self.Clean_officer6_address.lot_order		:= if(r.address_type = 9	,r.Clean_address.lot_order		,l.Clean_officer6_address.lot_order);
		self.Clean_officer6_address.dbpc				:= if(r.address_type = 9	,r.Clean_address.dbpc					,l.Clean_officer6_address.dbpc);
		self.Clean_officer6_address.chk_digit		:= if(r.address_type = 9	,r.Clean_address.chk_digit		,l.Clean_officer6_address.chk_digit);
		self.Clean_officer6_address.rec_type		:= if(r.address_type = 9	,r.Clean_address.rec_type			,l.Clean_officer6_address.rec_type);
		self.Clean_officer6_address.fips_state	:= if(r.address_type = 9	,r.Clean_address.county[1..2]	,l.Clean_officer6_address.fips_state);
		self.Clean_officer6_address.fips_county	:= if(r.address_type = 9	,r.Clean_address.county[3..5]	,l.Clean_officer6_address.fips_county);
		self.Clean_officer6_address.geo_lat			:= if(r.address_type = 9	,r.Clean_address.geo_lat			,l.Clean_officer6_address.geo_lat);
		self.Clean_officer6_address.geo_long		:= if(r.address_type = 9	,r.Clean_address.geo_long			,l.Clean_officer6_address.geo_long);
		self.Clean_officer6_address.msa					:= if(r.address_type = 9	,r.Clean_address.msa					,l.Clean_officer6_address.msa);
		self.Clean_officer6_address.geo_blk			:= if(r.address_type = 9	,r.Clean_address.geo_blk			,l.Clean_officer6_address.geo_blk);
		self.Clean_officer6_address.geo_match		:= if(r.address_type = 9	,r.Clean_address.geo_match		,l.Clean_officer6_address.geo_match);
		self.Clean_officer6_address.err_stat		:= if(r.address_type = 9	,r.Clean_address.err_stat			,l.Clean_officer6_address.err_stat);
		self 																		:= l;
		self																		:= [];
	end;
				
	dCleanMailingAddressAppended	:= join(
																				dStandardizeNameInput_dist
																				,dCleancontactAddressAppended_dist(address_type = 1)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
		
	dCleanLocationAddressAppended	:= join(
																				dCleanMailingAddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 2)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanRAAddressAppended				:= join(
																				dCleanLocationAddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 3)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);																				
																				
	dCleanOfficer1AddressAppended	:= join(
																				dCleanRAAddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 4)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanOfficer2AddressAppended	:= join(
																				dCleanOfficer1AddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 5)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanOfficer3AddressAppended	:= join(
																				dCleanOfficer2AddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 6)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanOfficer4AddressAppended	:= join(
																				dCleanOfficer3AddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 7)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanOfficer5AddressAppended	:= join(
																				dCleanOfficer4AddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 8)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																				
	dCleanOfficer6AddressAppended	:= join(
																				dCleanOfficer5AddressAppended
																				,dCleancontactAddressAppended_dist(address_type = 9)
																				,left.unique_id = right.unique_id
																				,tGetStandardizedAddress(left,right)
																				,local
																				,left outer
																				);
																	
	dAppendIds							:= Append_Ids.fAppendBdid	(dCleanOfficer6AddressAppended);
	dRollup									:= Rollup_Base						(dAppendIds);

	return dRollup;

end;