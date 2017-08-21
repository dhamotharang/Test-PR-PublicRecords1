export MAC_CtryCodeOwnSellDeed(inFile, outFile):= macro

import LN_propertyV2, ut;

///////////////////////////////////////////////////////////////////////
//DEED MAILING ADDRESS/////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////
	#uniquename(inData)
	%inData% := inFile;
	
	 dslayoutFix := RECORD
		%inData%;
		string orig_mailing_street;
		string orig_mailing_csz;
		string fix_mailing_street;
		string fix_mailing_csz;
		string derived_country;
		integer seq;
	 END;

	dslayoutFix tranFile(%inData% l):= transform
		self.orig_mailing_street:= '';
		self.orig_mailing_csz		:= '';
		self.fix_mailing_street := '';
		self.fix_mailing_csz		:= '';
		self.derived_country		:= '';
		self.seq								:= 0;
		self := l;
	end;

	#uniquename(ds)
	%ds% := project(%inData%, tranFile(left), local);
	
	#uniquename(ds_norm_addr)
	dslayoutFix tNormAddr(%ds% pInput, integer cnt):= TRANSFORM
				
			buy_mail_addr1			:=	pInput.mailing_street;
			buy_mail_addr2			:=	pInput.mailing_csz;
			sell_mail_addr1			:=	pInput.seller_mailing_full_street_address;
			sell_mail_addr2			:=	pInput.seller_mailing_address_citystatezip;
		
		self.orig_mailing_street:= choose(cnt, buy_mail_addr1, sell_mail_addr1);
		self.orig_mailing_csz		:= choose(cnt, buy_mail_addr2, sell_mail_addr2);
		self.fix_mailing_street	:= choose(cnt, buy_mail_addr1, sell_mail_addr1);
		self.fix_mailing_csz		:= choose(cnt, buy_mail_addr2, sell_mail_addr2);
		self.seq								:= cnt;
		self										:= pInput;
	END;	
	
	%ds_norm_addr% := normalize(%ds%, 2, tNormAddr(left,counter))(fix_mailing_street<>'' or fix_mailing_csz<>'');

//Fix Parsing Issue///////////////////////////////////////////////////////////////////////////////////////////////////////

	dslayoutFix semiTran(%ds_norm_addr% l):= transform
		self.fix_mailing_street 		:= if(regexfind(';', l.fix_mailing_street, 0)<>'' and trim(l.fix_mailing_csz, left, right)='',
																						l.fix_mailing_street[1..stringlib.stringfind(l.fix_mailing_street, ';', 1)-1],
																						l.fix_mailing_street);
		self.fix_mailing_csz			 	:= if(regexfind(';', l.fix_mailing_street, 0)<>'' and trim(l.fix_mailing_csz, left, right)='',
																						l.fix_mailing_street[stringlib.stringfind(l.fix_mailing_street, ';', 1)+1..],
																						l.fix_mailing_csz);
		self := l;
	end;

	#uniquename(ds_semi)
	%ds_semi% := project(%ds_norm_addr%, semiTran(left), local);

//Space Issue/////////////////////////////////////////////////////////////////////////////////////////////////////////////

	//Filter records
	#uniquename(ds_no_com)
	#uniquename(ds_com)
	%ds_no_com% := %ds_semi%(regexfind(',', fix_mailing_csz, 0)='');
	%ds_com%		:= %ds_semi%(regexfind(',', fix_mailing_csz, 0)<>'');

	//Number of commas
	dslayoutFix zipRec(%ds_com% l):= transform
		
			uppCs := StringLib.StringToUpperCase(l.fix_mailing_csz);//trim(stringlib.stringfilter(StringLib.StringToUpperCase(l.mailing_csz), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
			remSp	:= regexreplace('  ', uppCs, ' ');
			remCm	:= if(regexfind(','+'[A-Z]+'+'[A-Z]+'+',', remSp, 0)<>'',
										regexreplace(',', remSp[1..stringlib.stringfind(remSp, ',', 2)-1], ', '),
									if(regexfind(','+'[A-Z]+'+'[A-Z]+', remSp, 0)<>'',
										regexreplace(',', remSp, ', '),
										remSp));
		
		self.fix_mailing_csz := remCm;
		self := l;
	end;
	
	#uniquename(ds_comma)
	#uniquename(ds_fix)
	%ds_comma% 	:= project(%ds_com%, zipRec(left), local);
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

	dslayoutClean	:= record
		dslayoutFix;
		cleanAddressLayout;
	end;
	
	dslayoutClean cleanAddrTr(%ds_fix% pInput) := transform
	
			Append_PrepPropertyAddr1	:= ut.CleanSpacesAndUpper(pInput.fix_mailing_street);
			Append_PrepPropertyAddr2	:= regexreplace('([0]{5}|[,])$', ut.CleanSpacesAndUpper(LN_Propertyv2.Functions.fDropZip4(pInput.fix_mailing_csz)), '');

		self.Append_PrepAddr1			:=	Append_PrepPropertyAddr1;
		self.Append_PrepAddr2			:=	Append_PrepPropertyAddr2;
		self.Append_RawAID				:=  0;
		//self.source_code					:=	'O';
		self											:=	pInput;
		
	end;
	
	#uniquename(dsAddr)
	%dsAddr%	:=	project(%ds_fix%, cleanAddrTr(left), local);
	
	dslayoutClean	tPrepAddr(%dsAddr% pInput)	:= transform
		self.Append_PrepAddr2	:= if(pInput.Append_PrepAddr1	!=	'' and	pInput.Append_PrepAddr2	=	'',
																	'UNKNOWN 12345',
																	pInput.Append_PrepAddr2);
		self									:= pInput;
	end;
	
	#uniquename(dPrepAddr)
	%dPrepAddr%	:=	project(%dsAddr%, tPrepAddr(left), local);
	
	#uniquename(dPrepCleanAddr)
	LN_PropertyV2_Fast.Function_Foreign_Countries.Append_AID(%dPrepAddr%, %dPrepCleanAddr%);

	//Flag Confirmed US/US Territory Addresses
	#uniquename(confirmAd)
	#uniquename(notConfirmAdd)
	%confirmAd% 		:= %dPrepCleanAddr%(err_stat[1]='S');	
	%notConfirmAdd%	:= %dPrepCleanAddr%(err_stat[1] in ['','E']);
	
	%dPrepCleanAddr% findCntry(%confirmAd% l):= transform
		self.derived_country :=  if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(l.st),
																							'UNITED_STATES',
																						if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(l.st)<>'',
																							LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(l.st),
																							''));
		self 															 := l;
	end;

	#uniquename(ds_confirmAdd)
	#uniquename(ds_all)
	%ds_confirmAdd% 	:= project(%confirmAd%, findCntry(left), local);
	%ds_all%					:= %notConfirmAdd%;	

