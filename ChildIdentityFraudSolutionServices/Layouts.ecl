import Autokey_batch,AddrBest,BatchServices,BatchShare,VehicleV2_Services,DidVille,CriminalRecords_BatchService,
       LiensV2_Services,HealthCareProvider,SexOffender_Services,paw_services,Foreclosure_Services,
			 WatercraftV2_Services,FaaV2_Services;

export Layouts := module

	// **************************************************************************************
	// <INPUT_OUTPUT_LAYOUTS>
	
	export BatchIn := record		
		BatchShare.Layouts.ShareAcct;	
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress - [addr, county_name];
		BatchShare.Layouts.SharePII;
		string1 Identity_Type_Indicator;
	end;
	
	export BatchOut := record
		BatchShare.Layouts.ShareAcct;
		/* Domain specific fields should be added below */ 
		//**The below fields are from the Header Search.		
		string1  Misrepresented_SSN;
		string1  Compromised_SSN;
		string1  Highly_Compromised_SSN;
		string1  Newly_Compromised_SSN;
		string1  Input_Identities_With_Risky_Associates;
		typeof(BatchShare.Layouts.ShareDid.Did) Header_DID;
		//**The below fields are from the ADL_Best service.
		//lex_id_2 / BestDID 
		typeof(DidVille.Layout_Did_OutBatch.Did) Best_Did;
		//ssn / ImposterSSN
		typeof(DidVille.Layout_Did_OutBatch.best_ssn) Imposter_SSN;
		//lex_id_3 / ImposterDID
		typeof(DidVille.Layout_Did_OutBatch.Did) Imposter_Did;
		//best_ssn / BestSSN
		typeof(DidVille.Layout_Did_OutBatch.best_ssn) Best_SSN;
		//best_fname
		typeof(DidVille.Layout_Did_OutBatch.best_fname) Best_Fname; 
		//best_lname
		typeof(DidVille.Layout_Did_OutBatch.best_lname) Best_Lname;

		//** The below fields are from the Best Address service.			
		//best_addr1
		
		string120 Best_Addr1;
		//best_city
		typeof(AddrBest.Layout_BestAddr.Batch.p_city_name) Best_City;
		//best_state
		typeof(AddrBest.Layout_BestAddr.Batch.st) Best_State;
		//best_zip
		typeof(AddrBest.Layout_BestAddr.Batch.z5) Best_Zip;
		//date_last_seen
		typeof(AddrBest.Layout_BestAddr.Batch.addr_dt_last_seen) Best_Date_Last_Seen;
		//latitude
		typeof(AddrBest.Layout_BestAddr.batch_out_final.latitude) Latitude;
		//longitude
		typeof(AddrBest.Layout_BestAddr.batch_out_final.longitude) Longitude;
		//statecode+county_fips
		string5 Geocode;
		

		//** The below fields are from the Deceased check.			
		//deceased_indicator
		 string1 Deceased_Indicator;
		//dod
		typeof(BatchServices.layout_Death_Batch_out.dod8) DOD;
		//lname
		typeof(BatchServices.layout_Death_Batch_out.lname) Deceased_Lname;
		//fname
		typeof(BatchServices.layout_Death_Batch_out.fname) Deceased_Fname;
		//deceased_matchcode
		typeof(BatchServices.layout_Death_Batch_out.matchcode) Deceased_Matchcode;

		//** The below fields are from Consumer InstantID.
		//hri_1_code
		string4 Hri_1_Code;
		//hri_2_code
		string4 Hri_2_Code;
		//ITIN Fraud Filer
		string1 ITIN_FraudFiler;

		//** The below fields are from the Criminal - Department of Corrections check.			
		//doc_lname
		typeof(CriminalRecords_BatchService.Layouts.offender.lname) doc_lname; 
		//doc_fname
		typeof(CriminalRecords_BatchService.Layouts.offender.fname) doc_fname;
		//doc_dob
		typeof(CriminalRecords_BatchService.Layouts.offender.dob) doc_dob; 
		//doc_ssn
		typeof(CriminalRecords_BatchService.Layouts.offender.ssn) doc_ssn; 
		//doc_num
		typeof(CriminalRecords_BatchService.Layouts.offender.doc_num) doc_num; 
		//doc_state_origin
		typeof(CriminalRecords_BatchService.Layouts.batch_pii_out.INCR_state_origin) doc_state_origin; 

		//** The below fields are from the Relatives & Associates check.			
		//rel first name 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_first_name_1 ) rel_first_name_1; 
		//rel last name 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_last_name_1 ) rel_last_name_1; 
		//rel address 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_address_1 ) rel_address_1;
		//rel city 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_city_1 ) rel_city_1;
		//rel state 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_state_1 ) rel_state_1;
		//rel zipcode 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_zipcode_1 ) rel_zipcode_1;
		//rel dob 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_dob_1 ) rel_dob_1;
		//rel first name 2
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_first_name_2 ) rel_first_name_2;
		//rel last name 2
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_last_name_2 ) rel_last_name_2;
		//rel lexid 2
		typeof(DidVille.Layout_Did_OutBatch.Did) rel_DID_2;
		//rel first name 3
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_first_name_3 ) rel_first_name_3;
		//rel last name 3
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_last_name_3 ) rel_last_name_3;
		//rel lexid 3
		typeof(DidVille.Layout_Did_OutBatch.Did) rel_DID_3;
		//asso first name 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_first_name_1 ) asso_first_name_1;
		//asso last name 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_last_name_1 ) asso_last_name_1;
		//asso address 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_address_1 ) asso_address_1;
		//asso city 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_city_1 ) asso_city_1;
		//asso state 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_state_1 ) asso_state_1;
		//asso zipcode 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_zipcode_1 ) asso_zipcode_1;
		//asso dob 1
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_dob_1 ) asso_dob_1;
		//asso first name 2
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_first_name_2 ) asso_first_name_2;
		//asso last name 2
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_last_name_2 ) asso_last_name_2;
		//asso lexid 2
		typeof(DidVille.Layout_Did_OutBatch.Did) asso_DID_2;
		//asso first name 3
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_first_name_3 ) asso_first_name_3;
		//asso last name 3
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_last_name_3 ) asso_last_name_3;
		//asso lexid 3
		typeof(DidVille.Layout_Did_OutBatch.Did) asso_DID_3;

		//** The below fields are from the Bankruptcy check.			
		//BK_count
		unsigned3 BKcount;
		//debtor did 
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_DID) debtor_DID;
		//debtor 1 lname
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_1_lname) debtor_1_lname;
		//debtor 1 fname
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_1_fname) debtor_1_fname;
		//debtor prim range
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_prim_range) debtor_prim_range;
		//debtor prim name
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_prim_name) debtor_prim_name;
		//debtor p city name
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_p_city_name) debtor_p_city_name;
		//debtor st
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_st) debtor_st;
		//debtor zip
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.debtor_zip) debtor_zip;
		//case number
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.case_number) bk_case_number;
		//court location
		typeof(BatchServices.layout_BankruptcyV3_Batch_out.court_location) court_location;

		//** The below fields are from the Lien/Judgment check.			
		//LJ count
		unsigned3 LJ_count;
		//debtor 1 party 1 did
		typeof(LiensV2_Services.Batch_Layouts.batch_out.debtor_1_party_1_did) debtor_1_party_1_did;
		//debtor 1 party 1 lname
		typeof(LiensV2_Services.Batch_Layouts.batch_out.debtor_1_party_1_lname) debtor_1_party_1_lname;
		//debtor 1 party 1 fname
		typeof(LiensV2_Services.Batch_Layouts.batch_out.debtor_1_party_1_fname) debtor_1_party_1_fname;
		//creditor orig name
		typeof(LiensV2_Services.Batch_Layouts.batch_out.creditor_orig_name) creditor_orig_name;
		//case number
		typeof(LiensV2_Services.Batch_Layouts.batch_out.case_number) LJ_case_number;
		//orig filing date
		typeof(LiensV2_Services.Batch_Layouts.batch_out.orig_filing_date) orig_filing_date;
		//release date
		typeof(LiensV2_Services.Batch_Layouts.batch_out.release_date) release_date;

		//** The below fields are from the Property check.			
		//Prop_count
		unsigned3 Prop_count;
		// buyer 1 did
		typeof(BatchServices.layout_Property_Batch_out.buyer_1_did) buyer_1_did;
		// buyer 1 orig name
		typeof(BatchServices.layout_Property_Batch_out.buyer_1_orig_name) buyer_1_orig_name;
		// buyer 2 orig name
		typeof(BatchServices.layout_Property_Batch_out.buyer_2_orig_name) buyer_2_orig_name;
		// property address1
		typeof(BatchServices.layout_Property_Batch_out.property_address1) property_address1;
		// property p city name
		typeof(BatchServices.layout_Property_Batch_out.property_p_city_name) property_p_city_name;
		// property st
		typeof(BatchServices.layout_Property_Batch_out.property_st) property_st;
		// property zip
		typeof(BatchServices.layout_Property_Batch_out.property_zip) property_zip;
		// assess county name
		typeof(BatchServices.layout_Property_Batch_out.assess_county_name) assess_county_name;
		// assess apna or pin number
		typeof(BatchServices.layout_Property_Batch_out.assess_apna_or_pin_number) assess_apna_or_pin_number;
		// deed property address desc
		typeof(BatchServices.layout_Property_Batch_out.deed_property_address_desc) deed_property_address_desc;
		// owner 1 orig name
		typeof(BatchServices.layout_Property_Batch_out.owner_1_orig_name) owner_1_orig_name;
		// owner 2 orig name
		typeof(BatchServices.layout_Property_Batch_out.owner_2_orig_name) owner_2_orig_name;
		// seller 1 orig name
		typeof(BatchServices.layout_Property_Batch_out.seller_1_orig_name) seller_1_orig_name;
		// deed apnt or pin number
		typeof(BatchServices.layout_Property_Batch_out.deed_apnt_or_pin_number ) deed_apnt_or_pin_number;
		// property county name
		typeof(BatchServices.layout_Property_Batch_out.property_county_name ) property_county_name ; 
		// deed recording date
		typeof(BatchServices.layout_Property_Batch_out.deed_recording_date) deed_recording_date;

		//** The below fields are from the Sexual Offender check.			
		// SOF_count
		unsigned3 SOF_count;
		// Unique Id
		//typeof(BatchShare.Layouts.ShareDid.Did) SOF_DID;
		// name_first
		typeof(SexOffender_Services.Layouts.batch_out.first_name) SOF_name_first;
		// name_last
		typeof(SexOffender_Services.Layouts.batch_out.last_name) SOF_name_last;
		// Street_Address1
		string125 SOF_Street_Address1;
		// City
		typeof(SexOffender_Services.Layouts.batch_out.p_city_name) SOF_City;
		// State
		typeof(SexOffender_Services.Layouts.batch_out.st) SOF_State;
		// Zip5
		typeof(SexOffender_Services.Layouts.batch_out.zip5) SOF_Zip5;
		// date last seen
		typeof(SexOffender_Services.Layouts.batch_out.date_last_seen) SOF_date_last_seen;
		// dob
		typeof(SexOffender_Services.Layouts.batch_out.dob) SOF_dob;

		//** The below fields are from the People at Work check.			
		// PAWK_count
		unsigned3 PAWK_count;
		// pawk 1 did
		typeof(paw_services.Layouts.Batch_out.pawk_1_did ) pawk_1_did;
		// pawk 1 first
		typeof(paw_services.Layouts.Batch_out.pawk_1_first )pawk_1_first;
		// pawk 1 last
		typeof(paw_services.Layouts.Batch_out.pawk_1_last ) pawk_1_last;
		// pawk 1 company name
		typeof(paw_services.Layouts.Batch_out.pawk_1_company_name )pawk_1_company_name;
		// pawk 1 address
		typeof(paw_services.Layouts.Batch_out.pawk_1_address ) pawk_1_address;
		// pawk 1 city
		typeof(paw_services.Layouts.Batch_out.pawk_1_city )pawk_1_city;
		// pawk 1 state
		typeof(paw_services.Layouts.Batch_out.pawk_1_state )pawk_1_state;
		// pawk 1 zip5
		typeof(paw_services.Layouts.Batch_out.pawk_1_zip5) pawk_1_zip5;
		// FEIN
		typeof(paw_services.Layouts.Batch_out.pawk_1_fein) pawk_1_fein;
		//PAWK_Phone
		typeof(paw_services.Layouts.Batch_out.pawk_1_phone10) pawk_1_phone;

		//** The below fields are from the Foreclosure check.			
		// FC_count
		unsigned3 FC_count;
		// fc unique id
		//typeof(BatchShare.Layouts.ShareDid.Did) fc_did;
		// plntff1 name
		typeof(Foreclosure_Services.Layouts.Final_Batch.plntff1_name) plntff1_name;
		// plntff2 name
		typeof(Foreclosure_Services.Layouts.Final_Batch.plntff2_name) plntff2_name;
		// ownr 1 first name
		typeof(Foreclosure_Services.Layouts.Final_Batch.ownr_1_first_name) ownr_1_first_name;
		// ownr 1 last name
		typeof(Foreclosure_Services.Layouts.Final_Batch.ownr_1_last_name) ownr_1_last_name;
		// ownr 2 first name
		typeof(Foreclosure_Services.Layouts.Final_Batch.ownr_2_first_name) ownr_2_first_name;
		// ownr 2 last name
		typeof(Foreclosure_Services.Layouts.Final_Batch.ownr_2_last_name) ownr_2_last_name;
		// p city name
		typeof(Foreclosure_Services.Layouts.Final_Batch.p_city_name) fc_p_city_name;
		// st
		typeof(Foreclosure_Services.Layouts.Final_Batch.st) fc_st;
		// zip
		typeof(Foreclosure_Services.Layouts.Final_Batch.zip) fc_zip;
		// deed recording date
		STRING8  fc_deed_recording_date;

		// ** The below fields are from the Motor Vehicle check.			
		// MV_count
		unsigned3 MV_count;
		// reg license plate
		typeof(VehicleV2_Services.Batch_Layout.final_layout.reg_license_plate) reg_license_plate;
		// vin
		typeof(VehicleV2_Services.Batch_Layout.final_layout.vin) vin_out; 
		// own 1 did
		typeof(VehicleV2_Services.Batch_Layout.final_layout.own_1_did) own_1_did;
		// reg 1 did
		typeof(VehicleV2_Services.Batch_Layout.final_layout.reg_1_did) reg_1_did;
		// reg latest effective date
		typeof(VehicleV2_Services.Batch_Layout.final_layout.reg_latest_effective_date) reg_latest_effective_date; 

		// ** The below fields are from the Professional License check.			
		// PL_count
		unsigned3 PL_count; 
		// did
		typeof(BatchShare.Layouts.ShareDid.Did) PL_did;
		// orig name
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_name) orig_name;
		// orig addr 1
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_addr_1) orig_addr_1;
		// orig city
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_city ) orig_city;
		// orig st
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_st ) orig_st;
		// orig zip
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_zip) orig_zip;
		// source st
		typeof(HealthCareProvider.Layouts.PROF_LIC.source_st ) source_st;
		// orig license number
		typeof(HealthCareProvider.Layouts.PROF_LIC.orig_license_number) orig_license_number;
		// license type
		typeof(HealthCareProvider.Layouts.PROF_LIC.license_type) license_type;
		// issue date
		typeof(HealthCareProvider.Layouts.PROF_LIC.issue_date) issue_date;

		// ** The below fields are from the Watercraft check.			
		// WC_count
		unsigned3 WC_count;
		// did 1
		typeof(BatchShare.Layouts.ShareDid.Did) wc_did_1;
		// fname 1
		typeof(WatercraftV2_Services.Layouts.batch_out.fname_1) fname_1;
		// lname 1
		typeof(WatercraftV2_Services.Layouts.batch_out.lname_1) lname_1;
		// hull number
		typeof(WatercraftV2_Services.Layouts.batch_out.hull_number) hull_number;
		// registration date
		typeof(WatercraftV2_Services.Layouts.batch_out.registration_date) registration_date;

		// ** The below fields are from the Aircraft check.	
		// AC_count
		unsigned3 AC_count;
		// did out
		typeof(BatchShare.Layouts.ShareDid.Did) did_out;
		// name
		typeof(FaaV2_Services.Layouts.batch_out.name) name;
		// serial number 1
		typeof(FaaV2_Services.Layouts.batch_out.serial_number_1) serial_number;
		// last action date 1
		typeof(FaaV2_Services.Layouts.batch_out.last_action_date_1) last_action_date;

		// ** The below fields are from the Business check.
		// Biz_count
		unsigned3 Biz_count;
		// bdid
		typeof(BatchServices.layout_Business_Batch_out.bdid) bdid_out;
		// ContactID 
		//string Biz_ContactID;
		// company name
		typeof(BatchServices.layout_Business_Batch_out.company_name) company_name;
		// street
		typeof(BatchServices.layout_Business_Batch_out.street) biz_street;
		// city
		typeof(BatchServices.layout_Business_Batch_out.city) biz_city;
		// state
		typeof(BatchServices.layout_Business_Batch_out.state) biz_state;
		// zip
		typeof(BatchServices.layout_Business_Batch_out.zip) biz_zip;
					
		integer	error_code;

