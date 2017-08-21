IMPORT Didville, Doxie_cbrs, VehicleV2_Services;

export Layouts := MODULE

	EXPORT portfolio := MODULE
	
		EXPORT base := RECORD
			UNSIGNED6 pid;
			UNSIGNED6 rid;
			STRING14 timestamp;
			STRING1 action_code;
			UNSIGNED6 did;
			UNSIGNED6 bdid;
			UNSIGNED8 hash_docid;
			types.productMask	product_mask;
			STRING20	name_first;
			STRING20	name_middle;
			STRING20	name_last;
			STRING5		name_suffix;
			STRING120 comp_name;
			STRING10  prim_range;
			STRING2   predir;
			STRING28  prim_name;
			STRING4   addr_suffix;
			STRING2   postdir;
			STRING10  unit_desig;
			STRING8   sec_range;
			STRING25  p_city_name;
			STRING2   st;
			STRING5   z5;
			STRING4   zip4;
			STRING9   fein;
			STRING12	ssn;
			STRING8		dob;
			STRING10  phone;
		END;
  END;

	EXPORT InfoRec := RECORD
		DidVille.Layout_Did_OutBatch.seq;
		STRING1 action_code;
		portfolio.base.pid;
		portfolio.base.rid;
		portfolio.base.hash_docid;
		portfolio.base.product_mask;
	END;

	EXPORT DIDMetaRec := RECORD /* (DidVille.Layout_Did_OutBatch) */
		Doxie_cbrs.layout_references;
		DidVille.Layout_Did_OutBatch;		
		STRING120 comp_name;
		InfoRec - seq;
	END;

  export Temp_Fields := RECORD
	  string30  own_1_corp_key;
		string30  own_2_corp_key;
		string30  reg_1_corp_key;
		string30  reg_2_corp_key;
	END;
	
	EXPORT Layout_Output := RECORD
		// •	Client ID
		// o	Each Corporation Record will be given its own unique identifier since one is not provided on input 
		INTEGER4 Client_ID;
		
		// •	Process_Flag - describes if from with contact or without contact - WC or WOC
		STRING3 Process_Flag;
		// •	Incorp_Reg_Dates_Match (see requirement 4.2.6 and 4.3.6.) - Y/N
		STRING1 Incorp_Reg_Year_Match;
		// •	Bought_Before_LLC_Incorp - Y/N
		STRING1 Bought_Before_LLC_Incorp;
		
		// •	Still_Owns - Y/N
		STRING1 Business_Owned; 
		STRING1 Contact_Owned;

		// •	Charter Number -- Layout_Corporate_Direct_Corp_Base string32  corp_orig_sos_charter_nbr
		string32 Charter_Number;
		
		// •	Corporation Name -- Layout_Corporate_Direct_Corp_Base string350 corp_legal_name
		string350 Corp_Name;
		
		// •	Status -- Layout_Corporate_Direct_Corp_Base string60  corp_status_desc
		string60 Status;
		
		// •	Incorporation State -- Layout_Corporate_Direct_Corp_Base string2	  corp_state_origin
		string2 Incorp_State;
		
		// •	Incorporation Date -- Layout_Corporate_Direct_Corp_Base string8	  corp_inc_date
		//                                                         OR string8	  corp_forgn_date
		string8 Incorp_Date;
		
		// •	Original Organization Structure Description -- Layout_Corporate_Direct_Corp_Base string60  corp_orig_org_structure_desc
		string60 Orig_org_struct_description;
		
		// •	Corporate Address -- Layout_Corporate_Direct_Corp_Base 
		string150 corp_addr;
		/*
			string10  corp_addr1_prim_range;
			string2   corp_addr1_predir;
			string28  corp_addr1_prim_name;
			string4   corp_addr1_addr_suffix;
			string2   corp_addr1_postdir;
			string10  corp_addr1_unit_desig;
			string8   corp_addr1_sec_range;
			string25  corp_addr1_p_city_name;
			string25  corp_addr1_v_city_name;
			string2   corp_addr1_state;
			string5   corp_addr1_zip5;
			string4   corp_addr1_zip4
		*/
		
		// •	Contact Name -- Layout_Corporate_Direct_Corp_Base 
		string75 reg_agent_name; 
		/*
			string5   corp_ra_title1;
			string20  corp_ra_fname1;
			string20  corp_ra_mname1;
			string20  corp_ra_lname1;
			string5   corp_ra_name_suffix1;
		*/
		
		// •	Contact Address -- Layout_Corporate_Direct_Corp_Base
		string150 reg_agent_addr;
		/*
			string10  corp_ra_prim_range;
			string2   corp_ra_predir;
			string28  corp_ra_prim_name;
			string4   corp_ra_addr_suffix;
			string2   corp_ra_postdir;
			string10  corp_ra_unit_desig;
			string8   corp_ra_sec_range;
			string25  corp_ra_p_city_name;
			string25  corp_ra_v_city_name;
			string2   corp_ra_state;
			string5   corp_ra_zip5;
			string4   corp_ra_zip4
		*/

		// •	Contact Name 
		string75 contact_name; 
		
		// •	Contact Address
		string150 contact_addr;

		// •	Owner 1 did
		unsigned6 owner1_did;
		// •	Owner 1 bdid
		unsigned6 owner1_bdid;
		// •	Owner 1 First Name
		string20 owner1_first_name;
		// •	Owner 1 Middle Name
		string20 owner1_middle_name;
		// •	Owner 1 Last Name
		string20 owner1_last_name;
		// •	Owner 1 SSN
		string9 owner1_SSN;
		// •	Owner 1 Company Name
		string70 owner1_company_name;
		// •	Owner 1 Address
		string120 owner1_address;
		// •	Owner 1 City
		string35 owner1_city;
		// •	Owner 1 State
		string2 owner1_state;
		// •	Owner 1 Zip Code
		string10 owner1_zip_code;
		
		// •	Owner 2 did
		unsigned6 owner2_did;
		// •	Owner 2 bdid
		unsigned6 owner2_bdid;
		// •	Owner 2 First Name
		string20 owner2_first_name;
		// •	Owner 2 Middle Name
		string20 owner2_middle_name;
		// •	Owner 2 Last Name
		string20 owner2_last_name;
		// •	Owner 2 SSN
		string9 owner2_SSN;
		// •	Owner 2 Company Name
		string70 owner2_company_name;
		// •	Owner 2 Address
		string120 owner2_address;
		// •	Owner 2 City
		string35 owner2_city;
		// •	Owner 2 State
		string2 owner2_state;
		// •	Owner 2 Zip Code
		string10 owner2_zip_code;
		
		// •	Reg 1 did: 
		//          VehicleV2.Layout_Base.Party - unsigned6		Append_DID
		//          faa.layout_aircraft_registration_out - string12	did_out
		//          Watercraft.Layout_Watercraft_Search_Base - string12	did
		unsigned6 reg_1_did;
		
		// •	Reg 1 bdid:
		//          VehicleV2.Layout_Base.Party - unsigned6		Append_BDID
		//          faa.layout_aircraft_registration_out - string12	bdid_out
		//          Watercraft.Layout_Watercraft_Search_Base - string12	did
		unsigned6 reg_1_bdid;

		// •	Reg 1 First Name:
		//          VehicleV2.Layout_Base.Party - Append_Clean_Name STRING20 fname
		//          faa.layout_aircraft_registration_out - string20 	fname
		//          Watercraft.Layout_Watercraft_Search_Base - string20	fname
		string20 reg_1_first_name;
		
		// •	Reg 1 Middle Name:
		//          VehicleV2.Layout_Base.Party - Append_Clean_Name STRING20 mname
		//          faa.layout_aircraft_registration_out - string20 	mname
		//          Watercraft.Layout_Watercraft_Search_Base - string20	mname
		string20 reg_1_middle_name;

		// •	Reg 1 Last Name:
		//          VehicleV2.Layout_Base.Party - Append_Clean_Name STRING20 lname
		//          faa.layout_aircraft_registration_out - string20 	lname
		//          Watercraft.Layout_Watercraft_Search_Base - string20	lname
		string20 reg_1_last_name;

		// •	Reg 1 SSN:
		//          VehicleV2.Layout_Base.Party - string9			Orig_SSN
		//          faa.layout_aircraft_registration_out - string9	best_ssn
		//          Watercraft.Layout_Watercraft_Search_Base - string9		orig_ssn
		string9 reg_1_ssn;

		// •	Reg 1 Company Name:
		//          VehicleV2.Layout_Base.Party - string70		Append_Clean_CName
		//          faa.layout_aircraft_registration_out - string50 	compname
		//          Watercraft.Layout_Watercraft_Search_Base - string60	company_name
		string70 reg_1_company_name;

		// •	Reg 1 Address:
		//          VehicleV2.Layout_Base.Party - string70		Orig_Address
		//          faa.layout_aircraft_registration_out - string33 	street AND 	string33 	street2
		//          Watercraft.Layout_Watercraft_Search_Base - 	string60	orig_address_1 AND string60	orig_address_2 
		string120 reg_1_address;
		
		// •	Reg 1 City:
		//          VehicleV2.Layout_Base.Party - string35		Orig_City
		//          faa.layout_aircraft_registration_out - string18 	city
		//          Watercraft.Layout_Watercraft_Search_Base - string25	orig_city
		string35 reg_1_city;
		
		// •	Reg 1 State:
		//          VehicleV2.Layout_Base.Party - string2		Orig_State
		//          faa.layout_aircraft_registration_out - string5 	state
		//          Watercraft.Layout_Watercraft_Search_Base - string2		orig_state
		string2 reg_1_state;

		// •	Reg 1 Zip Code:
		//          VehicleV2.Layout_Base.Party - string10		Orig_Zip
		//          faa.layout_aircraft_registration_out - string10 	zip_code
		//          Watercraft.Layout_Watercraft_Search_Base - string10	orig_zip
		string10 reg_1_zip_code;
		
		// •	Reg 2 did
		unsigned6 reg_2_did;
		// •	Reg 2 bdid
		unsigned6 reg_2_bdid;
		// •	Reg 2 First Name
		string20 reg_2_first_name;
		// •	Reg 2 Middle Name
		string20 reg_2_middle_name;
		// •	Reg 2 Last Name
		string20 reg_2_last_name;
		// •	Reg 2 SSN
		string9 reg_2_ssn;
		// •	Reg 2 Company Name
		string70 reg_2_company_name;
		// •	Reg 2 Address
		string120 reg_2_address;
		// •	Reg 2 City
		string35 reg_2_city;
		// •	Reg 2 State
		string2 reg_2_state;
		// •	Reg 2 Zip Code
		string10 reg_2_zip_code;

		// •	Type Flag
		// o	MV – Motor Vehicle
		// o	WC – Watercraft
		// o	AC – Aircraft
		// RT - Real Time Motor Vehicle
		STRING2 Type_Flag;

		// •	Identification Number 
		// o	MVR – vin: VehicleV2.Layout_Base.Main - string25    orig_vin
		// o	Watercraft – Hull Number: Watercraft.Layout_Watercraft_Main_Base - string30	hull_number
		// o	Aircraft – n_number_1: faa.layout_aircraft_registration_out - string8 	n_number
		STRING30 Id_Number;
		
		// •	Year
		// o	MVR – model_year: VehicleV2.Layout_Base.Main - string4 orig_year
		// o	Watercraft – model_year: Watercraft.Layout_Watercraft_Main_Base - string4		model_year
		// o	Aircraft – year_mfr_1: faa.layout_aircraft_registration_out - string8 	year_mfr
		STRING4 Year;

		// •	Make
		// o	MVR – make_desc: VehicleV2.Layout_Base.Main - 	string36	orig_make_desc
		// o	Watercraft – watercraft_make_description: Watercraft.Layout_Watercraft_Main_Base - string30	watercraft_make_description
		// o	Aircraft – aircraft_mfr_name_1: faa.layout_aircraft_registration_out - string30 	aircraft_mfr_name
		STRING36 Make;

		// •	Model 
		// o	MVR – model_desc: VehicleV2.Layout_Base.Main - string30	orig_model_desc
		// o	Watercraft – watercraft_model_desc: Watercraft.Layout_Watercraft_Main_Base - string30	watercraft_model_description
		// o	Aircraft – ac_model_name_1: faa.layout_aircraft_registration_out - string20 	model_name
		STRING30 Model;

		// •	Body Style 
		// o	MVR – body_style_desc: VehicleV2.Layout_Base.Main - string20 orig_body_desc
		// o	Watercraft – hull_type_description: Watercraft.Layout_Watercraft_Main_Base - string20	hull_type_description
		// o	Aircraft – category_mapped_1
		STRING20 Body_Style;
		
		// •	Type Description
		// o	MVR – vehicle_type_desc: VehicleV2.Layout_Base.Main - string30 orig_vehicle_type_desc
		// o	Watercraft – vehicle_type_desc: Watercraft.Layout_Watercraft_Main_Base - string20	vehicle_type_description
		// o	Aircraft – aircraft_type_mapped_1: faa.layout_aircraft_registration_out - string13 	type_aircraft
		STRING30 Type_Description;

		// •	Color 
		// o	MVR – major_color_desc: VehicleV2.Layout_Base.Main - string15	orig_major_color_desc
		// o	Watercraft – watercraft_color_1_description: Watercraft.Layout_Watercraft_Main_Base - string20 watercraft_color_1_description
		// o	Aircraft – n/a
		STRING20 Color;
		
		// •	Base Price 
		// o	MVR – vina_price: VehicleV2.Layout_Base.Main - string6	VINA_Price
		// o	Watercraft – purchase_price: Watercraft.Layout_Watercraft_Main_Base - string10 purchase_price
		// o	Aircraft – n/a
		STRING10 Base_Price;

		// •	Watercraft Name: Watercraft.Layout_Watercraft_Main_Base - string40 watercraft_name
		STRING40 Watercraft_Name;

		// •	Registration State 
		// o	MVR – state_orig: VehicleV2.Layout_Base.Main - string2 state_origin
		// o	Watercraft – st_registration: Watercraft.Layout_Watercraft_Main_Base - string2 st_registration
		// o	Aircraft – n/a
		STRING2 Reg_State;

		// •	First Registration Date 
		// o	MVR – reg_first_date: VehicleV2.Layout_Base.Party - string8	Reg_First_Date
		// o	Watercraft – n/a
		// o	Aircraft – n/a
		STRING8 First_Reg_Date;

		// •	Earliest Registration Date
		// o	MVR – reg_earliest_effective_date: VehicleV2.Layout_Base.Party - string8 Reg_Earliest_Effective_Date
		// o	Watercraft – n/a
		// o	Aircraft – n/a
		STRING8 Earliest_Reg_Date;

		// •	Latest Registration Date 
		// o	MVR – reg_latest_effective_date: VehicleV2.Layout_Base.Party - string8 Reg_Latest_Effective_Date
		// o	Watercraft – registration_date: Watercraft.Layout_Watercraft_Main_Base - string8		registration_date
		// o	Aircraft – n/a
		STRING8 Latest_Reg_Date;

		// •	Expiration Date
		// o	MVR – reg_latest_expiration_date: VehicleV2.Layout_Base.Party - string10 Reg_Latest_Expiration_Date
		// o	Watercraft – registration_expiration_date: Watercraft.Layout_Watercraft_Main_Base - string8		registration_expiration_date
		// o	Aircraft – n/a
		STRING10 Expiration_Date;

		// •	Certification Issue Date
		// o	Aircraft – cert_issue_date_1: faa.layout_aircraft_registration_out - string15 	cert_issue_date
		STRING15 Certification_Issue_Date;

		// •	Last Action Date
		// o	Aircraft – last_action_date_1: faa.layout_aircraft_registration_out - string16 	last_action_date
		STRING16 Last_Action_Date;

		// •	Registration Decal Number
		// o	MVR – reg_decal_number: VehicleV2.Layout_Base.Party - string10 Reg_Decal_Number
		// o	Watercraft – decal_number: Watercraft.Layout_Watercraft_Main_Base - string20	decal_number
		// o	Aircraft – n/a
		STRING20 Reg_Decal_Number;

		// •	Registration Status
		// o	MVR – (There is a record type [historical, expired, current] that is return in Accurint but I cannot find it returned in batch.  Thoughts??)
		//           VehicleV2.Layout_Base.Party - string20	Reg_Status_Desc
		// o	Watercraft – registration_status_description: Watercraft.Layout_Watercraft_Main_Base - string40	registration_status_description
		// o	Aircraft – current_flag_1 (active, historical): faa.layout_aircraft_registration_out - string1 	current_flag
		STRING40 Reg_Status;

		// •	Registration Type
		// o	MVR – reg_license_plate_type_desc: VehicleV2.Layout_Base.Party - string65	Reg_License_Plate_Type_Desc
		// o	Watercraft – n/a
		// o	Aircraft – type_registrant (individual, co-owner, partnership, corporation): 
		//                               faa.layout_aircraft_registration_out - string15 	type_registrant
		STRING65 Reg_Type;

		// •	title number 
		// o	MVR – ttl_number: VehicleV2.Layout_Base.Party - string20 Ttl_Number
		// o	Watercraft – title_number: Watercraft.Layout_Watercraft_Main_Base - string20	title_number
		// o	Aircraft – n/a
		STRING20 Title_Number;

		// •	Earliest Title Date 
		// o	MVR – ttl_earliest_issue_date: VehicleV2.Layout_Base.Party - string8	Ttl_Earliest_Issue_Date
		// o	Watercraft – n/a
		// o	Aircraft – n/a
		STRING8 Earliest_Title_Date;

		// •	Title Latest Issue Date 
		// o	MVR – ttl_latest_issue_date: VehicleV2.Layout_Base.Party - string8	Ttl_Latest_Issue_Date
		// o	Watercraft – title_issue_date: Watercraft.Layout_Watercraft_Main_Base - string8		title_issue_date
		// o	Aircraft – n/a
		STRING8 Title_Latest_Issue_Date;

		// •	Title Status
		// o	MVR – ttl_status_desc: VehicleV2.Layout_Base.Party - string48	Ttl_Status_Desc
		// o	Watercraft – title_status_description: Watercraft.Layout_Watercraft_Main_Base - string40	title_status_description
		// o	Aircraft – n/a
		STRING48 Title_Status;

		// •	Tag Number 
		// o	MVR – reg_license_plate: VehicleV2.Layout_Base.Party - string10	Reg_License_Plate
		// o	Watercraft – n/a
		// o	Aircraft – n/a
		STRING10 Tag_Number;

		// •	Tag State 
		// o	MVR – reg_license_state: VehicleV2.Layout_Base.Party - string2 Reg_License_State
		// o	Watercraft – n/a
		// o	Aircraft – n/a
		STRING2 Tag_State;
	
		// •	Best First Name
		STRING20 Best_First_Name;
		// •	Best Middle Name
		STRING20 Best_Middle_Name;
		// •	Best Last Name
		STRING20 Best_Last_Name;
		STRING9 Best_SSN;
		// •	Best Address
		STRING80 Best_Address;
		// •	Best City
		STRING25 Best_City;
		// •	Best State
		STRING2 Best_State;
		// •	Best ZipCode
		STRING10 Best_Zipcode;
		// •	Best Date First Seen
		STRING6 Best_Date_First_Seen;
		// •	Best Date Last Seen
		STRING6 Best_Date_Last_Seen;	
		
		Temp_Fields
	end;

  export IdVehicleRec := RECORD
	  unsigned6 id;
		string30 corp_key;
    STRING30 vehKey;
	  STRING15 iterKey := '';
	  STRING15 seqKey := '';
		unsigned4 lastReportDate := 0;
		STRING30 sort1 := '';
		STRING30 sort2 := '';		
  END;
	
	export outputRec := RECORD
    IdVehicleRec rec;
    Layout_output out;
  END;
	
	export Layout_Final_Output := RECORD
		Layout_Output - Temp_Fields
	END;
	
	export ContactPairRec := RECORD
		unsigned6 bdid;
		string30  corp_key;
		unsigned6 did;
	END;
	
	export BusinessList := RECORD
	  unsigned6 bdid;
		string30  corp_key;
	END;
	
	export PolkOutLayout := {VehicleV2_Services.Layouts_RTBatch_V2.rec OR VehicleV2_Services.Layouts_RTBatch_V2.rec_out};

end;