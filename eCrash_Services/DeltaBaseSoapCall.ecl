IMPORT ut, iesp, Gateway, lib_stringlib;


//TODO eCrash team is a bit concerned that failures will simply act as though no delta records are found.
// This silent fail could lead to customers simply not trusting the system because they don't get answers.
EXPORT DeltaBaseSoapCall(IParam.searchrecords in_mod) := MODULE

		EXPORT EspServiceName := in_mod.SqlSearchEspNAME;
		EXPORT EspServiceUrl := in_mod.SqlSearchEspURL;
		EXPORT IsSafeToPerformSoap := EspServiceUrl <> '' AND EspServiceName <> '';
		EXPORT eCrashRecordStructure := Layouts.eCrashRecordStructure;

		EXPORT Layouts.eCrashRecordStructure transformDeltaJoinedRecs(Layouts.DeltaJoinedRecord DeltaRecord) := TRANSFORM		
				string CROSS_ST := IF(DeltaRecord.crossStreet = 'N/A','',DeltaRecord.crossStreet);
				boolean IsaTFRecord := DeltaRecord.reportCode ='TF';
				string IsReadyTmp := (STRING) DeltaRecord.isReadyForPublic;
				string IS_AVAIL := if(IsaTFRecord,'1',IsReadyTmp);
				boolean HasPersonState := DeltaRecord.state <> '';
				boolean HasZipCode := DeltaRecord.zipCode <> '';
				boolean HasLongZip := HasZipCode AND LENGTH(DeltaRecord.zipCode)>5;
				string Zip5 := IF(HasZipCode,DeltaRecord.zipCode[1..5],'');
				string Zip4 := IF(HasLongZip,DeltaRecord.zipCode[6..9],'');
				dolFormat(STRING dol) := dol[1..4]+dol[6..7]+dol[9..10];
				string8 fSlashedMDYtoCYMD(string pDateIn) := intformat((integer2)regexreplace('.*/.*/([0-9]+)',pDateIn,'$1'),4,1) 
																												+intformat((integer1)regexreplace('([0-9]+)/.*/.*',pDateIn,'$1'),2,1)
																												+intformat((integer1)regexreplace('.*/([0-9]+)/.*',pDateIn,'$1'),2,1);

				string date_of_birth := map(regexfind('-',DeltaRecord.dateOfBirth) and trim(DeltaRecord.dateOfBirth,left,right)[1..10] !='0000-00-00'
																	=> lib_stringlib.StringLib.stringfilterout(trim(DeltaRecord.dateOfBirth,left,right),'-')
																			,regexfind('/',DeltaRecord.dateOfBirth)
																				=> fSlashedMDYtoCYMD(DeltaRecord.dateOfBirth)
																		,'');

				self.report_code 					:= DeltaRecord.reportCode;
				self.jurisdiction_state 	:= DeltaRecord.jurisdictionState;
				self.st										:= IF(HasPersonState, DeltaRecord.state, self.jurisdiction_state);
				self.person_addr_st				:= DeltaRecord.state;
				self.zipFull 							:= DeltaRecord.zipCode;
				self.jurisdiction 				:= DeltaRecord.jurisdiction;
				self.l_accnbr							:= DeltaRecord.accident_number;	//deltabase Case_Identifier column=searchkey only
				self.orig_accnbr 					:= DeltaRecord.caseIdentifier;
				self.addl_report_number		:= DeltaRecord.stateReportNumber;
				self.formattedStateReportNumber := DeltaRecord.formattedStateReportNumber;
				self.accident_date 				:= dolFormat(DeltaRecord.dateOfLoss);
				self.accident_street 			:= DeltaRecord.street;
				self.accident_cross_street := CROSS_ST;
				self.accident_location		:= IF(CROSS_ST!='', DeltaRecord.street+' & '+CROSS_ST, DeltaRecord.street);
				self.next_street 					:= DeltaRecord.nextStreet;
				self.jurisdiction_nbr 		:= DeltaRecord.agencyID;
				self.agency_ori 					:= DeltaRecord.agencyORI;
				self.IMAGE_HASH 					:= DeltaRecord.reportHashkey;
				self.is_available_for_public := IS_AVAIL;
				self.Report_Has_Coversheet := (STRING)DeltaRecord.hasCoversheet;
				self.report_status 				:= '';
				self.fname 								:= DeltaRecord.firstName;
				self.mname 								:= DeltaRecord.middleName;
				self.lname 								:= DeltaRecord.lastName;
				self.name_suffix 					:= DeltaRecord.nameSuffix;
				self.dob 									:= date_of_birth;
				self.page_count            := DeltaRecord.pageCount;

				self.driver_license_nbr 	:= DeltaRecord.driverLicenseNumber;
				self.v_city_name 					:= DeltaRecord.city;
				self.zip 									:= Zip5;
				self.zip4									:= Zip4;
				self.record_type					:= DeltaRecord.personType;
				
				self.tag_nbr							:= DeltaRecord.tagNbr;
				self.vin									:= DeltaRecord.vin;
				self.vehicle_year					:= DeltaRecord.vehicleYear;
				self.make_description			:= DeltaRecord.makeDescription;
				self.model_description		:= DeltaRecord.modelDescription;
