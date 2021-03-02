import  TopBusiness, iesp;
export PropertySection_layouts := MODULE

	export rec_OptionsLayout := record
		boolean lnbranded;
		boolean internal_testing;
		string1 businessReportFetchLevel;
    boolean IncludeVendorSourceB;
    boolean IncludeAssignmentsAndReleases;
	end;
	
	export rec_input := record
		string25 acctno;
		iesp.share.t_businessIdentity;
	end;
	
	export rec_main := record 
		string12  ln_fares_id;	
		string1   vendor;				
		string5   county_code;
		string45  apn; // or is it the next field.including both
		string200 legal_description;
		iesp.share.t_Address Property_Address;
		string25  property_id;
		boolean   current_flag;
		unsigned4 owner_date;
	end;			
				
  export rec_Mortgage := record
	  string12  in_ln_fares_id;
	  string12  ln_fares_id;
		string1   vendor;	
		string1   current_record;
	  iesp.share.t_date   recordingDate;
		iesp.share.t_date   contractDate;	
		string15  LoanAmount;
		string15  LoanAmount2; 
		iesp.share.t_date   LoanDate; // 
		string40  lenderName;     
		string1   buyer_or_borrower_ind; //new - 'O' for buyer, 'B' for borrower
		string18  county_name;
		string2   st;
		string30 TransactionType;
		string30 Description;
		string50 LoanType;
		string1 firstTDLenderTypeCode;		
		string3 firstTDLoanTypeCode;
		string45 apn;
		string3 documentTypeCode;	      // adding here due to moving join to codesv3 outside deed key join
		string3 faresTransactionType;		// adding here due to moving join to codesv3 outside deed key join
	end;			
	
	export mortgageInfo := record
		string12 in_ln_fares_id;
		string12 ln_fares_id;
		string1 current_record;
		iesp.TopBusinessReport.t_TopBusinessPropertyMortgageInfo;
	end;			

  export foreclosureNOD_info := record
	   string12 ln_fares_id;
		 iesp.TopBusinessReport.t_TopBusinessPropertyForeclosure;
	end;
  export transactionInfo := record
		string12 ln_fares_id;
		iesp.TopBusinessReport.t_TopbusinessPropertyTransaction;
	end;
	
	export accurintPartyFields := record
		string10  prim_range;
		string2   predir;
		string28  prim_name;
		string4   suffix;
		string2   postdir;
		string10  unit_desig;
		string8   sec_range;
		string25  p_city_name;
		string25  v_city_name;
		string2   st;
		string5   zip;
		string4   zip4;
		string4   cart;
		string1   cr_sort_sz;
		string4   lot;
		string1   lot_order;
		string2   dbpc;
		string1   chk_digit;
		string2   rec_type;
		string5   county;
		string18   county_name;
		string10  geo_lat;
		string11  geo_long;
		string4   msa;
		string7   geo_blk;
		string1   geo_match;
		string10  phone_number;
		string12 UniqueID; 
	end;
	
	export rec_party := record
		string2   source;
		string50  ln_fares_id;								
		string1   vendor;		
		string1   party_type;						
		string1   party_type_address;		
		string120 company_name;
		unsigned4 owner_date;
		string20  name_last;
		string20  name_first;
		string20  name_middle;
		string5   name_suffix;
		string5   name_title;
		iesp.share.t_address property_Address;			
		iesp.share.t_address ownerSeller_address;
		// extra accurint fields
		accurintPartyFields;
   end;			
	
	export denorm_layout := record
	   string1 current_record;	  	
	   iesp.share.t_businessIdentity;
		 string12 ln_fares_id;
		 string12 in_ln_fares_id;
		 string1 party_type;
		 string1 party_type_address;
		 unsigned4 owner_date;
		 iesp.share.t_address property_Address;
	end;
	export rec_PropertyTransactionExtra := record
	  string12 ln_fares_id;
		string1  partyType;    // O - owner, B - Buyer
		string1  party_type_address;   //party_type_addresses here are types S, (Seller) P (Property), O (Owner)
		string120 companyName;                     // could be either owner or seller.
		iesp.share.t_Name Name;        // this may be blank or not and could be owner or seller
		iesp.share.t_Address Address;   // represents both owner or seller.
		//iesp.share.t_Address PropertyAddress;	
	end;
	
	export rec_propertyBizLayoutExtra := record
		string12 ln_fares_id;
		unsigned4 owner_date;
		//string1 partyType;
		boolean isForeclosed; 		//for each row														 
		boolean IsNOD; 			
		string1 current_record;
		iesp.share.t_address property_Address; ////TMP ADD HERE
		iesp.topBusinessReport.t_TopbusinessPropertyParty;
		//unsigned4 addrs_per_state; 
	end;
	
	 export rec_PropertyParent := record
	  rec_main;		
		iesp.share.t_businessIdentity;		
		string12 in_ln_fares_id;
    string15	assessedTotalValue;
		string15	marketLandValue;
	  string15	marketTotalValue;
		string8   AssessmentDate;   				
		string12 PropertyUniqueID;
		boolean isForeclosed;
		boolean isNOD;
    dataset(rec_propertyBizLayoutExtra) Parties 
		        {MAXCOUNT(iesp.constants.TOPBUSINESS.MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS)};					
		//string120 CnamePropertyOwner
	end;			
	
	export rec_dateLayout := record
	  string50 ln_fares_id;
		unsigned4 foreclosureNOD_recording_date;		
		string12 in_ln_fares_id;
	end;
		
	export accurint_accessorFields := record
		//  accessor fields:        
		string2		stateCode;
		string30	countyName;
		//string45	APN;
		string5		fipsCode;
		string2		duplicateApnMultipleAddressId;
		string3		assesseeOwnershipRightsCode;
		string47  assesseeOwnershipRightsDesc;
		string2		assesseeRelationshipCode;
		string47  assesseeRelationshipDesc;
		string1		  ownerOccupied;
		string8		recordingDate;
		string8		priorRecordingDate;
		string45	countyLandUseDescription;
		string4	standardizedLandUseCode; 
		string76  standardizedLandUseDesc; 
		string250	legalBriefDescription;		
		string7		legalLotNumber;	 
		string40	legalSubdivisionName;	 
		string2		recordTypeCode;
		string103 recordTypeDesc;
		string10	recorderBookNumber;
		string10	  recorderPageNumber;
		//string8		saleDate;
		string15	  salesPrice;
		string15	mortgageLoanAmount;
		string5		mortgageLoanTypeCode;
		string31   mortgageLoanTypeDesc;
		string60	  mortgageLenderName;
		// string11	    assessedTotalValue;
		string4		  assessedValueYear;
		string1		homesteadHomeownerExemption;
		 //string11	marketLandValue; 
		string15	marketImprovementValue;
		//string11  	marketTotalValue;
		string4		marketValueYear;
		string13	  taxAmount;
		string4		taxYear;
		string30	  landSquareFootage;
		string4	  yearBuilt; 
		string5	  noOfStories;
		string28   noOfStoriesDesc;		
		string5		noOfBedrooms;
		string8		noOfBaths;
		string2		noOfPartialBaths;
		string3		garageTypeCode;
		string3		poolCode;
		string27  poolDesc;
		string3		exteriorWallsCode;
		string30  exteriorWallsDesc;		
		string5		roofTypeCode;			
		string20  roofTypeDesc; 
		string3		heatingCode;
		string28  heatingDesc;
		string3		  heatingFuelTypeCode;
		string23    heatingFuelTypeDesc;
		string3		  airConditioningCode;
		string28    airConditioningDesc;
		string1	  airConditioningTypeCode;
		string18   airConditioningTypeDesc;
	end;
		
	export rec_PropertyIntermediateLayout := record
	  rec_PropertyParent;		         				 																								
		// boolean isForeclosed;
		// boolean isNOD;
		string45 fares_unformatted_apn;
		//unsigned2 salesPrice;
		string30  DocumentType;
		iesp.share.T_date  SaleDate;
		//string18 County;
		string50 county_land_use_description;
		// both of these are debug fields to be removed later
		string30 my_fares_id;
		integer CountForeclosed;
		integer CountNOD;
		dataset(rec_datelayout) foreclosure_stamped_date;
		dataset(rec_datelayout) NOD_stamped_date;
		string40 AddressType;
		string45 LandUsage;
		// all the accessor key fields for accurrint
		// put into iesp.topbusinessReport.t_topBusinessProperty
		//accurint_accessorFields;
		iesp.topbusinessReport.t_TopBusinessAccessor accessor;
		string8 recording_date;
		string15 salesPrice;
	end;
	
	export 	rec_linkids_plus_PropertyDetail := record
		string120 CnamePropertyOwner;
		unsigned4 AssessmentDateCalculation;
		string50 county_land_use_description;
	  iesp.share.t_businessIdentity;							
		string1   current_record;		// add back in later.
		unsigned4 addrs_per_state;	
		dataset(rec_datelayout) foreclosure_stamped_date;
		dataset(rec_datelayout) NOD_stamped_date;
		integer CountForeclosed;
		integer CountNOD;		
		iesp.topBusinessReport.t_TopBusinessProperty; // includes  PropertyUniqueID				
		                                              // includes accessor accurint fields
																									// includes deeed accurint fields
  end;
	
	export rec_linkids_plus_propertyDetail_foreclosureNOD := record
	  rec_linkids_plus_PropertyDetail;	
  end;	
	
	export rec_linkids_plus_PropertyRecord := record
	  string25  acctno;
		unsigned4 AssessmentDateCalculation;
		iesp.share.t_businessIdentity;
		iesp.topBusinessReport.t_TopbusinessPropertySummary;   
		integer totalCnt;
	end;	
	export rec_final := record
	  string25 acctno;
		//unsigned2 PropertyRecordCount;
		//rec_linkids_plus_PropertyRecord - acctno PropertyRecords;
		iesp.topbusinessreport.t_TopBusinessPropertySection;	
	end;	
	
end;