IMPORT FLAccidents_Ecrash, ut, doxie, lib_stringlib;

//** late fix for bug 128352 highlighted with lines below, two sections ************************************
//** Added the fix for bug 138974

EXPORT ConstantsDeltaBase := MODULE

		EXPORT SELECTSTMT				:=	'SELECT ';
		EXPORT LIMITCLAUSE			:=	' LIMIT 1000 ';
		
		
// ***** Pulling date_added from deltabase for resolving defect 138974		
		EXPORT Join_Columns 		:= 	' k.delta_key_id,k.date_added,k.report_code,k.jurisdiction_state,k.jurisdiction,k.case_identifier,k.state_report_number,' + 
																'k.original_case_ident,k.original_st_rpt_num,k.date_of_loss,k.accident_location_street,k.accident_location_crossstreet,'+ 
																'k.accident_location_nextstreet,k.agency_id,k.agency_ori,k.report_hashkey,k.has_coversheet,k.is_ready_for_public,k.vendor_code,'+
																'k.report_link_id,k.report_type_id,k.contrib_source,k.officer_id, p.delta_key_id as pdelta_key_id,p.person_type,p.name_first,p.name_middle,p.name_last,' + 
																// 'p.name_suffix,p.dob,p.driver_license_number,p.address,p.city,p.state,p.zip_code,k.report_id,k.incident_id,k.is_deleted ';
																'p.name_suffix,p.dob,p.driver_license_number,p.address,p.city,p.state,p.zip_code,p.vehicle_unit_number,k.report_id,k.incident_id,k.is_deleted,' +
																// 'v.vin,v.tag_number,v.tag_state'; 
																'v.vin,v.tag_number,v.unit_number'; 
		// EXPORT Join_FROM				:=	' FROM delta_ec.delta_key k, delta_ec.delta_person p';
		// EXPORT Join_WHERE				:=	' WHERE k.delta_key_id = p.delta_key_id ';

		EXPORT Join_FROM				:=	' FROM delta_ec.delta_key k ' +
																'LEFT JOIN delta_ec.delta_person AS p use index(p_delta_key_id_idx) ON p.delta_key_id = k.delta_key_id ' + 
																'LEFT JOIN delta_ec.delta_vehicle AS v	use index(v_delta_key_id_idx) ON v.delta_key_id = k.delta_key_id ' + 
																//we don't want to join by p.vehicle_unit_number if person record doesn't exist because we still want to return a record with the vehicle data
																//we need "OR v.unit_number IS NULL" because according to the logic that builds payload data if vehicle has empty unit_number - we
																//want to assign that vehicle to ALL of the person records
																'AND (IF (p.delta_key_id IS NULL, TRUE, p.vehicle_unit_number = v.unit_number) OR v.unit_number IS NULL)';
		EXPORT Join_WHERE				:=	' WHERE ';
		
		SHARED ImageRetrievalSqlSelectFrom :=	'SELECT k.date_added,k.state_report_number,k.original_st_rpt_num,k.case_identifier,k.original_case_ident,' + 
																'k.report_code,k.date_of_loss,k.agency_ori,k.agency_id,k.jurisdiction,k.jurisdiction_state,k.report_id,k.delta_key_id,' + 
																'k.report_hashkey,k.accident_location_street,k.vendor_report_id,k.report_type_id,k.vendor_code,k.page_count, ' + 
																' k.accident_location_crossstreet,p.name_first,p.vehicle_unit_number,p.address,p.person_type,' + 
																' p.name_middle,p.name_last,p.driver_license_number,p.city,p.state,p.zip_code,p.date_added as person_creation_date,' + 
																'v.vin,v.vehicle_year,' + 
																' v.make_description,v.model_description,v.tag_number,k.is_deleted,k.incident_id' +
																' FROM delta_ec.delta_key AS k ';
		SHARED ImageRetrievalSqlJoin := 'LEFT JOIN delta_ec.delta_person AS p use index(p_delta_key_id_idx) ON p.delta_key_id = k.delta_key_id' + 
																' LEFT JOIN delta_ec.delta_vehicle AS v	use index(v_delta_key_id_idx) ON v.delta_key_id = k.delta_key_id AND p.vehicle_unit_number = v.unit_number';														
		
		EXPORT ImageRetrievalSqlByReportId := ImageRetrievalSqlSelectFrom + ' USE INDEX(ix_rid_dadded) ' + ImageRetrievalSqlJoin;
		EXPORT ImageRetrievalSql := ImageRetrievalSqlSelectFrom + ' USE INDEX(ix_caseid_aid_jstate_rcode_dadded_rid) ' + ImageRetrievalSqlJoin;	
		
		EXPORT JoinSetupString	:=	SELECTSTMT + Join_Columns + Join_FROM + Join_WHERE;
		PersonInnerSelect := ' k.delta_key_id IN (SELECT k.delta_key_id ' + Join_FROM + 'WHERE ' ;
		EXPORT PersonOuterToInnerSelect := JoinSetupString + PersonInnerSelect;
		
		EXPORT TmImageSql := 'SELECT report_data FROM delta_ec.delta_report_data';
		
		EXPORT Document_Select := 'SELECT document_id AS documentId,jurisdiction AS jurisdiction,jurisdiction_state AS jurisdictionState,' + 
															'case_identifier AS caseIdentifier,state_report_number AS stateReportNumber,date_of_loss AS dateOfLoss,' +
															' hashkey AS hashKey,report_type_id AS reportTypeId,is_deleted AS isDeleted,extension AS extenstion,' + 
															' page_count AS pageCount, date_added AS dateAdded ' +
                              'FROM delta_ec.delta_document WHERE ';
		
		
// ******** Below are TRANSFORMs for Deltabase => FLAccidents_Ecrash.key_EcrashV2_accnbrV1 **********

		

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
				self := [];
		END;
				 //THIS.prim_range,predir,prim_name := LEFT.address				//we don't have cleaned address so cannot fill these 3 fields.

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

END;