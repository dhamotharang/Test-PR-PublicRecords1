/*2013-12-20T16:49:19Z (akoenen)
C:\Users\koenenax\AppData\Roaming\HPCC Systems\eclide\akoenen\dataland\InstantID_Archiving_Services\Layouts\2013-12-20T16_49_19Z.ecl
*/
/*2013-12-16T18:35:45Z (akoenen)
C:\Users\koenenax\AppData\Roaming\HPCC Systems\eclide\akoenen\dataland\InstantID_Archiving_Services\Layouts\2013-12-16T18_35_45Z.ecl
*/
import iesp, Standard;
EXPORT Layouts := MODULE
		EXPORT layout_in := RECORD
			STRING30	firstname := '';
			STRING30 	lastname := '';
			STRING45  Addr := '';
			STRING10	prim_range := '';
			STRING28  prim_name := '';
			STRING15	suffix := '';
			STRING25  city := '';
			STRING2   state := '';
			STRING5   zip := '';
			STRING9   postalCode := '';
			STRING8		dob := '';
			STRING9 	ssn := '';
			STRING20  NationalId := '';
			STRING16 	queryid  := '';
			STRING32 	uniqueid := '';
			STRING25  TransactionId := '';
			STRING20	companyid := '';
		END;
		
		EXPORT IIDI2_echo_layout := RECORD
			// STRING32 uniqueid := '';
			STRING32 queryid := '';
			STRING25 transactionid := '';
			STRING32 date_added := '';
			Unicode first_name := '';
			Unicode middle_name := '';
			Unicode last_name := '';
			Unicode full_name := '';
			Unicode maiden_name := '';
			STRING1  gender := '';
			Unicode street_address1 := '';
			Unicode street_address2 := '';
			STRING10 unit_number := '';
			Unicode building_number := '';
			Unicode building_name := '';
			STRING10 floor_number := '';
			Unicode street_number := '';
			Unicode street_name := '';
			Unicode street_type := '';
			Unicode suburb := '';
			Unicode city := '';
			Unicode county := '';
			Unicode district := '';
			Unicode state := '';
			STRING9  postal_code := '';
			STRING2  country := '';
			STRING10 telephone := '';
			STRING10 mobile_phone := '';
			STRING10 work_phone := '';
			STRING10 dob := '';
			STRING32 national_id := '';
			Unicode national_id_city_issued := '';
			Unicode national_id_district_issued := '';
			Unicode national_id_county_issued := '';
			Unicode national_id_province_issued := '';
			STRING32 dl_number := '';
			STRING32 dl_state := '';
			STRING32 dl_expire_date := '';
			STRING32 dl_version_number := '';
			STRING32 passport_number := '';
			STRING32 passport_expire_date := '';
			Unicode passport_place_birth := '';
			Unicode passport_country_birth := '';
			Unicode passport_family_name_birth := '';
		END;
		
		EXPORT layout_dobmask := RECORD
			layout_in;
			unsigned4 dob_unmasked;
			Standard.Date.Datestr dob_masked;
		END;
		EXPORT delta_value := RECORD
			STRING100 Value {xpath('Value')};
		END;
		EXPORT delta_parameter := RECORD
			DATASET(delta_value) Parameter {xpath('Parameter')}; 
		END;
		EXPORT delta_input := RECORD
			STRING select {xpath('Select')};
			DATASET(delta_parameter) Parameters {xpath('Parameters')};
			Boolean _Blind {xpath('_Blind')};
		END;
		
		EXPORT uni_delta_value := RECORD
			Unicode Value {xpath('Value')};
		END;
		EXPORT uni_delta_parameter := RECORD
			DATASET(uni_delta_value) Parameter {xpath('Parameter')}; 
		END;
		EXPORT uni_delta_input := RECORD
			STRING select {xpath('Select')};
			DATASET(uni_delta_parameter) Parameters {xpath('Parameters')};
			Boolean _Blind {xpath('_Blind')};
		END;
		
		EXPORT Elements := RECORD
			STRING100 value := '';
			STRING150 description := '';
		END;	
		EXPORT ElementsWithOrder := RECORD
			Elements;
			INTEGER order := 0;
		END;
		EXPORT ElementsWithRF_id := RECORD
			Elements;
			STRING2 RF_id := '';
		END;
		
