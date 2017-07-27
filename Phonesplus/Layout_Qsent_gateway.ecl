import AutoStandardI,BatchServices,PhonesFeedback_Services,Doxie_Raw,iesp;

export Layout_Qsent_gateway := MODULE
			
	export t_QSentCISAddress := RECORD
		iesp.share.t_Address;
		string AddressType {xpath('AddressType')};
	END;	
	export t_QSentCISPhone := RECORD
     string PhoneNPA {xpath('PhoneNpa')};
     string PhoneNXX  {xpath('PhoneNxx')};
		 string PhoneLine  {xpath('PhoneLine')};
  END;
	export t_QSentCISPhone_out := RECORD
     string PhoneNPA {xpath('PhoneNpa')};
     string PhoneNXX  {xpath('PhoneNxx')};
     string PhoneLine  {xpath('PhoneLine')};
  END;
	EXPORT t_QSentCISOCPhoneInfo := RECORD
		string PhoneNPA {xpath('PhoneNpa')};
		string PhoneNXX {xpath('PhoneNxx')};
		string PhoneLine {xpath('PhoneLine')};
		string PhoneExt {xpath('PhoneExt')};
		string FaxLine {xpath('FaxLine')};
		string FaxNpa {xpath('FaxNpa')};
		string FaxNxx {xpath('FaxNxx')};
	END;
	EXPORT t_QSentCISOCName := record
		string82 Full {xpath('Full')};
		string30 First {xpath('First')};
		string20 Middle {xpath('Middle')};
		string30 Last {xpath('Last')};
		string5 Suffix {xpath('Suffix')};
		string3 Prefix {xpath('Prefix')};
	END;
	EXPORT t_QSentCISOCContactInfo := RECORD
		t_QSentCISOCName Name {xpath('Name')};
		iesp.share.t_Address Address {xpath('Address')};
		string Email {xpath('Email')};
	END;
	export t_QSentCISOperatingCompany := RECORD
		 String  Number {xpath('Number')}; 
		 String  Name {xpath('Name')}; 
		 String  AffiliatedTo {xpath('AffiliatedTo')}; 
		iesp.share.t_Address Address  {xpath('Address')}; 
		 t_QSentCISOCPhoneInfo  PhoneInfo {xpath('PhoneInfo')}; 
		 t_QSentCISOCContactInfo  Contact {xpath('Contact')}; 
	END;
	export t_QSentCISDeliveryInfo := RECORD
	  String MetroStatAreaCode {xpath('MetroStatAreaCode')}; 
		String ConsMetroStatAreaCode {xpath('ConsMetroStatAreaCode')}; 
		String DeliveryPointCode {xpath('DeliveryPointCode')}; 
		String CountyCode {xpath('CountyCode')}; 
		String CarrierRoute {xpath('CarrierRoute')}; 
		String CheckDigit {xpath('CheckDigit')}; 
		String SortZone {xpath('SortZone')}; 
	END;
	
	export t_QSentCISSearchBy := RECORD
		  String BusinessName {xpath('BusinessName')};
      Boolean UseSimilarBusinessNames {xpath('UseSimilarBusinessNames')};
      String FirstName {xpath('FirstName')};
      Boolean UseSimilarFirstNames {xpath('UseSimilarFirstNames')};
      String LastName {xpath('LastName')};
      Boolean UseSimilarLastNames {xpath('UseSimilarLastNames')};
      String StreetAddress {xpath('StreetAddress')};
      String City {xpath('City')};
      String State {xpath('State')};
      String Zip5 {xpath('Zip5')};
      String Zip4 := '' ; 
      t_QSentCISPhone phone {xpath('Phone')}; 
      String SurroundMiles := '' ;
      String MetroCode := '' ;
      String GeoQuery := '' ;
      String GeoState := '' ;
			String SSN {xpath('SSN')}:= '';
	END;
	
	EXPORT t_QSentCISEndUserInfo := RECORD
		String CompanyName := '' ;
		String StreetAddress1 := '' ;
		String City := '' ;
		String State := '' ;
		String Zip5 := '' ;
	END;


	EXPORT t_QSentCISUser  := RECORD
		string ReferenceCode {XPATH('ReferenceCode')}:= '' ;
		string BillingCode := '' ; 
		string QueryId := '' ;
		string GLBPurpose {XPATH('GLBPurpose')};
		string DLPurpose  {XPATH('DLPurpose')};
		t_QSentCISEndUserInfo EndUser;
		integer MaxWaitSeconds := 2000000;
	END;
	
	EXPORT t_QSentCISSearchOptions := RECORD
		String ReferenceId := '' ;
		String QueryType {xpath('QueryType')};
		String StartSequence := '' ;
		String ResultCount {xpath('ResultCount')}:= '' ;
		boolean ShowNonPublished {xpath('ShowNonPublished')};
		String ServiceType {xpath('ServiceType')};
		String QueryCategory := '' ;
		boolean IntelligentSearch {xpath('IntelligentSearch')};
		String SearchCode := '' ; 
		String Match {xpath('Match')} := '' ;
		String MatchSortCode {xpath('MatchSortCode')}:= '' ;
		String MinScore := '' ;
		String1 RequestCredential {xpath('RequestCredential')}:= '0';
		boolean Blind {xpath('Blind')};
	END;
	
	EXPORT t_QSentCISGatewayParams := RECORD
		string16 TxnTransactionId {xpath('TxnTransactionId')};
		integer  BatchJobId {xpath('BatchJobId')};
		integer  ProcessSpecId {xpath('ProcessSpecId')};
		integer  RoyaltyCode {xpath('RoyaltyCode')};
		string50 RoyaltyType {xpath('RoyaltyType')};
		string80 QueryName {xpath('QueryName')};
		boolean	 CheckVendorGatewayCall {xpath('CheckVendorGatewayCall')};//hidden[internal]
		boolean  MakeVendorGatewayCall {xpath('MakeVendorGatewayCall')};//hidden[internal]	
	END;
	
	EXPORT t_QSentCISSearchRequest := RECORD
	    t_QSentCISUser User {xpath('User')};
			t_QSentCISSearchOptions Options {xpath('Options')};
			t_QSentCISSearchby SearchBy {xpath('SearchBy')};
			t_QSentCISGatewayParams GatewayParams {xpath('GatewayParams')}; 
	END;
	
	EXPORT t_QSentCISSearchSummary := RECORD
			String ReferenceId {xpath('ReferenceId')};
			integer IntelligentSearchResult {xpath('IntelligentSearchResult')};
			integer StateListCount {xpath('StateListCount')};
			integer TotalListingsFound {xpath('TotalListingsFound')};
			integer TotalListingsReturned {xpath('TotalListingsReturned')};
			string ResponseType {xpath('ResponseType')};
			string StatusCode {xpath('StatusCode')};
			string ErrorCode {xpath('ErrorCode')};
			string ErrorMessage {xpath('ErrorMessage')};
			string ErrorDescription {xpath('ErrorDescription')};
	END;
	
	 
	EXPORT t_QSentCISListing  := RECORD
		 String CongressionalDistrict  {xpath('CongressionalDistrict')};
		 String Latitude {xpath('Latitude')} ;
		 String Longitude {xpath('Longitude')};
		 String ListingType {xpath('ListingType')};
		 String ListingName {xpath('ListingName')};
		 String MatchCode  {xpath('MatchCode')};
		 String MatchScore  {xpath('MatchScore')};
		 String ServiceClass  {xpath('ServiceClass')} ;
		 String DataSource  {xpath('DataSource')};
		 String NonPublished  {xpath('NonPublished')};
		 String2 SSNMatch {xpath('SSNMatch')};
		 iesp.share.t_date ListingCreationDate  {xpath('ListingCreationDate')};
		 iesp.share.t_date ListingTransactionDate  {xpath('ListingTransactionDate')};
		iesp.share.t_Name Name {xpath('Name')};
		 t_QSentCISPhone_out Phone {xpath('Phone')};
		 t_QSentCISOperatingCompany OperatingCompany {xpath('OperatingCompany')};
		 t_QSentCISAddress Address {xpath('Address')};
		 t_QSentCISDeliveryInfo DeliveryInfo {xpath('DeliveryInfo')};
	END;

  EXPORT t_QSentCISListings  := RECORD 
		DATASET(t_QSentCISListing) Listing {maxcount(BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT),  xpath('Listing')};
	END;

	EXPORT t_QSentCISStateListing := RECORD
			String ListingsReturned {xpath('ListingsReturned')};
			String ListingsFound {xpath('ListingsFound')};
			string StateName {xpath('StateName')};
			string StateAbbr {xpath('StateAbbr')};
			string Filtered {xpath('Filtered')};
      t_QSentCISListings Listings {xpath('Listings')};
	END;
	
	EXPORT t_QSentCISStateListings := RECORD
      DATASET(t_QSentCISStateListing) StateListing {maxcount(BatchServices.Constants.RealTime.REALTIME_PHONE_LIMIT),xpath('StateListing')};
	END;
	
	EXPORT t_QSentCISPVListing := RECORD
	    String GenericName {xpath('GenericName')};
  		String PortingCode {xpath('PortingCode')};
			String DataSource {xpath('DataSource')};
			String ServiceClass {xpath('ServiceClass')};
			t_QSentCISPhone_out Phone {xpath('Phone')};
			t_QSentCISOperatingCompany OperatingCompany {xpath('OperatingCompany')};	
	END;	
	
	EXPORT t_QSentCISSearchResponse := RECORD
	    String ErrorMessage := '';
	    String ErrorCode := '';
      t_QSentCISSearchSummary Summary {xpath('Summary')};
      t_QSentCISStateListings StateListings {xpath('StateListings')};
      t_QSentCISPVListing PVListing {xpath('PVListing')};
  END;
	export t_QSentCISSearchResponseEx := record
	   	t_QSentCISSearchResponse response {xpath('response')};
  end;

	
	
END;