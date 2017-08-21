import	Address,AID,codes,ut,vehlic,vehiclecodes,NID,_Validate;

	unsigned4	fBestSeenDate(string8	pRegDate,string8	pTitleDate,string8	pProcessDate)	:=
	function
		unsigned4	lRegDate			:=	(unsigned8)pRegDate;
		unsigned4	lTitleDate		:=	(unsigned8)pTitleDate;
		unsigned4	lProcessDate	:=	(unsigned8)pProcessDate;
		unsigned4	lReturnValue	:=	if(	lRegDate	<=	lProcessDate	and	lRegDate	<>	0,
																		lRegDate,
																		if(lTitleDate	<=	lProcessDate	and	lTitleDate <> 0,
																				lTitleDate,
																				0
																			)
																	);
		return	lReturnValue;
	end;

	string1 MA_Vehicle_Type_Mapping(string body_style) := 
				CASE(TRIM(body_style),
						 'SEDAN'		=> 'P',
						 'UTIL' 		=> 'T',
						 'COUPE' 		=> 'P',
						 'PU' 			=> 'T',
						 'TRAIL' 		=> 'X',
						 'VAN' 			=> 'P',
						 'STWAG'		=> 'P',
						 'HATCH'		=> 'P',
						 'MOTCY'		=> 'M',
						 'TRUCK'		=> 'T',
						 'SUV'			=> 'P',
						 'CONVT'		=> 'P',
						 'OTHER'		=> 'U',
						 'HARDT'		=> 'P',
						 'BUS'			=> 'T',
						 'CAMP'			=> 'X',
						 'TRACT'		=> 'T',
						 'AUTHM'		=> 'U',
						 'DUMP'			=> 'U',
						 'CABCH'		=> 'U',
						 'BOX'			=> 'U',
						 'WAGON'		=> 'P',
						 'CABCA'		=> 'U',
						 'FLAT'			=> 'U',
						 'SUBUR'		=> 'U',
						 'AMBUL'		=> 'T',
						 'LIMO'			=> 'P',
						 'TANK'			=> 'T',
						 'CONST'		=> 'U',
						 'PANEL'		=> 'U',
						 'BUCKT'		=> 'U',
						 'HERSE'		=> 'U',
						 'GARBA'		=> 'U',
						 'MIXER'		=> 'T',
						 'FIRE'			=> 'T',
						 'LOADR'		=> 'T',
						 'TOW'			=> 'T',
						 'BACKH'		=> 'U',
						 'ROLL'			=> 'T',
						 'RAMP'			=> 'T',
						 'CRANE'		=> 'T',
						 'LOG'			=> 'U',
						 'WELL'			=> 'U',
						 'LSV'			=> 'U',
						 'FARM'			=> 'T',
						 'CARCA'		=> 'P',
						 'ARMOR'		=> 'T',
						 'SCOOT'		=> 'M',
             'U'
					);

	string3 MA_Vehicle_Color_Code_Mapping(string1 color_code) := 
				CASE(TRIM(color_code),
						 '0'		=> 'ONG',
						 '1'		=> 'BLK',
						 '2'		=> 'BLU',
						 '3'		=> 'BRO',
						 '4'		=> 'RED',
						 '5'		=> 'YEL',
						 '6'		=> 'GRN',
						 '7'		=> 'WHI',
						 '8'		=> 'GRY',
						 '9'		=> 'PLE',
						 ''			=> '',
						 'UNK');

	
	select_vins := [
									'IFTCR11S8FUB4520A',   //all 5 address populated
									'1FMDU34X5MUA83160',   //all 5 address populated
									'WBXPA73434WC43782',   //4 address populated, no vehmail_zip
									'1HGCM55755A117600',	 //4 address populated, no vehmail_zip
									'1GCDM15Z8HB129929',   //owner 1 address = BX 55               	C/O USCG HOUSING    	BAYAMON        	PR	000000000
									'WAUBA24B2WN043390',   //owner 1 address = 17065 YONGE ST      	CANADA              	NEW MARKET     	ON	000000000
									'1W4200E1984069423',	 //no address at all
									'1JCMT7840JT167305' 	 //France, Europe
								];	
  ma_prepped	:=	vehiclev2.files.In.MA.PreppedBldg;
	// ma_prepped1	:=	vehiclev2.files.In.MA.PreppedBldg(trim(veh_vin) in select_vins);
	// ma_prepped2 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_last_name<>'' AND owner2_last_name<>''),10); 
	// ma_prepped3 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(vehmail_street1<>'' AND
																										// owner1_mail_street1<>'' AND owner1_resi_street1<>'' AND
	                                                  // owner2_mail_street1<>'' AND owner2_resi_street1<>''),10);
	// ma_prepped4 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_type='1' and append_owner1nametypeind='B'),10); 
	// ma_prepped5 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_type='1' and append_owner1nametypeind='P'),2); 
	// ma_prepped6 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_type='1' and append_owner1nametypeind='I'),2); 
	// ma_prepped7 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_type='1' and append_owner1nametypeind='U'),2); 
	// ma_prepped8 :=  choosen(vehiclev2.files.In.MA.PreppedBldg(owner1_type='1' and append_owner1nametypeind='D'),2); 
	// ma_prepped9 :=  choosen(vehiclev2.files.In.MA.PreppedBldg((owner1_type='2' AND append_owner1nametypeind<>'B') or 
	                                                          // (owner2_type='2' AND append_owner2nametypeind<>'B')),10);
	//ma_prepped := ma_prepped1+ma_prepped2+ma_prepped3+ma_prepped4+ma_prepped5+ma_prepped6+
	//              ma_prepped7+ma_prepped8+ma_prepped9;
	//output(choosen(ma_prepped,1000),,named('ma_prepped'));
	//output(count(ma_prepped));

	// clean all fields to keep only the printable characters
	ut.CleanFields(ma_prepped,ma_update_clean);
                                                                                        
	exception_addr_pattern := '(C/O.*$|ADDRESS UNKNOWN|UNKNOWN ADDRESS|UNKNOWN NEED PROOF|GENERAL DELIVERY|^CO [A-Za-z ]+$|'+
	                          '^ATT [A-Za-z ]+$|^ATTN [A-Za-z ]+$|^DBA [A-Za-z ]+$|^SEND TO .*$|ATTENTION|' +
														'UNKNOWN|STREET ADDRESS|GEN DELIVERY)';
	VehicleV2.Layout_MA.CLEAN_ADDR_NAME tAppendAddressesNames(ma_update_clean	pInput)	:=
	TRANSFORM
		//Setup for address cleaning
		temp_vehmail_street1	:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.VEHMAIL_STREET1,''));
		temp_vehmail_street2	:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.VEHMAIL_STREET2,''));
		SELF.Append_MailAddr1 := stringlib.stringtouppercase(stringlib.stringcleanspaces(
																 temp_vehmail_street1 + ' ' + temp_vehmail_street2));
		SELF.Append_MailAddr2 := stringlib.stringtouppercase(
																 regexreplace('[,]$',
																		 stringlib.stringcleanspaces(
																				IF(pInput.VEHMAIL_CITY<>'',pInput.VEHMAIL_CITY+', ', ' ') + 
																				pInput.VEHMAIL_ST + ' ' + 
																				IF(pInput.VEHMAIL_ZIP[1..5]<>'00000',pInput.VEHMAIL_ZIP[1..5],'')),
																			''));
		temp_o1mail_street1		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER1_MAIL_STREET1,''));
		temp_o1mail_street2		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER1_MAIL_STREET2,''));
		SELF.Append_Owner1MailAddr1 := stringlib.stringtouppercase(stringlib.stringcleanspaces(
																 temp_o1mail_street1 + ' ' + temp_o1mail_street2));
		SELF.Append_Owner1MailAddr2 := stringlib.stringtouppercase(
																 regexreplace('[,]$',
																		 stringlib.stringcleanspaces(
																				IF(pInput.OWNER1_MAIL_CITY<>'',pInput.OWNER1_MAIL_CITY+', ', ' ') + 
																				pInput.OWNER1_MAIL_ST + ' ' + 
																				IF(pInput.OWNER1_MAIL_ZIP[1..5]<>'00000',pInput.OWNER1_MAIL_ZIP[1..5],'')),
																			''));
		temp_o1resi_street1		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER1_RESI_STREET1,''));
		temp_o1resi_street2		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER1_RESI_STREET2,''));
		SELF.Append_Owner1ResiAddr1 := stringlib.stringtouppercase(stringlib.stringcleanspaces(
																 temp_o1resi_street1 + ' ' + temp_o1resi_street2));
		SELF.Append_Owner1ResiAddr2 := stringlib.stringtouppercase(
																 regexreplace('[,]$',
																		 stringlib.stringcleanspaces(
																				IF(pInput.OWNER1_RESI_CITY<>'',pInput.OWNER1_RESI_CITY+', ', ' ') + 
																				pInput.OWNER1_RESI_ST + ' ' + 
																				IF(pInput.OWNER1_RESI_ZIP[1..5]<>'00000',pInput.OWNER1_RESI_ZIP[1..5],'')),
																			''));
		temp_o2mail_street1		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER2_MAIL_STREET1,''));
		temp_o2mail_street2		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER2_MAIL_STREET2,''));
		SELF.Append_Owner2MailAddr1 := stringlib.stringtouppercase(stringlib.stringcleanspaces(
																 temp_o2mail_street1 + ' ' + temp_o2mail_street2));
		SELF.Append_Owner2MailAddr2 := stringlib.stringtouppercase(
																 regexreplace('[,]$',
																		 stringlib.stringcleanspaces(
																				IF(pInput.OWNER2_MAIL_CITY<>'',pInput.OWNER2_MAIL_CITY+', ', ' ') + 
																				pInput.OWNER2_MAIL_ST + ' ' + 
																				IF(pInput.OWNER2_MAIL_ZIP[1..5]<>'00000',pInput.OWNER2_MAIL_ZIP[1..5],'')),
																			''));
		temp_o2resi_street1		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER2_RESI_STREET1,''));
		temp_o2resi_street2		:= TRIM(REGEXREPLACE(exception_addr_pattern,pInput.OWNER2_RESI_STREET2,''));
		SELF.Append_Owner2ResiAddr1 := stringlib.stringtouppercase(stringlib.stringcleanspaces(
																 temp_o2resi_street1 + ' ' + temp_o2resi_street2));
		SELF.Append_Owner2ResiAddr2 := stringlib.stringtouppercase(
																 regexreplace('[,]$',
																		 stringlib.stringcleanspaces(
																				IF(pInput.OWNER2_RESI_CITY<>'',pInput.OWNER2_RESI_CITY+', ', ' ') + 
																				pInput.OWNER2_RESI_ST + ' ' + 
																				IF(pInput.OWNER2_RESI_ZIP[1..5]<>'00000',pInput.OWNER2_RESI_ZIP[1..5],'')),
																			''));
		//Setup for name cleaning
		tempOwner1Name 								:= IF(pInput.OWNER1_TYPE='2',	
																				stringlib.stringCleanSpaces(				//business
																								 TRIM(pInput.OWNER1_LAST_NAME) + ' ' + TRIM(pInput.FILLER1) +
																								 TRIM(pInput.OWNER1_FIRST_NAME) + ' ' + TRIM(pInput.FILLER2) +
																								 TRIM(pInput.OWNER1_MIDDLE_NAME) + ' ' + TRIM(pInput.FILLER3)),
																				stringlib.stringCleanSpaces(				//person
																								 TRIM(pInput.OWNER1_FIRST_NAME) + ' ' + 
																								 TRIM(pInput.OWNER1_MIDDLE_NAME) + ' ' +
																								 TRIM(pInput.OWNER1_LAST_NAME)));

		SELF.APPEND_OWNER1_NAME  			:=	tempOwner1Name;
		boolean is_owner1_business		:= If(pInput.OWNER1_TYPE='2' OR pInput.Append_Owner1NameTypeInd='B',TRUE,FALSE);
		SELF.RAW_OWNER1_LNAME 				:= pInput.OWNER1_LAST_NAME;
		SELF.RAW_OWNER1_FNAME 				:= pInput.OWNER1_FIRST_NAME;
		SELF.RAW_OWNER1_MNAME 				:= pInput.OWNER1_MIDDLE_NAME;
		SELF.COMPANY_NAME1						:= IF(is_owner1_business,tempOwner1Name,'');			 
		tempOwner2Name 								:= IF(pInput.OWNER2_TYPE='2',	
																				stringlib.stringCleanSpaces(				//business
																								 TRIM(pInput.OWNER2_LAST_NAME) + ' ' + TRIM(pInput.FILLER4) +
																								 TRIM(pInput.OWNER2_FIRST_NAME) + ' ' + TRIM(pInput.FILLER5) +
																								 TRIM(pInput.OWNER2_MIDDLE_NAME) + ' ' + TRIM(pInput.FILLER6)),
																				stringlib.stringCleanSpaces(				//person
																								 TRIM(pInput.OWNER2_FIRST_NAME) + ' ' + 
																								 TRIM(pInput.OWNER2_MIDDLE_NAME) + ' ' +
																								 TRIM(pInput.OWNER2_LAST_NAME)));
		SELF.APPEND_OWNER2_NAME  			:=	tempOwner2Name;
		boolean is_owner2_business		:= If(pInput.OWNER2_TYPE='2' OR pInput.Append_Owner2NameTypeInd='B',TRUE,FALSE);
		SELF.RAW_OWNER2_LNAME 				:= IF(is_owner2_business,'',pInput.OWNER2_LAST_NAME);
		SELF.RAW_OWNER2_FNAME 				:= IF(is_owner2_business,'',pInput.OWNER2_FIRST_NAME);
		SELF.RAW_OWNER2_MNAME 				:= IF(is_owner2_business,'',pInput.OWNER2_MIDDLE_NAME);
		SELF.COMPANY_NAME2						:= IF(is_owner2_business,tempOwner2Name,'');			 

		self :=	pInput;
		SELF := [];
	end;

	ma_append_prep_addrname	:=	project(ma_update_clean,tAppendAddressesNames(left));
	//output(choosen(ma_append_prep_addrname,1000),,named('ma_append_prep_addr'));
	//output(count(ma_append_prep_addrname));
	
	// Append sequence number so as to normalize records by address
	rAppendAIDNIDSeqNum_layout	:=
	record
		unsigned6				Append_SeqNum				:=	0;
		VehicleV2.Layout_MA.CLEAN_ADDR_NAME;
		string1					AddrInd							:=	'';
		string100				Append_PrepAddr1		:=	'';
		string50				Append_PrepAddr2		:=	'';
		AID.Common.xAID	Append_RawAID	:=	0;
		string1					NameInd							:=	'';
		STRING20				fname:='';
		STRING20				mname:='';
		STRING20				lname:='';
		STRING5					sname:='';
		STRING50				myfullname:='';
		STRING50				company_name:='';
		STRING20				clean_lname:='';
		STRING20				clean_mname:='';
		STRING20				clean_fname:='';
		STRING5					clean_title:='';
		STRING5					clean_suffix:='';
		STRING10        prim_range:='';
		STRING2         predir:='';
		STRING28        prim_name:='';
		STRING4         suffix:='';
		STRING2         postdir:='';
		STRING10        unit_desig:='';
		STRING8         sec_range:='';
		STRING25        p_city_name:='';
		STRING25        v_city_name:='';
		STRING2         state:='';
		STRING5         zip5:='';
		STRING4         zip4:='';
		STRING2         rec_type:='';
		STRING5         county:='';
		STRING10        geo_lat:='';
		STRING11        geo_long:='';
		string4					cbsa:='';
		string7					geo_blk:='';
		string1					geo_match:='';
		STRING4					err_stat:='';
	end;
	
	// Append sequence number so as to normalize records by address
	ut.MAC_Sequence_Records_NewRec(ma_append_prep_addrname,rAppendAIDNIDSeqNum_layout,Append_SeqNum,dAppendSeqNum);
	dAppendSeqNumDist	:=	distribute(dAppendSeqNum,hash(Append_SeqNum));
	//output(choosen(dAppendSeqNumDist,1000),,named('dAppendSeqNumDist'));
	//output(count(dAppendSeqNumDist));
	
	// Normalize records by address so as to pass to AddressID macro
	rAppendAIDNIDSeqNum_layout	tVehiclesNormAddr(dAppendSeqNumDist	pInput,integer	cnt)	:=
	transform
		self.AddrInd					:=	choose(cnt,'1','2','3','4','5');
		self.Append_PrepAddr1	:=	choose(cnt,pInput.Append_MailAddr1,pInput.Append_Owner1MailAddr1,pInput.Append_Owner1ResiAddr1,
		                                                             pInput.Append_Owner2MailAddr1,pInput.Append_Owner2ResiAddr1);
		self.Append_PrepAddr2	:=	choose(cnt,pInput.Append_MailAddr2,pInput.Append_Owner1MailAddr2,pInput.Append_Owner1ResiAddr2,
		                                                             pInput.Append_Owner2MailAddr2,pInput.Append_Owner2ResiAddr2);
		self.Append_RawAID		:=	0;
		self									:=	pInput;
	end;

	dNormalizeAddr	:=	normalize(dAppendSeqNumDist,5,tVehiclesNormAddr(left,counter),local);

	//output(choosen(dNormalizeAddr,1000),,named('dNormalizeAddr'));
	//output('dNormalizeAddr record count = ' + count(dNormalizeAddr));

	prep_addr_populated			:=	dNormalizeAddr(Append_PrepAddr2!='');
	prep_addr_not_populated	:=	dNormalizeAddr(Append_PrepAddr2='');
	//output(choosen(prep_addr_populated,1000),,named('prep_addr_populated'));
	//output('prep_addr_populated record count = ' + count(prep_addr_populated));

	// Pass the records to the AddressID macro to fetch the RawAID
	unsigned4	lAIDAppendFlags	:=	AID.Common.eReturnValues.RawAID	|
																AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(	prep_addr_populated,
															Append_PrepAddr1,
															Append_PrepAddr2,
															Append_RawAID,
															clean_AppendAID,
															lAIDAppendFlags
														);

	 //output(choosen(clean_AppendAID,100),,named('clean_AppendAID'));
	 //output('clean_AppendAID record count = ' + count(clean_AppendAID));

	// Combine the blank or invalid address records after passing to the AID macro
	rAppendAIDNIDSeqNum_layout	tReformatAID(clean_AppendAID	pInput)	:=
	transform
		self.Append_RawAID	:=	pInput.AIDWork_RawAID;
		self.prim_range			:=	pInput.AIDWork_AceCache.prim_range;
		self.predir					:=	pInput.AIDWork_AceCache.predir;
		self.prim_name			:=	pInput.AIDWork_AceCache.prim_name;
		self.suffix					:=	pInput.AIDWork_AceCache.addr_suffix;
		self.postdir				:=	pInput.AIDWork_AceCache.postdir;
		self.unit_desig			:=	pInput.AIDWork_AceCache.unit_desig;
		self.sec_range			:=	pInput.AIDWork_AceCache.sec_range;
		self.p_city_name		:=	pInput.AIDWork_AceCache.p_city_name;
		self.v_city_name		:=	pInput.AIDWork_AceCache.v_city_name;
		self.state					:=	pInput.AIDWork_AceCache.st;
		self.zip5						:=	pInput.AIDWork_AceCache.zip5;
		self.zip4						:=	pInput.AIDWork_AceCache.zip4;
		self.county					:=	pInput.AIDWork_AceCache.county;
		self.rec_type				:=	pInput.AIDWork_AceCache.rec_type;
		self.geo_lat				:=	pInput.AIDWork_AceCache.geo_lat;
		self.geo_long				:=	pInput.AIDWork_AceCache.geo_long;
		self.cbsa						:=	pInput.AIDWork_AceCache.msa;
		self.geo_blk				:=	pInput.AIDWork_AceCache.geo_blk;
		self.geo_match			:=	pInput.AIDWork_AceCache.geo_match;
		self.err_stat				:=	pInput.AIDWork_AceCache.err_stat;
		self								:=	pInput;
	end;

	dAddrCombined						:=	project(clean_AppendAID,tReformatAID(left))	+	prep_addr_not_populated : INDEPENDENT;
	//dAddrCombined						:=	prep_addr_populated	+	prep_addr_not_populated;
	//output(dAddrCombined,,named('dAddrCombined'));
	dAddrCombinedDist 			:=	distribute(dAddrCombined,hash(Append_SeqNum));
	
	// Denormalize records by address
	rAppendAIDNIDSeqNum_layout	tDenormAddr(dAppendSeqNumDist	le,dAddrCombinedDist	ri)	:=
	transform
		self.Append_MailRawAID					:=	if(ri.AddrInd	=	'1',ri.Append_RawAID,le.Append_MailRawAID);
		self.veh_mail_prim_range				:=	if(ri.AddrInd	=	'1',ri.prim_range,le.veh_mail_prim_range);
		self.veh_mail_predir						:=	if(ri.AddrInd	=	'1',ri.predir,le.veh_mail_predir);
		self.veh_mail_prim_name					:=	if(ri.AddrInd	=	'1',ri.prim_name,le.veh_mail_prim_name);
		self.veh_mail_suffix						:=	if(ri.AddrInd	=	'1',ri.suffix,le.veh_mail_suffix);
		self.veh_mail_postdir						:=	if(ri.AddrInd	=	'1',ri.postdir,le.veh_mail_postdir);
		self.veh_mail_unit_desig				:=	if(ri.AddrInd	=	'1',ri.unit_desig,le.veh_mail_unit_desig);
		self.veh_mail_sec_range					:=	if(ri.AddrInd	=	'1',ri.sec_range,le.veh_mail_sec_range);
		self.veh_mail_p_city_name				:=	if(ri.AddrInd	=	'1',ri.p_city_name,le.veh_mail_p_city_name);
		self.veh_mail_v_city_name				:=	if(ri.AddrInd	=	'1',ri.v_city_name,le.veh_mail_v_city_name);
		self.veh_mail_state							:=	if(ri.AddrInd	=	'1',ri.state,le.veh_mail_state);
		self.veh_mail_zip5							:=	if(ri.AddrInd	=	'1',ri.zip5,le.veh_mail_zip5);
		self.veh_mail_zip4							:=	if(ri.AddrInd	=	'1',ri.zip4,le.veh_mail_zip4);
		self.veh_mail_rec_type					:=	if(ri.AddrInd	=	'1',ri.rec_type,le.veh_mail_rec_type);
		self.veh_mail_county						:=	if(ri.AddrInd	=	'1',ri.county,le.veh_mail_county);
		self.veh_mail_geo_lat						:=	if(ri.AddrInd	=	'1',ri.geo_lat,le.veh_mail_geo_lat);
		self.veh_mail_geo_long					:=	if(ri.AddrInd	=	'1',ri.geo_long,le.veh_mail_geo_long);
		self.veh_mail_cbsa							:=	if(ri.AddrInd	=	'1',ri.cbsa,le.veh_mail_cbsa);
		self.veh_mail_geo_blk						:=	if(ri.AddrInd	=	'1',ri.geo_blk,le.veh_mail_geo_blk);
		self.veh_mail_geo_match					:=	if(ri.AddrInd	=	'1',ri.geo_match,le.veh_mail_geo_match);
		self.veh_mail_err_stat					:=	if(ri.AddrInd	=	'1',ri.err_stat,le.veh_mail_err_stat);
		
		self.Append_Owner1MailRawAID		:=	if(ri.AddrInd	=	'2',ri.Append_RawAID,le.Append_Owner1MailRawAID);
		self.owner1_mail_prim_range			:=	if(ri.AddrInd	=	'2',ri.prim_range,le.owner1_mail_prim_range);
		self.owner1_mail_predir					:=	if(ri.AddrInd	=	'2',ri.predir,le.owner1_mail_predir);
		self.owner1_mail_prim_name			:=	if(ri.AddrInd	=	'2',ri.prim_name,le.owner1_mail_prim_name);
		self.owner1_mail_suffix					:=	if(ri.AddrInd	=	'2',ri.suffix,le.owner1_mail_suffix);
		self.owner1_mail_postdir				:=	if(ri.AddrInd	=	'2',ri.postdir,le.owner1_mail_postdir);
		self.owner1_mail_unit_desig			:=	if(ri.AddrInd	=	'2',ri.unit_desig,le.owner1_mail_unit_desig);
		self.owner1_mail_sec_range			:=	if(ri.AddrInd	=	'2',ri.sec_range,le.owner1_mail_sec_range);
		self.owner1_mail_p_city_name		:=	if(ri.AddrInd	=	'2',ri.p_city_name,le.owner1_mail_p_city_name);
		self.owner1_mail_v_city_name		:=	if(ri.AddrInd	=	'2',ri.v_city_name,le.owner1_mail_v_city_name);
		self.owner1_mail_state					:=	if(ri.AddrInd	=	'2',ri.state,le.owner1_mail_state);
		self.owner1_mail_zip5						:=	if(ri.AddrInd	=	'2',ri.zip5,le.owner1_mail_zip5);
		self.owner1_mail_zip4						:=	if(ri.AddrInd	=	'2',ri.zip4,le.owner1_mail_zip4);
		self.owner1_mail_rec_type				:=	if(ri.AddrInd	=	'2',ri.rec_type,le.owner1_mail_rec_type);
		self.owner1_mail_county					:=	if(ri.AddrInd	=	'2',ri.county,le.owner1_mail_county);
		self.owner1_mail_geo_lat				:=	if(ri.AddrInd	=	'2',ri.geo_lat,le.owner1_mail_geo_lat);
		self.owner1_mail_geo_long				:=	if(ri.AddrInd	=	'2',ri.geo_long,le.owner1_mail_geo_long);
		self.owner1_mail_cbsa						:=	if(ri.AddrInd	=	'2',ri.cbsa,le.owner1_mail_cbsa);
		self.owner1_mail_geo_blk				:=	if(ri.AddrInd	=	'2',ri.geo_blk,le.owner1_mail_geo_blk);
		self.owner1_mail_geo_match			:=	if(ri.AddrInd	=	'2',ri.geo_match,le.owner1_mail_geo_match);
		self.owner1_mail_err_stat				:=	if(ri.AddrInd	=	'2',ri.err_stat,le.owner1_mail_err_stat);
		
		self.Append_Owner1ResiRawAID		:=	if(ri.AddrInd	=	'3',ri.Append_RawAID,le.Append_Owner1ResiRawAID);
		self.owner1_resi_prim_range			:=	if(ri.AddrInd	=	'3',ri.prim_range,le.owner1_resi_prim_range);
		self.owner1_resi_predir					:=	if(ri.AddrInd	=	'3',ri.predir,le.owner1_resi_predir);
		self.owner1_resi_prim_name			:=	if(ri.AddrInd	=	'3',ri.prim_name,le.owner1_resi_prim_name);
		self.owner1_resi_suffix					:=	if(ri.AddrInd	=	'3',ri.suffix,le.owner1_resi_suffix);
		self.owner1_resi_postdir				:=	if(ri.AddrInd	=	'3',ri.postdir,le.owner1_resi_postdir);
		self.owner1_resi_unit_desig			:=	if(ri.AddrInd	=	'3',ri.unit_desig,le.owner1_resi_unit_desig);
		self.owner1_resi_sec_range			:=	if(ri.AddrInd	=	'3',ri.sec_range,le.owner1_resi_sec_range);
		self.owner1_resi_p_city_name		:=	if(ri.AddrInd	=	'3',ri.p_city_name,le.owner1_resi_p_city_name);
		self.owner1_resi_v_city_name		:=	if(ri.AddrInd	=	'3',ri.v_city_name,le.owner1_resi_v_city_name);
		self.owner1_resi_state					:=	if(ri.AddrInd	=	'3',ri.state,le.owner1_resi_state);
		self.owner1_resi_zip5						:=	if(ri.AddrInd	=	'3',ri.zip5,le.owner1_resi_zip5);
		self.owner1_resi_zip4						:=	if(ri.AddrInd	=	'3',ri.zip4,le.owner1_resi_zip4);
		self.owner1_resi_rec_type				:=	if(ri.AddrInd	=	'3',ri.rec_type,le.owner1_resi_rec_type);
		self.owner1_resi_county					:=	if(ri.AddrInd	=	'3',ri.county,le.owner1_resi_county);
		self.owner1_resi_geo_lat				:=	if(ri.AddrInd	=	'3',ri.geo_lat,le.owner1_resi_geo_lat);
		self.owner1_resi_geo_long				:=	if(ri.AddrInd	=	'3',ri.geo_long,le.owner1_resi_geo_long);
		self.owner1_resi_cbsa						:=	if(ri.AddrInd	=	'3',ri.cbsa,le.owner1_resi_cbsa);
		self.owner1_resi_geo_blk				:=	if(ri.AddrInd	=	'3',ri.geo_blk,le.owner1_resi_geo_blk);
		self.owner1_resi_geo_match			:=	if(ri.AddrInd	=	'3',ri.geo_match,le.owner1_resi_geo_match);
		self.owner1_resi_err_stat				:=	if(ri.AddrInd	=	'3',ri.err_stat,le.owner1_resi_err_stat);

		self.Append_Owner2MailRawAID		:=	if(ri.AddrInd	=	'4',ri.Append_RawAID,le.Append_Owner2MailRawAID);
		self.owner2_mail_prim_range			:=	if(ri.AddrInd	=	'4',ri.prim_range,le.owner2_mail_prim_range);
		self.owner2_mail_predir					:=	if(ri.AddrInd	=	'4',ri.predir,le.owner2_mail_predir);
		self.owner2_mail_prim_name			:=	if(ri.AddrInd	=	'4',ri.prim_name,le.owner2_mail_prim_name);
		self.owner2_mail_suffix					:=	if(ri.AddrInd	=	'4',ri.suffix,le.owner2_mail_suffix);
		self.owner2_mail_postdir				:=	if(ri.AddrInd	=	'4',ri.postdir,le.owner2_mail_postdir);
		self.owner2_mail_unit_desig			:=	if(ri.AddrInd	=	'4',ri.unit_desig,le.owner2_mail_unit_desig);
		self.owner2_mail_sec_range			:=	if(ri.AddrInd	=	'4',ri.sec_range,le.owner2_mail_sec_range);
		self.owner2_mail_p_city_name		:=	if(ri.AddrInd	=	'4',ri.p_city_name,le.owner2_mail_p_city_name);
		self.owner2_mail_v_city_name		:=	if(ri.AddrInd	=	'4',ri.v_city_name,le.owner2_mail_v_city_name);
		self.owner2_mail_state					:=	if(ri.AddrInd	=	'4',ri.state,le.owner2_mail_state);
		self.owner2_mail_zip5						:=	if(ri.AddrInd	=	'4',ri.zip5,le.owner2_mail_zip5);
		self.owner2_mail_zip4						:=	if(ri.AddrInd	=	'4',ri.zip4,le.owner2_mail_zip4);
		self.owner2_mail_rec_type				:=	if(ri.AddrInd	=	'4',ri.rec_type,le.owner2_mail_rec_type);
		self.owner2_mail_county					:=	if(ri.AddrInd	=	'4',ri.county,le.owner2_mail_county);
		self.owner2_mail_geo_lat				:=	if(ri.AddrInd	=	'4',ri.geo_lat,le.owner2_mail_geo_lat);
		self.owner2_mail_geo_long				:=	if(ri.AddrInd	=	'4',ri.geo_long,le.owner2_mail_geo_long);
		self.owner2_mail_cbsa						:=	if(ri.AddrInd	=	'4',ri.cbsa,le.owner2_mail_cbsa);
		self.owner2_mail_geo_blk				:=	if(ri.AddrInd	=	'4',ri.geo_blk,le.owner2_mail_geo_blk);
		self.owner2_mail_geo_match			:=	if(ri.AddrInd	=	'4',ri.geo_match,le.owner2_mail_geo_match);
		self.owner2_mail_err_stat				:=	if(ri.AddrInd	=	'4',ri.err_stat,le.owner2_mail_err_stat);

		self.Append_Owner2ResiRawAID		:=	if(ri.AddrInd	=	'5',ri.Append_RawAID,le.Append_Owner2ResiRawAID);
		self.owner2_resi_prim_range			:=	if(ri.AddrInd	=	'5',ri.prim_range,le.owner2_resi_prim_range);
		self.owner2_resi_predir					:=	if(ri.AddrInd	=	'5',ri.predir,le.owner2_resi_predir);
		self.owner2_resi_prim_name			:=	if(ri.AddrInd	=	'5',ri.prim_name,le.owner2_resi_prim_name);
		self.owner2_resi_suffix					:=	if(ri.AddrInd	=	'5',ri.suffix,le.owner2_resi_suffix);
		self.owner2_resi_postdir				:=	if(ri.AddrInd	=	'5',ri.postdir,le.owner2_resi_postdir);
		self.owner2_resi_unit_desig			:=	if(ri.AddrInd	=	'5',ri.unit_desig,le.owner2_resi_unit_desig);
		self.owner2_resi_sec_range			:=	if(ri.AddrInd	=	'5',ri.sec_range,le.owner2_resi_sec_range);
		self.owner2_resi_p_city_name		:=	if(ri.AddrInd	=	'5',ri.p_city_name,le.owner2_resi_p_city_name);
		self.owner2_resi_v_city_name		:=	if(ri.AddrInd	=	'5',ri.v_city_name,le.owner2_resi_v_city_name);
		self.owner2_resi_state					:=	if(ri.AddrInd	=	'5',ri.state,le.owner2_resi_state);
		self.owner2_resi_zip5						:=	if(ri.AddrInd	=	'5',ri.zip5,le.owner2_resi_zip5);
		self.owner2_resi_zip4						:=	if(ri.AddrInd	=	'5',ri.zip4,le.owner2_resi_zip4);
		self.owner2_resi_rec_type				:=	if(ri.AddrInd	=	'5',ri.rec_type,le.owner2_resi_rec_type);
		self.owner2_resi_county					:=	if(ri.AddrInd	=	'5',ri.county,le.owner2_resi_county);
		self.owner2_resi_geo_lat				:=	if(ri.AddrInd	=	'5',ri.geo_lat,le.owner2_resi_geo_lat);
		self.owner2_resi_geo_long				:=	if(ri.AddrInd	=	'5',ri.geo_long,le.owner2_resi_geo_long);
		self.owner2_resi_cbsa						:=	if(ri.AddrInd	=	'5',ri.cbsa,le.owner2_resi_cbsa);
		self.owner2_resi_geo_blk				:=	if(ri.AddrInd	=	'5',ri.geo_blk,le.owner2_resi_geo_blk);
		self.owner2_resi_geo_match			:=	if(ri.AddrInd	=	'5',ri.geo_match,le.owner2_resi_geo_match);
		self.owner2_resi_err_stat				:=	if(ri.AddrInd	=	'5',ri.err_stat,le.owner2_resi_err_stat);

		self := ri;
		
		end;

	dDenormAddr							:=	denormalize(	dAppendSeqNumDist,
																						dAddrCombinedDist,
																						left.Append_SeqNum	=	right.Append_SeqNum,
																						tDenormAddr(left,right),
																						local
																					);
																					
	 //output(choosen(dDenormAddr,1000),,named('dDenormAddr'));
	 //output('dDenormAddr record count = ' + count(dDenormAddr));

	dAppendSeqNumDist1	:=	distribute(dDenormAddr,hash(Append_SeqNum));


