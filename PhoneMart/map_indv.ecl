IMPORT header_quick, yellowpages, Cellphone, ut, AID, did_Add;
#OPTION('multiplePersistInstances',FALSE);

EXPORT map_indv(STRING8 filedate) := FUNCTION

	//BUG 186973 -    
	//  1. populate DID by calling did_add.MAC_Match_Flex using vendor provided name, SSN, address to find matching DID.
	//	2. populate name, address, city, state, and zip from name/address fields in header(equifax only).

	layout_plus := record
		unsigned6 	did;
		unsigned6 	did_pii := 0;
		PhoneMart.Layouts.Indv;
		string 			address2;
		Unsigned8		rawAID := 0;
		string10	  cleaned_PRIM_RANGE;
		string2     cleaned_PREDIR;
		string28	  cleaned_PRIM_NAME;
		string4     cleaned_ADDR_SUFFIX;
		string2     cleaned_POSTDIR;
		string10    cleaned_UNIT_DESIG;
		string8		  cleaned_SEC_RANGE;
		string30    cleaned_P_CITY_NAME;   	// increase length to accommodate Canadian City
		string25    cleaned_V_CITY_NAME;
		string2		  cleaned_STATE;
		string6		  cleaned_ZIP;						// increase length to accommodate Canadian Zip
		string8			dob := '';
		string2 		src := '';
		string10		mname := '';
		string5			name_suffix := '';
	end;	

	//input file
	pm_indv					:= PhoneMart.Files.PhoneMart_Indv;
	
	bad_dn := ['1234567890','9198789987','123456789','8014936558','9198789987','8014936558','2079898998',
						 '7136630127','6264057914','5072842511','2102222222','8004986761','3019478352','3166892417',
						 '6064787426','7032558011','7075269638','3306686015','8014936558','9198789987','6109980000',
						 '7862753185','9727906100','3178965412','4126473087','9144250046','5103716027','8459383030',
						 '8329259765','9048038263','8325670596','5125605147','3104300433','8179257213','5163004135',
						 '9194289998','9178802730'];
	pm_indv_good_dn := pm_indv(length(phone)=10 AND 
														 TRIM(phone) NOT IN bad_dn AND
														 NOT REGEXFIND('(1111111|2222222|3333333|4444444|5555555|6666666|7777777|8888888|9999999|0000000|1234567)',phone));

	//BUG 189909 - Filter out phone numbers that have more than 1000 records in the raw data file
	dn_threhold := 1000;
	dn_cnt := table(pm_indv_good_dn,{phone,cnt:=count(group)},phone);
	dn_remove_list := dn_cnt(cnt>dn_threhold);
	pm_indv_filtered_1 := JOIN(DISTRIBUTE(pm_indv_good_dn,hash(phone)),
														 DISTRIBUTE(dn_remove_list,hash(phone)),
														 LEFT.PHONE=RIGHT.PHONE,
														 TRANSFORM({pm_indv_good_dn},SELF:=LEFT;),
														 LEFT ONLY,
														 LOCAL);

	//BUG 185365 - remove records with bad SSNs 
	bad_ssn := ['000011111','000110000','000111111','000112222','001000000','001000001','001010101','001010011',
	            '001020003','009999999','078051120','111000000','111001111','111110000','111111234',
							'111112222','111221111','111221313','111222222','111224444','123111111','123451111','112223333',
							'111223344','121121212','123459999','141000000','123451234','123456123','123456987','123654789',
							'123457890','123457896','123654789','909090909','789654123','333220000','111441111',
							'000110000','131313131','222334455','300000000','333221111','229229229','321321321',
	            '126111213','424508582','454545454','666036666','987987987','999020202','555443333','111111222',
							'333224444','444556666','909909090','999991234','123123456','111999999','001010011','414111111',
							'112233333','112233445','001020003','999887777','977111111','123456879','123456666','989898989',
							'144111111','555446666','123000000','222112222','545454545','222221111','123457899','123999999',
							'555889999','123546789','777889999','999009999','111221212','123459876','111122222','987456321',
							'123450000','234234234','111225555','222111111','111222111','222113333','141414141','140111111',
							'444554444','999090909','000123456','513555555','123001234','223330000','555225555','123121235',
							'321456789','111121234','123456456','101101010','151515151','530111111','123457895','111114444',
							'149111111','010111111','555123456','123455555','111223334','999119999','680680680','123412341',
							'898989898','123458888','999060606','121212122','123457891','011010101','123111234','111115555',
							'111221234','123121212','111223456','123654987','121211212','121221212','123454567','142111111',
							'123465789','143111111','999995555','111122333','612097564','111221122','191919191','141411111',
							'132456789','252525252','111121112','123457894','000100000','000999999','555115555','123555555',
							'123457789','999996666','555554444','111111212','456454564','123454545','111121212','555551212',						
							'696969696','111991111','323232323','615293290','123454321','123124567','001100001','444111111',
							'555559999','232232323','123456890','112121212','525252525','222223333','999998888','600123456',
							'234232342','555551111','123456897','000990000','111111000','111220000','213213213','002020002'];	
	pm_indv_good_dn_ssn	:= pm_indv_filtered_1(TRIM(ssn)  NOT IN ut.Set_BadSSN AND TRIM(ssn)  NOT IN bad_ssn AND
																					NOT REGEXFIND('(1111111|2222222|3333333|4444444|5555555|6666666|7777777|8888888|9999999|0000000|1234567)',ssn));

	//BUG 189909 - Filter out phone numbers that have more than 1000 records in the raw data file
	ssn_threhold := 1000;
	ssn_cnt := TABLE(pm_indv_good_dn_ssn(ssn<>''),{ssn,cnt:=COUNT(GROUP)},ssn);
	ssn_remove_list := ssn_cnt(cnt>ssn_threhold);
	pm_indv_filtered_2 := JOIN(DISTRIBUTE(pm_indv_good_dn_ssn(ssn<>''),hash(ssn)),
														 DISTRIBUTE(ssn_remove_list,hash(ssn)),
														 LEFT.ssn=RIGHT.ssn,
														 TRANSFORM({pm_indv_good_dn_ssn},SELF:=LEFT;),
														 LEFT ONLY,
														 LOCAL);
	pm_indv_prep	:= 	DISTRIBUTE(pm_indv_filtered_2 + pm_indv_good_dn_ssn(ssn=''), HASH(phone));
	
	//Filter out records with invalid phone numbers
	yellowpages.NPA_PhoneType(pm_indv_prep, phone, phonetype, outfile);
	pm_indv_sel				:= PROJECT(outfile(phonetype<>'INVALID-NPA/NXX/TB'), {pm_indv_prep});
	
	//header file - filter out records without did or ssn
	hdr_eqx 					:= header_quick.file_header_quick(did<>0 AND ssn<>'' AND (src IN ['EQ','QH','WH']));
	hdr_eqx_latest 		:= ROLLUP(SORT(DISTRIBUTE(hdr_eqx, did),did,-dt_last_seen,-dt_first_seen, local), 
	                            LEFT.did=RIGHT.did, 
															TRANSFORM({hdr_eqx},SELF:=LEFT;));

	//match SSN
	match_ssn 				:= JOIN(DISTRIBUTE(pm_indv_sel, hash(ssn)),
														DISTRIBUTE(hdr_eqx,hash(ssn)),
														TRIM(LEFT.ssn)=TRIM(RIGHT.ssn),
														TRANSFORM(layout_plus, SELF.did := (UNSIGNED6) RIGHT.did; 
																									 SELF.ssn := RIGHT.ssn;								//Per contract, SSN in vendor's file is for lookup only, can not be displayed.
																									 SELF:=LEFT;SELF:=[];),
														LEFT OUTER, LOCAL);
															
	match_ssn_did_zero_dedup := dedup(sort(distribute(match_ssn(did=0),hash(lname,fname,city,state,zipcode)),record,local),record,local);

	//clean the address and then get lexid using cleaned address
	layout_plus constructAddr(match_ssn_did_zero_dedup L) := TRANSFORM
		 SELF.addr 			:= ut.CleanSpacesAndUpper(L.addr);
		 SELF.address2 	:= ut.CleanSpacesAndUpper(TRIM(L.city,left,right) + ', ' + L.state + ' ' + L.zipcode);
		 SELF := L;
	END;
	pre_AID_clean 	:= PROJECT(match_ssn_did_zero_dedup, constructAddr(LEFT));
	// AID
	unsigned4	lFlags:= AID.Common.eReturnValues.RawAID | AID.Common.eReturnValues.ACECacheRecords;
	AID.MacAppendFromRaw_2Line(pre_AID_clean, addr, address2, RawAID, withAID, lFlags);

	layout_plus tGetStandardizedAddress(withAID L) :=	transform
			self.cleaned_prim_range		:= L.AIDWork_ACECache.prim_range;
			self.cleaned_predir				:= L.AIDWork_ACECache.predir;
			self.cleaned_prim_name		:= L.AIDWork_ACECache.prim_name;
			self.cleaned_addr_suffix	:= L.AIDWork_ACECache.addr_suffix;
			self.cleaned_postdir			:= L.AIDWork_ACECache.postdir;
			self.cleaned_unit_desig		:= L.AIDWork_ACECache.unit_desig;
			self.cleaned_sec_range		:= L.AIDWork_ACECache.sec_range;
			self.cleaned_p_city_name	:= L.AIDWork_ACECache.p_city_name;
			self.cleaned_v_city_name	:= L.AIDWork_ACECache.v_city_name;
			self.cleaned_state				:= L.AIDWork_ACECache.st;
			self.cleaned_zip					:= L.AIDWork_ACECache.zip5;
			self 											:= L;
	end;		
	after_aid_clean :=	project(withAID,tGetStandardizedAddress(left));

	matchset	:=	['A','S','P'];

	did_Add.MAC_Match_Flex(	after_aid_clean,matchset,						
													ssn,foo,fname,mname,lname,name_suffix,
													cleaned_prim_range,cleaned_prim_name,cleaned_sec_range,cleaned_zip,cleaned_state,phone,
													did_pii,
													layout_plus,
													false,'',	//these should default to zero in definition
													75,
													match_pii_dedup1//,true,src
												);

	layout_slim := record
		unsigned6 	did;
		PhoneMart.Layouts.Indv-[ADDR,CITY,STATE,ZIPCODE,FNAME,LNAME];
	end;	
	//Remove PII dirived from vendor info	which includes SSN for match_pii_dedup1.
	combined  			:= PROJECT(match_ssn(did<>0), transform(layout_slim,SELF:=LEFT;SELF:=[];))+ 
	                   PROJECT(match_pii_dedup1,transform(layout_slim,self.did:=left.did_pii;self.ssn:='';SELF:=LEFT;SELF:=[];));
	combined_dedup	:= DEDUP(SORT(DISTRIBUTE(combined,HASH(phone,did)),RECORD,LOCAL),RECORD,LOCAL);

	PhoneMart.Layouts.base tx(combined_dedup L, hdr_eqx_latest R) := TRANSFORM
		SELF.record_type							:='4';
		SELF.DT_VENDOR_FIRST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_VENDOR_LAST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_FIRST_SEEN						:=(UNSIGNED4) L.FIRST_SEEN_DATE;
		SELF.DT_LAST_SEEN							:=(UNSIGNED4) L.LAST_SEEN_DATE;
		//
		SELF.ADDRESS 									:= StringLib.StringCleanSpaces(R.prim_range + ' ' +
																								R.predir + ' ' +
																								R.prim_name + ' ' +
																								R.suffix + ' ' +
																								R.postdir +
																								IF(TRIM(R.unit_desig+R.sec_range)<>'',
																									 ', ' + StringLib.StringCleanSpaces(R.unit_desig + ' ' + R.sec_range),
																									 ''));	
		SELF.CITY 										:= R.city_name;
		SELF.STATE 										:= R.st;
		SELF.ZIPCODE 									:= R.zip;
		SELF.TITLE										:= R.title;
		SELF.FNAME										:= R.fname;
		SELF.MNAME										:= R.mname;
		SELF.LNAME										:= R.lname;
		SELF.NAME_SUFFIX							:= R.name_suffix;
		SELF													:=L;
		SELF													:=R;
		SELF:=[];
	END;

	PhoneMart.Layouts.base tx1(combined_dedup L) := TRANSFORM
		SELF.record_type							:='4';
		SELF.DT_VENDOR_FIRST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_VENDOR_LAST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_FIRST_SEEN						:=(UNSIGNED4) L.FIRST_SEEN_DATE;
		SELF.DT_LAST_SEEN							:=(UNSIGNED4) L.LAST_SEEN_DATE;
		SELF													:=L;
		SELF:=[];
	END;

	//Get the name and address info from HDR
	base_indv_did		:= JOIN(DISTRIBUTE(combined_dedup(did<>0), did),
													DISTRIBUTE(hdr_eqx_latest,did),	
													LEFT.did=RIGHT.did,
													tx(LEFT,RIGHT),
													LEFT OUTER, LOCAL);
	base_indv_other	:= PROJECT(combined_dedup(did=0),tx1(LEFT));
	
	base_indv_dedup := DEDUP(SORT(DISTRIBUTE(base_indv_did+base_indv_other,HASH(phone)),RECORD,LOCAL),RECORD,ALL,LOCAL)
	                   : PERSIST('~thor_data400::persist::phonemart::map_indv');
										 
	RETURN base_indv_dedup; 
 
 END;
