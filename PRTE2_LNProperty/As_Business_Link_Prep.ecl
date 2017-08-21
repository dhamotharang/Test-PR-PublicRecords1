IMPORT Business_Header_SS, Business_Header, Business_HeaderV2, ut, mdr;

EXPORT as_Business_Link_Prep(
	dataset(Layouts.Layout_DID_Out	 ) pLNPropertySearch 
	,dataset(Layouts.layout_deed_mortgage_common_model_base) pLNPropertyDeed
	,dataset(Layouts.layout_property_common_model_base) pLNPropertyTax
	,dataset(Layouts.layout_addl_fares_deed) pLNPropertyAddlDeed 
	,dataset(Layouts.layout_addl_fares_tax) pLNPropertyAddlTax
	) := function
	
	asbussource := as_Business_source(
					 pLNPropertySearch  
					,pLNPropertyDeed		
					,pLNPropertyTax			
					,pLNPropertyAddlDeed
					,pLNPropertyAddlTax);
										
	sGoodSource	:=	['OO','BB','SS'];
	dAssessorIn	:=	asbussource.ln_propertyv2_tax_as_business_source(LENGTH(TRIM(fips_code)) = 5);
	dDeedIn		  :=	asbussource.ln_propertyv2_deed_as_business_source;
	searchwprop :=  asbussource.p3(source_code in sGoodSource);
	dSearchIn	  := searchwprop(~(is_true));
	rSearchWithCNameOnly := RECORD
		dSearchIn.ln_fares_id;
		dSearchIn.cname;
	END;

	dSearchWithoutBogusNames	:=	dSearchIn(
									ln_fares_id != '',
									LENGTH(TRIM(cname)) >= 5,
									~((INTEGER)zip = 0 AND prim_name = ''),
									stringlib.stringfind(cname,'00000',1) = 0,
									stringlib.stringfilterout(cname,'1234567890-') != '',
									stringlib.stringfilterout(cname,'1234567890- ') != 'TU',
									(stringlib.stringfind(cname,' TRUST',1) = 0 or stringlib.stringfind(cname,' BANK',1) != 0),
									stringlib.stringfind(cname,'FAMILY',1) <= 1);

	dSearchWithCNameOnly	  	:=	TABLE(dSearchWithoutBogusNames,rSearchWithCNameOnly);
	dSearchWithNonBlankCName	  	:=	DEDUP(dSearchWithCNameOnly,ln_fares_id,all);
	
	TYPEOF(dSearchIn)	tGetSearchIFCNameExists(dSearchIn pSearch, dSearchWithNonBlankCName pNonBlankCName) := TRANSFORM
		SELF	:=	pSearch;
	END;

	dSearchDistFiltered	:=	JOIN(dSearchIn,dSearchWithNonBlankCName,
							 LEFT.ln_fares_id = RIGHT.ln_fares_id,
							 tGetSearchIFCNameExists(LEFT,RIGHT),
							 LOCAL);
							 
	rAssessorSlim	 := RECORD
		dAssessorIn.ln_fares_id;
		dAssessorIn.assessee_phone_number;
		dAssessorIn.tax_year;
		dAssessorIn.recording_date;
		dAssessorIn.sale_date;
		dAssessorIn.src;	
		dAssessorIn.uid;
	END;

	rDeedSlim := RECORD
		dDeedIn.ln_fares_id;
		dDeedIn.recording_date;
		dDeedIn.src;
		dDeedIn.uid;
		dDeedIn.partial_interest_transferred;
	END;

	dAssessorSlim	  	:=	TABLE(dAssessorIn,rAssessorSlim);
	dDeedSlim		    	:=	TABLE(dDeedIn,rDeedSlim);

	Layouts.layout_business_link_prep tJOINSearchAndAssessor(dSearchDistFiltered pSearch, dAssessorSlim pAssessor) :=	TRANSFORM
		SELF.source						:=	MDR.sourceTools.fProperty(pSearch.ln_fares_id);
		SELF.dt_first_seen				     :=	pSearch.dt_first_seen;
		SELF.dt_last_seen			      	:=	pSearch.dt_last_seen;
		SELF.dt_vendor_first_reported	    		:=	pSearch.dt_vendor_last_reported;	// sometimes first reported uses dt_xxx_seen date, so use last reported since it is always the process date
		SELF.dt_vendor_last_reported	    		:=	pSearch.dt_vendor_last_reported;
		SELF.company_bdid                 		:=  	pSearch.bdid;
		SELF.company_name			          :=	if (trim(pSearch.old_cname) <> '', ut.fnTrim2Upper(pSearch.old_cname), ut.fnTrim2Upper(pSearch.cname));
		SELF.company_address.prim_range  		:=	pSearch.prim_range;
		SELF.company_address.predir			:=	pSearch.predir;
		SELF.company_address.prim_name	 	:=	pSearch.prim_name;
		SELF.company_address.addr_suffix		:=	pSearch.suffix;
		SELF.company_address.postdir		 	:=	pSearch.postdir;
		SELF.company_address.unit_desig		:=	pSearch.unit_desig;
		SELF.company_address.sec_range	  	:=	pSearch.sec_range;
		SELF.company_address.p_city_name 		:=	pSearch.p_city_name;
		SELF.company_address.v_city_name 		:=	pSearch.v_city_name;
		SELF.company_address.st   	     	:=	pSearch.st;
		SELF.company_address.zip				:=	pSearch.zip;
		SELF.company_address.zip4			:=	pSearch.zip4;
		SELF.company_address.cart         		:=  	pSearch.cart;
		SELF.company_address.cr_sort_sz   		:=  	pSearch.cr_sort_sz;
		SELF.company_address.lot          		:=  	pSearch.lot;
		SELF.company_address.lot_order    		:=  	pSearch.lot_order;
		SELF.company_address.dbpc         		:=  	pSearch.dbpc;
		SELF.company_address.chk_digit    		:=  	pSearch.chk_digit;
		SELF.company_address.rec_type     		:=  	pSearch.rec_type;
		SELF.company_address.fips_state	 	:=	pSearch.county[1..2];
		SELF.company_address.fips_county		:=	pSearch.county[3..5];
		SELF.company_address.geo_lat		 	:=	pSearch.geo_lat;
		SELF.company_address.geo_long		 	:=	pSearch.geo_long;
		SELF.company_address.msa				:=	pSearch.msa;
		SELF.company_address.geo_blk		  	:=	pSearch.geo_blk;
		SELF.company_address.geo_match	  	:=	pSearch.geo_match;
		SELF.company_address.err_stat		  	:=	pSearch.err_stat;
		SELF.company_phone	             		:=	pSearch.phone_number;		
		SELF.vl_id		              		:=	pSearch.source_code[1..2] + TRIM(pSearch.vendor_source_flag) + pSearch.ln_fares_id[1..12];
		SELF.source_record_id		          :=	pSearch.source_rec_id;
		SELF.title			               :=	pSearch.title;
		SELF.fname			               :=	pSearch.fname;
		SELF.mname			               :=	pSearch.mname;
		SELF.lname			               :=	pSearch.lname;
		SELF.name_suffix                  		:=	pSearch.name_suffix;
		SELF.partial_interest_transferred		:=	'';
		SELF                              		:=  	pSearch;
		SELF                              		:=  	[];
