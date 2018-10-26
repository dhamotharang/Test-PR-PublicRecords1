IMPORT ut,STD, PRTE2_Prof_License_Mari, Address,Prof_license_mari,PRTE2, AID;

EXPORT fCleanNameAddr(DATASET(PRTE2_Prof_License_Mari.layouts.search) dsBaseFile) := FUNCTION	
PRTE2.CleanFields(dsBaseFile, dsBaseFile2);


dsBaseFile3:=project(dsBaseFile2,
Transform(layouts.search,

SELF.Append_BusAddrFirst:= left.ADDR_ADDR1_1 + ' ' + left.ADDR_ADDR2_1;	
																													 
SELF.Append_BusAddrLast:=	left.ADDR_CITY_1 + IF(left.ADDR_CITY_1 <> '',', ','') + left.ADDR_STATE_1 
																											 + ' ' + left.ADDR_ZIP5_1;
	
	
self.ADDR_CITY_1 :=	TRIM(left.ADDR_CITY_1,LEFT,RIGHT);
self.ADDR_STATE_1 :=TRIM(left.ADDR_STATE_1,Left,right);
self.ADDR_zip5_1 :=TRIM(left.ADDR_zip5_1,Left,right);
 
												 
Self.Append_MailAddrFirst:= left.ADDR_ADDR1_2 + ' ' + left.ADDR_ADDR2_2;	

SElf.Append_MailAddrLast :=	left.ADDR_CITY_2 + IF(left.ADDR_CITY_2 <> '',', ','') + left.ADDR_STATE_2 
																															 + ' ' + left.ADDR_ZIP5_2;	

self.ADDR_CITY_2 :=	TRIM(left.ADDR_CITY_2,LEFT,RIGHT);
self.ADDR_STATE_2 :=TRIM(left.ADDR_STATE_2,Left,right);
self.ADDR_zip5_2 :=TRIM(left.ADDR_zip5_2,Left,right);																												 
self:=Left;	
self:=[];
));																												 


dsBaseFile4 := PRTE2.AddressCleaner(dsBaseFile3,  
																				['Append_BusAddrFirst','Append_MailAddrFirst'],
																				['dummy','dummy2'], //blank field, not used but passed for attribute purposes
																				['ADDR_CITY_1','ADDR_City_2'],
																				['ADDR_STATE_1','ADDR_STATE_2'],
																				['ADDR_ZIP5_1','ADDR_ZIP5_2'],
																				['BusAddress','MailAddress'],
																				['BusAddress_rawaid','MailAddress_rawaid']
																				);


