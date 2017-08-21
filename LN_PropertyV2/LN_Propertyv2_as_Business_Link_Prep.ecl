#OPTION('multiplePersistInstances',FALSE);
IMPORT Business_Header_SS, Business_Header, Business_HeaderV2, ut, mdr;

EXPORT LN_Propertyv2_as_Business_Link_Prep(

	 DATASET(Layout_DID_Out													                  ) pLNPropertySearch  	= File_Search_DID
	,dataset(Layouts.layout_deed_mortgage_common_model_base_scrubs	  ) pLNPropertyDeed		  = Files.Base.DeedMortgage
	,dataset(Layouts.layout_property_common_model_base_scrubs			    ) pLNPropertyTax			= Files.Base.Assessment
	,DATASET(layout_addl_fares_deed									                  ) pLNPropertyAddlDeed = File_addl_Fares_deed
	,DATASET(layout_addl_fares_tax									                  ) pLNPropertyAddlTax	= File_addl_Fares_tax	
	,STRING																						                   pPersistName				= business_header._dataset().thor_cluster_Persists +  'persist::LN_Propertyv2::LN_Propertyv2_as_Business_Link_Prep'
  ,Boolean IsPRCT = false
	) := FUNCTION

	// Per Jill, the fips_code filter to throw out "crap records"  :-)
	// Omitting "bad pairs" of name/address.  Namely, "OS" and "SO" (owner name, seller address and vice versa)
	asbussource := ln_propertyv2_as_Business_source(
										 pLNPropertySearch  
										,pLNPropertyDeed		
										,pLNPropertyTax			
										,pLNPropertyAddlDeed
										,pLNPropertyAddlTax
										,IsPRCT);
										
	sGoodSource	:=	['OO','BB','SS'];
	dAssessorIn	:=	asbussource.ln_propertyv2_tax_as_business_source(LENGTH(TRIM(fips_code)) = 5);
	dDeedIn		  :=	asbussource.ln_propertyv2_deed_as_business_source;
	searchwprop :=  asbussource.p3(source_code in sGoodSource);
	
	// filter propagated address records
	dSearchIn	  := searchwprop(~(is_true));

	// Start getting one record per Search record when at least one record per fares_id has non-blank cname
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
	dSearchWithCNameDist	  	:=	DISTRIBUTE(dSearchWithCNameOnly,HASH(ln_fares_id));
	dSearchWithCNameSort	  	:=	SORT(dSearchWithCNameDist,ln_fares_id,-cname,LOCAL);	// IF there is a cname, one of them will be first
	dSearchWithCNameDedup	  	:=	DEDUP(dSearchWithCNameSort,ln_fares_id,LOCAL);
	dSearchWithNonBlankCName	:=	dSearchWithCNameDedup;
	// End getting one record per Search record when at least one record per fares_id has non-blank cname:  dSearchWithNonBlankCName

	// Start getting all search records that have at least one cname filled in the same fares_id
	dSearchDist					      :=	DISTRIBUTE(dSearchIn,HASH(ln_fares_id));

	TYPEOF(dSearchDist)	tGetSearchIFCNameExists(dSearchDist pSearch, dSearchWithNonBlankCName pNonBlankCName) := TRANSFORM
		SELF	:=	pSearch;
	END;

	dSearchDistFiltered	:=	JOIN(dSearchDist,dSearchWithNonBlankCName,
										           LEFT.ln_fares_id = RIGHT.ln_fares_id,
										           tGetSearchIFCNameExists(LEFT,RIGHT),
										           LOCAL);
															 
	// End getting all search records that have at least one cname filled in the same fares_id:  dSearchDistFiltered

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
	dAssessorSlimDist	:=	DISTRIBUTE(dAssessorSlim,HASH(ln_fares_id));
	dDeedSlimDist		  :=	DISTRIBUTE(dDeedSlim,HASH(ln_fares_id));

	layout_business_link_prep tJOINSearchAndAssessor(dSearchDistFiltered pSearch, dAssessorSlimDist pAssessor) :=	TRANSFORM
		SELF.source						            :=	MDR.sourceTools.fProperty(pSearch.ln_fares_id);
		SELF.dt_first_seen				        :=	pSearch.dt_first_seen;
		SELF.dt_last_seen			      	    :=	pSearch.dt_last_seen;
		SELF.dt_vendor_first_reported	    :=	pSearch.dt_vendor_last_reported;	// sometimes first reported uses dt_xxx_seen date, so use last reported since it is always the process date
		SELF.dt_vendor_last_reported	    :=	pSearch.dt_vendor_last_reported;
		SELF.company_bdid                 :=  pSearch.bdid;
		SELF.company_name			          	:=	if (trim(pSearch.old_cname) <> '', ut.fnTrim2Upper(pSearch.old_cname), ut.fnTrim2Upper(pSearch.cname));
		//SELF.std_company_name			        :=	ut.fnTrim2Upper(pSearch.cname);
		SELF.company_address.prim_range  	:=	pSearch.prim_range;
		SELF.company_address.predir			 	:=	pSearch.predir;
		SELF.company_address.prim_name	 	:=	pSearch.prim_name;
		SELF.company_address.addr_suffix	:=	pSearch.suffix;
		SELF.company_address.postdir		 	:=	pSearch.postdir;
		SELF.company_address.unit_desig		:=	pSearch.unit_desig;
		SELF.company_address.sec_range	  :=	pSearch.sec_range;
		SELF.company_address.p_city_name 	:=	pSearch.p_city_name;
		SELF.company_address.v_city_name 	:=	pSearch.v_city_name;
		SELF.company_address.st   	     	:=	pSearch.st;
		SELF.company_address.zip				 	:=	pSearch.zip;
		SELF.company_address.zip4				  :=	pSearch.zip4;
		SELF.company_address.cart         :=  pSearch.cart;
		SELF.company_address.cr_sort_sz   :=  pSearch.cr_sort_sz;
		SELF.company_address.lot          :=  pSearch.lot;
		SELF.company_address.lot_order    :=  pSearch.lot_order;
		SELF.company_address.dbpc         :=  pSearch.dbpc;
		SELF.company_address.chk_digit    :=  pSearch.chk_digit;
		SELF.company_address.rec_type     :=  pSearch.rec_type;
		SELF.company_address.fips_state	 	:=	pSearch.county[1..2];
		SELF.company_address.fips_county	:=	pSearch.county[3..5];
		SELF.company_address.geo_lat		 	:=	pSearch.geo_lat;
		SELF.company_address.geo_long		 	:=	pSearch.geo_long;
		SELF.company_address.msa				  :=	pSearch.msa;
		SELF.company_address.geo_blk		  :=	pSearch.geo_blk;
		SELF.company_address.geo_match	  :=	pSearch.geo_match;
		SELF.company_address.err_stat		  :=	pSearch.err_stat;
		SELF.company_phone	             	:=	pSearch.phone_number;		
		SELF.vl_id		              			:=	pSearch.source_code[1..2] + TRIM(pSearch.vendor_source_flag) + pSearch.ln_fares_id[1..12];
		// SELF.contact_name.title			      :=	pSearch.title;
		// SELF.contact_name.fname			     	:=	pSearch.fname;
		// SELF.contact_name.mname			     	:=	pSearch.mname;
		// SELF.contact_name.lname			      :=	pSearch.lname;
		// SELF.contact_name.name_suffix     :=	pSearch.name_suffix;
		SELF.source_record_id		          :=	pSearch.source_rec_id;
		SELF.title			                  :=	pSearch.title;
		SELF.fname			                	:=	pSearch.fname;
		SELF.mname			                	:=	pSearch.mname;
		SELF.lname			                  :=	pSearch.lname;
		SELF.name_suffix                  :=	pSearch.name_suffix;
		SELF.partial_interest_transferred	:=	'';
		SELF                              :=  pSearch;
		SELF                              :=  [];