// ****** For resolving bug 138974 modified the transform to capture date_added.
				self.date_added           := DeltaRecord.date_added;
				self.report_id						:= DeltaRecord.reportID;
				self.vehicle_incident_id  := DeltaRecord.incidentID;
				self.vehicle_Unit_Number  := DeltaRecord.vehicleUnitNumber;
				self.address							:= DeltaRecord.address;
				self.person_creation_date := DeltaRecord.personCreationDate;
				
				//Added as part of report associations
				self.report_type_id       := DeltaRecord.reportTypeID;
				self.vendor_code          := DeltaRecord.vendorCode;
				self.ReportLinkID         := DeltaRecord.reportLinkID;
				self.vendor_report_id     := DeltaRecord.vendorReportID;
				self.is_deleted				    := DeltaRecord.isDeleted;
				
				//Added contrib_source
				self.contrib_source       := DeltaRecord.contrib_source;
				
				self.unit_number					:= DeltaRecord.unitNumber;
				self.officer_id						:= DeltaRecord.officerID;
				self.date_report_submitted          := dolFormat(DeltaRecord.date_report_submitted) ;
				self := [];
		END;
		
		EXPORT Layouts.ImageData populateImageDataResult(Layouts.ImageData DeltaRecord) := TRANSFORM
			SELF.Blob := DeltaRecord.Blob;
		END;
		
		EXPORT Layouts.AgencyDateRecord populateLastUploadDate(Layouts.DeltaBaseAgencyData DeltaRecord) := TRANSFORM
			SELF.lastUploadDate := DeltaRecord.lastUploadDate;
			SELF := [];
		END;
		
		EXPORT Layouts.SubsIncidentRecord populateSubsIncidentData(Layouts.DeltaBaseSubsIncidentData DeltaRecord) := TRANSFORM
			SELF.incidentId := DeltaRecord.incidentId;
		END;
		
		EXPORT Layouts.DocumentData populateDocumentData(Layouts.DeltaBaseDocumentData DeltaRecord) := TRANSFORM
			self := DeltaRecord;
			self.isDelta := true;
		END;

		EXPORT LookupDeltabase(SQLString, Transformer, ResponseLayout) := FUNCTIONMACRO		
			SqlDataset := DATASET([{SQLString}], Layouts.R_DeltaBaseSelectRequest);
			ShouldPerform := SQLString <> '' AND IsSafeToPerformSoap;			
			Incidents := IF(ShouldPerform, 
				Gateway.SoapCall_Deltabase(
					SqlDataset, 
					eCrash_Services.Layouts.R_DeltaBaseSelectRequest, 
					eCrash_Services.Layouts.ResponseLayout
				)
			);
						
			EspRecords := PROJECT(Incidents, Transformer(LEFT));
			
			RETURN EspRecords;
		ENDMACRO;
				
		EXPORT LookupDeltabase_ALias(SQLString_DS, Transformer, ResponseLayout) := FUNCTIONMACRO		
			ShouldPerform := count(SQLString_DS(TRIM(Select) <> '')) > 0 AND IsSafeToPerformSoap;
			Incidents := IF(ShouldPerform, 
			Gateway.SoapCall_Deltabase(
					SQLString_DS, 
					eCrash_Services.Layouts.R_DeltaBaseSelectRequest, 
					eCrash_Services.Layouts.ResponseLayout
				)
			);
						
			EspRecords := PROJECT(Incidents, Transformer(LEFT));

			RETURN EspRecords;
			
		ENDMACRO;
		
		EXPORT LookupIncidentPersons_Alias(Dataset(Layouts.R_DeltaBaseSelectRequest) SQLString_DS) := FUNCTION
			RETURN LookupDeltabase_alias(SQLString_DS, transformDeltaJoinedRecs, DeltaBaseReportResponse);
		END;
		
		EXPORT LookupIncidentPersons(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, transformDeltaJoinedRecs, DeltaBaseReportResponse);
		END;
		
		EXPORT GetImageData(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateImageDataResult, DeltaBaseImageDataResponse);
		END;
		
		EXPORT GetReportData(STRING DeltabaseReportSelectSql) := FUNCTION
			ReportDeltabaseRowRaw := LookupIncidentPersons(DeltabaseReportSelectSql);
			//each report in deltabase has a duplicative report with the case_identifier and state_report_number swapped
			//so here we need to get only one report and that's why we need to filter by l_accnbr here
			AccNbr := ReportDeltabaseRowRaw[1].l_accnbr;
			
			RETURN ReportDeltabaseRowRaw(l_accnbr = AccNbr);
		END;
		
		EXPORT GetAgencyLastReportDate(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateLastUploadDate, DeltaBaseAgencyDataResponse);
		END;
		
		EXPORT GetAgencySubscriptionIncidentIds(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateSubsIncidentData, DeltaBaseSubsIncidentResponse);
		END;
	
		EXPORT GetDocumentData(STRING SQLString) := FUNCTION
			RETURN LookupDeltabase(SQLString, populateDocumentData, DeltaBaseDocumentResponse);
		END;
		
	END;