//-------------------Search layouts-------------------------------------//	
		EXPORT delta_single_out := RECORD
			STRING30 last_name {xpath('last_name')};
			STRING30 first_name {xpath('first_name')};
			STRING45 street {xpath('street')};
			STRING45 street_number {xpath('street_number')};
			STRING15 street_type {xpath('street_type')};
			STRING28 street_name {xpath('street_name')};
			STRING45 city {xpath('city')};
			STRING17 state {xpath('state')};
			STRING9 postalcode {xpath('postalcode')};
			STRING5 zip {xpath('zip')};		
			STRING32 uniqueid {xpath('uniqueid')};
			STRING32 queryid {xpath('queryid')};
			STRING25 transactionid {xpath('transaction_id')};
			STRING32 date_added {xpath('date_added')};
		END;
		
		EXPORT delta_iidi_single_out := RECORD
			STRING30 first_name {xpath('first_name')};
			STRING30 middle_name {xpath('middle_name')};
			STRING30 last_name {xpath('last_name')};
			STRING45 full_name {xpath('full_name')};
			STRING30 maiden_name {xpath('maiden_name')};
			STRING1  gender {xpath('gender')};
			STRING45 street_address1 {xpath('street_address1')};
			STRING45 street_address2 {xpath('street_address2')};
			STRING10 unit_number {xpath('unit_number')};
			STRING10 building_number {xpath('building_number')};
			STRING45 building_name {xpath('building_name')};
			STRING10 floor_number {xpath('floor_number')};
			STRING10 street_number {xpath('street_number')};
			STRING30 street_name {xpath('street_name')};
			STRING15 street_type {xpath('street_type')};
			STRING45 suburb {xpath('suburb')};
			STRING45 city {xpath('city')};
			STRING45 county {xpath('county')};
			STRING45 district {xpath('district')};
			STRING17 state {xpath('state')};
			STRING9  postal_code {xpath('postal_code')};
			STRING2  country {xpath('country')};
			STRING10 telephone {xpath('phone')};
			STRING10 mobile_phone {xpath('mobile_phone')};
			STRING10 work_phone {xpath('work_phone')};
			STRING10 dob {xpath('dob')};
			STRING32 national_id {xpath('national_id')};
			STRING32 national_id_city_issued {xpath('national_id_city_issued')};
			STRING32 national_id_district_issued {xpath('national_id_district_issued')};
			STRING32 national_id_county_issued {xpath('national_id_county_issued')};
			STRING32 national_id_province_issued {xpath('national_id_province_issued')};
			STRING32 dl_number {xpath('dl_number')};
			STRING32 dl_state {xpath('dl_state')};
			STRING32 dl_expire_date {xpath('dl_expire_date')};
			STRING32 dl_version_number {xpath('dl_version_number')};
			STRING32 passport_number {xpath('passport_number')};
			STRING32 passport_expire_date {xpath('passport_expire_date')};
			STRING32 passport_place_birth {xpath('passport_place_birth')};
			STRING32 passport_country_birth {xpath('passport_country_birth')};
			STRING32 passport_family_name_birth {xpath('passport_family_name_birth')};
			// STRING32 uniqueid {xpath('uniqueid')};
			STRING32 queryid {xpath('queryid')};
			STRING25 transactionid {xpath('transaction_id')};
			STRING32 date_added {xpath('date_added')};
		END;
		
		EXPORT Single_DeNormed_Records := RECORD
			delta_single_out;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions
		END;
		
		EXPORT Single_IIDI2_DeNormed_Records := RECORD
			delta_iidi_single_out;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions
			END;
		
		EXPORT single_DB_Response := RECORD		
			DATASET(delta_single_out) Response {xpath('Records/Rec')};		
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};		
		END;
		
		EXPORT single_IIDI2_DB_Response := RECORD		
			DATASET(delta_iidi_single_out) Response {xpath('Records/Rec')};		
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};		
		END;
		
		EXPORT denorm_searchNameAddr := RECORD
			RECORDOF(iesp.iidarchivesearch.t_InstantIDArchiveSearchRecord);
		END;
		
		EXPORT denorm_IIDI2searchNameAddr := RECORD
			RECORDOF(iesp.iidi2archivesearch.t_InstantIDIntl2ArchiveSearchRecord);
		END;
		
		EXPORT IIDI2SQLlayout := record
			String SQLWhereCriteria;
			Dataset(uni_delta_parameter) SQLValues;
		end;