end;
	
	// </INPUT_OUTPUT_LAYOUTS>
	// **************************************************************************************

  EXPORT rec_instantid := RECORD
		BatchShare.Layouts.ShareAcct;
		STRING50  identity_verification_nas; // 4.1.7... / Step 1 (Instant ID)
		STRING4  hri_1_indicator;
		STRING100 hri_1_description;
		STRING4  hri_2_indicator;
		STRING100 hri_2_description;
		STRING4  hri_3_indicator;
		STRING100 hri_3_description;
		STRING4  hri_4_indicator;
		STRING100 hri_4_description;
		STRING4  hri_5_indicator;
		STRING100 hri_5_description;
		STRING4  hri_6_indicator;
		STRING100 hri_6_description;
		STRING8  verified_dob;	
	END;	

	EXPORT RelRecord := record 
    unsigned1 idx;
    boolean		val;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_first_name_1) rel_first_name;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_last_name_1) rel_last_name;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_address_1) rel_address;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_city_1) rel_city;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_state_1) rel_state;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_zipcode_1) rel_zipcode;
    typeof(DidVille.Layout_RAN_BestInfo_BatchOut.rel_dob_1) rel_dob;
	end;


	EXPORT AssoRecord := record 
		unsigned1 idx;
    boolean		val;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_first_name_1 ) asso_first_name;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_last_name_1 ) asso_last_name;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_address_1 ) asso_address;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_city_1 ) asso_city;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_state_1 ) asso_state;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_zipcode_1 ) asso_zipcode;
		typeof(DidVille.Layout_RAN_BestInfo_BatchOut.asso_dob_1 ) asso_dob;
	end;
	
end;