END;

	dSearchAndAssessor	:=	JOIN(dSearchDistFiltered, dAssessorSlim,
							LEFT.ln_fares_id = RIGHT.ln_fares_id,
							   tJOINSearchAndAssessor(LEFT, RIGHT),
							LEFT OUTER);

	Layouts.layout_business_link_prep tJOINSearchAssessorAndDeed(dSearchAndAssessor pSearchAssessor, dDeedSlim pDeed) := TRANSFORM
		SELF.dt_first_seen				      	:=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_first_seen);
		SELF.dt_last_seen				        	:=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_last_seen);
		SELF.dt_vendor_last_reported		  :=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported		  :=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_vendor_first_reported); 
		SELF.partial_interest_transferred	:=	pDeed.partial_interest_transferred;
		SELF							              	:=	pSearchAssessor;
	END;

	dSearchAndAssessorAndDeed	:=	JOIN(dSearchAndAssessor, dDeedSlim,
															  LEFT.ln_fares_id = RIGHT.ln_fares_id,
										            tJOINSearchAssessorAndDeed(LEFT, RIGHT),
										            LEFT OUTER);

	Layouts.layout_business_link_prep tAdjustDates(dSearchAndAssessorAndDeed pInput) := TRANSFORM
		SELF.dt_vendor_first_reported	:=	pInput.dt_first_seen;
		SELF.dt_last_seen			      	:=	IF(pInput.dt_last_seen < pInput.dt_first_seen, pInput.dt_first_seen, pInput.dt_last_seen);
		SELF.dt_vendor_last_reported	:=	SELF.dt_last_seen;
		SELF							            :=	pInput;
	END;

	LN_Propertyv2_as_BusLink_Preparation := 	PROJECT(dSearchAndAssessorAndDeed, tAdjustDates(LEFT));
	RETURN LN_Propertyv2_as_BusLink_Preparation;

END;