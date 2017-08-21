EXPORT MAC_CtryCodeOwnAssess(inFile, outFile):= macro

import LN_propertyV2, ut;

	#uniquename(inData)
	%inData% := inFile;
	
	dslayout := RECORD
		%inData%;
		string fix_mailing_street;
		string fix_mailing_csz;
		string derived_mailing_country;
	END;	
	
	dslayout tranFile(%inData% l):= transform
		self.fix_mailing_street 				:= '';
		self.fix_mailing_csz						:= '';
		self.derived_mailing_country		:= '';
		self := l;
	end;

	#uniquename(ds)
	%ds% := project(%inData%, tranFile(left), local);
	
	//Fix Parsing Issue///////////////////////////////////////////////////////////////////////////////////////////////////////
	
	dslayout semiTran(%ds% l):= transform
		self.fix_mailing_street 	 := if(regexfind(';', l.mailing_full_street_address, 0)<>'' and trim(l.mailing_city_state_zip, left, right)='',
																						l.mailing_full_street_address[1..stringlib.stringfind(l.mailing_full_street_address, ';', 1)-1],
																						l.mailing_full_street_address);
		self.fix_mailing_csz			 := if(regexfind(';', l.mailing_full_street_address, 0)<>'' and trim(l.mailing_city_state_zip, left, right)='',
																						l.mailing_full_street_address[stringlib.stringfind(l.mailing_full_street_address, ';', 1)+1..],
																						l.mailing_city_state_zip);
		self := l;
	end;

	#uniquename(ds_semi)
	%ds_semi% := project(%ds%, semiTran(left));

//Fix Space Issue/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Filter records
	#uniquename(ds_no_com)
	#uniquename(ds_com)
	%ds_no_com% := %ds_semi%(regexfind(',', fix_mailing_street, 0)='');
	%ds_com%		:= %ds_semi%(regexfind(',', fix_mailing_street, 0)<>'');

	//Number of commas
	dslayout zipRec(%ds_com% l):= transform
		
			uppCs := StringLib.StringToUpperCase(l.fix_mailing_csz);//trim(stringlib.stringfilter(StringLib.StringToUpperCase(l.mailing_city_state_zip), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
			remSp	:= regexreplace('  ', uppCs, ' ');
			remCm	:= if(regexfind(','+'[A-Z]+'+'[A-Z]+'+',', remSp, 0)<>'',
										regexreplace(',', remSp[1..stringlib.stringfind(remSp, ',', 2)-1], ', '),
									if(regexfind(','+'[A-Z]+'+'[A-Z]+', remSp, 0)<>'',
										regexreplace(',', remSp, ', '),
										remSp));
		
		self.mailing_city_state_zip := remCm;
		self := l;
	end;
	
	#uniquename(ds_comma)
	#uniquename(ds_fix)
	%ds_comma% 	:= project(%ds_com%, zipRec(left));
	%ds_fix%		:= %ds_comma% + %ds_no_com%;

