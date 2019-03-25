
IMPORT Didville, Doxie, Doxie_cbrs, Doxie_Files, Header, PhonesFeedback, Property, PhonesInfo, BIPV2;

EXPORT layouts := MODULE

	EXPORT portfolio := MODULE
	
		EXPORT base := RECORD
			UNSIGNED6 pid := 0;
			UNSIGNED6 rid := 0;
			STRING14  timestamp := '';
			STRING1   action_code := '';
			UNSIGNED6 did := 0;
			UNSIGNED6 bdid := 0;
			UNSIGNED8 hash_docid := 0;
			AccountMonitoring.types.productMask	product_mask := 0;
			STRING20	 name_first := '';
			STRING20	 name_middle := '';
			STRING20	 name_last := '';
			STRING5	 name_suffix := '';
			STRING120 comp_name := '';
			STRING10  prim_range := '';
			STRING2   predir := '';
			STRING28  prim_name := '';
			STRING4   addr_suffix := '';
			STRING2   postdir := '';
			STRING10  unit_desig := '';
			STRING8   sec_range := '';
			STRING25  p_city_name := '';
			STRING2   st := '';
			STRING5   z5 := '';
			STRING4   zip4 := '';
			STRING9   fein := '';
			STRING12	 ssn := '';
			STRING8	 dob := '';
			STRING10  phone := '';
			// PIS - additional fields
			STRING100 name_business := '';
			STRING10 business_phone := '';
			STRING10 postal_code := '';
			STRING20 license_number := '';
			STRING2 lic_state := '';
			STRING20 npi := '';
			STRING20 dea_number := '';
			STRING10 clia := '';
			STRING7 ncpdp_number := '';
			STRING1 entity_type := '';
			STRING1 ln_entity_type := '';
			STRING20 upin := '';
			// Member Point - additional fields
			STRING50 guardian_name_first := '';
			STRING50 guardian_name_last := '';
			STRING10 guardian_dob := '';
			STRING9 guardian_ssn := '';
			UNSIGNED6 DotID			:= 0;
			UNSIGNED6 EmpID			:= 0;
			UNSIGNED6 POWID			:= 0;
			UNSIGNED6 ProxID		:= 0;
			UNSIGNED6 SELEID		:= 0;
			UNSIGNED6 OrgID			:= 0;
			UNSIGNED6 UltID			:= 0;
		END;
		
		EXPORT update := RECORD
			UNSIGNED6 pid;                // portfolio id
			UNSIGNED6 rid;                // record id
			UNSIGNED8 hash_docid;         // document id hash
			STRING1   action_code;
			UNSIGNED8 product_mask;
			STRING50  name_first;
			STRING50  name_middle;
			STRING50  name_last;
			STRING10  name_suffix;
			STRING100 name_full;
			STRING9   ssn;
			STRING100 address_1;
			STRING100 address_2;
			STRING50  city;
			STRING2   state;
			STRING10  zip;
			STRING10  dob;
			STRING14  phone;
			UNSIGNED6 did;
			UNSIGNED6 bdid;
			// PIS - additional fields
			STRING9 fein;
			STRING100 name_business;
			STRING10 business_phone;
			STRING10 postal_code;
			STRING20 license_number;
			STRING2 lic_state;
			STRING20 npi;
			STRING20 dea_number;
			STRING10 clia;
			STRING7 ncpdp_number;
			STRING1 entity_type;
			STRING1 ln_entity_type;
			STRING20 upin;
			// Member Point - additional fields
			STRING50 guardian_name_first;
			STRING50 guardian_name_last;
			STRING10 guardian_dob;
			STRING9 guardian_ssn;
			BIPV2.IDlayouts.l_header_ids;
		END;
	
	END;
	
	EXPORT documents := MODULE
	
		SHARED template(in_product,in_documentid_record) := MACRO
		
			EXPORT in_product := MODULE
				SHARED update_common := RECORD
					UNSIGNED6 pid  :=  0;
					UNSIGNED6 rid  :=  0;
					UNSIGNED6 hid  :=  0;
					STRING1   action_code;
				END;
				SHARED base_common := RECORD
					update_common;
					STRING14 timestamp;
				END;
				EXPORT update := RECORD
					update_common;
					/* no timestamp */
					in_documentid_record;
				END;
				EXPORT base := RECORD
					base_common;
					/* has timestamp */
					in_documentid_record;
				END;
			END;
					
		ENDMACRO;
		
		SHARED bankruptcy_documentid_record := RECORD
			AccountMonitoring.product_files.bankruptcy.search_file.tmsid;
		END;
		SHARED deceased_documentid_record := RECORD
			AccountMonitoring.product_files.deceased.base_file.state_death_id;
		END;		
		SHARED reverseaddress_documentid_record := RECORD
			AccountMonitoring.product_files.address.watchdog_file_best.prim_range;
			AccountMonitoring.product_files.address.watchdog_file_best.prim_name;
			AccountMonitoring.product_files.address.watchdog_file_best.sec_range;
			AccountMonitoring.product_files.address.watchdog_file_best.city_name;
			AccountMonitoring.product_files.address.watchdog_file_best.st;
			AccountMonitoring.product_files.address.watchdog_file_best.zip;
		END;
		SHARED phone_documentid_record := RECORD
			AccountMonitoring.product_files.phone.rec_gong_history_slim.phone10;
		END;
		SHARED paw_documentid_record := RECORD
			AccountMonitoring.product_files.people_at_work.base_file_b.company_name;
		END;
		SHARED property_documentid_record := RECORD
			AccountMonitoring.product_files.property.layout_search_file_b.prim_range;
			AccountMonitoring.product_files.property.layout_search_file_b.predir;
			AccountMonitoring.product_files.property.layout_search_file_b.prim_name;
			AccountMonitoring.product_files.property.layout_search_file_b.suffix;
			AccountMonitoring.product_files.property.layout_search_file_b.postdir;
			AccountMonitoring.product_files.property.layout_search_file_b.unit_desig;
			AccountMonitoring.product_files.property.layout_search_file_b.sec_range;
			AccountMonitoring.product_files.property.layout_search_file_b.p_city_name;
			AccountMonitoring.product_files.property.layout_search_file_b.st;
			AccountMonitoring.product_files.property.layout_search_file_b.zip;
		END;
		SHARED litigiousdebtor_documentid_record := RECORD
			AccountMonitoring.product_files.litigiousdebtor.litigiousdebtor_file_slim.courtstate;
			AccountMonitoring.product_files.litigiousdebtor.litigiousdebtor_file_slim.docketnumber;
		END;
		SHARED liens_documentid_record := RECORD
			AccountMonitoring.product_files.liens.main_file.tmsid;
		END;
		SHARED criminal_documentid_record := RECORD
			doxie_files.File_Offenders.offender_key;
		END;
		SHARED phonefeedback_documentid_record := RECORD
			PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base.did;
			PhonesFeedback.Layouts_PhonesFeedback.Layout_PhonesFeedback_base.phone_number;
		END;
		SHARED foreclosure_documentid_record := RECORD
			Property.Layout_Fares_Foreclosure.situs1_zip;
			Property.Layout_Fares_Foreclosure.situs1_prim_name;
			Property.Layout_Fares_Foreclosure.situs1_prim_range;
			Property.Layout_Fares_Foreclosure.situs1_addr_suffix;
			Property.Layout_Fares_Foreclosure.situs1_predir;
		END;
		SHARED workplace_documentid_record := RECORD
			AccountMonitoring.product_files.workplace.base_file_slim.did;
		END;
		SHARED address_documentid_record := RECORD
			Header.Layout_Header.did;
		END;
		SHARED didupdate_documentid_record := RECORD
			AccountMonitoring.product_files.header_files.doxie_key_rid_did.did;
		END;		
		SHARED bdidupdate_documentid_record := RECORD
			AccountMonitoring.product_files.header_files.business_header_key_rcid.bdid;
		END;
		SHARED phoneownership_documentid_record := RECORD
			PhonesInfo.Layout_Common.portedMetadata_Main.deact_start_dt;
			PhonesInfo.Layout_Common.portedMetadata_Main.account_owner;	
			PhonesInfo.Layout_Common.portedMetadata_Main.spid;	
			PhonesInfo.Layout_Common.portedMetadata_Main.serv; 
			PhonesInfo.Layout_Common.portedMetadata_Main.line; 
			PhonesInfo.Layout_Common.portedMetadata_Main.dt_last_reported; 
			PhonesInfo.Layout_Common.portedMetadata_Main.port_start_dt; 
			PhonesInfo.Layout_Common.portedMetadata_Main.swap_start_dt;	
			PhonesInfo.Layout_Common.portedMetadata_Main.phone_swap;	
			PhonesInfo.Layout_Common.portedMetadata_Main.deact_code;	
			PhonesInfo.Layout_Common.portedMetadata_Main.is_deact;	
			PhonesInfo.Layout_Common.portedMetadata_Main.source;	
		END;
		SHARED bipbestupdate_documentid_record := RECORD
			BIPV2.IDlayouts.l_header_ids;
		END;
		
		SHARED sbfe_documentid_record := RECORD
			BIPV2.IDlayouts.l_header_ids;
		END;
		
		SHARED ucc_documentid_record := RECORD
			AccountMonitoring.product_files.ucc.uccMain_key.tmsid;
		END;
		
		SHARED govtdebarred_documentid_record := RECORD
			AccountMonitoring.product_files.govtdebarred.govtLinkid_key.samnumber;
		END;
		
		SHARED inquiry_documentid_record := RECORD
			AccountMonitoring.product_files.inquiry.inquiryLinkid_key.search_info.transaction_id;
			AccountMonitoring.product_files.inquiry.inquiryLinkid_key.search_info.sequence_number;
			AccountMonitoring.product_files.inquiry.inquiryLinkid_key.search_info.datetime;
		END;
		
		SHARED corp_documentid_record := RECORD
			AccountMonitoring.product_files.corp.corpKey_key.corp_key;
		END;
		
		SHARED mvr_documentid_record := RECORD
			AccountMonitoring.product_files.mvr.main_key.vehicle_key;
			AccountMonitoring.product_files.mvr.main_key.iteration_key;
		END;
		
		SHARED aircraft_documentid_record := RECORD
			AccountMonitoring.product_files.aircraft.airLinkid_key.n_number;
		END;
		
		SHARED watercraft_documentid_record := RECORD
			AccountMonitoring.product_files.watercraft.waterLinkid_key.watercraft_key;
			AccountMonitoring.product_files.watercraft.waterLinkid_key.sequence_key;
			AccountMonitoring.product_files.watercraft.waterLinkid_key.state_origin;
		END;
   
   SHARED personheader_documentid_record := RECORD
			AccountMonitoring.product_files.watercraft.waterLinkid_key.watercraft_key;
			AccountMonitoring.product_files.watercraft.waterLinkid_key.sequence_key;
			AccountMonitoring.product_files.watercraft.waterLinkid_key.state_origin;
		END;
    
		template(default,doxie.layout_references);
		template(bankruptcy,bankruptcy_documentid_record);
		template(deceased,deceased_documentid_record);
		template(address,address_documentid_record);
		template(phone,phone_documentid_record);
		template(paw,paw_documentid_record);
		template(property,property_documentid_record);
		template(litigiousdebtor,litigiousdebtor_documentid_record);
		template(liens,liens_documentid_record);
		template(criminal,criminal_documentid_record);
		template(phonefeedback,phonefeedback_documentid_record);
		template(foreclosure,foreclosure_documentid_record);
		template(workplace,workplace_documentid_record);	
		template(reverseaddress,reverseaddress_documentid_record);
		template(didupdate,didupdate_documentid_record);
		template(bdidupdate,bdidupdate_documentid_record);
		template(phoneownership,phoneownership_documentid_record);
		template(bipbestupdate,bipbestupdate_documentid_record);
		template(sbfe,sbfe_documentid_record);
		template(ucc,ucc_documentid_record);
		template(govtdebarred,govtdebarred_documentid_record);
		template(inquiry,inquiry_documentid_record);
		template(corp,corp_documentid_record);
		template(mvr,mvr_documentid_record);
		template(aircraft,aircraft_documentid_record);
		template(watercraft,watercraft_documentid_record);
		template(personheader,personheader_documentid_record);
	END;
	
	EXPORT results := RECORD
		UNSIGNED6 pid;
		UNSIGNED6 rid;
		UNSIGNED6 hid;
		UNSIGNED6 did;
		UNSIGNED6 bdid;
		UNSIGNED8 product_mask;
	END;
	
	EXPORT history := RECORD
		results;
		UNSIGNED8 hash_value; 
		STRING14  timestamp;
	END;
	EXPORT InfoRec := RECORD
		DidVille.Layout_Did_OutBatch.seq;
		// STRING1 action_code;
		// portfolio.base.pid;
		// portfolio.base.rid;
		// portfolio.base.hash_docid;
		// portfolio.base.product_mask;
		portfolio.base;
	END;
	EXPORT DIDMetaRec := RECORD /* (DidVille.Layout_Did_OutBatch) */
		Doxie_cbrs.layout_references;
		DidVille.Layout_Did_OutBatch;		
		// STRING120 comp_name;
		InfoRec - [seq,addr_suffix,bdid,did,dob,p_city_name,postdir,predir,prim_name,prim_range,sec_range,ssn,st,unit_desig,z5,zip4];
	END;	
