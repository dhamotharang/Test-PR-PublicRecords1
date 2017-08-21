// import	Address,AID;

export	Append_AID(inSearch,outSearch,isBuildBase	=	false)	:=
macro
	import	Address,AID;
	
	#uniquename(bad_addr1_pattern)
	#uniquename(dSearchAddrPopulated)
	#uniquename(dSearchPartialAddrPopulated)
	string	%bad_addr1_pattern%		:=	'^(1234 UNKNOWN|UNK|UNKN|UNKNOWN|ADDRESS UNKNOWN|11 UNKNOWN)$';
	%dSearchAddrPopulated%				:=	inSearch(			Append_PrepAddr1	!=	''
																							and	regexfind(%bad_addr1_pattern%,Append_PrepAddr1,nocase)	=	false
																							and	Append_PrepAddr2	!=	''
																							and	regexfind('UNKNOWN|12345',Append_PrepAddr2,nocase)	=	false
																						);
	%dSearchPartialAddrPopulated%	:=	inSearch(~(			Append_PrepAddr1	!=	''
																								and	regexfind(%bad_addr1_pattern%,Append_PrepAddr1,nocase)	=	false
																								and	Append_PrepAddr2	!=	''
																								and	regexfind('UNKNOWN|12345',Append_PrepAddr2,nocase)	=	false
																							)
																					);

	// Pass the records to the AddressID macro to fetch the RawAID
	#uniquename(lAIDAppendFlags)
	unsigned4	%lAIDAppendFlags%	:=	AID.Common.eReturnValues.RawAID	|
																	AID.Common.eReturnValues.ACECacheRecords;
	
	#uniquename(dSearchAppendAID)
	AID.MacAppendFromRaw_2Line(	%dSearchAddrPopulated%,
															Append_PrepAddr1,
															Append_PrepAddr2,
															Append_RawAID,
															%dSearchAppendAID%,
															%lAIDAppendFlags%
														);

	#uniquename(tReformat2Orig)
	recordof(inSearch)	%tReformat2Orig%(%dSearchAppendAID%	pInput)	:=
	transform
		self.Append_RawAID:=	pInput.AIDWork_RawAID;
		self.prim_range		:=	pInput.AIDWork_AceCache.prim_range;
		self.predir				:=	pInput.AIDWork_AceCache.predir;
		self.prim_name		:=	pInput.AIDWork_AceCache.prim_name;
		self.suffix				:=	pInput.AIDWork_AceCache.addr_suffix;
		self.postdir			:=	pInput.AIDWork_AceCache.postdir;
		self.unit_desig		:=	pInput.AIDWork_AceCache.unit_desig;
		self.sec_range		:=	pInput.AIDWork_AceCache.sec_range;
		self.p_city_name	:=	pInput.AIDWork_AceCache.p_city_name;
		self.v_city_name	:=	pInput.AIDWork_AceCache.v_city_name;
		self.st						:=	pInput.AIDWork_AceCache.st;
		self.zip					:=	pInput.AIDWork_AceCache.zip5;
		self.zip4					:=	pInput.AIDWork_AceCache.zip4;
		self.cart					:=	pInput.AIDWork_AceCache.cart;
		self.cr_sort_sz		:=	pInput.AIDWork_AceCache.cr_sort_sz;
		self.lot					:=	pInput.AIDWork_AceCache.lot;
		self.lot_order		:=	pInput.AIDWork_AceCache.lot_order;
		self.dbpc					:=	pInput.AIDWork_AceCache.dbpc;
		self.chk_digit		:=	pInput.AIDWork_AceCache.chk_digit;
		self.rec_type			:=	pInput.AIDWork_AceCache.rec_type;
		self.county				:=	pInput.AIDWork_AceCache.county;
		self.geo_lat			:=	pInput.AIDWork_AceCache.geo_lat;
		self.geo_long			:=	pInput.AIDWork_AceCache.geo_long;
		self.msa					:=	pInput.AIDWork_AceCache.msa;
		self.geo_blk			:=	pInput.AIDWork_AceCache.geo_blk;
		self.geo_match		:=	pInput.AIDWork_AceCache.geo_match;
		self.err_stat			:=	pInput.AIDWork_AceCache.err_stat;
		self							:=	pInput;
	end;

	#uniquename(dSearchCleanAddr)
	%dSearchCleanAddr%	:=	project(%dSearchAppendAID%,%tReformat2Orig%(left)) : independent; // DF-19358 - added independent to resolve failure

	// Clean address for records with either address1 or address2 not populated using the regular address cleaner
	#uniquename(rAppendTmpCleanAddr_layout)
	%rAppendTmpCleanAddr_layout%	:=
	record
		recordof(inSearch);
		string182	Append_CleanAddress;
	end;
	
	#uniquename(dSearchPartialAddrPopulatedDist)
	#uniquename(dSearchPartialAddrPopulatedSort)
	#uniquename(dSearchPartialAddrPopulatedDedup)
	%dSearchPartialAddrPopulatedDist%		:=	distribute(%dSearchPartialAddrPopulated%,hash(Append_PrepAddr1,Append_PrepAddr2));
	%dSearchPartialAddrPopulatedSort%		:=	sort(%dSearchPartialAddrPopulatedDist%,Append_PrepAddr1,Append_PrepAddr2,local);
	%dSearchPartialAddrPopulatedDedup%	:=	dedup(%dSearchPartialAddrPopulatedSort%,Append_PrepAddr1,Append_PrepAddr2,local);
	
	#uniquename(tCleanAddr)
	%rAppendTmpCleanAddr_layout%	%tCleanAddr%(%dSearchPartialAddrPopulatedDedup%	pInput)	:=
	transform
		string	vCleanPrepAddr1		:=	if(	regexfind(%bad_addr1_pattern%,stringlib.stringcleanspaces(pInput.Append_PrepAddr1),nocase),
																			'',
																			stringlib.stringcleanspaces(pInput.Append_PrepAddr1)
																		);
		self.Append_PrepAddr1			:=	vCleanPrepAddr1;
		self.Append_CleanAddress	:=	if(	trim(vCleanPrepAddr1)	=	'' and 
																		( pInput.Append_PrepAddr2	=	'UNKNOWN 12345' or 
																		  regexfind('UNKNOWN, [A-Z][A-Z] 12345',pInput.Append_PrepAddr2,0)<>''),
																				'',
																				Address.CleanAddress182(vCleanPrepAddr1,pInput.Append_PrepAddr2)
																			);
		self											:=	pInput;
	end;
	
	#uniquename(dSearchCleanPartialAddrTmp)
	%dSearchCleanPartialAddrTmp%	:=	project(%dSearchPartialAddrPopulatedDedup%,%tCleanAddr%(left));
	
	#uniquename(tReformat)
	recordof(inSearch)	%tReformat%(%dSearchPartialAddrPopulatedDist%	le,%dSearchCleanPartialAddrTmp%	ri)	:=
	transform
		self.prim_range		:=  ri.Append_CleanAddress[1..10];
		self.predir				:= 	ri.Append_CleanAddress[11..12];
		self.prim_name		:= 	ri.Append_CleanAddress[13..40];
		self.suffix				:=  ri.Append_CleanAddress[41..44];
		self.postdir			:= 	ri.Append_CleanAddress[45..46];
		self.unit_desig		:= 	ri.Append_CleanAddress[47..56];
		self.sec_range		:= 	ri.Append_CleanAddress[57..64];
		self.p_city_name	:= 	if(	stringlib.stringcleanspaces(ri.Append_CleanAddress[65..89])	in	['SCHENECTADY','UNKNOWN']	and	stringlib.stringcleanspaces(ri.Append_CleanAddress[90..114])	=	'UNKNOWN',
															'',
															ri.Append_CleanAddress[65..89]
														);
		self.v_city_name	:=  if(	stringlib.stringcleanspaces(ri.Append_CleanAddress[90..114])	!=	'UNKNOWN',
															ri.Append_CleanAddress[90..114],
															''
														);
		self.st						:= 	ri.Append_CleanAddress[115..116];
		self.zip					:= 	ri.Append_CleanAddress[117..121];
		self.zip4					:= 	ri.Append_CleanAddress[122..125];
		self.cart					:= 	ri.Append_CleanAddress[126..129];
		self.cr_sort_sz		:= 	ri.Append_CleanAddress[130];
		self.lot					:= 	ri.Append_CleanAddress[131..134];
		self.lot_order		:= 	ri.Append_CleanAddress[135];
		self.dbpc					:= 	ri.Append_CleanAddress[136..137];
		self.chk_digit		:= 	ri.Append_CleanAddress[138];
		self.rec_type			:= 	ri.Append_CleanAddress[139..140];
		self.county				:= 	ri.Append_CleanAddress[141..145];
		self.geo_lat			:= 	ri.Append_CleanAddress[146..155];
		self.geo_long			:= 	ri.Append_CleanAddress[156..166];
		self.msa					:= 	ri.Append_CleanAddress[167..170];
		self.geo_blk			:= 	ri.Append_CleanAddress[171..177];
		self.geo_match		:= 	ri.Append_CleanAddress[178];
		self.err_stat			:= 	ri.Append_CleanAddress[179..182];
		self							:=	le;
	end;
	
	#uniquename(dSearchCleanPartialAddr)
	
	#if(isBuildBase	=	true)
		%dSearchCleanPartialAddr%	:=	%dSearchPartialAddrPopulated%;
	#else
		%dSearchCleanPartialAddr%	:=	join(	%dSearchPartialAddrPopulatedDist%,
																				%dSearchCleanPartialAddrTmp%,
																				left.Append_PrepAddr1	=	right.Append_PrepAddr1	and
																				left.Append_PrepAddr2	=	right.Append_PrepAddr2,
																				%tReformat%(left,right),
																				left outer,
																				local
																			);
	#end
	
	#uniquename(dSearchAID)
	%dSearchAID%	:=	%dSearchCleanAddr%	+	%dSearchCleanPartialAddr%;
	
	outSearch	:=	distribute(%dSearchAID%,random());
endmacro;