//Find US Addresses & US Territories w/ Address Cleaner/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	cleanAddressLayout := record
		string100				Append_PrepAddr1;
		string50				Append_PrepAddr2;
		unsigned8				Append_RawAID;
		string10				prim_range		:= '';
		string2					predir				:= '';
		string28				prim_name			:= '';
		string4					suffix				:= '';
		string2					postdir				:= '';
		string10				unit_desig		:= '';
		string8					sec_range			:= '';
		string25				p_city_name		:= '';
		string25				v_city_name		:= '';
		string2					st						:= '';
		string5					zip						:= '';
		string4					zip4					:= '';
		string4					cart					:= '';
		string1					cr_sort_sz		:= '';
		string4					lot						:= '';
		string1					lot_order			:= '';
		string2					dbpc					:= '';
		string1					chk_digit			:= '';
		string2					rec_type			:= '';
		string5					county				:= '';
		string10				geo_lat				:= '';
		string11				geo_long			:= '';
		string4					msa						:= '';
		string7					geo_blk				:= '';
		string1					geo_match			:= '';
		string4					err_stat			:= '';
		string					source_code		:= '';
	end;

	dslayout2	:= record
		dslayout;
		cleanAddressLayout;
	end;
	
	dslayout2 cleanAddrTr(%ds_fix% pInput) := transform
	
			Append_PrepPropertyAddr1	:= ut.CleanSpacesAndUpper(pInput.fix_mailing_street);
			Append_PrepPropertyAddr2	:= regexreplace('([0]{5}|[,])$', ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(pInput.fix_mailing_csz)), '');

		self.Append_PrepAddr1			:=	Append_PrepPropertyAddr1;
		self.Append_PrepAddr2			:=	Append_PrepPropertyAddr2;
		self.Append_RawAID				:=  0;
		//self.source_code					:=	'O';
		self											:=	pInput;
		
	end;
	
	#uniquename(dsAddr)
	%dsAddr%	:=	project(%ds_fix%, cleanAddrTr(left));
	
	dslayout2	tPrepAddr(%dsAddr% pInput)	:= transform
		self.Append_PrepAddr2	:= if(pInput.Append_PrepAddr1	!=	'' and	pInput.Append_PrepAddr2	=	'',
																	'UNKNOWN 12345',
																	pInput.Append_PrepAddr2);
		self									:= pInput;
	end;
	
	#uniquename(dPrepAddr)
	%dPrepAddr%	:=	project(%dsAddr%,tPrepAddr(left));
	
	#uniquename(dPrepCleanAddr)
	LN_PropertyV2_Fast.Function_Foreign_Countries.Append_AID(%dPrepAddr%, %dPrepCleanAddr%);

	//Flag Confirmed US/US Territory Addresses
	#uniquename(confirmAd)
	#uniquename(notConfirmAdd)
	%confirmAd% 		:= %dPrepCleanAddr%(err_stat[1]='S');	
	%notConfirmAdd%	:= %dPrepCleanAddr%(err_stat[1] in ['','E']);
	
	%dPrepCleanAddr% findCntry(%confirmAd% l):= transform
		self.derived_mailing_country :=  if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(l.st),
																				'UNITED_STATES',
																			if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(l.st)<>'',
																				LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(l.st),
																				''));
		self := l;
	end;

	#uniquename(ds_confirmAdd)
	%ds_confirmAdd% 	:= project(%confirmAd%, findCntry(left));
	
	#uniquename(ds_all)
	%ds_all%					:= %notConfirmAdd%;