//-------------------Report layouts-------------------------------------//
		EXPORT delta_single_report_out := RECORD, MAXLENGTH(200000)
			STRING25 transactionid {xpath('transactionid')};
			STRING32 date_added {xpath('date_added')};
			STRING20 companyid {xpath('companyid')};
			INTEGER8 companyidsource {xpath('companyidsource')};
			STRING10 espversion {xpath('espversion')}; 
			STRING5 source {xpath('source')}; //values['BATCH','ESP','']
			STRING requestdata {xpath('requestdata'),maxlength(35000)};
			STRING responsedata {xpath('responsedata'),maxlength(161000)};
			STRING45 queryid {xpath('queryid')};
		END;		
		EXPORT delta_single_report_blob := RECORD
			STRING25 transactionid {xpath('transactionid')};
			STRING32 date_added {xpath('date_added')};
			STRING20 companyid {xpath('companyid')};
			INTEGER8 companyidsource {xpath('companyidsource')};
			STRING10 espversion {xpath('espversion')}; 
			STRING5 source {xpath('source')}; //values['BATCH','ESP','']
			STRING requestdata { BLOB, MAXLENGTH(35000) };// {xpath('requestdata'),maxlength(20000)};//{ BLOB, MAXLENGTH(2000000) };
			STRING responsedata { BLOB, MAXLENGTH(161000) };//{xpath('responsedata'),maxlength(66000)};
			STRING45 queryid {xpath('queryid')};
		END;			
	
		EXPORT Report_DeNormed_Records := RECORD, MAXLENGTH(200000)
			delta_single_report_out;
			DATASET(iesp.share.t_ResponseHeader) Exceptions ;
		END;
		EXPORT Report_DB_Response	:=	RECORD, MAXLENGTH(200000)
			DATASET(delta_single_report_out)	Response {xpath('Records/Rec')};		
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};	
		END;
		EXPORT denorm_inputandblobs := RECORD, MAXLENGTH(200000)
			RECORDOF(iesp.iidsinglereport.t_InstantIDArchiveSingleReportRecord);
			INTEGER RecordCount := 0;
			DATASET(iesp.share.t_ResponseHeader) Header;		
			string queryid := '' ;
		END;	
		
		EXPORT denorm_IIDI2_inputandblobs := RECORD, MAXLENGTH(200000)
			RECORDOF(iesp.iidi2singlereport.t_InstantIDIntl2ArchiveSingleReportRecord);
			INTEGER RecordCount := 0;
			DATASET(iesp.share.t_ResponseHeader) Header;		
			string queryid := '' ;
		END;
		
//-------------------IID Summary layouts-------------------------------------//		
		EXPORT IID := RECORD
			string16 transaction_id {xpath('transaction_id')};
			STRING3 cvi {xpath('cvi')};
			STRING3 nas {xpath('nas')};
			STRING3 nap {xpath('nap')};
			STRING3	risk_code {xpath('risk_code')};
			string1 dob_verified {xpath('dob_verified')};
			STRING150 description {xpath('description')};
		END;		
		EXPORT IID_Records := RECORD//, MAXLENGTH(10000)
			IID;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;		
		EXPORT IID_Response := RECORD
			DATASET(IID) Response {xpath('Records/Rec'), MAXCOUNT(5)};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};	
		END;			
