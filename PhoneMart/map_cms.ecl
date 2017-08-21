IMPORT header_quick, yellowpages, Cellphone;
#OPTION('multiplePersistInstances',FALSE);

EXPORT map_cms(STRING8 filedate) := FUNCTION

	//Use CID_NUMBER to derive DID from header_quick.file_header_quick
	//input file
	pm_cms 			:= PhoneMart.Files.PhoneMart_CMS;
	
	bad_dn := ['1234567890','9198789987','123456789','8014936558','9198789987','8014936558','2079898998',
		         '7136630127','6264057914','5072842511','2102222222','8004986761','3019478352','3166892417',
						 '6064787426','7032558011','7075269638','3306686015','8014936558','9198789987','6109980000',
						 '7862753185','9727906100','3178965412','4126473087','9144250046','5103716027','8459383030',
						 '8329259765','9048038263','8325670596','5125605147','3104300433','8179257213','5163004135',
						 '9194289998','9178802730'];
	pm_cms_good_dn := pm_cms(length(phone)=10 AND 
		                       TRIM(phone) NOT IN bad_dn AND
													 NOT REGEXFIND('(1111111|2222222|3333333|4444444|5555555|6666666|7777777|8888888|9999999|0000000|1234567)',phone));

	//BUG 189909 - Filter out phone numbers that have more than 1000 records in the raw data file
	dn_threhold := 1000;
	dn_cnt := table(pm_cms_good_dn,{phone,cnt:=count(group)},phone);
	dn_remove_list := dn_cnt(cnt>dn_threhold);
	pm_cms_filtered := JOIN(DISTRIBUTE(pm_cms_good_dn,hash(phone)),
	                        DISTRIBUTE(dn_remove_list,hash(phone)),
													LEFT.PHONE=RIGHT.PHONE,
													TRANSFORM({pm_cms_good_dn},SELF:=LEFT;),
													LEFT ONLY, LOCAL);
													
	//Filter out records with invalid phone numbers
	yellowpages.NPA_PhoneType(pm_cms_filtered, phone, phonetype, outfile);
	pm_cms_sel	:= PROJECT(outfile(phonetype<>'INVALID-NPA/NXX/TB'), {pm_cms_filtered});

	//header file - filter out records without did or vendor_id
	hdr_eqx 		:= header_quick.file_header_quick(did<>0 AND vendor_id<>'' AND (src IN ['EQ','QH','WH']));
	hdr_eqx_latest 		:= ROLLUP(SORT(DISTRIBUTE(hdr_eqx, did),did,-dt_last_seen,-dt_first_seen, local), 
	                            LEFT.did=RIGHT.did, 
															TRANSFORM({hdr_eqx},SELF:=LEFT;));
	
	PhoneMart.Layouts.base tx(pm_cms_sel L, hdr_eqx_latest R) := TRANSFORM
		SELF.record_type							:='1';
		SELF.SSN 											:= '';                           
		SELF.DT_VENDOR_FIRST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_VENDOR_LAST_REPORTED	:=(UNSIGNED4) filedate;
		SELF.DT_FIRST_SEEN						:=(UNSIGNED4) L.FIRST_SEEN_DATE;
		SELF.DT_LAST_SEEN							:=(UNSIGNED4) L.LAST_SEEN_DATE;
		////BUG 186973 - Populate address fields
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
		SELF.CID_NUMBER								:= R.vendor_id;					//We can not use cid_number from input file
		SELF													:= L;
		SELF													:= R;
		SELF:=[];
	END;
	
	base_cms		:= JOIN(DISTRIBUTE(pm_cms_sel, HASH(CID_NUMBER)),
										DISTRIBUTE(hdr_eqx_latest,hash(vendor_id)),	
										LEFT.CID_NUMBER=RIGHT.vendor_id,
										tx(LEFT, RIGHT),
										LEFT OUTER, LOCAL);

	base_cms_dedup := DEDUP(SORT(DISTRIBUTE(base_cms,HASH(phone)),RECORD,LOCAL),RECORD,ALL,LOCAL)
	                   : PERSIST('~thor_data400::persist::phonemart::map_cms');
										 
	RETURN base_cms_dedup; 
 
 END;
