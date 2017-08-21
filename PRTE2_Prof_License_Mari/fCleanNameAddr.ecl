IMPORT ut,STD, PRTE2_Prof_License_Mari, Address,Prof_license_mari;

EXPORT fCleanNameAddr(DATASET(PRTE2_Prof_License_Mari.layouts.search) dsBaseFile) := FUNCTION	
	
recordof(dsBaseFile) xCleanNameAddr(recordof(dsBaseFile) L) := TRANSFORM
// ---------------------
// MD => Identify as Individual Record
// GR => Identify as Business Record
//----------------------
lfm := STD.Str.CleanSpaces(trim(L.name_last)+ ' '+ if(L.name_sufx <> '', trim(L.name_sufx)+', ', ', ')+ trim(L.name_first) +' '+ trim(L.name_mid));
clean_name :=  MAP(L.type_cd = 'MD' and L.name_org_orig <> '' and L.name_format = 'L' => Address.CleanPersonLFM73(L.name_org_orig),
									 L.type_cd = 'MD' and L.name_org_orig <> '' and L.name_format = 'F' => Address.CleanPersonFML73(L.name_org_orig),	
								   L.type_cd = 'GR' and lfm <> '' => Address.CleanPersonLFM73(lfm),
												    '');
														
SELF.TITLE				:= clean_name[1..5];
SELF.FNAME				:= IF(clean_name != '',trim(clean_name[6..25],LEFT,RIGHT),L.NAME_FIRST);
SELF.MNAME				:= IF(clean_name != '',trim(clean_name[26..45],LEFT,RIGHT),L.NAME_MID);
SELF.LNAME				:= IF(clean_name != '',trim(clean_name[46..65],LEFT,RIGHT),L.NAME_LAST);
SELF.NAME_SUFFIX	:= IF(clean_name != '',trim(clean_name[66..70],LEFT,RIGHT), L.NAME_SUFX);
SELF.NAME_COMPANY	:= IF(L.type_cd = 'GR' and L.name_mari_org != '', L.name_mari_org, L.name_office);
SELF.NAME_COMPANY_DBA := IF(L.NAME_MARI_DBA <> '', L.NAME_MARI_DBA, L.NAME_DBA);

//Cleaning Business Address
Append_BusAddressFirst	:= address.fn_addr_clean_prep(TRIM(TRIM(l.ADDR_ADDR1_1, LEFT,RIGHT) + ' ' + TRIM(l.ADDR_ADDR2_1,LEFT,RIGHT)),'first');	
Append_BusAddressLast	:=	address.fn_addr_clean_prep(TRIM(l.ADDR_CITY_1,LEFT,RIGHT) 
																													 + IF(l.ADDR_CITY_1 <> '',', ','') + TRIM(l.ADDR_STATE_1,LEFT,RIGHT) 
																													 + ' ' + TRIM(l.ADDR_ZIP5_1,LEFT,RIGHT),'last');
clean_address_bus := Address.CleanAddress182(Append_BusAddressFirst,Append_BusAddressLast);	
SELF.Append_BusAddrFirst := Append_BusAddressFirst; 
SELF.Append_BusAddrLast	 :=	Append_BusAddressLast;
self.BUS_PRIM_RANGE 	:= clean_address_bus[1..10];
self.BUS_PREDIR				:= clean_address_bus[11..12];
self.BUS_PRIM_NAME		:= clean_address_bus[13..40];
self.BUS_ADDR_SUFFIX	:= clean_address_bus[41..44];
self.BUS_POSTDIR			:= clean_address_bus[45..46];
self.BUS_UNIT_DESIG		:= clean_address_bus[47..56];
self.BUS_SEC_RANGE		:= clean_address_bus[57..64];
self.BUS_P_CITY_NAME	:= clean_address_bus[65..89];
self.BUS_V_CITY_NAME	:= clean_address_bus[90..114];
self.BUS_STATE				:= clean_address_bus[115..116];
self.BUS_ZIP5					:= clean_address_bus[117..121];
self.BUS_ZIP4					:= clean_address_bus[122..125];
self.BUS_CART					:= clean_address_bus[126..129];
self.BUS_CR_SORT_SZ		:= clean_address_bus[130];
self.BUS_LOT					:= clean_address_bus[131..134];
self.BUS_LOT_ORDER		:= clean_address_bus[135];
self.BUS_DPBC					:= clean_address_bus[136..137];
self.BUS_CHK_DIGIT		:= clean_address_bus[138];
self.BUS_REC_TYPE			:= clean_address_bus[139..140];
self.BUS_ACE_FIPS_ST	:= clean_address_bus[141..142];
self.BUS_COUNTY				:= clean_address_bus[143..145];
self.BUS_GEO_LAT			:= clean_address_bus[146..155];
self.BUS_GEO_LONG			:= clean_address_bus[156..166];
self.BUS_MSA					:= clean_address_bus[167..170];
self.BUS_GEO_BLK			:= clean_address_bus[171..177];
self.BUS_GEO_MATCH		:= clean_address_bus[178];
self.BUS_ERR_STAT			:= clean_address_bus[179..182];


