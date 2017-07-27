IMPORT batchdatasets,batchshare,suppress,LN_PropertyV2,ut, lib_date;

// 2 step process  (uses fn_getPropertyBatch() 2 times to return property records for additional processing.
//    Step 1: fn_getPropertyBatch by input subject info  (SSN and Name)
//            Find all Homestead properties for input subjects (homesteaded at any point in time) and accumulate the unique addresses 
//            for these properties to use in Step 2
//    Step 2: fn_getPropertyBatch by address only.
//            Take all unqiue addresses found in step 2 and find the "latest" properties record for each address.
//            Determine if input owner is the current owner.
//            Combine records generated from 2 input subjects and determine co-ownership, etc.
//

EXPORT fn_getPropertyRecs(DATASET(HomesteadExemption_Services.Layouts.batch_in) ds_batch_in, 
                          HomesteadExemption_Services.IParams.BatchParams in_mod,
                           unsigned1 nss =suppress.constants.NonSubjectSuppression.doNothing, 
                           boolean isFCRA=FALSE) := FUNCTION
  Min2String(string l, string r) := if(l<>'' and r<>'', min(l, r), if(l<>'', l, r));													 
	acctnoRec := record
	  string20 acctnoFull;
	end;
  acctnoRec	removeDashNumber(ds_batch_in l) := transform
	  self.acctnoFull := l.acctno[1..(length(trim(l.acctno))-2)];
	end;
	ds_batch_acctno_full := project(ds_batch_in, removeDashNumber(left));												 
	
	ds_batch_acctno_only := dedup(sort(ds_batch_acctno_full, acctnoFull), acctnoFull);
  
	//create empty final output rows with ACCTNO without -1 -2 for joining to later.
	HomesteadExemption_Services.layouts.layout_property_recs fillParent(ds_batch_acctno_only l) := transform
	   self.acctno := l.acctnoFull;
		 self := [];
	end;
  propParent := project(ds_batch_acctno_only, fillParent(left));
	
  batchdatasets.layouts.batch_in  fillin(ds_batch_in l) := transform
    //clear the address so the property returned is more than just the property at this address.	  
		self.addr        := '';
		self.prim_range  := '';
		self.predir      := '';
		self.prim_name   := '';
		self.addr_suffix := '';
		self.postdir     := '';
		self.unit_desig  := '';
		self.sec_range   := '';
		self.p_city_name := '';
		self.st          := '';
		self.z5      		 := '';
		self.zip4        := '';
		self.county_name := '';
		self := l;
	end;
	ds_batch := project(ds_batch_in, fillin(left)); //removes tax year, did, etc.
 	//step 5A Get property by owner First, Last & SSN
  prop_raw := fn_getPropertyBatch(ds_batch, nss, isFCRA);
	
	HomesteadExemption_Services.layouts.layout_prop_batch_plus fillInTaxYear(ds_batch_in l,prop_raw r) := transform
		homeEx   := r.assess_homestead_homeowner_exemption ='Y';
		OwnerOcc := r.assess_owner_occupied = 'Y';
		taxEx    := functions.fn_findTerm(r.assess_tax_exemption1_desc) OR
								functions.fn_findTerm(r.assess_tax_exemption2_desc) OR
								functions.fn_findTerm(r.assess_tax_exemption3_desc) OR
								functions.fn_findTerm(r.assess_tax_exemption4_desc) ;
		self.isHomesteadExcemption := homeEx OR OwnerOcc OR taxEx;		
		self.clean_parcelID := map (r.assess_apna_or_pin_number <> '' => HomesteadExemption_Services.Functions.fn_addZeroToParcelID(r.assess_apna_or_pin_number),
		                            r.deed_apnt_or_pin_number   <> '' => HomesteadExemption_Services.Functions.fn_addZeroToParcelID(r.deed_apnt_or_pin_number),
																stringlib.StringCleanSpaces(r.property_address1 + ' '+r.property_address2 + ' '+ r.property_p_city_name +' '+r.property_st +' '+r.property_zip));
   
 	  self.in_Tax_Year := l.tax_year; //input tax year
		self.in_name_last := l.name_last;
		self.in_name_first := l.name_first;
		self.did := l.did;// lexid lookedup with score >= 89% 														 
		self := r;
		self := [];
  end;
	//step 5b  set HE boolean and restore input taxyear and looked up DID.
	prop_raw_he := JOIN( ds_batch_in ,prop_raw, left.acctno = right.acctno, fillInTaxYear(left,right), left outer);
	
	// filter property found to only include properties owned by input subject and ishomesteadExcemption
	prop_own_wBlankAddr := prop_raw_he(isHomesteadExcemption and ((ut.NZEQ((integer)owner_1_did,did)) or (ut.NZEQ((integer)owner_2_did,did))));
	prop_own := prop_own_wBlankAddr(property_address1 <> '' and ((property_p_city_name<>'' and property_st <> '') or property_zip <> ''));
  // step 5A deduping logic (1 record per parcelID per tax year)  dedup by clean_parcelid, tax year and isHE, Assess before DEED, and source A/B
	prop_own_every_year := dedup(sort(prop_own, acctno, clean_parcelID,  -sortby_date, fid_type, vendor_source_flag), 
	                                       acctno, clean_parcelID, sortby_date);
	//step 5C count assessment years
  assess_count_rec := RECORD
     prop_own_every_year.acctno;
		 prop_own_every_year.clean_parcelID;
     integer assess_cnt := count(group);
  END;
	assessYearsTable := table(prop_own_every_year(fid_type = 'A'),assess_count_rec, acctno, clean_parcelID, few);
	
	//prop_own_dedup := dedup(prop_own_every_year, acctno, clean_parcelID);
	// 1 record per acctno, parcelID,
	//step 5D Set HE flag
	prop_own_every_year  fillHE(prop_own_every_year l) := transform
	  self.homestead_exemption_flag := map ((integer)l.assess_tax_year between (integer)l.in_tax_Year-1 AND (integer) l.in_tax_year+1 => 'Y', 
		                                 (((integer)l.assess_market_value_year between (integer)l.in_tax_Year-1 AND (integer) l.in_tax_year+1) and
																		 ((integer)l.assess_assessed_value_year between (integer)l.in_tax_Year-1 AND (integer) l.in_tax_year+1))=> 'PH',
		                                 '');
		
		self := l;
	end;
	prop_he := project(prop_own_every_year, fillHE(left));
	
	//bug 176336 save homestead flag set for prior years based on input tax year
	// then create 1 row lookup table to use later for each acctno and parcelid called prop_parcel_1_homestead.
	prop_parcel := record
	   prop_own_every_year.acctno;
		 prop_own_every_year.clean_parcelID;
		 string2 homestead_exemption_flag := '';
	end;
	prop_parcle_all_homestead := project(prop_he, prop_parcel);
	prop_parcel_1_homestead := dedup(sort(prop_parcle_all_homestead, acctno, clean_parcelID, -homestead_exemption_flag ),acctno, clean_parcelID);
 //get 1 unique address location per acctno.	
	prop_he_unique_addr := dedup(sort(prop_he, acctno, property_address1, property_address2, property_p_city_name, property_st,property_zip,-isHomesteadExcemption,-homestead_exemption_flag, -sortby_date), 
	                                           acctno, property_address1, property_address2, property_p_city_name, property_st,property_zip);
  	//step 6  Get property by address
  tempRec := record	
	  batchdatasets.layouts.batch_in;
	  string err_addr;
	end;
	tempRec  fillAddr(prop_he l) := transform
	    SELF.ACCTNO       := l.acctno;
      SELF.ADDR       	:= trim(l.property_address1,RIGHT) + ' ' + l.property_address2;
			SELF.p_city_name	:= l.property_p_city_name;
			SELF.st          	:= l.property_st;
			SELF.z5      		  := l.property_zip;
			SELF.zip4      	  := l.property_zip4;
			SELF.county_name  := l.property_county_name;
			SELF := [];
   end;
  
	batch_in_addr := project(prop_he_unique_addr, fillAddr(left));
	BatchShare.MAC_CleanAddresses(batch_in_addr, batch_in_parsedaddr);
	//parsed address needed for fn_getPropertyBatch
	//remove addressess that didn't clean.
	batch_in_addr_clean := project(batch_in_parsedaddr, batchdatasets.layouts.batch_in)(prim_range <> '' and prim_name <> '') ;