DS_out	:=	Project(dsBaseFile4,
Transform(recordof(dsBaseFile4),

SELF.FNAME				:= if(Left.type_cd='MD',Left.name_first,'');
SELF.MNAME				:= if(Left.type_cd='MD',Left.name_mid,'');
SELF.LNAME				:= if(Left.type_cd='MD',Left.name_last,'');
SELF.NAME_SUFFIX	:= if(Left.type_cd='MD',Left.name_sufx,'');

SELF.NAME_COMPANY	:= IF(Left.type_cd = 'GR' and Left.name_mari_org != '', Left.name_mari_org, Left.name_office);
SELF.NAME_COMPANY_DBA := IF(Left.NAME_MARI_DBA <> '', Left.NAME_MARI_DBA, Left.NAME_DBA);

SELF.Append_BusAddrFirst := Left.Append_BusAddrFirst; 
SELF.Append_BusAddrLast	 :=	Left.Append_BusAddrLast;

self.BUS_PRIM_RANGE 	:= Left.busaddress.prim_range;
self.BUS_PREDIR				:= Left.busaddress.predir;
self.BUS_PRIM_NAME		:= Left.busaddress.prim_name;
self.BUS_ADDR_SUFFIX	:= Left.busaddress.addr_suffix;
self.BUS_POSTDIR			:= Left.busaddress.postdir;
self.BUS_UNIT_DESIG		:= Left.busaddress.unit_desig;
self.BUS_SEC_RANGE		:= Left.busaddress.sec_range;
self.BUS_P_CITY_NAME	:= Left.busaddress.p_city_name;
self.BUS_V_CITY_NAME	:= Left.busaddress.v_city_name;
self.BUS_STATE				:= Left.busaddress.st;
self.BUS_ZIP5					:= Left.busaddress.zip;
self.BUS_ZIP4					:= Left.busaddress.zip4;
self.BUS_CART					:= Left.busaddress.cart;
self.BUS_CR_SORT_SZ		:= Left.busaddress.cr_sort_sz;
self.BUS_LOT					:= Left.busaddress.lot;
self.BUS_LOT_ORDER		:= Left.busaddress.lot_order;
self.BUS_DPBC					:= Left.busaddress.dbpc;
self.BUS_CHK_DIGIT		:= Left.busaddress.chk_digit;
self.BUS_REC_TYPE			:= Left.busaddress.rec_type;
self.BUS_ACE_FIPS_ST	:= Left.busaddress.fips_state;
self.BUS_COUNTY				:= Left.busaddress.fips_county;
self.BUS_GEO_LAT			:= Left.busaddress.geo_lat;
self.BUS_GEO_LONG			:= Left.busaddress.geo_long;
self.BUS_MSA					:= Left.busaddress.msa;
self.BUS_GEO_BLK			:= Left.busaddress.geo_blk;
self.BUS_GEO_MATCH		:= Left.busaddress.geo_match;
self.BUS_ERR_STAT			:= Left.busaddress.err_stat;

SELF.Append_MailAddrFirst := 	Left.Append_MailAddrFirst; 
SELF.Append_MailAddrLast	:=	Left.Append_MailAddrLast;
self.MAIL_PRIM_RANGE 	:= Left.MailAddress.prim_range;
self.MAIL_PREDIR			:= Left.MailAddress.predir;
self.MAIL_PRIM_NAME		:= Left.MailAddress.prim_name;
self.MAIL_ADDR_SUFFIX	:= Left.MailAddress.addr_suffix;
self.MAIL_POSTDIR			:= Left.MailAddress.postdir;
self.MAIL_UNIT_DESIG	:= Left.MailAddress.unit_desig;
self.MAIL_SEC_RANGE		:= Left.MailAddress.sec_range;
self.MAIL_P_CITY_NAME	:= Left.MailAddress.p_city_name;
self.MAIL_V_CITY_NAME	:= Left.MailAddress.v_city_name;
self.MAIL_STATE				:= Left.MailAddress.st;
self.MAIL_ZIP5				:= Left.MailAddress.zip;
self.MAIL_ZIP4				:= Left.MailAddress.zip4;
self.MAIL_CART				:= Left.MailAddress.cart;
self.MAIL_CR_SORT_SZ	:= Left.MailAddress.cr_sort_sz;
self.MAIL_LOT					:= Left.MailAddress.lot;
self.MAIL_LOT_ORDER		:= Left.MailAddress.lot_order;
self.MAIL_DPBC				:= Left.MailAddress.dbpc;
self.MAIL_CHK_DIGIT		:= Left.MailAddress.chk_digit;
self.MAIL_REC_TYPE		:= Left.MailAddress.rec_type;
self.MAIL_ACE_FIPS_ST	:= Left.MailAddress.fips_state;
self.MAIL_COUNTY			:= Left.MailAddress.fips_county;
self.MAIL_GEO_LAT			:= Left.MailAddress.geo_lat;
self.MAIL_GEO_LONG		:= Left.MailAddress.geo_long;
self.MAIL_MSA					:= Left.MailAddress.msa;
self.MAIL_GEO_BLK			:= Left.MailAddress.geo_blk;
self.MAIL_GEO_MATCH		:= Left.MailAddress.geo_match;
self.MAIL_ERR_STAT		:= Left.MailAddress.err_stat;

self.link_ssn :=Left.link_ssn;
self.link_dob:=Left.link_dob;
self.link_fein:=Left.link_fein;
self.link_inc_date:=Left.link_inc_date;
self.cust_name:=Left.cust_name;
self_bug_num:=Left.Bug_num;

SELF.did :=  prte2.fn_AppendFakeID.did(self.fname, self.lname, self.link_ssn, self.link_dob, self.cust_name);


SELF.bdid := prte2.fn_AppendFakeID.bdid(self.name_company,	self.BUS_PRIM_RANGE,	self.BUS_PRIM_NAME, self.BUS_V_CITY_NAME, self.BUS_STATE, (string5)self.BUS_ZIP5, self.Cust_name);
                                             vLinkingIds := prte2.fn_AppendFakeID.LinkIds(self.name_company, (string9)self.link_fein, self.link_inc_date, self.MAIL_PRIM_RANGE, self.BUS_PRIM_NAME, 
                                                            self.BUS_SEC_RANGE, self.BUS_V_CITY_NAME, self.BUS_STATE, (string5)self.BUS_ZIP5, 'LN_PR');
                                        
                                            SELF.powid	:= vLinkingIds.powid;
                                            SELF.proxid	:= vLinkingIds.proxid;
                                            SELF.seleid	:= vLinkingIds.seleid;
                                            SELF.orgid	:= vLinkingIds.orgid;
                                            SELF.ultid	:= vLinkingIds.ultid;	   
                                         
 
SELF := 	Left;
SELF := 	[];
));

RETURN ds_Out;
	
END;