//-------------------FraudPt Summary layouts-------------------------------------//		
		EXPORT Fraud_Pt := RECORD
			STRING25 transaction_id {xpath('transaction_id')};
			STRING3 cvi {xpath('cvi')};
			STRING3 risk_code {xpath('risk_code')};
			STRING3 score {xpath('score')};
			STRING30 Name {xpath('name')};
			STRING30 Score_Type {xpath('Score_Type')};
			STRING150 description {xpath('description')};
		END;
		EXPORT FraudPt_Records := RECORD//, MAXLENGTH(10000)
			Fraud_Pt;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
			STRING30 score_id := '';
		END;		
		EXPORT FraudPt_Response := RECORD
			DATASET(Fraud_Pt) Response {xpath('Records/Rec')};
			INTEGER RecordCount {xpath('RecsReturned')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};	
		END;	
		EXPORT FraudPt_slim := RECORD
			STRING3 risk_code := '';
			STRING3 score;
			INTEGER cnt := 0;
			INTEGER type;
			STRING150 description :='';
			STRING25 transaction_id := '';
			STRING30 Score_Type := '';
		END;
		EXPORT ScoreInfo := RECORD
			STRING10 score := '';
			INTEGER type := 0;
			INTEGER score_cnt := 0;
			INTEGER score_total := 0;
			DECIMAL5_2 Percent := 0;
			STRING3 Risk_Code := '';
			INTEGER Order := 0;
			STRING150 description :='';
		END;
	EXPORT IdxInfo := RECORD
		STRING30 Idx := '';
		INTEGER idx_cnt := 0;
		INTEGER idx_total := 0;
		string32 name := '';
	END;
	EXPORT risk_name_cnts :=	RECORD
		STRING30 Name := '';
		STRING32 Idx := '';
		INTEGER CNT := 0;
		DECIMAL5_2 PERCENT := 0;
	END;
	EXPORT idx_rec := RECORD
		iesp.iidfraudpointsummary.t_FraudRiskIndexSummary;
		STRING3 idx := '';
	END;
	//-------------------IIDI Summary layouts-------------------------------------//
		EXPORT IIDI_RiskInd := RECORD
			string25 transaction_id {xpath('transaction_id')};
			STRING3 ivi {xpath('ivi')};
			STRING3 risk_code {xpath('risk_code')};	
			STRING150 description {xpath('description')};	
		END;
		EXPORT IIDI_RiskInd_Records := RECORD//, MAXLENGTH(10000)
			IIDI_RiskInd;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;		
		EXPORT IIDI_RiskInd_Response := RECORD
			DATASET(IIDI_RiskInd) Response {xpath('Records/Rec')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};	
		END;	
		EXPORT iviInfo := RECORD
			STRING3 ivi := '';
			INTEGER ivi_cnt := 0;
			INTEGER ivi_total := 0;
			INTEGER order := 0;
		END;
		EXPORT IIwithReportElementX := RECORD
			STRING3 ivi := '';
			RECORDOF(iesp.iidsummary_share.t_ReportElement);
			INTEGER CNT := 0;
			INTEGER ORDER := 0;	
			STRING150 description := '';
		END;
		EXPORT IIDI_Verified := RECORD
			string25 transaction_id {xpath('transaction_id')};
			STRING30 name {xpath('name')};
			STRING3 source_count {xpath('source_Count')};	
		END;
		EXPORT IIDI_Verified_Records := RECORD//, MAXLENGTH(10000)
			IIDI_Verified;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;		
		EXPORT IIDI_Verified_Response := RECORD
			DATASET(IIDI_Verified) Response {xpath('Records/Rec')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};
		END;		
		EXPORT rec_verified_info := RECORD
			STRING25 transaction_id := '';
			STRING32 name := '';
			STRING3 source_count := '0';
			INTEGER cnt:=0;
			INTEGER tot := 0;
		END;
		EXPORT rec_src_cnts := RECORD
			STRING FieldVerification := '';
			iesp.iidsummary_share.t_ReportElementEx;
		END;	
//-------------------cvi layouts-------------------------------------//
	EXPORT cvi_element := RECORD
		string100 value := '';
		string150 description := '';
	END;
	EXPORT CVIwithReportElement := RECORD
		STRING3 cvi := '';
		RECORDOF(iesp.iidsummary_share.t_ReportElement);
		INTEGER CNT := 0;
		INTEGER Order := 0;
	END;

	EXPORT CVIwithReportElementX := RECORD
		STRING3 cvi := '';
		DATASET (iesp.iidsummary_share.t_ReportElementEx) RI;
	END;
	EXPORT CVIwithReportElementXWithSeq := RECORD
		CVIwithReportElement;
		STRING150 description := '';
	END;
