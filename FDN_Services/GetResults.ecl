IMPORT iesp, FraudDefenseNetwork;

EXPORT GetResults(DATASET(FDN_Services.Layouts.raw_rec) ds_in = DATASET([], FDN_Services.Layouts.raw_rec)) := FUNCTION
	
	FDN_Services.Layouts.Count_Recs_Layout xForm(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			SELF.file_type := L.classification_Permissible_use_access.file_type;
	END;	
	
	ds_ids_con := PROJECT(ds_in, xForm(LEFT));
	
	count_total := COUNT(ds_ids_con);

  count_by_type := TABLE(ds_ids_con, {file_type, cnt := COUNT(GROUP)}, file_type);	
	
	//**************************************************************************************************
		//hits
		iesp.frauddefensenetwork.t_FDNHit hits (RECORDOF(count_by_type) L) := TRANSFORM
			SELF.FileType := (STRING)L.file_type;
			SELF.FileType_Count := L.cnt;	
		END;
		
		//matchCount
		iesp.frauddefensenetwork.t_FDNMatchCounts matchCount() := TRANSFORM
			SELF.TotalHits := count_total;
			SELF.hits := PROJECT(count_by_type, hits(LEFT));
		END;
			
	//******************************************************************************************************
	
		//entity
		iesp.frauddefensenetwork.t_FDNEntity entity(FDN_Services.Layouts.raw_rec E) := TRANSFORM
		  // Check/set entity type boolean for use below
      boolean EntityIsAddress := E.classification_Entity.Entity_type = 
			                                                FDN_Services.Constants.Entity_Types.ADDRESS;
      boolean EntityIsPerson  := E.classification_Entity.Entity_type = 
			                                                FDN_Services.Constants.Entity_Types.PERSON;
      boolean EntityIsPhone   := E.classification_Entity.Entity_type = 
			                                                FDN_Services.Constants.Entity_Types.PHONE;
      boolean EntityIsSsn     := E.classification_Entity.Entity_type = 
			                                                FDN_Services.Constants.Entity_Types.SSN;
			SELF.EntityTypeId      := E.classification_Entity.Entity_type_id;
			SELF._Type             := E.classification_Entity.Entity_type;
			SELF.EntitySubTypeId   := E.classification_Entity.Entity_sub_type_id;
			SELF.SubType           := E.classification_Entity.Entity_sub_type;
			SELF.RoleId            := E.classification_Entity.role_id;
			SELF.Role              := E.classification_Entity.role;
			SELF.EvidenceId        := E.classification_Entity.Evidence_id;
			SELF.Evidence          := E.classification_Entity.Evidence;
			SELF.InvestigatedCount := E.classification_Entity.investigated_count;
			// Output of Name.* or Address.* or SSN or Phone10 is dependent upon the Entity_type value
			SELF.did				       := if(EntityisPerson,E.did,0);
			SELF.NameType				   := if(EntityisPerson,E.Name_Type,'');
			SELF.Name.First        := if(EntityisPerson,E.cleaned_name.fname,'');
			SELF.Name.Middle       := if(EntityisPerson,E.cleaned_name.mname,'');
			SELF.Name.Last         := if(EntityisPerson,E.cleaned_name.lname,'');
			SELF.Name.Suffix       := if(EntityisPerson,E.cleaned_name.name_suffix,'');
			SELF.Name.Prefix       := if(EntityisPerson,E.cleaned_name.title,'');
      SELF.Address.StreetNumber					:= if(EntityIsAddress,E.clean_address.prim_range,'');
      SELF.Address.StreetPreDirection		:= if(EntityIsAddress,E.clean_address.predir,'');
      SELF.Address.StreetName						:= if(EntityIsAddress,E.clean_address.prim_name,'');
      SELF.Address.StreetSuffix					:= if(EntityIsAddress,E.clean_address.addr_suffix,'');
      SELF.Address.StreetPostDirection	:= if(EntityIsAddress,E.clean_address.postdir,'');
      SELF.Address.UnitDesignation	    := if(EntityIsAddress,E.clean_address.unit_desig,'');
      SELF.Address.UnitNumber						:= if(EntityIsAddress,E.clean_address.sec_range,'');
      SELF.Address.City									:= if(EntityIsAddress,
																							if(E.clean_address.v_city_name != '', 
			                                          E.clean_address.v_city_name,
																								E.clean_address.p_city_name),
																							'');
      SELF.Address.State								:= if(EntityIsAddress,E.clean_address.st,'');
      SELF.Address.Zip5									:= if(EntityIsAddress,E.clean_address.zip,'');
      SELF.Address.Zip4									:= if(EntityIsAddress,E.clean_address.zip4,'');
      SELF.AddressType									:= if(EntityIsAddress,E.Address_Type,'');
			SELF.SSN               	:= if(EntityIsSsn,E.ssn,'');
			SELF.Phone10           	:= if(EntityIsPhone,E.clean_phones.phone_number,'');
			SELF.ContactType       	:= if(EntityIsPhone,E.Contact_Type,'');
			SELF.Carrier           	:= if(EntityIsPhone,E.Carrier,'');
			SELF.InService					:= if(EntityIsPhone,E.In_service,'');
			SELF										:= []; // to null out unused Name.* & Address.* fields
		END;

		//source
		iesp.frauddefensenetwork.t_FDNSource source(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			SELF.FileType												:= (STRING)L.classification_Permissible_use_access.file_type;
			SELF.GCID														:= L.classification_Permissible_use_access.gc_id;
			SELF.FileCode												:= L.classification_Permissible_use_access.fdn_file_code;
			SELF.PrimarySourceEntityId					:= L.classification_source.Primary_source_Entity_id;
			SELF.PrimarySourceEntity						:= (STRING)L.classification_Permissible_use_access.primary_source_entity;
			SELF.ExpectationOfVictimEntitiesId	:= L.classification_source.Expectation_of_Victim_Entities_id;
			SELF.ExpectationOfVictimEntities		:= L.classification_source.Expectation_of_Victim_Entities;
			SELF.IndustrySegment								:= L.classification_source.Industry_segment;
			SELF.SourceTypeId										:= L.classification_source.Source_type_id;
			SELF.SourceType											:= L.classification_source.Source_type;
			SELF																:=[];
		END;

		//workflow
		iesp.frauddefensenetwork.t_FDNWorkflow workflow(FraudDefenseNetwork.Layouts_Key.Classification.Activity L) := TRANSFORM
				SELF.CommittedId	:= L.workflow_stage_committed_id;
				SELF.Committed		:= L.workflow_stage_committed;
				SELF.DetectedId		:= L.workflow_stage_detected_id;
				SELF.Detected			:= L.workflow_stage_detected;
				SELF							:=[];
		END;
		
		//severity
		iesp.frauddefensenetwork.t_FDNSeverity severity(FraudDefenseNetwork.Layouts_Key.Classification.Activity L) := TRANSFORM
				SELF.ThreatId     := L.Threat_id;
				SELF.Threat     	:= L.Threat;
				SELF.Exposure   	:= L.Exposure;
				SELF.Loss      		:= L.write_off_loss;
				SELF.Mitigated  	:= L.Mitigated;
				SELF.AlertLevelId := L.Alert_level_id;
				SELF.AlertLevel 	:= L.Alert_level;
				SELF							:=[];
		END;

		//activity
		iesp.frauddefensenetwork.t_FDNActivity activity(FDN_Services.Layouts.raw_rec A) := TRANSFORM
			SELF.SuspectedDiscrepancyId	:= A.classification_Activity.Suspected_Discrepancy_id;
			SELF.SuspectedDiscrepancy 	:= A.classification_Activity.Suspected_Discrepancy;
			SELF.ConfidenceDeceitfulId	:= A.classification_Activity.Confidence_that_activity_was_deceitful_id;
			SELF.ConfidenceDeceitful  	:= A.classification_Activity.Confidence_that_activity_was_deceitful;
			SELF.ChannelsId 						:= A.classification_Activity.Channels_id;
			SELF.Channels 							:= A.classification_Activity.Channels;
			SELF.IndustryFraudType 			:= A.classification_Activity.category_or_fraudtype;
			SELF.EventDate							:= iesp.ECL2ESP.toDate((INTEGER)A.Event_Date);  
			SELF.ReportedDate 					:= iesp.ECL2ESP.toDate((INTEGER)A.Reported_Date); 
			SELF.ReportedTime.Hour    	:= (INTEGER)A.Reported_Time[1..2];
			SELF.ReportedTime.Minute  	:= (INTEGER)A.Reported_Time[3..4];
			SELF.ReportedTime.Second  	:= (INTEGER)A.Reported_Time[5..6];
  		SELF.Workflow								:= ROW(workflow(A.classification_Activity));
			SELF.Severity								:= ROW(severity(A.classification_Activity));
			SELF.Description          	:= A.classification_Activity.description;
			SELF												:=[];
		END;
		
		//ENTITY CHARACTERISTICS
		iesp.frauddefensenetwork.t_FDNEntityCharacteristics txEntityCharacteristics(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			SELF.ReasonDescription	:= L.Reason_Description;
			SELF.CustomerFraudCode1	:= L.Customer_Fraud_Code_1;
			SELF										:= L; //Disposition
		END;

		// Business 
		iesp.frauddefensenetwork.t_FDNBusiness txBusiness(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isBusiness:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.BUSINESS;
			SELF.BusinessName				:= IF(isBusiness, L.Business_Name, '');
			SELF.CleanBusinessName	:= IF(isBusiness, L.clean_business_name, '');
			SELF.BusinessType1			:= IF(isBusiness, L.Business_Type_1, '');
			SELF.BusinessType2			:= IF(isBusiness, L.Business_Type_2, '');
			SELF.DotID							:= IF(isBusiness, L.DotID, 0);
			SELF.EmpID							:= IF(isBusiness, L.EmpID, 0);
			SELF.POWID							:= IF(isBusiness, L.POWID, 0);
			SELF.ProxID							:= IF(isBusiness, L.ProxID, 0);
			SELF.SELEID							:= IF(isBusiness, L.SELEID, 0);
			SELF.OrgID							:= IF(isBusiness, L.OrgID, 0);
			SELF.UltID							:= IF(isBusiness, L.UltID, 0);
			SELF.FEIN								:= IF(isBusiness, L.FEIN, '');
		END;

		// EMAIL ADDRESS
		iesp.frauddefensenetwork.t_FDNEMail txEMail(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isEmail:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.EMAIL_ADDRESS;
			SELF.EmailAddress			:= IF(isEmail, L.Email_Address, '');
			SELF.EmailAddressType	:= IF(isEmail, L.Email_Address_Type, '');
			SELF.Host							:= IF(isEmail, L.Host, '');
		END;

		// IP ADDRESS
		iesp.frauddefensenetwork.t_FDNIP txIPAddress(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isIP:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.IP_ADDRESS;
			SELF.IPAddress			:= IF(isIP, L.IP_Address, '');
			SELF.Class					:= IF(isIP, L.Class, '');
			SELF.SubnetMask			:= IF(isIP, L.Subnet_mask, '');
			SELF.ISP						:= IF(isIP, L.ISP, '');
		END;

		// DEVICE
		iesp.frauddefensenetwork.t_FDNDevice txDevice(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isDevice:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.DEVICE_ID;
			SELF.DeviceID											:= IF(isDevice, L.Device_ID, '');
			SELF.UniqueNumber									:= IF(isDevice, L.Unique_number, '');
			SELF.MACAddress										:= IF(isDevice, L.MAC_Address, '');
			SELF.SerialNumber									:= IF(isDevice, L.Serial_Number, '');
			SELF.DeviceType										:= IF(isDevice, L.Device_Type, '');
			SELF.DeviceIdentificationProvider	:= IF(isDevice, L.Device_identification_Provider, '');
		END;

		// TRANSACTION 
		iesp.frauddefensenetwork.t_FDNTransaction txTransaction(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			SELF.TransactionID		:= L.Transaction_ID;
			SELF.TransactionType	:= L.Transaction_Type;
			SELF.AmountOfLoss			:= L.Amount_of_Loss;
		END;

		// LICENSED PROFESSIONAL (LP)
		iesp.frauddefensenetwork.t_FDNLicensedProfessional txLicensedProfessional(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isLP:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.LICENSED_PROFESSIONAL;
			SELF.ProfessionalID								:= IF(isLP, L.Professional_ID, '');
			SELF.ProfessionType								:= IF(isLP, L.Profession_Type, '');
			SELF.CorrespondingProfessionalIDs	:= IF(isLP, L.Corresponding_Professional_IDs, '');
			SELF.LicensedPRState							:= IF(isLP, L.Licensed_PR_State, '');
		END;
		
		// PROVIDER (LNPID, NPI, AppendedProviderId)
		iesp.frauddefensenetwork.t_FDNProvider txProvider(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isProvider:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.PROVIDER;
			SELF.LNPID												:= IF(isProvider, L.LNPID, 0);
			SELF.NPI													:= IF(isProvider, L.NPI, '');
			SELF.AppendedProviderId						:= IF(isProvider, L.Appended_Provider_ID, 0);
		END;
		
		// TIN
		iesp.frauddefensenetwork.t_FDNTIN txTIN(FDN_Services.Layouts.raw_rec L) := TRANSFORM
			isTIN:= L.classification_Entity.entity_type_id = FDN_Services.Constants.EntityTypes_Enum.TIN;
			SELF.TIN				:= IF(isTIN, L.TIN, '');
		END;

		//txRecords
		iesp.frauddefensenetwork.t_FDNRecord txRecords(Layouts.raw_rec L) := TRANSFORM
			SELF.Source								:= ROW(source(L));
			SELF.Activity							:= ROW(activity(L));
			SELF.Entity								:= ROW(entity(L));
			SELF.EntityCharacteristics:= ROW(txEntityCharacteristics(L));
			SELF.Business							:= ROW(txBusiness(L));
			SELF.EMail								:= ROW(txEMail(L));
			SELF.IP										:= ROW(txIPAddress(L));
			SELF.Device								:= ROW(txDevice(L));
			SELF.Transaction					:= ROW(txTransaction(L));
			SELF.LicensedProfessional	:= ROW(txLicensedProfessional(L));
			SELF.Provider							:= ROW(txProvider(L));
			SELF.TaxIdentifier				:= ROW(txTIN(L));
			SELF.RecordID							:= L.Record_Id; 
			SELF.EventLocation				:= L.Event_Location; 
			SELF:=[];
		END;

		//MatchDetails
		iesp.frauddefensenetwork.t_FDNMatchDetails matchDetail() := TRANSFORM
			SELF.Records := CHOOSEN(PROJECT(ds_in, txRecords(LEFT)),iesp.Constants.FDN.MAX_COUNT_MATCH_DETAILS);
		END;
				
		//SearchRecord
	  iesp.frauddefensenetwork.t_FDNSearchRecord txSearch() := TRANSFORM
			SELF.MatchDetails := ROW(matchDetail());
			SELF.MatchCounts  := ROW(matchCount());
		END;
				
	iesp.frauddefensenetwork.t_FDNSearchResponse response() := TRANSFORM
		SELF.Records := DATASET([txSearch()]);
	END;
	
// OUTPUT(ds_in, NAMED('ds_in')); 

	RETURN ROW(response());
END;