//Flag Foreign Records////////////////////////////////////////////////////////////////////////////////////////////////

	//XX OKC
	#uniquename(ds_okc_xx)
	%ds_okc_xx% 	:= %ds_all%(regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O');

	dslayoutClean xxFlag(%ds_okc_xx% l):= transform
		self.derived_country := if(trim(l.fix_mailing_csz, left, right)='XX',
																						LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_street, left, right)),
																					if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right))<>'',
																						LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																						''));
		self := l;
	end;
	
	#uniquename(ds_okc_xx_flag)	
	%ds_okc_xx_flag% 	:= project(%ds_okc_xx%, xxFlag(left), local);

	//Comma	in CSZ
	#uniquename(ds_comm_csz_initial)
	%ds_comm_csz_initial% 		:= %ds_all%(regexfind(',', fix_mailing_csz, 0)<>'' and not (regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O'));
	
	dslayoutClean cszFind(%ds_comm_csz_initial% l):= transform
		ctry := trim(stringlib.stringfilter(l.fix_mailing_csz[stringlib.stringfind(l.fix_mailing_csz, ',', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
	
		self.derived_country	:= if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(ctry) and ctry<>'CA',
																							'UNITED_STATES',
																						if(ctry ='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'',
																							'UNITED_STATES',
																						if(ctry ='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.fix_mailing_csz, left, right), 0)<>'',
																							'CANADA',	
																						if(ctry='CA' and l.err_stat[1]='E',
																							'UNITED_STATES',	
																						if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUS(ctry)=false and LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(ctry)<>'',
																							LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbr(trim(stringlib.stringfilter(l.fix_mailing_csz[stringlib.stringfind(l.fix_mailing_csz, ',', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right)),
																							'')))));
		self																:= l;
	end;
	
	#uniquename(ds_comm_csz_initial2)
	%ds_comm_csz_initial2% := project(%ds_comm_csz_initial%, cszFind(left), local);

	dslayoutClean cszFind2(%ds_comm_csz_initial2% l):= transform
		self.derived_country	:= if(trim(l.derived_country, left, right)='',
																							LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																							l.derived_country);
		self 																:= l;
	end;
	
	#uniquename(ds_comma_csz)
	%ds_comma_csz% := project(%ds_comm_csz_initial2%, cszFind2(left), local);
	
	//No Comma in CSZ
	#uniquename(ds_no_comm_csz)
	%ds_no_comm_csz% := %ds_all%(trim(fix_mailing_csz, left, right)<>'' and regexfind(',', fix_mailing_csz, 0)='' and not (regexfind('XX', fix_mailing_csz, 0)<>'' and vendor_source_flag='O'));
	
	dslayoutClean fixCSZ2(%ds_no_comm_csz% l):= transform
		filter := trim(stringlib.stringfilter(l.fix_mailing_csz, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right);
	
		self.derived_country := if(regexfind('[0-9][0-9][0-9][0-9][0-9]+'+' '+'[0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 3)<>0,
																						trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 3)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),
																					if(regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 2)<>0,
																						trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 2)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),
																					if(regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'' and stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)<>0,
																						filter,	
																					if(stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)<>0,
																						trim(stringlib.stringfilter(trim(l.fix_mailing_csz, left, right)[length(trim(l.fix_mailing_csz, left, right))-stringlib.stringfind(stringLib.StringReverse(trim(l.fix_mailing_csz, left, right)), ' ', 1)+2..], 'ABCDEFGHIJKLMNOPQRSTUVWXYZ '), left, right),	
																						filter))));
		self 																:= l;
	end;

	#uniquename(ds_o)
	%ds_o% := project(%ds_no_comm_csz%, fixCSZ2(left), local);
	
	//Find Countries
	dslayoutClean fixCountry(%ds_o% l):= transform
		self.derived_country := if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.derived_country, left, right)) and trim(l.derived_country, left, right)<>'CA',
																						'UNITED_STATES',
																					if(trim(l.derived_country, left, right) ='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.fix_mailing_csz, left, right), 0)<>'',
																						'UNITED_STATES',
																					if(trim(l.derived_country, left, right) ='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.fix_mailing_csz, left, right), 0)<>'',
																						'CANADA',	
																					if(trim(l.derived_country, left, right) ='CA' and l.err_stat[1]='E',
																						'UNITED_STATES',
																					if(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right))<>'',
																						LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.fix_mailing_csz, left, right)),
																						'')))));
		self := l;
	end;

	#uniquename(ds_no_comma_csz)
	%ds_no_comma_csz% := project(%ds_o%, fixCountry(left), local);
	
	//No CSZ
	#uniquename(no_csz)
	%no_csz% := %ds_all%(trim(fix_mailing_csz, left, right)='');

	dslayoutClean findCountryFull(%no_csz% l):= transform
		self.derived_country := if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.orig_mailing_street, left, right)) and trim(l.orig_mailing_street, left, right)<>'CA',
																						'UNITED_STATES',
																					if(trim(l.orig_mailing_street, left, right)='CA' and regexfind('[0-9][0-9][0-9][0-9][0-9]+', trim(l.orig_mailing_street, left, right), 0)<>'',
																						'UNITED_STATES',
																					if(trim(l.orig_mailing_street, left, right)='CA' and regexfind(' [ABCEGHJKLMNPRSTVXY][0-9][A-Z][ ]{0,1}[0-9][A-Z][0-9]$', trim(l.orig_mailing_street, left, right), 0)<>'',
																						'CANADA',	
																					if(trim(l.orig_mailing_street, left, right) ='CA' and l.err_stat[1]='E',
																						'UNITED_STATES',
																					if(LN_PropertyV2_Fast.Function_Foreign_Countries.fisUs(trim(l.orig_mailing_street, left, right))=false and LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.orig_mailing_street, left, right))<>'',
																						LN_PropertyV2_Fast.Function_Foreign_Countries.fCountry(trim(l.orig_mailing_street, left, right)),
																						'')))));
		self 																:= l;
	end;

	#uniquename(ds_no_csz)
	%ds_no_csz% := project(%no_csz%, findCountryFull(left), local);
	
	#uniquename(ds_concat)
	%ds_concat% := %ds_confirmAdd% + %ds_okc_xx_flag% + %ds_comma_csz% + %ds_no_comma_csz% + %ds_no_csz%;// : persist('~thor40_241_11::persist::foreign_address_deed_mail');

	//Run additional tests for missing countries
	#uniquename(ds_country)
	dslayoutFix addlTest2(%ds_concat% l):= transform
		self.derived_country	:= LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryCode(
																						if(trim(l.derived_country, left, right)='',
																							LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryZip(trim(l.fix_mailing_csz, left, right)),
																						if(trim(l.derived_country, left, right)='' and trim(LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryZip(trim(l.fix_mailing_csz, left, right)), left, right)='',
																							LN_PropertyV2_Fast.Function_Foreign_Countries.fCountryAbbrDeed(trim(l.fix_mailing_csz, left, right), l.vendor_source_flag),
																							trim(l.derived_country, left, right))));
		self := l;
	end;

	%ds_country%	:= project(%ds_concat%, addlTest2(left), local);//: persist('~thor40_241_11::persist::foreign_address_deed_mail_test');	
	
	//Populate Countries to Derived Fields
	%inData% tAddrDenorm(%inData% l, %ds_country% r):= transform
		self.ln_buyer_mailing_country_code		:= if(r.seq = 1, r.derived_country, l.ln_buyer_mailing_country_code); 
		self.ln_seller_mailing_country_code		:= if(r.seq = 2, r.derived_country, l.ln_seller_mailing_country_code);
		self	:= l;
	end;
	
	outFile  := dedup(denormalize(sort(distribute(%inData%, hash(ln_fares_id)), ln_fares_id, local),
																sort(distribute(%ds_country%, hash(ln_fares_id)), ln_fares_id, seq, local),
																		left.ln_fares_id = right.ln_fares_id, 
																		tAddrDenorm(left, right), local), all);

	//output(outFile);
	
endmacro;