// Normalize records by names so as to pass to cleaning name macro
	rAppendAIDNIDSeqNum_layout	tVehiclesNormName(dAppendSeqNumDist1	pInput,integer	cnt)	:=
	transform
		self.NameInd					:=	choose(cnt,'1','2');
		self.fname						:=	choose(cnt,pInput.RAW_OWNER1_FNAME,pInput.RAW_OWNER2_FNAME);
		self.mname						:=	choose(cnt,pInput.RAW_OWNER1_MNAME,pInput.RAW_OWNER2_MNAME);
		self.lname						:=	choose(cnt,pInput.RAW_OWNER1_LNAME,pInput.RAW_OWNER2_LNAME);
		self.myfullname				:=	choose(cnt,pInput.APPEND_OWNER1_NAME,pInput.APPEND_OWNER2_NAME);
		self.company_name			:=	choose(cnt,pInput.company_name1,pInput.company_name2);
		self									:=	pInput;
		self									:=  [];
	end;
	dNormalizeName	:=	normalize(dAppendSeqNumDist1,2,tVehiclesNormName(left,counter),local);

	//output(choosen(dNormalizeName,1000),,named('dNormalizeName'));
	//output('dNormalizeName record count = ' + count(dNormalizeName));

	prep_name_populated			:=	dNormalizeName(myfullname!='' and company_name='');
	prep_name_not_populated	:=	dNormalizeName(myfullname='' or company_name<>'');
	output(choosen(prep_name_populated,1000),,named('prep_name_populated'));
	output('prep_name_populated record count = ' + count(prep_name_populated));

	// Pass the records to the name cleaning macro
	NID.Mac_CleanParsedNames(prep_name_populated, getname,
															, firstname:=fname,middlename:=mname,lastname:=lname,namesuffix:=sname
															, includeInRepository:=true, normalizeDualNames:=true
														);
	 //output(choosen(getname,1000),,named('getname'));
	 //output('getname record count = ' + count(getname));

	// Combine the blank or invalid address records after passing to the AID macro
	rAppendAIDNIDSeqNum_layout txGetName(getname l) := TRANSFORM
		self.clean_title := l.cln_title;
		self.clean_fname := l.cln_fname;
		self.clean_mname := l.cln_mname;
		self.clean_lname := l.cln_lname;
		self.clean_suffix:= l.cln_suffix;
		SELF := l;
	END;

	dNameombined						:=	project(getname,txGetName(left))	+	prep_addr_not_populated;
	//dNameombined						:=	prep_name_populated	+	prep_addr_not_populated;
	//output(choosen(dNameombined,1000),,named('dNameombined'));
	//output('dNameombined record count = ' + count(dNameombined));

	dNameCombinedDist 			:=	distribute(dNameombined,hash(Append_SeqNum));
	
	// Denormalize records by names
	rAppendAIDNIDSeqNum_layout	tDenormName(dAppendSeqNumDist1	le,dNameCombinedDist	ri)	:=
	transform
		self.OWNER1_CLEAN_LNAME				:=	if(ri.NameInd	=	'1',ri.clean_lname,le.OWNER1_CLEAN_LNAME);
		self.OWNER1_CLEAN_MNAME				:=	if(ri.NameInd	=	'1',ri.clean_mname,le.OWNER1_CLEAN_MNAME);
		self.OWNER1_CLEAN_FNAME				:=	if(ri.NameInd	=	'1',ri.clean_fname,le.OWNER1_CLEAN_FNAME);
		self.OWNER1_CLEAN_TITLE				:=	if(ri.NameInd	=	'1',ri.clean_title,le.OWNER1_CLEAN_TITLE);
		self.OWNER1_CLEAN_SUFFIX			:=	if(ri.NameInd	=	'1',ri.clean_suffix,le.OWNER1_CLEAN_SUFFIX);
		self.OWNER2_CLEAN_LNAME				:=	if(ri.NameInd	=	'2',ri.clean_lname,le.OWNER2_CLEAN_LNAME);
		self.OWNER2_CLEAN_MNAME				:=	if(ri.NameInd	=	'2',ri.clean_mname,le.OWNER2_CLEAN_MNAME);
		self.OWNER2_CLEAN_FNAME				:=	if(ri.NameInd	=	'2',ri.clean_fname,le.OWNER2_CLEAN_FNAME);
		self.OWNER2_CLEAN_TITLE				:=	if(ri.NameInd	=	'2',ri.clean_title,le.OWNER2_CLEAN_TITLE);
		self.OWNER2_CLEAN_SUFFIX			:=	if(ri.NameInd	=	'2',ri.clean_suffix,le.OWNER2_CLEAN_SUFFIX);
		self														:=	le;
	end;

	dDenormName							:=	denormalize(	dAppendSeqNumDist1,
																						dNameCombinedDist,
																						left.Append_SeqNum	=	right.Append_SeqNum,
																						tDenormName(left,right),
																						local
																					);
																					
	//output(choosen(dDenormName,1000),,named('dDenormName'));
	//output('dDenormName record count = ' + count(dDenormName));

	VehicleV2.Layout_MA.MA_as_VehicleV2	MAToCommon(dDenormName	L)	:= 
	TRANSFORM
		SELF.DT_VENDOR_FIRST_REPORTED		:= (UNSIGNED) L.process_date;
		SELF.DT_VENDOR_LAST_REPORTED		:= (UNSIGNED) L.process_date;
		SELF.RAW_REG_PREFIX							:= TRIM(L.REG_PREFIX);
		SELF.PLATE_TYPE									:= TRIM(L.REG_PREFIX);
		SELF.RAW_REG_EFF_DATE						:= TRIM(L.REG_EFF_DATE);
		SELF.REGISTRATION_EFFECTIVE_DATE:= IF(L.REG_EFF_DATE[1..2] IN ['19','20'],TRIM(L.REG_EFF_DATE),'');
		SELF.RAW_REG_EXP_DATE						:= TRIM(L.REG_EXP_DATE);
		SELF.REGISTRATION_EXPIRATION_DATE:= IF(L.REG_EXP_DATE[1..2] IN ['19','20'],
		                                       TRIM(L.REG_EXP_DATE)+(STRING2) (_Validate.Date.fDaysInMonth((integer) L.REG_EXP_DATE[1..4],(integer) L.REG_EXP_DATE[5..6])),
																					 '');
		SELF.RAW_REG_PLTISS_DATE				:= TRIM(L.REG_PLTISS_DATE);
		SELF.REGISTRATION_ISSUE_DATE		:= IF(L.REG_PLTISS_DATE[1..2] IN ['19','20'],TRIM(L.REG_PLTISS_DATE),'');
		SELF.RAW_VEHT_PURCHDATE					:= L.VEHT_PURCHDATE;
		SELF.RAW_VEHT_TITLEDATE					:= L.VEHT_TITLEDATE;
		SELF.TITLE_ISSUE_DATE						:= IF(L.VEHT_TITLEDATE<>'00000000' AND L.VEHT_TITLEDATE[1..2] IN ['19','20'],
		                                      TRIM(L.VEHT_TITLEDATE),
																					IF(L.VEHT_PURCHDATE<>'00000000' AND  L.VEHT_PURCHDATE[1..2] IN ['19','20'],TRIM(L.VEHT_PURCHDATE),''));
		self.dt_first_seen							:=	fBestSeenDate(SELF.REGISTRATION_ISSUE_DATE,SELF.TITLE_ISSUE_DATE,L.process_date);
		self.dt_last_seen								:=	fBestSeenDate(SELF.REGISTRATION_ISSUE_DATE,SELF.TITLE_ISSUE_DATE,L.process_date);

		SELF.HISTORY										:= IF(SELF.REGISTRATION_EXPIRATION_DATE[1..6]<ut.GetDate[1..6] AND (unsigned4)(self.REGISTRATION_EXPIRATION_DATE[1..6])<>0,
		                                   'E',
																			 '');
		SELF.TRUE_LICENSE_PLSTE_NUMBER	:= StringLib.StringTouPPERCase(TRIM(L.REG_NUMBER));
		SELF.REGISTRATION_STATUS_CODE		:= '';
		SELF.RAW_VIN										:= TRIM(L.VEH_VIN);
		SELF.ORIG_VIN										:= TRIM(L.VEH_VIN);
		SELF.RAW_VEH_YRMFGR							:= TRIM(L.VEH_YRMFGR);
		SELF.YEAR_MAKE									:= TRIM(L.VEH_YRMFGR);
		SELF.RAW_VEH_MFGR								:= TRIM(L.VEH_MFGR);
		self.MAKE_CODE									:= trim(L.VEH_MFGR, left, right);

		SELF.RAW_VEH_BODY_STYLE					:= TRIM(L.VEH_BODY_STYLE);
		SELF.RAW_VEH_NUM_DOORS					:= TRIM(L.VEH_NUM_DOORS);
		SELF.BODY_CODE									:= TRIM(L.VEH_BODY_STYLE);
		SELF.body_style_description			:= TRIM(L.VEH_BODY_STYLE + 
		                                        IF(L.VEH_NUM_DOORS<>'' AND L.VEH_NUM_DOORS<>'0',' '+L.VEH_NUM_DOORS + ' Door',''));
		SELF.RAW_VEH_MODL_NUMB					:= TRIM(L.VEH_MODL_NUMB);
		SELF.RAW_VEH_MODL_NAME					:= TRIM(L.VEH_MODL_NAME);
		SELF.ORIG_MODEL_DESC						:= IF(TRIM(L.VEH_MODL_NAME)=TRIM(L.VEH_MODL_NUMB),
																					TRIM(L.VEH_MODL_NAME),
		                                      stringlib.stringCleanSpaces(L.VEH_MODL_NAME + ' ' + L.VEH_MODL_NUMB));

		SELF.RAW_TRANSMISSION_TYPE			:= L.TRANSMISSION_TYPE;
		SELF.RAW_COMMERCIAL_GVW_THOUSANDS := L.COMMERCIAL_GVW_THOUSANDS;
		SELF.ORIG_GROSS_WEIGHT					:= L.COMMERCIAL_GVW_THOUSANDS + '000';
		SELF.RAW_VEH_NUM_CYLL						:= L.VEH_NUM_CYLL;
		SELF.number_of_cylinders				:= (unsigned2) L.VEH_NUM_CYLL;
		
		SELF.RAW_TITLE_PREFIX						:= L.TITLE_PREFIX;
		SELF.RAW_TITLE_NUMBER						:= L.TITLE_NUMBER;
		SELF.TITLE_NUMBER								:= IF(L.TITLE_PREFIX='' AND REGEXFIND('^[0]+$',TRIM(L.TITLE_NUMBER)),
		                                      '',
																					TRIM(L.TITLE_PREFIX)+TRIM(L.TITLE_NUMBER));

		SELF.RAW_VEHR_TYPE							:= L.VEHR_TYPE;
		SELF.RAW_VEHC_TYPE							:= L.VEHC_TYPE;
		SELF.VEHICLE_TYPE								:= MA_Vehicle_Type_Mapping(L.VEH_BODY_STYLE);

		SELF.RAW_MAJOR_COLOR_CODE				:= L.COLOR_MAJOR;
		SELF.MAJOR_COLOR_CODE						:= MA_Vehicle_Color_Code_Mapping(L.COLOR_MAJOR);
		SELF.RAW_MINOR_COLOR_CODE				:= L.COLOR_MINOR;		
		SELF.MINOR_COLOR_CODE						:= MA_Vehicle_Color_Code_Mapping(L.COLOR_MINOR);
	
		//Addresses and names
		SELF.RAW_VEHMAIL_STREET1				:= L.VEHMAIL_STREET1;  
    SELF.RAW_VEHMAIL_STREET2				:= L.VEHMAIL_STREET2;   
    SELF.RAW_VEHMAIL_CITY						:= L.VEHMAIL_CITY;   
    SELF.RAW_VEHMAIL_STATE					:= L.VEHMAIL_ST;   
    SELF.RAW_VEHMAIL_ZIP						:= L.VEHMAIL_ZIP;  
		//SELF.Append_MailAddr1						:= L.Append_MailAddr1;
		//SELF.Append_MailAddr2						:= L.Append_MailAddr2;
		//SELF.Append_MailRawAID				  := L.Append_MailRawAID;
		SELF.RAW_OWNER1_TYPE 						:= L.OWNER1_TYPE;
		SELF.RAW_OWNER1_LIC_NUM 				:= L.OWNER1_LICNO;
		SELF.RAW_OWNER1_BDATE 					:= L.OWNER1_BDATE;
		SELF.RAW_OWNER1_EDATE 					:= L.OWNER1_EDATE;
		SELF.RAW_OWNER1_LIC_CLASS 			:= L.OWNER1_LIC_CLASS;
		//User owner1_type (provided by owner) and Append_Owner1NameTypeInd to determine if the name for business or personal
		SELF.RAW_OWNER1_MAIL_STREET1 		:= L.OWNER1_MAIL_STREET1;
		SELF.RAW_OWNER1_MAIL_STREET2 		:= L.OWNER1_MAIL_STREET2;
		SELF.RAW_OWNER1_MAIL_CITY 			:= L.OWNER1_MAIL_CITY;
		SELF.RAW_OWNER1_MAIL_STATE 			:= L.OWNER1_MAIL_ST;
		SELF.RAW_OWNER1_MAIL_ZIP 				:= L.OWNER1_MAIL_ZIP;
		//SELF.Append_Reg1MailAddr1				:= L.Append_Reg1MailAddr1;
		//SELF.Append_Reg1MailAddr2				:= L.Append_Reg1MailAddr2;
		//SELF.Append_Reg1MailRawAID		  := L.Append_Reg1MailRawAID;
		SELF.RAW_OWNER1_RESI_STREET1 		:= L.OWNER1_RESI_STREET1;
		SELF.RAW_OWNER1_RESI_STREET2 		:= L.OWNER1_RESI_STREET2;
		SELF.RAW_OWNER1_RESI_CITY 			:= L.OWNER1_RESI_CITY;
		SELF.RAW_OWNER1_RESI_STATE 			:= L.OWNER1_RESI_ST;
		SELF.RAW_OWNER1_RESI_ZIP 				:= L.OWNER1_RESI_ZIP;
		//SELF.Append_Reg1ResiAddr1				:= L.Append_Reg1ResiAddr1;
		//SELF.Append_Reg1ResiAddr2				:= L.Append_Reg1ResiAddr2;
		//SELF.Append_Reg1ResiRawAID		  := L.Append_Reg1ResiRawAID;
		SELF.RAW_OWNER2_TYPE 						:= L.OWNER2_TYPE;
		SELF.RAW_OWNER2_LIC_NUM 				:= L.OWNER2_LICNO;
		SELF.RAW_OWNER2_BDATE 					:= L.OWNER2_BDATE;
		SELF.RAW_OWNER2_EDATE 					:= L.OWNER2_EDATE;
		SELF.RAW_OWNER2_LIC_CLASS 			:= L.OWNER2_LIC_CLASS;
		//User owner2_type (provided by owner) and Append_Owner2NameTypeInd to determine if the name for business or personal
		boolean is_owner2_business			:= If(L.OWNER1_TYPE='2' OR L.Append_Owner1NameTypeInd='B',TRUE,FALSE);
		SELF.RAW_OWNER2_LNAME 					:= L.OWNER2_LAST_NAME;
		SELF.RAW_OWNER2_FNAME 					:= L.OWNER2_FIRST_NAME;
		SELF.RAW_OWNER2_MNAME 					:= L.OWNER2_MIDDLE_NAME;
		SELF.COMPANY_NAME2							:= IF(is_owner2_business,
																					stringlib.stringCleanSpaces(
																								 TRIM(L.OWNER2_LAST_NAME) + ' ' + TRIM(L.FILLER4) +
																								 TRIM(L.OWNER2_FIRST_NAME) + ' ' + TRIM(L.FILLER5) +
																								 TRIM(L.OWNER2_MIDDLE_NAME) + ' ' + TRIM(L.FILLER6)),
																					'');			 
		SELF.RAW_OWNER2_MAIL_STREET1 		:= L.OWNER2_MAIL_STREET1;
		SELF.RAW_OWNER2_MAIL_STREET2 		:= L.OWNER2_MAIL_STREET2;
		SELF.RAW_OWNER2_MAIL_CITY 			:= L.OWNER2_MAIL_CITY;
		SELF.RAW_OWNER2_MAIL_STATE 			:= L.OWNER2_MAIL_ST;
		SELF.RAW_OWNER2_MAIL_ZIP 				:= L.OWNER2_MAIL_ZIP;
		//SELF.Append_Reg2MailAddr1				:= L.Append_Reg2MailAddr1;
		//SELF.Append_Reg2MailAddr2				:= L.Append_Reg2MailAddr2;
		//SELF.Append_Reg2MailRawAID		  := L.Append_Reg2MailRawAID;
		SELF.RAW_OWNER2_RESI_STREET1 		:= L.OWNER2_RESI_STREET1;
		SELF.RAW_OWNER2_RESI_STREET2 		:= L.OWNER2_RESI_STREET2;
		SELF.RAW_OWNER2_RESI_CITY 			:= L.OWNER2_RESI_CITY;
		SELF.RAW_OWNER2_RESI_STATE 			:= L.OWNER2_RESI_ST;
		SELF.RAW_OWNER2_RESI_ZIP 				:= L.OWNER2_RESI_ZIP;
		//SELF.Append_Reg2ResiAddr1				:= L.Append_Reg2ResiAddr1;
		//SELF.Append_Reg2ResiAddr2				:= L.Append_Reg2ResiAddr2;
		//SELF.Append_Reg2ResiRawAID		  := L.Append_Reg2ResiRawAID;
		SELF.RAW_VEHT_TITLE_MILAGE			:= TRIM(L.VEHT_TITLE_MILAGE);

		//Set up fields in the vendor file and will not be used by LN
		SELF.RAW_VEHC_SURROGATE					:= L.VEHC_SURROGATE;
		SELF.RAW_CUMULATIVE_INTERFACE_CODE := L.CUMULATIVE_INTERFACE_CODE;
		SELF.RAW_REG_COLOR							:= L.REG_COLOR;
		SELF.RAW_REG_STACHG_DATE				:= L.REG_STACHG_DATE;
		SELF.RAW_VEH_NUM_PASS						:= L.VEH_NUM_PASS;
		SELF.RAW_VEHR_ADVANCED					:= L.VEHR_ADVANCED;
		SELF.RAW_PLACE_OF_GARAGING			:= L.PLACE_OF_GARAGING;
		SELF.RAW_JUNKED_VEHICLE					:= L.JUNKED_VEHICLE;
		SELF.RAW_INSURANCE_CODE					:= L.INSURANCE_CODE;
		SELF.RAW_OWNER1_HEIGHT 					:= L.OWNER1_HEIGHT;
		SELF.RAW_OWNER1_SEX 						:= L.OWNER1_SEX;
		SELF.RAW_OWNER2_HEIGHT 					:= L.OWNER2_HEIGHT;
		SELF.RAW_OWNER2_SEX 						:= L.OWNER2_SEX;
		SELF.RAW_EXCISE_MSRP						:= L.EXCISE_MSRP;
		SELF.RAW_VEHT_LIEN_KEY1					:= L.VEHT_LIEN_KEY1;
		SELF.RAW_VEHT_LIEN_TYPE1				:= L.VEHT_LIEN_TYPE1;
		SELF.RAW_VEHT_LIEN_KEY2					:= L.VEHT_LIEN_KEY2;
		SELF.RAW_VEHT_LIEN_TYPE2				:= L.VEHT_LIEN_TYPE2;
		SELF.RAW_VEHT_TITLE_BRAN				:= L.VEHT_TITLE_BRAN;
		SELF.RAW_BRAN_TABLE_BASE				:= L.BRAN_TABLE_BASE;
		
		SELF := L;
		SELF := [];
	END;	
	
	//Map to MA base layout
	dsUpdate := PROJECT(dDenormName, MAToCommon(LEFT));
export	Map_MA_Update	:=	dsUpdate : persist('~thor_data400::persist::vehicleV2::ma_update');
	