//Cleaning Mailing Address
Append_MailAddressFirst := 	address.fn_addr_clean_prep(TRIM(TRIM(l.ADDR_ADDR1_2,LEFT,RIGHT) + ' ' + TRIM(l.ADDR_ADDR2_2,LEFT,RIGHT)),'first');	
																																			
Append_MailAddressLast	 :=		address.fn_addr_clean_prep(TRIM(TRIM(l.ADDR_CITY_2,LEFT,RIGHT) 
																															+ IF(l.ADDR_CITY_2 <> '',', ','') + TRIM(l.ADDR_STATE_2,LEFT,RIGHT)) 
																															+ ' ' + TRIM(l.ADDR_ZIP5_2,LEFT,RIGHT),'last');
clean_address_mail := Address.CleanAddress182(Append_MailAddressFirst, Append_MailAddressLast);
SELF.Append_MailAddrFirst := 	Append_MailAddressFirst; 
SELF.Append_MailAddrLast	:=	Append_MailAddressLast;
self.MAIL_PRIM_RANGE 	:= clean_address_mail[1..10];
self.MAIL_PREDIR			:= clean_address_mail[11..12];
self.MAIL_PRIM_NAME		:= clean_address_mail[13..40];
self.MAIL_ADDR_SUFFIX	:= clean_address_mail[41..44];
self.MAIL_POSTDIR			:= clean_address_mail[45..46];
self.MAIL_UNIT_DESIG	:= clean_address_mail[47..56];
self.MAIL_SEC_RANGE		:= clean_address_mail[57..64];
self.MAIL_P_CITY_NAME	:= clean_address_mail[65..89];
self.MAIL_V_CITY_NAME	:= clean_address_mail[90..114];
self.MAIL_STATE				:= clean_address_mail[115..116];
self.MAIL_ZIP5				:= clean_address_mail[117..121];
self.MAIL_ZIP4				:= clean_address_mail[122..125];
self.MAIL_CART				:= clean_address_mail[126..129];
self.MAIL_CR_SORT_SZ	:= clean_address_mail[130];
self.MAIL_LOT					:= clean_address_mail[131..134];
self.MAIL_LOT_ORDER		:= clean_address_mail[135];
self.MAIL_DPBC				:= clean_address_mail[136..137];
self.MAIL_CHK_DIGIT		:= clean_address_mail[138];
self.MAIL_REC_TYPE		:= clean_address_mail[139..140];
self.MAIL_ACE_FIPS_ST	:= clean_address_mail[141..142];
self.MAIL_COUNTY			:= clean_address_mail[143..145];
self.MAIL_GEO_LAT			:= clean_address_mail[146..155];
self.MAIL_GEO_LONG		:= clean_address_mail[156..166];
self.MAIL_MSA					:= clean_address_mail[167..170];
self.MAIL_GEO_BLK			:= clean_address_mail[171..177];
self.MAIL_GEO_MATCH		:= clean_address_mail[178];
self.MAIL_ERR_STAT		:= clean_address_mail[179..182];
SELF := 	L;
SELF := 	[];
END;

clean_NameAddr := PROJECT(dsBaseFile, xCleanNameAddr(LEFT));

RETURN clean_NameAddr;
		
END;
