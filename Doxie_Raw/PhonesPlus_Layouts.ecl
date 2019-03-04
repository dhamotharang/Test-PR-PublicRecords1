import PhonesFeedback_Services, iesp, Risk_Indicators;

export PhonesPlus_Layouts := MODULE
		// Child dataset layout
		export Layout_Phone_noreconn_description := record
			 string  description := '';
		end;

		// Tidy up the layout
		export finalLayout  := record
			string1    typeFlag;  // N, D or G
			string15   did;
			string120  listed_name;
			string10   phone;
			DATASET(PhonesFeedback_Services.Layouts.feedback_report) Feedback {MAXCOUNT(1)};
			string100   Carrier_Name;  //Original Carrier Name?  e.g. Sprint	

			string3    COCType;
			dataset(Layout_Phone_noreconn_description) COCDescription;	
			string4    SSC;
			dataset(Layout_Phone_noreconn_description) SSCDescription;		
			
			string5    title;
			string30   fname;
			string20   mname;
			string30   lname;
			string5    name_suffix;	
			//Address Risk Indicators
      boolean    yellow_flag := false; //this indicates if a yellow flag should be displayed in Client based on the hri code
			DATASET(Risk_Indicators.Layout_Desc) hri_address {MAXCOUNT(10)};
      string1    tnt := '';
			string10   prim_range;
			string2    predir;
			string28   prim_name;
			string4    suffix;
			string2    postdir;
			string10   unit_desig;
			string8    sec_range;
			// string70   streetaddress;
			string25   city_name;
			string2    st;
			string5    zip;
			string4    zip4;
      string18   county_name;
			string1    listing_type_bus;
			string1    listing_type_res;
			string1    listing_type_gov;	
			string254  caption_text;
			string1    dial_indicator;     // Telcordia dial indicator, translate 1 = Y and 0 = N
			string50   phone_region_city;  // Telcordia city
			string2    phone_region_st;    // telcordia state
			string1    telcordia_only;
			string2 vendor_id;
			string25	  append_phone_type:= '';
			string1 activeflag;
			DATASET(Risk_Indicators.Layout_Desc) hri_phone {MAXCOUNT(10)};
			STRING2 TargusType := '';
			boolean confirmed_flag := false;
			boolean isDeepDive := false;
			string2 SSNMatch := '';
			string9 SSN := '';
			string9 ssn_unmasked := '';
			unsigned4 dod := 0;
			boolean IsLimitedAccessDMF := false;
		  string1 deceased;
		end;

		export preFinalLayout := record
			string20  acctno;
			unsigned2 penalt;
			finalLayout;
			unsigned2 ConfidenceScore;
			unsigned4 cell_type := 1; 
			string30  new_type := '';
			string120  listed_name_targus;
			string4 timezone;
			string8      dt_first_seen;
			string8      dt_last_seen;
			boolean      vendor_dt_last_seen_used;
			string15 service_type := '';
		end;

		export Layout_Phone_Description := record
			 string  description := '';
		end;
		
	export t_QSentCISOCName_out := RECORD
		string62 fullname;
		string20 fname;
		string20 mname;
		string30 lname;
		string5 name_suffix ;
		string3 name_prefix ;
	END;
	
	export t_QSentCISOCAddress_out := RECORD
		string10 StreetNumber {xpath('prim_range')};
		string2 StreetPreDirection {xpath('predir')};
		string28 StreetName {xpath('prim_name')};
		string2 StreetPostDirection {xpath('postdir')};
		string4 StreetSuffix {xpath('suffix')};
		string10 UnitDesignation {xpath('unit_desig')};
		string8 UnitNumber {xpath('sec_range')};
		string60 StreetAddress1 {xpath('streetaddress1')};
		string60 StreetAddress2 {xpath('streetaddress2')};
		string2 State {xpath('state')};
		string25 City {xpath('city')};
		string5 Zip5 {xpath('zip5')};
		string4 Zip4 {xpath('zip4')};
		// string18 County {xpath('County')};
	END;
	
	EXPORT t_QSentCISOCPhoneInfo_out := RECORD
		string PhoneNPA ;
		string PhoneNXX ;
		string PhoneLine ;
		string PhoneExt ;
		string FaxLine ;
		string FaxNpa ;
		string FaxNxx ;
	END;
	
	EXPORT t_QSentCISOCContactInfo_out := RECORD
		t_QSentCISOCName_out Name ;
		t_QSentCISOCAddress_out Address ;
		string Email ;
	END;

	
	export t_QSentCISOperatingCompany_out := RECORD
		 String  Number ; 
		 String  Name ; 
		 String  AffiliatedTo ;
		 t_QSentCISOCAddress_out Address  ;
		 t_QSentCISOCPhoneInfo_out  PhoneInfo ;
		 t_QSentCISOCContactInfo_out  Contact ;
	END;
	
	export t_RealTimePhone_Ext := RECORD
		string CallerId := '' ;
		string StatusCode  := '';
		string StatusCode_Desc  := '';
		string StatusCode_Flag := '';
		string StatusCode_FlagDesc  := '';
		String PortingCode  := '';
		String PortingCode_Desc  := '';
		// new columns added for Real-time Phones Batch
		String CongressionalDistrict  {xpath('CongressionalDistrict')};
		String CarrierRoute := '' ;
		String SortZone := '' ;
		String MetroStatAreaCode := '' ;     
		String ConsMetroStatAreaCode := '' ;
		String Latitude {xpath('Latitude')} ;
		String Longitude {xpath('Longitude')};
		String CountyCode  {xpath('FIPS')};
		String DataSource  {xpath('DataSource')};
		String ListingType {xpath('ListingType')};
	  String ListingName {xpath('ListingName')};
		iesp.share.t_date ListingCreationDate {xpath('ListingCreationDate')};
		iesp.share.t_date ListingTransactionDate;
		String NonPublished  {xpath('NonPublished')};
		String PrivacyIndicator  {xpath('PrivacyIndicator')};
		t_QSentCISOperatingCompany_out OperatingCompany;
	END;
	
	export t_RealTimePhone_Ext1 := RECORD(t_RealTimePhone_Ext)
		string ServiceClass {xpath('ServiceClass')};
		string GenericName {xpath('GenericName')};
		string DeliveryPointCode {xpath('DeliveryPointCode')};
		string DeliveryPointCheckDigit {xpath('DeliveryPointCheckDigit')};
		string AddressType {xpath('AddressType')};
	END;
	
	export t_PhoneplusSearchResponse := RECORD
	  preFinalLayout;
		t_RealTimePhone_Ext  RealTimePhone_Ext;
	END;
	
	export PhonePlusSearchResponse_Ext := RECORD
		preFinalLayout;
		t_RealTimePhone_Ext1 RealTimePhone_Ext;
	END;

END;