END;

	dSearchAndAssessor	:=	JOIN(dSearchDistFiltered, dAssessorSlimDist,
								          LEFT.ln_fares_id = RIGHT.ln_fares_id,
									        tJOINSearchAndAssessor(LEFT, RIGHT),
								          LEFT OUTER,
							            LOCAL);

	layout_business_link_prep tJOINSearchAssessorAndDeed(dSearchAndAssessor pSearchAssessor, dDeedSlimDist pDeed) := TRANSFORM
		SELF.dt_first_seen				      	:=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_first_seen);
		SELF.dt_last_seen				        	:=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_last_seen);
		SELF.dt_vendor_last_reported		  :=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported		  :=	IF(pDeed.ln_fares_id <> '', (INTEGER)(pDeed.recording_date), pSearchAssessor.dt_vendor_first_reported); 
		SELF.partial_interest_transferred	:=	pDeed.partial_interest_transferred;
		SELF							              	:=	pSearchAssessor;
	END;

	dSearchAndAssessorAndDeed	:=	JOIN(dSearchAndAssessor, dDeedSlimDist,
										            //LEFT.vl_id[4..15] = RIGHT.ln_fares_id,
															  LEFT.ln_fares_id = RIGHT.ln_fares_id,
										            tJOINSearchAssessorAndDeed(LEFT, RIGHT),
										            LEFT OUTER,
										            LOCAL);

	layout_business_link_prep tAdjustDates(dSearchAndAssessorAndDeed pInput) := TRANSFORM
		SELF.dt_vendor_first_reported	:=	pInput.dt_first_seen;
		SELF.dt_last_seen			      	:=	IF(pInput.dt_last_seen < pInput.dt_first_seen, pInput.dt_first_seen, pInput.dt_last_seen);
		SELF.dt_vendor_last_reported	:=	SELF.dt_last_seen;
		SELF							            :=	pInput;
	END;

	LN_Propertyv2_as_BusLink_Preparation := 	PROJECT(dSearchAndAssessorAndDeed, tAdjustDates(LEFT));
	LN_Propertyv2_as_BusLink_Preparation_persist := LN_Propertyv2_as_BusLink_Preparation	: PERSIST(pPersistName);

	RETURN if(isPRCT, LN_Propertyv2_as_BusLink_Preparation, LN_Propertyv2_as_BusLink_Preparation_persist) ;

END;