//Flag Foreign Records////////////////////////////////////////////////////////////////////////////////////////////////

	//XX OKC
	#uniquename(ds_okc_xx)
	%ds_okc_xx% 	:= %ds_all%(regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O');

	dslayout2 xxFlag(%ds_okc_xx% l):= transform
		self.derived_mailing_country := if(trim(l.fix_mailing_csz, left, right)='XX',
																			LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_street, left, right)),
																		if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right))<>'',
																			LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																			''));
		self := l;
	end;
	
	#uniquename(ds_okc_xx_flag)
	%ds_okc_xx_flag% := project(%ds_okc_xx%, xxFlag(left));

	//Comma	in CSZ
	#uniquename(ds_comm_csz1)
	%ds_comm_csz1% := %ds_all%(regexfind(',', fix_mailing_csz, 0)<>'' and not (regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O'));
	
	dslayout2 cszFind(%ds_comm_csz1% l):= transform
		ctry := trim(stringlib.stringfilter(l.fix_mailing_csz[stringlib.stringfind(l.fix_mailing_csz, ',', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
	
		self.derived_mailing_country	:= if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(ctry) and ctry<>'CA',
																				'UNITED_STATES',
																			if(ctry='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'',
																				'UNITED_STATES',	
																			if(ctry='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.fix_mailing_csz, left, right), 0)<>'',
																				'CANADA',
																			if(ctry='CA' and l.err_stat[1]='E',
																					'UNITED_STATES',
																			if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(ctry)=false and LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(ctry)<>'',
																				LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(trim(stringlib.stringfilter(l.fix_mailing_csz[stringlib.stringfind(l.fix_mailing_csz, ',', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right)),
																				'')))));
		self 													:= l;
	end;

	#uniquename(ds_comma_csz2)
	%ds_comma_csz2% := project(%ds_comm_csz1%, cszFind(left));

	dslayout2 cszFind2(%ds_comma_csz2% l):= transform
		self.derived_mailing_country	:= if(trim(l.derived_mailing_country, left, right)='',
																				LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																				l.derived_mailing_country);
		self 													:= l;
	end;
	
	#uniquename(ds_comma_csz)
	%ds_comma_csz% := project(%ds_comma_csz2%, cszFind2(left));

	//No Comma in CSZ
	#uniquename(ds_no_comm_csz)	
	%ds_no_comm_csz% := %ds_all%(trim(fix_mailing_csz, left, right)<>'' and regexfind(',', fix_mailing_csz, 0)='' and not (regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O'));
	
	dslayout2 fixCSZ(%ds_no_comm_csz% l):= transform
		filter := trim(stringlib.stringfilter(l.fix_mailing_csz, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
	
		self.derived_mailing_country := if(regexfind('[0-9][0-9][0-9][0-9][0-9]+'+' '+'[0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 3)<>0,
																				trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 3)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),
																			if(regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 2)<>0,
																				trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 2)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),
																			if(regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)<>0,
																				filter,	
																			if(stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)<>0,
																				trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),	
																				filter))));
		self := l;
	end;

	#uniquename(ds_o)
	%ds_o% := project(%ds_no_comm_csz%, fixCSZ(left));
	
	//Find Countries
	dslayout2 fixCountry(%ds_o% l):= transform
		self.derived_mailing_country := if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.derived_mailing_country, left, right)) and trim(l.derived_mailing_country, left, right)<>'CA',
																				'UNITED_STATES',
																			if(trim(l.derived_mailing_country, left, right)='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'',
																				'UNITED_STATES',	
																			if(trim(l.derived_mailing_country, left, right)='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.fix_mailing_csz, left, right), 0)<>'',
																				'CANADA',
																			if(trim(l.derived_mailing_country, left, right)='CA' and l.err_stat[1]='E',
																				'UNITED_STATES',
																			if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right))<>'',
																				LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																				'')))));
		self := l;
	end;

	#uniquename(ds_no_comma_csz)
	%ds_no_comma_csz% := project(%ds_o%, fixCountry(left));

	//No CSZ
	#uniquename(no_csz)
	%no_csz% := %ds_all%(trim(fix_mailing_csz, left, right)='');

	dslayout2 findCountryFull(%no_csz% l):= transform
		self.derived_mailing_country := if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.fix_mailing_street, left, right)) and trim(l.fix_mailing_street, left, right)<>'CA',
																				'UNITED_STATES',
																			if(trim(l.fix_mailing_street, left, right)='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_street, left, right), 0)<>'',
																				'UNITED_STATES',
																			if(trim(l.fix_mailing_street, left, right)='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.fix_mailing_street, left, right), 0)<>'',
																				'CANADA',	
																			if(trim(l.fix_mailing_street, left, right)='CA' and l.err_stat[1]='E',
																					'UNITED_STATES',
																			if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.fix_mailing_street, left, right))=false and LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_street, left, right))<>'',
																				LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_street, left, right)),
																				'')))));
		self := l;
	end;

	#uniquename(ds_no_csz)	
	%ds_no_csz% := project(%no_csz%, findCountryFull(left));

	#uniquename(ds_concat)
	%ds_concat% := %ds_confirmAdd% + %ds_okc_xx_flag% + %ds_comma_csz% + %ds_no_comma_csz% + %ds_no_csz%;

	//Run additional tests for missing countries
	%inData% addlTest(%ds_concat% l):= transform
		self.ln_mailing_country_code	:= LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryCode(
																				if(trim(l.derived_mailing_country, left, right)='',
																					LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryZip(trim(l.mailing_city_state_zip, left, right)),
																					trim(l.derived_mailing_country, left, right)));
		self := l;
	end;

	outFile:= project(%ds_concat%, addlTest(left)); //: persist('~thor40_241_11::persist::foreign_address_assessor');
	
endmacro;