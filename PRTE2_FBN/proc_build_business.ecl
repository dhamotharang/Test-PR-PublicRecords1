IMPORT  PromoteSupers, ut, NID, Address, STD,PRTE2, AID, MDR;

EXPORT PROC_BUILD_BUSINESS(String filedate) := FUNCTION

PRTE2.CleanFields(files.business_combine,BusinessCln);
PRTE2.CleanFields(files.contact_combine,ContactCln);

//Address Cleaner
bus_addr_cleaned := PRTE2.AddressCleaner(BusinessCln,  
																					['BUS_ADDRESS1', 'MAIL_STREET'],
																					['dummy1','dummy2'],
																					['BUS_CITY','MAIL_CITY'],
																					['BUS_STATE','MAIL_STATE'],
																					['BUS_ZIP','MAIL_ZIP'],
																					['business_address', 'mail_address'],
																					['business_address_rawaid', 'mail_address_rawaid']
																					);
																					

Layouts.Combined_Business_Base_ext ClnMain(bus_addr_cleaned L) := TRANSFORM
		self.bus_name			:= L.bus_name;																		

//Clean Business Address
		self.prim_range 		:= L.business_address.prim_range;
		self.predir     		:= L.business_address.predir;
		self.prim_name			:= L.business_address.prim_name;
		self.addr_suffix		:= L.business_address.addr_suffix;
		self.postdir				:= L.business_address.postdir;
		self.unit_desig			:= L.business_address.unit_desig;
		self.sec_range			:= L.business_address.sec_range;
		self.v_city_name		:= L.business_address.v_city_name;
		self.st							:= L.business_address.st;
		self.zip5           := L.business_address.zip;
		self.zip4						:= L.business_address.zip4;
		self.addr_rec_type	:= L.business_address.rec_type;
		self.fips_state			:= L.business_address.fips_state;
		self.fips_county		:= L.business_address.fips_county;	
		self.geo_lat				:= L.business_address.geo_lat;
		self.geo_long				:= L.business_address.geo_long;
		self.geo_blk				:= L.business_address.geo_blk;
		self.geo_match			:= L.business_address.geo_match;
		self.err_stat				:= L.business_address.err_stat;
	  self.RawAID 				:= L.business_address_rawaid;
	
	
//Clean Mailing address
		self.mail_prim_range 		:= L.mail_address.prim_range;
		self.mail_predir     		:= L.mail_address.predir;
		self.mail_prim_name			:= L.mail_address.prim_name;
		self.mail_addr_suffix		:= L.mail_address.addr_suffix;
		self.mail_postdir				:= L.mail_address.postdir;
		self.mail_unit_desig		:= L.mail_address.unit_desig;
		self.mail_sec_range			:= L.mail_address.sec_range;
		self.mail_v_city_name		:= L.mail_address.v_city_name;
		self.mail_st						:= L.mail_address.st;
		self.mail_zip5          := L.mail_address.zip;
		self.mail_zip4					:= L.mail_address.zip4;
		self.mail_addr_rec_type	:= L.mail_address.rec_type;
		self.mail_fips_state		:= L.mail_address.fips_state;
		self.mail_fips_county		:= L.mail_address.fips_county;	
		self.mail_geo_lat				:= L.mail_address.geo_lat;
		self.mail_geo_long			:= L.mail_address.geo_long;
		SELF.mail_geo_blk				:= L.mail_address.geo_blk;
		self.mail_geo_match			:= L.mail_address.geo_match;
		self.mail_err_stat			:= L.mail_address.err_stat;
		self.Mail_RawAID 				:= L.mail_address_rawaid;
	
		self.prep_addr_line1					:= L.bus_address1;
		self.prep_addr_line_last			:= L.bus_address2;
  	self.Prep_Mail_Addr_Line1			:= Address.Addr1FromComponents(ut.CleanSpacesAndUpper(L.mail_street),'','','','','',''); 
		self.Prep_Mail_Addr_Line_Last := Address.Addr2FromComponents(ut.CleanSpacesAndUpper(L.mail_city),
																																 ut.CleanSpacesAndUpper(L.mail_State),
																																 TRIM((string)L.mail_ZIP,left,right));
		
		
		self.bdid      	:= prte2.fn_AppendFakeID.bdid(L.link_bus_name, L.business_address.prim_range,  L.business_address.prim_name,  L.business_address.v_city_name,  L.business_address.st,  L.business_address.zip,  L.cust_name);

//Appending Linkid(s)		
		vLinkingIds 		:= Prte2.fn_AppendFakeID.LinkIds(L.link_bus_name, L.link_fein, L.link_inc_date, L.business_address.prim_range, L.business_address.prim_name, L.business_address.sec_range, 
																											L.business_address.v_city_name, L.business_address.st, L.business_address.zip, L.cust_name);
		self.powid			:= vLinkingIds.powid;
		self.proxid			:= vLinkingIds.proxid;
		self.seleid			:= vLinkingIds.seleid;
		self.orgid			:= vLinkingIds.orgid;
		self.ultid			:= vLinkingIds.ultid;
		
		self.filing_date				:= (unsigned)l.filing_date;
		self.expiration_date		:= (unsigned)l.expiration_date;
		self.cancellation_date	:= (unsigned)l.cancellation_date;
		self.orig_filing_date		:= (unsigned)l.orig_filing_date;
		self.bus_comm_date			:= (unsigned)l.bus_comm_date;
		self.orig_fein					:= (unsigned)l.orig_fein;
		self.bus_zip						:= (unsigned)l.bus_zip;
		self.bus_zip4						:= (unsigned)l.bus_zip4;
		self.source_rec_id			:= L.seq_no;
		self := L;
		SELF := [];
	END;
	
df_business	:= PROJECT(bus_addr_cleaned, ClnMain(left));

///////////////////////////////////////////////////////////////////////////////////////
// Apply Global_SIDs
///////////////////////////////////////////////////////////////////////////////////////

//Apply Global_SID - TMSID[1..3]
addGlobalSID 		:= MDR.macGetGlobalSid(df_business, 'Fbn2', 'tmsid[1..3]', 'global_sid'); 

withGSIDs				:= addGlobalSID(global_sid<>0);	//Global_SIDs Populated
remainRec				:= addGlobalSID(global_sid=0);	//No Global_SIDs Populated

//Apply Global_SID - TMSID[1..2]
addGlobalSID2		:= MDR.macGetGlobalSid(remainRec, 'Fbn2', 'tmsid[1..2]', 'global_sid');

//Concat All Results
concatRecs			:= withGSIDs + addGlobalSID2;

PromoteSupers.MAC_SF_BuildProcess(concatRecs, constants.Base_fbnv2_Business, writefile_business);

Return  writefile_business;

END;