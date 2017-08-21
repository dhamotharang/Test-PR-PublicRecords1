IMPORT	Business_Header,	MDR,	_Validate,	ut;

EXPORT	fBusiness_Credit_As_Business_Linking(
	DATASET(Business_Credit.Layouts.SBFEAccountLayout)	pBase	=	Files().LinkIDs(active)
):=
FUNCTION

		//COMPANY MAPPING
		business_header.layout_business_linking.linking_interface	trfMap(pBase l, BOOLEAN	isDBA=FALSE) := TRANSFORM																				
				SELF.source_record_id							:=	l.persistent_record_ID;
				SELF.vl_id												:=	IF(l.record_type<>Constants().BS,(STRING)l.sbfe_id,'');
				self.current											:=	TRUE;
				SELF.source												:=	l.source;
				SELF.company_rawaid								:=	l.rawaid;
				SELF.company_name									:=	IF(isDBA,l.clean_DBA,l.clean_Business_Name);
				SELF.company_name_type_raw				:=	IF(isDBA,'DBA','LEGAL');
				SELF.dt_vendor_first_reported			:= (UNSIGNED4)l.dt_vendor_first_reported;
				SELF.dt_vendor_last_reported			:= (UNSIGNED4)l.dt_vendor_last_reported;
				SELF.company_fein									:=	IF(l.record_type<>Constants().IS,l.Federal_TaxID_SSN,'');
				SELF.company_phone								:=	IF(l.record_type<>Constants().IS,l.Phone_Number,''); //7 to 10 digits
				SELF.phone_score									:=	IF((INTEGER)SELF.company_phone=0,0,1);
				SELF.phone_type										:=	IF(SELF.phone_score>0,
																								IF(l.Phone_Type='002','F','T'),
																								''
																							); //7 to 10 digits
				SELF.company_address_type_raw			:=	IF(l.v_city_name<>'' OR l.st<>'' OR l.zip <>'' , 'BUSINESS','');
				SELF.company_address.prim_range		:=	l.prim_range;
				SELF.company_address.predir				:=	l.predir;
				SELF.company_address.prim_name		:=	l.prim_name;
				SELF.company_address.addr_suffix	:=	l.addr_suffix;
				SELF.company_address.postdir			:=	l.postdir;
				SELF.company_address.unit_desig		:=	l.unit_desig;
				SELF.company_address.sec_range		:=	l.sec_range;
				SELF.company_address.p_city_name	:=	l.p_city_name;
				SELF.company_address.v_city_name	:=	l.v_city_name;
				SELF.company_address.st						:=	l.st;
				SELF.company_address.zip					:=	l.zip;
				SELF.company_address.zip4					:=	l.zip4;
				SELF.company_address.fips_state		:=	l.fips_state;
				SELF.company_address.fips_county	:=	l.fips_county;
				SELF.company_address.msa					:=	l.msa;
				SELF.company_address.geo_lat			:=	l.geo_lat;
				SELF.company_address.geo_long			:=	l.geo_long;
				SELF.company_address.cart					:=	l.cart;
				SELF.company_address.cr_sort_sz		:=	l.cr_sort_sz;
				SELF.company_address.lot					:=	l.lot;
				SELF.company_address.lot_order		:=	l.lot_order;
				SELF.company_address.dbpc					:=	l.dbpc;
				SELF.company_address.chk_digit		:=	l.chk_digit;
				SELF.company_address.rec_type			:=	l.rec_type;
				SELF.company_address.geo_blk			:=	l.geo_blk;
				SELF.company_address.geo_match		:=	l.geo_match;
				SELF.company_address.err_stat			:=	l.err_stat;

				SELF.dt_first_seen_contact				:=	(UNSIGNED4)(IF(l.record_type=Constants().IS,l.dt_first_seen,0));
				SELF.dt_last_seen_contact					:=	(UNSIGNED4)(IF(l.record_type=Constants().IS,l.dt_last_seen,0));
				SELF.contact_did									:=	l.did;
				SELF.contact_name.title						:=	l.clean_title;
				SELF.contact_name.fname						:=	l.clean_fname;
				SELF.contact_name.mname						:=	l.clean_mname;
				SELF.contact_name.lname						:=	l.clean_lname;
				SELF.contact_name.name_suffix			:=	l.clean_suffix;
				SELF.contact_job_title_raw				:=	IF(l.record_type=Constants().IS,l.Business_Title,''); //Raw vendor data or vendorÂ’s field name - Examples: CHIEF EXECUTIVE OFFICER, PRESIDENT, SECRETARY, etc.
				SELF.contact_ssn									:=	IF(l.record_type=Constants().IS,l.Federal_TaxID_SSN,'');
				SELF.contact_phone								:=	IF(l.record_type=Constants().IS,l.Phone_Number,''); //7 to 10 digits

  			SELF															:=	l;
				SELF															:=	[];
		end;
																	
		dMapped			:=	PROJECT(pBase,trfMap(LEFT,FALSE));
		dDBAMapped	:=	PROJECT(pBase(clean_DBA<>'' AND clean_DBA<>clean_Business_Name),trfMap(LEFT,TRUE));
		
		dAsLinking  :=	DEDUP(SORT(DISTRIBUTE(dMapped+dDBAMapped,HASH(vl_id,company_name)),RECORD, LOCAL),RECORD, EXCEPT source_record_id, LOCAL);

		RETURN dAsLinking;
 
END;