//***********************************************************	 
//   S T E P   2
//***********************************************************	 	 
  //get all property records for these unique address locations for further processing.
	prop_addr := fn_getPropertyBatch(batch_in_addr_clean, nss, isFCRA);
	HomesteadExemption_Services.layouts.layout_prop_batch_plus fill_clean(prop_addr l) := transform
	 	self.clean_parcelID := map (l.assess_apna_or_pin_number <> '' => HomesteadExemption_Services.Functions.fn_addZeroToParcelID(l.assess_apna_or_pin_number),
		                            l.deed_apnt_or_pin_number   <> '' => HomesteadExemption_Services.Functions.fn_addZeroToParcelID(l.deed_apnt_or_pin_number),
																 stringlib.StringCleanSpaces(l.property_address1 + ' '+l.property_address2 + ' '+ l.property_p_city_name +' '+l.property_st +' '+l.property_zip));
    self := l;
		self := [];
  end;																 
	prop_addr_clean := project(prop_addr, fill_clean(left));
	HomesteadExemption_Services.layouts.layout_prop_batch_plus  addBatch(prop_he_unique_addr l, prop_addr_clean r) := transform
	   propFound := r.acctno <> '';
	   self.acctno := l.acctno;
     self.isHomesteadExcemption := if (propFound,l.isHomesteadExcemption, false);
		 self.homestead_exemption_flag := if (propFound,l.homestead_exemption_flag, '');	   
		 self.did := if (propFound,l.did,0);
		 self.in_tax_year := if (propFound,l.in_tax_year,'');
		 self.clean_parcelID := if (propFound,l.clean_parcelID,'');  //did=52 finds a parcelID but the address for that parcelID returns a different parcelID so the join fails.
 	   self.county_property :=if (propFound, map(r.assess_county_name <> '' => r.assess_county_name,																
		                            r.deed_county_name <> '' => r.deed_county_name,
																''),'');
		 self := r;
	end;
	
	prop_addr_plus := join(prop_he_unique_addr, prop_addr_clean, left.acctno = right.acctno and left.clean_parcelID = right.clean_parcelID, addBatch(left,right), left outer);
	
	//get latest record for each parcelID, highest date, Assess over Deed,  source A over B														 
	prop_2per_parcel := dedup(sort(prop_addr_plus, acctno, clean_parcelID, -sortby_date, fid_type, vendor_source_flag),acctno, clean_parcelID);
  	
	prop_2per_homestead  := join(prop_2per_parcel, assessYearsTable, 
	                             left.acctno = right.acctno and left.clean_parcelID = right.clean_parcelID,
															 transform(HomesteadExemption_Services.layouts.layout_prop_batch_plus, self.homestead_count_years := (string)right.assess_cnt, self := left),
															 left outer);
	prop_2per_length  := join(prop_2per_homestead, prop_parcel_1_homestead, 
	                             left.acctno = right.acctno and left.clean_parcelID = right.clean_parcelID,
															 transform(HomesteadExemption_Services.layouts.layout_prop_batch_plus, self.homestead_exemption_flag := right.homestead_exemption_flag, self := left),
															 left outer);															 
															 
  prop_2per_length set_owner_plus(prop_2per_length l,prop_2per_length r) := transform
	 //step 7  Set Co-Owner flag in input did1/ownername1 and did2/ownername2 match owner1 and owner2 of a single property.
	 prop_own1 := ut.nzeq(l.did, (integer)l.owner_1_did) OR ut.nzeq(l.did, (integer)l.owner_2_did);
	 prop_own2 := ut.nzeq(r.did, (integer)r.owner_1_did) OR ut.nzeq(r.did, (integer)r.owner_2_did);
	 prop_owned := prop_own1 or prop_own2;
	 soldIt := (l.sortby_date >= l.in_tax_year) and ~prop_owned;
	 saleDateLeft := map(l.deed_contract_date <> ''=> l.deed_contract_date , 
														    l.assess_sale_date <> '' => l.assess_sale_date,
																l.sortby_date);
	 saleDateRight := map(r.deed_contract_date <> ''=> r.deed_contract_date , 
														    r.assess_sale_date <> '' => r.assess_sale_date,
																r.sortby_date);																
   saleDate := min2String(saleDateLeft, saleDateRight);														
	 prop_co_owned := prop_own1 and prop_own2 and (l.did <> r.did);
	 
   self.property_coownership := if (prop_co_owned ,'Y','');
	 //step 7A Multiple Ownership.
   self.coowner_mult_exemption := if (prop_co_owned AND (l.assess_owner_occupied = 'Y' or r.assess_owner_occupied = 'Y'),'Y','');
	 //step 7B set purchase_date = (deed_contract_date or tax_sale_date) if current owner of property.  Does tax_sale_date=assess_sale_date(YYYYMMDD)
   self.purchase_date := if (prop_owned, if (l.deed_contract_date <> '', l.deed_contract_date , l.assess_sale_date),'');   
	 self.sale_date := if (soldIt ,saleDate,'');														
														; 
   self.seller_first := l.seller_1_first_name;
	 self.seller_last :=  l.seller_1_last_name;
	 self.seller_company := l.seller_1_company_name;														
                        //multiple deed_contract_dates  (refinancing, etc)....pick the lowest one where owner DID = input DID found.
                       // same with assess_sale_date (there only appears to be one of these)  
   self.homestead_count_years := max(l.homestead_count_years, r.homestead_count_years);  //max of either owners 		
	 self.owner_occupied := if (prop_owned and  (l.assess_owner_occupied = 'Y' or r.assess_owner_occupied = 'Y'),'Y','');
	 self.ownership_length := if (saleDate <> '', (string)lib_date.getage(saleDate),'');  
   self := l;											 
	end;
	
  prop_1per_parcel_roll := rollup(prop_2per_length, left.acctno[1..(length(trim(left.acctno))-2)] = right.acctno[1..(length(trim(right.acctno))-2)] and 
                                               left.clean_parcelID = right.clean_parcelID,	                                             
																							 set_owner_plus(left,right));
	prop_1per_parcel_roll set_owner_plus2(prop_1per_parcel_roll l) := transform
	 prop_own1 := ut.nzeq(l.did, (integer)l.owner_1_did) OR ut.nzeq(l.did, (integer)l.owner_2_did);
	 soldIt := (l.sortby_date >= l.in_tax_year) and ~prop_own1;
	 // REMOVE PROPERTY if there is a seller DID and its different than the subject 
	 // or the seller is a company and the subject is not the owner
	 // or the seller names don't match the input subject
	 // See: self.purchase_date assignment below for SKIP.
	 seller1blank := trim(l.seller_1_last_name + l.seller_1_first_name) = '';
	 seller2blank := trim(l.seller_2_last_name + l.seller_2_first_name) = '';
	 sellerNotSubject :=  MAP (l.seller_1_company_name <> '' => TRUE,
	                            HomesteadExemption_Services.Functions.fn_dids_match(l.did, (integer)l.seller_1_did, (integer)l.seller_2_did) => FALSE,
	                            HomesteadExemption_Services.Functions.fn_names_match(l.in_name_last, l.in_name_first, 
														                                                          l.seller_1_last_name, l.seller_1_first_name,
																																											l.seller_2_last_name, l.seller_2_first_name,) => FALSE,
														  (L.seller_1_did = '' and L.seller_2_did = '' AND seller1blank and seller2blank) => FALSE,																			 																																											
														 TRUE);
	 
	 saleDate := map(l.deed_contract_date <> ''=> l.deed_contract_date , 
														    l.assess_sale_date <> '' => l.assess_sale_date,
																l.sortby_date);
	 //step 7B set purchase_date = (deed_contract_date or tax_sale_date) if current owner of property.  Does tax_sale_date=assess_sale_date(YYYYMMDD)
   //remove/skip records that are for property SOLD by the subject but the seller indicated is not the subject.   
	 self.purchase_date := if (prop_own1,if (l.deed_contract_date <> '', l.deed_contract_date , l.assess_sale_date), if (sellerNotSubject, SKIP, ''));   
	 self.sale_date := if (soldIt ,saleDate,'');														
	 self.seller_first := l.seller_1_first_name;
	 self.seller_last :=  l.seller_1_last_name;
	 self.seller_company :=  l.seller_1_company_name;				
	 self.ownership_length := if (saleDate <> '', (string)lib_date.getage(saleDate),'');  	
	 //fix for DEED that are refinance and only a Borrrower name exists.
	 //in this case only return the borrower name as the owner name if the owner name is blank.
	 owner1Full := stringlib.stringcleanspaces(l.owner_1_first_name + l.owner_1_middle_name + l.owner_1_last_name);
	 owner2Full := stringlib.stringcleanspaces(l.owner_2_first_name + l.owner_2_middle_name + l.owner_2_last_name);
	 useBorrower1 := if (l.fid_type = 'D' and owner1Full = '', TRUE, FALSE);
	 useBorrower2 := if (l.fid_type = 'D' and owner2Full = '', TRUE, FALSE);
	 self.owner_1_first_name  := if (useBorrower1, l.borrower_1_first_name, l.owner_1_first_name);
	 self.owner_1_middle_name := if (useBorrower1, l.borrower_1_middle_name, l.owner_1_middle_name);
	 self.owner_1_last_name   := if (useBorrower1, l.borrower_1_last_name, l.owner_1_last_name);
	 self.owner_1_name_suffix := if (useBorrower1, l.borrower_1_name_suffix, l.owner_1_name_suffix);
	 
	 self.owner_2_first_name  := if (useBorrower2, l.borrower_2_first_name, l.owner_2_first_name);
	 self.owner_2_middle_name := if (useBorrower2, l.borrower_2_middle_name, l.owner_2_middle_name);
	 self.owner_2_last_name   := if (useBorrower2, l.borrower_2_last_name, l.owner_2_last_name);
	 self.owner_2_name_suffix := if (useBorrower2, l.borrower_2_name_suffix, l.owner_2_name_suffix);
   self := l;											 
	end;
																							 
  prop_1per_parcel := project(prop_1per_parcel_roll, set_owner_plus2(left));	
	//final sorting prior to flatting output properties
	prop_final_sort := sort(prop_1per_parcel,acctno, -homestead_exemption_flag, sale_date, -sortby_date, clean_parcelID);
	//step 8  Set Business Flag
	prop_final_sort  setBusiFlag(prop_final_sort l ) := transform
	  self.business_owner_flag := if (l.owner_1_company_name <> '' or 
		                                l.owner_2_company_name <> '' or 
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_1_orig_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_1_first_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_1_middle_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_1_last_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_1_name_suffix ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_2_orig_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_2_first_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_2_middle_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_2_last_name ) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.owner_2_name_suffix ),'B','');
		self.business_seller_flag := if (l.seller_company <> '' or 
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.seller_first) or
																		HomesteadExemption_Services.Functions.fn_findCorpWords(l.seller_last),'B','');
		self :=l;
	end;
	ds_businessFlag := project(prop_final_sort, setBusiFlag(left));
  
	// both the parent and children records need to have acctno that have the -1 -2 stripped off at this point.
	//property needs to be in correct order at this point.
	propChildren2flatten := project(ds_businessFlag, HomesteadExemption_Services.Transforms.xfm_1_prop(left));
  	
  //denormalize up to 10 properties for each acctno
	// one set of property fields: layout_temp_property_rec
	// 10 sets of property fields: layouts.layout_property_recs
	property_flat := denormalize(propParent, propChildren2flatten, left.acctno= right.acctno, 
	                             HomesteadExemption_Services.Transforms.xfm_10_property(left,right,counter));
	
	//debug output
		//debug
		
	 IF( in_mod.ViewDebugs, 
			OUTPUT( ds_batch_in, NAMED('batch_in') ) );
	 IF( in_mod.ViewDebugs, 
			OUTPUT( prop_raw, NAMED('prop_raw') ) );
			
			
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_own_wBlankAddr, NAMED('PropertyALL_HE_found') ) );
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_addr_clean, NAMED('PropertyAddress_found') ) );
	IF( in_mod.ViewDebugs, 
			OUTPUT( prop_own_every_year, NAMED('prop_own_every_year') ) );
	IF( in_mod.ViewDebugs, 
			OUTPUT( assessYearsTable, NAMED('assessYearsTable') ) );			
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_he, NAMED('prop_he') ) );			
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_parcel_1_homestead, NAMED('prop_parcel_1_homestead') ) );					
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_addr_plus, NAMED('prop_addr_plus') ) );
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_2per_parcel, NAMED('PropertyLatestRecordOnly') ) );
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_2per_length, NAMED('prop_2per_length') ) );
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_1per_parcel_roll, NAMED('prop_1per_parcel_roll') ) );
  IF( in_mod.ViewDebugs, 
			OUTPUT( prop_1per_parcel, NAMED('prop_1per_parcel') ) );
	IF( in_mod.ViewDebugs, 
			OUTPUT( prop_final_sort, NAMED('PropertyNoBusiFlag') ) );
	IF( in_mod.ViewDebugs, 
			OUTPUT( property_flat, NAMED('PropertyOutput') ) );	

	RETURN property_flat;
END; //of function