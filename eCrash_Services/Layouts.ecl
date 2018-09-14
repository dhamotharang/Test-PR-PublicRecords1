IMPORT FLAccidents_Ecrash,iesp;

//** Added the fix for bug 138974

EXPORT Layouts := MODULE
			// VIYER - ECH -4910 
			EXPORT KY_Response_incident := RECORD
				 iesp.ky_search.t_KYCrashSearchIncident;
				 iesp.ky_search.t_KYCrashSearchResponse._Header.Message ;				 
				 iesp.ecrash.t_ECrashSearchAgency.Agencyid ;
				 string2 source_id;
				 boolean IsReadyForPublic; 
				 boolean PrimaryAgency;
				 boolean AgencyMatch;
			END;
			
			EXPORT ECrashSearchAgency_alias_extended := RECORD
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean	PrimaryAgency;
				boolean hasAgencyORI; 
			  string agencyORISQL;
				string imageHashNotNull ; 
			  string requestedHashKeySQLifParms; 
				boolean hasJurisdiction; 
				boolean hasJurisdictionState; 
				string jurisNotNullSQL; 
				string jurisString; 
				string jurisIfParmSQL; 
				string jurisStateString; 
				string jurisStateIfParmSQL; 
				string jurisNotNullIfNoParmSQL; 
				string jurisAndStateIfParms; 
				string jurisAndStateIfParmsElseNotNull;
				string simplePartialReportNumberWhere;
				string vinTagSQL;
				string licenseSQL;
				string officerBadgeSQL;
				string jurisStateSQL;
		END;		
		
		EXPORT search := record
			string ReportNumber;
			boolean isDeepDive := false;
			string JurisdictionState;
			string Jurisdiction;
			string AgencyId;
			string AgencyORI;
			boolean PrimaryAgency := false;
		END;	
		
		// ****** For resolving bug 138974 modified eCrashRecordStrure to add date_added , I have added date_added  to enable the query
		// *** to pick up the latest report instance from delta base.
		EXPORT eCrashRecordStructure := 		RECORD 
			FLAccidents_Ecrash.key_EcrashV2_accnbrV1;
			String20 date_added := '';
			STRING2 person_addr_st := '';
			STRING100 address := '';
			STRING10 zipFull := '';
			STRING20 person_creation_date := '';
			STRING formattedStateReportNumber := '';
			UNSIGNED1 is_deleted := 0;
			STRING3 unit_number := '';
		END;	

		//variable length strings with maxlength are used because this layout is used
		//in the ROLLUP that groups report parties by report_id and concatenates all the 
		//fields of the parties within the group.
		EXPORT eCrashRecordCompare := RECORD 
			STRING image_hash {maxlength(100000)};
			STRING accident_street {maxlength(100000)};
			STRING accident_cross_street {maxlength(100000)};
			STRING fname {maxlength(100000)};
			STRING mname {maxlength(100000)};
			STRING lname {maxlength(100000)};
			STRING driver_license_nbr {maxlength(100000)};
			STRING tag_nbr {maxlength(100000)};
			STRING v_city_name {maxlength(100000)};
			STRING st {maxlength(100000)};
			STRING zip {maxlength(100000)};
			STRING vin {maxlength(100000)};
			STRING vehicle_year {maxlength(100000)};
			STRING make_description {maxlength(100000)};
			STRING model_description {maxlength(100000)};
			STRING report_id;
			STRING report_code;
			UNSIGNED1 is_deleted := 0;
			STRING3 report_type_id;
			STRING40 orig_accnbr;
			STRING40 addl_report_number;
			STRING8 accident_date;
			STRING100 jurisdiction;
			STRING2 jurisdiction_state;
			STRING20 date_added := '';
			STRING11 vehicle_incident_id;
		END;
		
		EXPORT recs_with_penalty := record
			eCrashRecordStructure;
			unsigned2 penalt := 0;
			boolean isDelta := false;
			boolean isMatched := false;
		END;
		
		EXPORT recs_with_report_association := record
			dataset (recs_with_penalty) recs;
		END;
		
		//===========================================================================
		// REQUEST using new CLUE model where entire SQL is built as a string!
		//===========================================================================
		EXPORT R_DeltaBaseSelectRequest := RECORD
				string Select {xpath('Select'), maxlength(2000000)};
		END;
		
		//===========================================================================
		// END REQUEST
		//===========================================================================

		EXPORT DeltaIncidentRecord := RECORD
			string36 deltaKeyID{xpath('delta_key_id')};
