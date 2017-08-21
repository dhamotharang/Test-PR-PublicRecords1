import tools, FraudShared; 
EXPORT MapToCommon  (
	 string pversion
	,dataset(Layouts.Base.IdentityData)         inBaseIdentityData        = Files().Base.IdentityData.Built
	,dataset(Layouts.Base.KnownFraud)         	inBaseKnownFraud         	= Files().Base.KnownFraud.Built
) :=
module  
 
 Export		IdentityData                    := project (inBaseIdentityData , transform(FraudShared.Layouts.Base.Main , 
			self.Record_ID              := 0; 
			self.customer_id						:= left.Client_ID;
      self.Sub_Customer_ID        := ''; //????????
			self.ln_report_date					:= left.Date_of_Transaction[1..8];
			self.Reported_Date					:= left.Date_of_Transaction[1..8];
			self.Event_Date							:= left.Date_of_Transaction[1..8];
      self.Reported_Time          := '';			
      self.Reason_Description			:= left.Reason_for_Transaction_Activity;
			self.Fraud_Point_Score      := ''; //???????? 
			self.raw_title              := left.Title;
	    self.raw_First_Name         := left.First_name;
	    self.raw_Middle_Name        := left.Middle_Name;
			self.raw_Last_Name          := left.Last_Name;
			self.raw_Orig_Suffix        := left.Suffix;
			self.raw_Full_name          := left.Full_Name; 
	    self.Drivers_License        := left.Drivers_License_Number;
			self.Street_1               := left.Physical_Address_1;
	    self.Street_2               := left.Physical_Address_2;
      self.Business_Name          := left.Customer_Name; 
			self.clean_business_name    := trim(left.Customer_Name,left,right); 
		  self.FEIN                   := ''; //???????? 
			self.work_phone             := '';
		// AID prep 
			self.address_1              :=	tools.AID_Helpers.fRawFixLine1(
		                                          trim(left.Physical_Address_1) + ' ' +
		                                          trim(left.Physical_Address_2));
		  self.address_2              :=  tools.AID_Helpers.fRawFixLineLast(
									                           stringlib.stringtouppercase(trim(left.city)
									                            + if(left.state != '', ', ', '')
									                            + trim(left.state)
									                            + ' '
									                            + trim(left.zip)[1..5]));                                          
			self.Rawlinkid              := 0; //???????? 
			//IdentityData
			self.transaction_id					:= left.Transaction_ID_Number;
			self.clean_address.geo_lat 	:= left.geo_lat;
			self.clean_address.geo_long	:= left.geo_long; 
			self.investigation_referral_case_id := left.Case_ID;
			//self.did                                                                := if(left.did = 0 ,self.Rawlinkid, left.did);  
		 // classification hardcode mapping is used instead of inline dataset ?  	
		  self.classification_source.source_type                                  := Mod_MbsContext.IdentityDataFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.IdentityDataPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.IdentityDataExpOfVicEntities;
			self.classification_source.Industry_segment                             := ''; //????????
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.IdentityDataSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.IdentityDataConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.IdentityDataWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.IdentityDataWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.IdentityDataChannels;
			self.classification_Activity.category_or_fraudtype                      := 'GENERAL';
			self.classification_Activity.description                                := 'This individual was investigated for potential fraud by professionals from the industry shown against "INDUSTRY SEGMENT" on the date shown against "DATE EVENT REPORTED"';
			self.classification_Activity.Threat                                     := Mod_MbsContext.IdentityDataThreat; 
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.IdentityDataAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.IdentityDataEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.IdentityDataEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.IdentityDataRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.IdentityDataEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self:= left; 
  	  self:= [];
	)); 
 
  Export		KnownFraud                    := project (inBaseKnownFraud , transform(FraudShared.Layouts.Base.Main , 
			self.Record_ID              := 0;  //????????
			self.customer_id						:= left.client_id;
      self.Sub_Customer_ID        := ''; //????????
			self.ln_report_date					:= left.reported_date;
      self.Reason_Description			:= left.reason_description;
			self.Fraud_Point_Score      := ''; //???????? 
			self.raw_title              := left.Title;
	    self.raw_First_Name         := left.First_name;
	    self.raw_Middle_Name        := left.Middle_Name;
			self.raw_Last_Name          := left.Last_Name;
			self.raw_Orig_Suffix        := left.orig_suffix;
			self.raw_Full_name          := left.Full_Name; 
			self.Street_1               := left.physical_address_1;
	    self.Street_2               := left.physical_address_2;
			self.clean_business_name    := trim(left.business_name,left,right); 
		// AID prep 
			self.address_1              :=	tools.AID_Helpers.fRawFixLine1(
		                                          trim(left.Physical_Address_1) + ' ' +
		                                          trim(left.Physical_Address_2));
		  self.address_2              :=  tools.AID_Helpers.fRawFixLineLast(
									                           stringlib.stringtouppercase(trim(left.city)
									                            + if(left.state != '', ', ', '')
									                            + trim(left.state)
									                            + ' '
									                            + trim(left.zip)[1..5]));                                  
			self.Rawlinkid              := 0; //???????? 
			//IdentityData
			self.transaction_id					:= left.customer_event_id;
			self.Drivers_License 				:= left.drivers_license_number;
			self.clean_address.geo_lat 	:= ''; //???????? 
			self.clean_address.geo_long	:= ''; //???????? 
			self.investigation_referral_case_id := left.investigation_referral_case_id;
			//self.did                                                                := if(left.did = 0 ,self.Rawlinkid, left.did);  
		 // classification hardcode mapping is used instead of inline dataset ?  	
		  self.classification_source.source_type                                  := Mod_MbsContext.KnownFraudFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.KnownFraudPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.KnownFraudExpOfVicEntities;
			self.classification_source.Industry_segment                             := ''; //????????
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.KnownFraudSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.KnownFraudConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.KnownFraudWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.KnownFraudWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.KnownFraudChannels;
			self.classification_Activity.category_or_fraudtype                      := 'GENERAL';
			self.classification_Activity.description                                := 'This individual was investigated for potential fraud by professionals from the industry shown against "INDUSTRY SEGMENT" on the date shown against "DATE EVENT REPORTED"';
			self.classification_Activity.Threat                                     := Mod_MbsContext.KnownFraudThreat; 
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.KnownFraudAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.KnownFraudEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.KnownFraudEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.KnownFraudRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.KnownFraudEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self:= left; 
  	  self:= [];
	)); 
// Append MBS classification attributes 

  CombinedClassification := Functions.Classification(IdentityData + KnownFraud) ; 
	
	// append rid 
	
	typeof(CombinedClassification)  to_form(CombinedClassification l) := transform
	
	 prefix                      := MAP( l.source= 'IDDT'             =>  1000000000000,
																			 l.source= 'KNFD'             =>  2000000000000,
								                      0);
	SELF.Record_ID               := prefix +  L.source_rec_id;  
	self := l;
  end;

 combined       := project(CombinedClassification,to_form(left));
 // Filter header records
 NewBaseRid := combined (Customer_event_id not in ['CUST_ID_NUM','CUSTOMERID']);

 EXPORT Build_Base_Main := FraudShared.Build_Base_Main(pversion,NewBaseRid);

END;