/*
	EXPORT layout_InBatch := RECORD
		InfoRec;
		qSTRING9  ssn;
		qSTRING8  dob;
		qstring10 phone10;
		qSTRING5  title;
		qSTRING20 fname;
		qSTRING20 mname;
		qSTRING20 lname;
		qSTRING5  suffix;
		qSTRING10 prim_range;
		qSTRING2  predir;
		qSTRING28 prim_name;
		qSTRING4  addr_suffix;
		qSTRING2  postdir;
		qSTRING10 unit_desig;
		qSTRING8  sec_range;
		qSTRING25 p_city_name;
		qSTRING2  st;
		qSTRING5  z5;
		qSTRING4  zip4;
		qstring120 company_name := '';
		qSTRING9  fein := '';
	END;
	
	EXPORT layout_OutBatch := RECORD
		layout_InBatch;
		unsigned6 did := 0;
		unsigned6 BDID := 0;
	END;
*/	
	EXPORT ECM := MODULE
	
		EXPORT base_layout := RECORD
			UNSIGNED6 eid := 0;
			UNSIGNED6 pid := 0;
		END;
		
		EXPORT results_layout := RECORD
			UNSIGNED6 eid;
			AccountMonitoring.types.productMask	product_mask;
			STRING20 product_name;
			UNSIGNED6 pid;
			REAL ratio;
		END;
		
	END;

END;

/*  Leaving this in for future use -- when we get the #for to read the output
    from fn_generate_Product_List_XML before compile	
	// Account Monitoring Product List & the Product List XML Layouts
  EXPORT rec_ProductList := 
     RECORD
			  STRING productName := '';
     END; // record ProductList

  EXPORT rec_ProductDefinitions := 
     RECORD
			  INTEGER    productNo        :=  0;
			  STRING     productName      := '';
			  UNSIGNED8  productMaskValue :=  0;
     END; // record ProductDefinitions

*/