//** Changed the record layout so that date_added from deltabase results can be captured.			
			string20 date_added{xpath('date_added')};
			string contrib_source{xpath('contrib_source')};
			string2 reportCode{xpath('report_code')};
			string2 jurisdictionState{xpath('jurisdiction_state')};
			string100 jurisdiction{xpath('jurisdiction')};
			string40 accident_number{xpath('case_identifier')};
			string40 caseIdentifier{xpath('original_case_ident')};
			string40 stateReportNumber{xpath('original_st_rpt_num')};
			string40 formattedStateReportNumber{xpath('state_report_number')};
			string10 dateOfLoss{xpath('date_of_loss')};
			string100 street{xpath('accident_location_street')};
			string100 crossStreet{xpath('accident_location_crossstreet')};
			string100 nextStreet{xpath('accident_location_nextstreet')};
			string11 agencyID{xpath('agency_id')};
			string9 agencyORI{xpath('agency_ori')};
			string64 reportHashkey{xpath('report_hashkey')};
			boolean hasCoversheet{xpath('has_coversheet')};
			boolean isReadyForPublic{xpath('is_ready_for_public')};
			string reportID{xpath('report_id')};
			string incidentID{xpath('incident_id')};
			string vendorCode{xpath('vendor_code')};
			string reportLinkID{xpath('report_link_id')};
			string reportTypeID{xpath('report_type_id')};
			string vendorReportID{xpath('vendor_report_id')};
			string pageCount{xpath('page_count')};
			unsigned1 isDeleted{xpath('is_deleted')};
			string12 officerID{xpath('officer_id')};
			string10 date_report_submitted {xpath('date_report_submitted')};
		END;

		EXPORT DeltaPersonRecord := RECORD
			string36 pDeltaKeyID{xpath('pdelta_key_id')};
			string100 personType{xpath('person_type')};
			string40 firstName{xpath('name_first')};
			string40 middleName{xpath('name_middle')};
			string100 lastName{xpath('name_last')};
			string3 nameSuffix{xpath('name_suffix')};
			string10 dateOfBirth{xpath('dob')};
			string25 driverLicenseNumber{xpath('driver_license_number')};
			string100 address{xpath('address')};
			string20 city{xpath('city')};
			string2 state{xpath('state')};
			string10 zipCode{xpath('zip_code')};
			string3 vehicleUnitNumber{xpath('vehicle_unit_number')};
			string20 personCreationDate{xpath('person_creation_date')};
		END;		
		
		EXPORT DeltaVehicleRecord := RECORD
			string20 dateAdded{xpath('date_added')};
			string36 vDeltaKeyID{xpath('delta_key_id')};
			string3 unitNumber{xpath('unit_number')};
			string30 vin{xpath('vin')};
			string10 vehicleYear{xpath('vehicle_year')};
			string100 makeDescription{xpath('make_description')};
			string100 modelDescription{xpath('model_description')};
			string12 tagNbr{xpath('tag_number')};
			string12 tagState{xpath('tag_state')};
		END;
		
		EXPORT DeltaJoinedRecord := RECORD
			DeltaIncidentRecord;
			DeltaPersonRecord;
			DeltaVehicleRecord;
		END;
		
		//===========================================================================
		// eCrash_Services.layouts (94,35) : 1041: Record doesn't have an explicit maximum record size
		EXPORT DeltaBaseReportResponse := RECORD 
			dataset(DeltaJoinedRecord) DataRecs{xpath('Records/Rec'), MAXCOUNT(500)};
			string RecsReturned{xpath('RecsReturned')};
			string Latency{xpath('Latency')};
			string ExceptionMessage{xpath('Exceptions/Exception/Message')};
		END;
		//===========================================================================
		
		EXPORT ImageData := RECORD
			STRING Blob {xpath('report_data'), MAXLENGTH(100000000)};
		END;
	
		EXPORT DeltaBaseImageDataResponse := RECORD 
			dataset(ImageData) DataRecs{xpath('Records/Rec'), MAXCOUNT(500)};
			string RecsReturned{xpath('RecsReturned')};
			string Latency{xpath('Latency')};
			string ExceptionMessage{xpath('Exceptions/Exception/Message')};
		END;
		
		EXPORT DeltaBaseAgencyData := RECORD
   		string lastUploadDate {xpath('last_upload_date'), MAXLENGTH(8)};
    END;
		
   	EXPORT AgencyDateRecord := RECORD(DeltaBaseAgencyData) 
   		string agencyID;
    END;
		
		EXPORT DeltaBaseAgencyDataResponse := RECORD 
			dataset(DeltaBaseAgencyData) DataRecs{xpath('Records/Rec'), MAXCOUNT(500)};
			string RecsReturned{xpath('RecsReturned')};
			string Latency{xpath('Latency')};
			string ExceptionMessage{xpath('Exceptions/Exception/Message')};
		END;
		
		EXPORT SubsIncidentRecord := RECORD 
			string incidentId;
		END;
		
		EXPORT SubsGroupedIncidentRecord := RECORD 
			string groupedIncidentIds;
		END;
		
		EXPORT SubsSeqIncidentRecord := RECORD 
			string incidentId;
			integer sequence;
	  END;
		
		EXPORT DeltaBaseSubsIncidentData := RECORD
			string incidentId {xpath('incidentId'), MAXLENGTH(10)};
		END;
		
		EXPORT DeltaBaseSubsIncidentResponse := RECORD 
			dataset(DeltaBaseSubsIncidentData) DataRecs{xpath('Records/Rec'), MAXCOUNT(1000)};
			string RecsReturned{xpath('RecsReturned')};
			string Latency{xpath('Latency')};
			string ExceptionMessage{xpath('Exceptions/Exception/Message')};
		END;
		
	  EXPORT DeltaBaseDocumentData := RECORD
			string documentId {xpath('documentId')};
			string jurisdiction {xpath('jurisdiction')};
			string jurisdictionState {xpath('jurisdictionState')};
			string caseIdentifier {xpath('caseIdentifier')};
			string stateReportNumber {xpath('stateReportNumber')};
			string dateOfLoss {xpath('dateOfLoss')};
			string hashKey {xpath('hashKey')};
			string reportTypeId {xpath('reportTypeId')};
			boolean isDeleted {xpath('isDeleted')} := false;
			string pageCount {xpath('pageCount')};
			string extension {xpath('extension')};
			string dateAdded {xpath('dateAdded')};
		END;
		
		EXPORT DeltaBaseDocumentResponse := RECORD 
			dataset(DeltaBaseDocumentData) DataRecs{xpath('Records/Rec'), MAXCOUNT(1000)};
			string RecsReturned{xpath('RecsReturned')};
			string Latency{xpath('Latency')};
			string ExceptionMessage{xpath('Exceptions/Exception/Message')};
		END;
		
		EXPORT DocumentData := RECORD(DeltaBaseDocumentData)
			boolean isDelta := false;
		END;
		
		EXPORT ReportPricing := RECORD
			string superreportid;
			string pagecount;
		END;
		
		EXPORT LastNameSortValue := RECORD
			string LastName;
		END;
		
		EXPORT GetSupplementalsResult := RECORD
			DATASET(RECORDOF(FLAccidents_Ecrash.Key_eCrashv2_Supplemental)) reportHashKeysFromKeyFinal;
			DATASET(eCrashRecordStructure) superReportRow;
			DATASET(eCrashRecordStructure) deltabaseReportsAll;
			DATASET(RECORDOF(FLAccidents_Ecrash.Key_eCrashv2_Supplemental)) reportsAllSlim;
		END;
		
		EXPORT SearchParameters := RECORD
				string Vin;	
				string DriversLicenseNum;
				string OfficerBadge;
				string LicensePlate;
				string CrossStreet;
				string LocStreet;
				string8 start_date;
				string8 end_date;
				string JurisdictionState;
				string Jurisdiction;
				string AgencyId;
				string AgencyORI;
				boolean primaryagency;
		END;

END;