//-------------------Flex ID Summary layouts-------------------------------------//	
	//-------------------CVI Summary layouts-------------------------------------//	
	EXPORT cviInfo := RECORD
		STRING3 cvi := '';
		integer cvi_cnt := 0;
		integer cvi_total := 0;
		integer order := 0;
	END;
	
	EXPORT FlexId_cvi := RECORD
			string25 transaction_id {xpath('transaction_id')};
			STRING3 cvi {xpath('cvi')};
			STRING3 nas {xpath('nas')};
			STRING3 nap {xpath('nap')};
			STRING3 risk_code {xpath('risk_code')};
			STRING1 first_name_verified {xpath('first_name_verified')};			
			STRING1 last_name_verified {xpath('last_name_verified')};
			STRING1 state_verified {xpath('state_verified')};
			STRING1 ssn_verified {xpath('ssn_verified')};
			STRING1 zip_verified {xpath('zip_verified')};
			STRING1 street_address_verified {xpath('street_address_verified')};
			STRING1 city_verified {xpath('city_verified')};
			STRING1 dob_verified {xpath('dob_verified')};
			STRING1 home_phone_verified  {xpath('home_phone_verified')};
			STRING1 dl_verified {xpath('dl_verified')};
			STRING150 description {xpath('description')};
		END;
		EXPORT FlexID_Response := RECORD
			DATASET(FlexId_cvi) Response {xpath('Records/Rec')};
			INTEGER RecordCount {xpath('RecsReturned')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};
		END;
		EXPORT FlexID_cvi_Records := RECORD//, MAXLENGTH(10000)
			FlexId_cvi;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;		
		EXPORT layout_cvi_element := RECORD
			STRING100 value := '';
			STRING150 description := '';
			INTEGER cnt := 0;
			decimal5_2 percent := 0;
		END;
		EXPORT ds_verified := RECORD
			STRING3 cvi := '';	
			DATASET(layout_cvi_element) Verified_Elements;
		END;
		EXPORT ds_verified_no := RECORD
			STRING3 cvi := '';	
			DATASET(iesp.flexidsummary.t_FlexIDSummaryVerifiedElementSummary) VerifiedElements;
		END;		
		EXPORT CVIwithVerifiedFields	:= RECORD
			string3 cvi := '';
			integer first_name_verified_cnt := 0;
			integer last_name_verified_cnt;
			integer state_verified_cnt ;
			integer ssn_verified_cnt ;
			integer zip_verified_cnt ;
			integer street_address_verified_cnt;
			integer city_verified_cnt ;
			integer dob_verified_cnt ;
			integer home_phone_verified_cnt;
			integer dl_verified_cnt ;			
			decimal5_2 Percent := 0;
		END;	
	 EXPORT	rec_verify_summ := RECORD
			STRING3 cvi := '';
			iesp.flexidsummary.t_FlexIDSummaryVerifiedElementSummary ;
			integer cnt := 0;
		end;
  //------------------- RedFlags layouts -------------------------------------//	
		EXPORT redflags_slim := RECORD
			STRING25 transaction_id {xpath('transaction_id')}; // e.g. '14745287R1' 
			STRING3 cvi {xpath('cvi')};                       // e.g. '10'
			STRING3 risk_code {xpath('risk_code')};           // e.g. '79' 
		END;
		EXPORT RedFlags_Records := RECORD//, MAXLENGTH(10000)
			redflags_slim;	
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;	
		EXPORT Redflags_Response	:=	RECORD//, MAXLENGTH(10000)
			DATASET(redflags_slim) Response {xpath('Records/Rec')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};
		END;
		EXPORT RI_elements := RECORD
			STRING3 cvi := '';		
			layout_cvi_element;	
		END;
		EXPORT redflags_flat := RECORD
			RI_elements;
			STRING2 redflag_id := '';
			STRING100 redflag_desc := '';
		END;
		EXPORT cvi_riskcode_counts := RECORD
			STRING3 cvi;
			STRING3 risk_code;
			UNSIGNED cnt;
		END;		
		EXPORT t_RedFlagsElement_plus_cvi_redflags := RECORD
			STRING3 cvi := '';
			STRING2 redflag_id := '';
			iesp.iidredflagsummary.t_RedFlagsElement;
		END;		
  //------------------- NAS/NAP layouts -------------------------------------//	
		
		EXPORT nasnap_slim := RECORD
			STRING25 transaction_id {xpath('transaction_id')}; // e.g. '14745287R1' 
			STRING3 nas {xpath('nas')};                       // e.g. '2'
			STRING3 nap {xpath('nap')};                       // e.g. '9' 
		END;
		EXPORT NASNAP_Records := RECORD
			nasnap_slim;
			DATASET(iesp.share.t_ResponseHeader) Exceptions;
		END;
		EXPORT NASNAP_Response	:=	RECORD//, MAXLENGTH(1000000)
			DATASET(nasnap_slim) Response {xpath('Records/Rec')};
			STRING200 ExceptionMessage {xpath('Exceptions/Exception/Message')};
		END;
	
		EXPORT rec_NASNAPSummary_flat := RECORD
			STRING3 NameAddressSSN;
			INTEGER NumberOfCases;
			DECIMAL5_2 NASPercent;
			STRING Value {xpath('Value')};
			DECIMAL5_2 NAPPercent;
			INTEGER order ;
		END;	
	
END;