import tools, HealthCareFacility,FraudShared, NID, ut; 
EXPORT MapToCommon  (
		string pversion
	 ,dataset(Layouts.Base.SuspectIP)    inBaseSuspectIP     = Files().Base.SuspectIP.Built
	 ,dataset(Layouts.Base.GLB5)         inBaseGLB5          = Files().Base.GLB5.Built
	 ,dataset(Layouts.Base.Tiger)        inBaseTiger         = Files().Base.Tiger.Built
	 ,dataset(Layouts.Base.CFNA)         inBaseCFNA          = Files().Base.CFNA.Built
	 ,dataset(Layouts.Base.TextMinedCrim)inBaseTextMinedCrim = Files().Base.TextMinedCrim.Built
	 ,dataset(Layouts.Base.OIG)          inBaseOIG           = Files().Base.OIG.Built
	 ,dataset(Layouts.Base.AInspection)  inBaseAInspection   = Files().Base.AInspection.Built
	 ,dataset(Layouts.Base.Erie)         inBaseErie          = Files().Base.Erie.Built
) :=
module  
 
 // SuspectIP 
 
 Export		SuspectIP                    := project (inBaseSuspectIP, transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                      := 0 ;
      self.Reported_Date                  := left.Reported_Date;
      self.Reported_time                  := left.Reported_time;		
			self.event_date                     := '';
			self.Reason_Description             := 'MONITORED IP ADDRESSES'; 
			self.source                         := 'SUSPECTIPADDRESS';
		  self.event_location                 :=  tools.AID_Helpers.fRawFixLineLast(
									                            stringlib.stringtouppercase(
																							  trim(left.orig_city) 
																							+ ','
									                            + trim(left.orig_state) 
																							+ ','
																							+ trim(left.orig_country)));
      self.ip_address                     := left.orig_ip;
			self.isp                            := left.orig_isp;

		  self.classification_source.source_type                                  := Mod_MbsContext.SuspectIPFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.SuspectIPPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.SuspectIPExpOfVicEntities;
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.SuspectIPSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.SuspectIPConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.SuspectIPWrkFlowStgComtd; 
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.SuspectIPWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.SuspectIPChannels;
			self.classification_Activity.category_or_fraudtype                      := 'GENERAL';
			self.classification_Activity.description                                := 'MONITORED IP ADDRESSES';
			self.classification_Activity.Threat                                     := Mod_MbsContext.SuspectIPThreat;
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.SuspectIPAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.SuspectIPEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.SuspectIPEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.SuspectIPRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.SuspectIPEvidence;
			self.classification_Entity.investigated_count                           := '';
     self.did                                                                := 0;       
		  self                                                                    := left; 
  	  self                                                                   := [];
	
	)); 

// GLB5 Append Market information 
  inBaseGLB5_dist       := distribute(inBaseGLB5, hash(orig_company_id));
  MBSmarketAppend_dist  := distribute(FraudShared.Files().Input.MBSmarketAppend.Sprayed, hash(company_id));

	Glb5MarketAppend      := join(inBaseGLB5_dist, MBSmarketAppend_dist, left.orig_company_id = right.company_id,
                                              transform(FraudDefenseNetwork.Layouts.base.Glb5,
																							               self.sybase_company_id        := stringlib.stringtouppercase(right.company_id); 
																							               self.sybase_main_country_code := stringlib.stringtouppercase(right.main_country_code); 
																							               self.sybase_bill_country_code := stringlib.stringtouppercase(right.bill_country_code);
																							               self.sybase_app_type          := stringlib.stringtouppercase(right.app_type);
																							               self.sybase_market            := stringlib.stringtouppercase(right.market);
																							               self.sybase_sub_market        := stringlib.stringtouppercase(right.sub_market);
																							               self.sybase_vertical          := stringlib.stringtouppercase(right.vertical) ;
																							               self                          := left; 
																							               self                          := []), left outer, local);


// Source exlusions 

  FilterSet    := ['GOV', 'GOVERNMENT & ACADEMIC', 'GOVERNMENT', 'HEA', 'HEALTHCARE INITIATIVE', 'GOVERNMENT HEALTHCARE', 'INTERNAL', 'HC -   PROVIDER',  'TAX & REVENUE.FEDERAL','HEALTHCARE' , 'PROVIDER', 'PHARMACY' ,'PAYER'];
  SrcExclusion := set(FraudShared.Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0  and status = 1), (string)gc_id); 
	SrcExclusionC := set(FraudShared.Files().Input.MBSSourceGcExclusion.Sprayed (gc_id <>0 and status = 1), (string)company_id); 
  Jfiltered    := Glb5MarketAppend(global_company_id   not in SrcExclusion ); 
	Jfiltered1   := Jfiltered(company_id    not in SrcExclusionC );
  JcountryCode := Jfiltered1(sybase_MAIN_COUNTRY_CODE = 'USA'); 
  Japptype     := JcountryCode(sybase_app_type          not in FilterSet ); 
  Jvertical    := Japptype (sybase_vertical             not in FilterSet ); 
  Jsub_market  := Jvertical(sybase_sub_market           not in FilterSet ); 
  Jmarket      := Jsub_market(sybase_market             not in FilterSet ):persist('temp::glb5_1'); 
   
   dInSegment   := project (Jmarket , transform( FraudDefenseNetwork.Layouts.base.Glb5, 

       self.Industry_segment := map( 
                              left.sybase_app_type in ['INS','AUTO','AIG','LIFE']    => 'INSURANCE' , 
			                        left.sybase_app_type in ['LE','LEG','USLM']      => 'LEGAL' , 
			                        left.sybase_app_type in ['TCOL', 'FCOL', 'COL','COLLECTIONS'] => 'COLLECTIONS' ,
															left.sybase_app_type ='IRB' => 'IRB',
			                        left.sybase_app_type = 'XBPS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'INSURANCE',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'LEGAL',
															left.sybase_app_type = ''  and left.sybase_vertical not in [ 'CORE','','AUTO','USLM'] => left.sybase_vertical ,
			                        left.sybase_app_type = ''  and left.sybase_vertical in [ 'CORE',''] 
															and left.sybase_sub_market = 'PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS' , 'OTHERS'); 
				
				self.sybase_app_type  := map ( 	left.sybase_app_type = ''  and left.sybase_vertical ='LIFE' => 'LIFE',
															left.sybase_app_type = ''  and left.sybase_vertical ='AUTO' => 'AUTO',
															left.sybase_app_type = ''  and left.sybase_vertical ='USLM' => 'USLM',
															left.sybase_app_type = ''  and left.sybase_vertical ='COLLECTIONS' => 'COLLECTIONS',
															left.sybase_app_type = ''  and left.sybase_vertical ='EMERGING' => 'EMERGING',
															left.sybase_app_type = ''  and left.sybase_vertical ='FINANCIAL SERVICES' => 'FINANCIAL SERVICES',
															left.sybase_app_type = ''  and self.Industry_segment ='OTHERS' => 'OTHERS',
															left.sybase_app_type = ''  and left.sybase_sub_market ='PRIVATE INVESTIGATORS' => 'PRIVATE INVESTIGATORS',
															left.sybase_app_type);
				
				self := left ));
				
				 Jdedup       := dedup(dInSegment,(unsigned)linkid, trim(company_id,left,right), trim(global_company_id,left,right) , trim(datetime[1..8],left,right),all ); 

				
 Export		GLB5                    := project (Jdedup , transform(FraudShared.Layouts.Base.Main , 
			
		
			self.Record_ID              := 0 ; 
			self.Customer_ID            := left.Global_company_id;
      self.Sub_Customer_ID        := left.company_id;
      self.Reported_Date          := left.datetime[1..8];
      self.Reported_Time          := '';			
			self.event_date             := '';
      self.Reason_Description     := left.function_description; 
			self.Fraud_Point_Score      := left.fraudpoint_score ; 
			self.raw_title              := '';
	    self.raw_First_Name         := left.orig_fname;
	    self.raw_Middle_Name        := left.orig_mname;
			self.raw_Last_Name          := left.orig_lname;
			self.raw_Orig_Suffix        := left.orig_namesuffix;
			self.raw_Full_name          := left.orig_full_name1; 
			self.SSN                    := left.ssn ; 
			self.DOB                    := left.DOB;
	    self.Drivers_License        := left.dl;
	    self.Drivers_License_State  := left.dl_state ; 
			self.Street_1               := left.orig_addr1; 
	    self.Street_2               := left.orig_lastline1; 
	    self.City                   := left.orig_city1 ; 
	    self.State                  := left.orig_state1; 
	    self.Zip                    := left.orig_zip1; 
      self.Business_Name          := left.orig_company_name1; 
			self.clean_business_name    := trim(left.orig_company_name1,left,right); 
		  self.FEIN                   := left.EIN ; 
		  self.phone_number           := left.phone_number; 
	    self.contact_type           := if(left.personal_phone ='' , 'B', 'I'); 
			self.work_phone             := left.work_phone; 
	    self.Email_Address          := left.email_address;
      self.IP_Address             := left.orig_ip_address2;
			self.source                 := 'GLB5' ; 
		// AID prep 
			self.address_1              :=	left.Address_1;

		  self.address_2              :=  left.Address_2;                         
          
			self.Rawlinkid               := (unsigned) left.linkid ; 
			//self.did                                                                := if(left.did = 0 ,self.Rawlinkid, left.did);  
		 // classification hardcode mapping is used instead of inline dataset ?  	
		  self.classification_source.source_type                                  := Mod_MbsContext.Glb5FileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.Glb5PrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.Glb5ExpOfVicEntities;
			self.classification_source.Industry_segment                             := MAP(left.Industry_segment='COLLECTIONS'          => 'COLLECTIONS',
																																															left.Industry_segment   ='EMERGING'             => 'UNKNOWN/NOT SUPPLIED' ,
																																															left.Industry_segment   ='FINANCIAL SERVICES'   => 'FINANCE',
																																															left.Industry_segment   ='IRB'                  => 'UNKNOWN/NOT SUPPLIED',
																																															left.Industry_segment   ='INSURANCE'            => 'INSURANCE (UNSPECIFIED SEGMENT)',
																																															left.Industry_segment   ='LEGAL'                => 'LEGAL',
																																															left.Industry_segment   ='OTHERS'               => 'UNKNOWN/NOT SUPPLIED',
																																															left.Industry_segment   ='PRIVATE INVESTIGATORS'=> 'PRIVATE INVESTIGATION(UNSPECIFIED SEGMENT)','');
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.Glb5SuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.Glb5ConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.Glb5WrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.Glb5WrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.Glb5Channels;
			self.classification_Activity.category_or_fraudtype                      := 'GENERAL';
			self.classification_Activity.description                                := 'This individual was investigated for potential fraud by professionals from the industry shown against "INDUSTRY SEGMENT" on the date shown against "DATE EVENT REPORTED"';
			self.classification_Activity.Threat                                     := Mod_MbsContext.Glb5Threat; 
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.Glb5AlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.Glb5EntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.Glb5EntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.Glb5Role;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.Glb5Evidence;
			self.classification_Entity.investigated_count                           := '';
		  self.did                                                                := left.did; 
		  self                                                                    := left; 
  	  self                                                                    := [];
	
	)); 
	
// Tiger base to common 

Export		Tiger                   := project (inBaseTiger , transform(FraudShared.Layouts.Base.Main , 
			
			self.Record_ID              := 0 ; 
      self.Customer_Event_ID      := left.CUST_ID_NUM ; 
      self.Reason_Description     := 'IDENTITY FRAUD'; 
			self.Event_Date             := left.app_date ; 
			self.Event_Location         := left.location_identifier; 
			self.raw_title              := '';
	    self.raw_First_Name         := left.First_name;
	    self.raw_Middle_Name        := left.MID_NAME;
			self.raw_Last_Name          := left.Last_Name;
			self.raw_Orig_Suffix        := '';
			self.raw_Full_name          := ''; 
			self.SSN                    := left.SSN ; 
			self.DOB                    := left.DOB;
			self.Street_1               := left.ADDRESS1; 
	    self.Street_2               := ''; 
	    self.City                   := left.City ; 
	    self.State                  := left.State; 
	    self.Zip                    := left.ZipCode; 
		  self.phone_number           := left.home_phone; 
			self.cell_phone             := left.CELL_PHONE ; 
			self.Email_Address          := left.EMAIL;
      self.IP_Address             := left.IP_address;
			self.income                 := left.net_income; 
			self.own_or_rent            := left.OWN_RENT_OTHER; 
			self.Investigation_Referral_Case_ID         := left.App_Number ; 
			self.Customer_Fraud_Code_1  := left.primary_fraud_code; 
			self.source                 := 'TIGER' ; 
			self.vendor_ID              := '18393';
		// AID prep 
			self.address_1              :=	left.Address_1;
		  self.address_2              :=  left.Address_2;              
          
		  self.classification_source.source_type                                  := Mod_MbsContext.TigerFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.TigerPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.TigerExpOfVicEntities;
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.TigerSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.TigerConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.TigerWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.TigerWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.TigerChannels;
			self.classification_Activity.category_or_fraudtype                      := 'IDENTITY FRAUD';
			self.classification_Activity.description                                := '';
			self.classification_Activity.Threat                                     := Mod_MbsContext.TigerThreat;
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.TigerAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.TigerEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.TigerEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.TigerRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.TigerEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self.did                                                                := left.did; 
		  self                                                                    := left; 
  	  self                                                                    := [];
	
	)); 

 // CFNA 
 Export		CFNA                   := project (inBaseCFNA , transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                      := 0 ;
			self.Reason_Description             := 'IDENTITY FRAUD'; 
			self.Vendor_ID                      := left.Vendor_ID; 
			self.customer_event_id              := left.customer_Id ; 
			self.ln_product_id                  := left.LN_Product_ID; 
			self.ln_sub_product_id              := left.LN_Sub_Product_ID ; 
			self.ln_report_date                 := left.Date_Fraud_Reported_LN; 
			self.ln_report_time                 := '';
      self.reported_date                  := '';
			self.event_date                     := left.Date_Application ; 
			self.investigation_referral_case_id := left.Application_ID; 
			self.Rawlinkid                      := left.appended_LexID; 
  		self.raw_first_name                 := left.first_name;
      self.raw_middle_name                := left.middle_name;
      self.raw_last_name                  := left.Last_name ;
      self.raw_orig_suffix                := left.suffix ;
			self.ssn                            := left.ssn ; 
			self.dob                            := left.dob ; 
			self.drivers_license                := left.Driver_License_Number; 
			self.drivers_license_state          := left.Driver_License_State; 
			self.income                         := left.income ; 
			self.own_or_rent                    := left.Own_or_Rent; 
			self.street_1                       := left.street_address; 
			self.city                           := left.city ; 
			self.state                          := left.state ; 
			self.zip                            := left.zip_code; 
			self.phone_number                   := left.phone_number; 
			self.email_address                  := left.Email_Address ; 
			self.ip_address                     := left.IP_Address; 
			self.device_identification_provider := left.device_identification_provider; 
			self.transaction_type               := left.Application_Fraud; 
			self.amount_of_loss                 := left.Gross_Fraud_Dollar_Loss; 
			self.source                         := 'CFNA' ; 
		// AID prep 
			self.address_1                      :=	left.Address_1;

		  self.address_2                      := left.Address_2;                           

		  self.classification_source.source_type                                  := Mod_MbsContext.CFNAFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.CFNAPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.CFNAExpOfVicEntities;
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.CFNASuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.CFNAConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.CFNAWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.CFNAWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.CFNAChannels;
			self.classification_Activity.category_or_fraudtype                      := 'IDENTITY FRAUD';
			self.classification_Activity.description                                := '';
			self.classification_Activity.Threat                                     := Mod_MbsContext.CFNAThreat;
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.CFNAAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.CFNAEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.CFNAEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.CFNARole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.CFNAEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self.did                                                                := left.did; 
		  self                                                                    := left; 
  	  self                                                                    := [];
	
	)); 


 Export		TextMinedCrim                            := project(inBaseTextMinedCrim, transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                      := 0 ;
			self.Reason_Description             := left.charge; 
			self.Vendor_ID                      := left.offender_key; 
			self.offender_key                   := left.offender_key;
			self.event_date                     := left.event_date;
			self.investigation_referral_case_id := left.case_num; 
			self.Rawlinkid                      := 0; 
  		self.raw_first_name                 := left.orig_fname;
      self.raw_middle_name                := left.orig_mname;
      self.raw_last_name                  := left.orig_lname	 ;
      self.raw_orig_suffix                := left.orig_name_suffix;
			self.raw_full_name                  := left.pty_nm; 
			self.ssn                            := left.ssn ; 
			self.dob                            := left.dob ; 
			self.drivers_license                := left.dl_num; 
			self.drivers_license_state          := left.dl_state; 
			self.street_1                       := left.street_address_1; 
			self.street_2                       := left.street_address_2; 
			self.city                           := left.v_city_name ; 
			self.state                          := left.st ; 
			self.zip                            := left.zip5; 
			self.source                         := 'TEXTMINEDCRIM';                                                                                   

		// AID prep 
			self.address_1                      :=	tools.AID_Helpers.fRawFixLine1(
		                                          trim(left.prim_range,left,right) + ' '+ 
																							     trim(left.predir,left,right) + ' ' + 
																							     trim(left.prim_name,left,right) + ' '+ 
																							     trim(left.addr_suffix,left,right) + ' '+ 
																							     trim(left.postdir,left,right) + ' '+ 
																							     trim(left.unit_desig,left,right)+ ' '+
																							     trim(left.sec_range,left,right));

		  self.address_2                      :=  tools.AID_Helpers.fRawFixLineLast(
									                           stringlib.stringtouppercase(trim(left.v_City_name)
									                            + if(left.St != '', ', ', '')
									                            + trim(left.St)
									                            + ' '
									                            + trim(left.zip5)));                           

		  self.classification_source.source_type                                  := Mod_MbsContext.TextMinedCrimFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.TextMinedCrimPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.TextMinedCrimExpOfVicEntities;
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.TextMinedCrimSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.TextMinedCrimConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.TextMinedCrimWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.TextMinedCrimWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.TextMinedCrimChannels;
			self.classification_Activity.category_or_fraudtype                      := left.fraud_type;
			self.classification_Activity.description                                := left.charge;
			self.classification_Activity.Threat                                     := Mod_MbsContext.TextMinedCrimThreat;
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.TextMinedCrimAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.TextMinedCrimEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.TextMinedCrimEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.TextMinedCrimRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.TextMinedCrimEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self.did                                                                := left.did;  
			self                                                                    := left;
  	  self                                                                    := [];
     )); 
		 
 Export		OIG                            := project (inBaseOIG, transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                      := 0 ;
			self.Reason_Description             := left.sancdesc;
			self.event_date                     := left.sancdate;
			self.Rawlinkid                      := 0; 
  		self.raw_first_name                 := left.firstname;
      self.raw_middle_name                := left.midname;
      self.raw_last_name                  := left.lastname	 ;
      self.raw_orig_suffix                := '';
			self.raw_full_name                  := ''; 
			self.ssn                            := left.ssn ; 
			self.dob                            := left.dob ; 
			self.street_1                       := left.address1; 
			self.street_2                       := ''; 
			self.city                           := left.city ; 
			self.state                          := left.state ; 
			self.zip                            := left.zip5; 
			self.address_type                   := if(left.addr_type = 'B','B',''); 
			self.source                         := if(left.addr_type = 'P', 'OIG_INDIVIDUAL','OIG_BUSINESS') ;                                                                             
			self.business_name                  := left.busname;                                                                             
			self.npi                            := left.npi;                                                                             
			self.profession_type                := left.specialty;
		// AID prep 
			self.address_1                      := left.address_1;
		  self.address_2                      := left.address_2;                           

		  self.classification_source.source_type                                  := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualFileType,Mod_MbsContext.OIGBusinessFileType);
			self.classification_source.Primary_source_Entity                        := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualPrimarySrcEntity, Mod_MbsContext.OIGBusinessPrimarySrcEntity); 
			self.classification_source.Expectation_of_Victim_Entities               := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualExpOfVicEntities, Mod_MbsContext.OIGBusinessExpOfVicEntities); 
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualSuspDiscrepancy, Mod_MbsContext.OIGBusinessSuspDiscrepancy); 
			self.classification_Activity.Confidence_that_activity_was_deceitful     := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualConfActivityDeceitful, Mod_MbsContext.OIGBusinessConfActivityDeceitful); 
			self.classification_Activity.workflow_stage_committed                   := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualWrkFlowStgComtd, Mod_MbsContext.OIGBusinessWrkFlowStgComtd); 
			self.classification_Activity.workflow_stage_detected                    := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualWrkFlowStgDetected, Mod_MbsContext.OIGBusinessWrkFlowStgDetected); 
			self.classification_Activity.Channels                                   := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualChannels, Mod_MbsContext.OIGBusinessChannels); 
			self.classification_Activity.category_or_fraudtype                      := 'SANCTIONS DUE TO HEALTHCARE FRAUD';
			self.classification_Activity.description                                := left.sancdesc;
			self.classification_Activity.Threat                                     := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualThreat, Mod_MbsContext.OIGBusinessThreat); 
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualAlertLevel, Mod_MbsContext.OIGBusinessAlertLevel);
			self.classification_Entity.Entity_type                                  := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualEntityType, Mod_MbsContext.OIGBusinessEntityType);
			self.classification_Entity.Entity_sub_type                              := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualEntitySubType, Mod_MbsContext.OIGBusinessEntitySubType);
			self.classification_Entity.role                                         := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualRole, Mod_MbsContext.OIGBusinessRole);
			self.classification_Entity.Evidence                                     := if(left.addr_type = 'P', Mod_MbsContext.OIGIndividualEvidence, Mod_MbsContext.OIGBusinessEvidence);
			self.classification_Entity.investigated_count                           := '';
      self.clean_business_name                                                := left.clean_business_name;       
      self.bdid                                                              := left.bdid;       
      self.dotid                                                             := left.dotid;
      self.dotscore                                                          := left.dotscore;
      self.dotweight                                                         := left.dotweight;
      self.empid                                                             := left.empid;
      self.empscore                                                          := left.empscore;
      self.empweight                                                         := left.empweight;
      self.powid                                                             := left.powid;
      self.powscore                                                          := left.powscore;
      self.powweight                                                         := left.powweight;
      self.proxid                                                            := left.proxid;
      self.proxscore                                                         := left.proxscore;
      self.proxweight                                                        := left.proxweight;
      self.seleid                                                            := left.seleid;
      self.selescore                                                         := left.selescore;
      self.seleweight                                                        := left.seleweight;
      self.orgid                                                             := left.orgid;
      self.orgscore                                                          := left.orgscore;
      self.orgweight                                                         := left.orgweight;
      self.ultid                                                             := left.ultid;
      self.ultscore                                                          := left.ultscore;
      self.ultweight                                                         := left.ultweight;      
      self.lnpid                                                             := left.lnpid;
		  self.did                                                                := left.did; 
		  self                                                                    := left; 
  	  self                                                                    := [];
	));
 
 // Address Inspection
 Export		AInspection                    := project (inBaseAInspection(length(trim(state,left,right)) <3), transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                      := 0 ;
			self.ln_report_date                 := left.dt_first_reported; 
      self.Reported_Date                  := left.dt_last_reported;
			self.event_date                     := '';
			self.Reason_Description             := left.comments; 
			self.street_1                       := left.address; 
			self.street_2                       := left.suffix; 
			self.city                           := left.city ; 
			self.state                          := left.state ; 
			self.zip                            := stringlib.stringfilterout(trim(left.zip_code,left,right),'-'); 
			self.source                         := 'ADDRESSINSPECTION';                                                                                   
		// AID prep 
			self.address_1                      :=	left.address_1;
		  self.address_2                      := left.address_2;                          

		  self.classification_source.source_type                                  := Mod_MbsContext.ainspectionFileType; 
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.ainspectionPrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.ainspectionExpOfVicEntities;
			self.classification_source.Industry_segment                             := '';
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.ainspectionSuspDiscrepancy;
			self.classification_Activity.Confidence_that_activity_was_deceitful     := Mod_MbsContext.ainspectionConfActivityDeceitful;
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.ainspectionWrkFlowStgComtd;
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.ainspectionWrkFlowStgDetected;
			self.classification_Activity.Channels                                   := Mod_MbsContext.ainspectionChannels;
			self.classification_Activity.category_or_fraudtype                      := 'GENERAL';
			self.classification_Activity.description                                := '';
			self.classification_Activity.Threat                                     := Mod_MbsContext.ainspectionThreat;
			self.classification_Activity.Exposure                                   := '';
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '';
			self.classification_Activity.Alert_level                                := Mod_MbsContext.ainspectionAlertLevel;
			self.classification_Entity.Entity_type                                  := Mod_MbsContext.ainspectionEntityType;
			self.classification_Entity.Entity_sub_type                              := Mod_MbsContext.ainspectionEntitySubType;
			self.classification_Entity.role                                         := Mod_MbsContext.ainspectionRole;
			self.classification_Entity.Evidence                                     := Mod_MbsContext.ainspectionEvidence;
			self.classification_Entity.investigated_count                           := '';
     self.did                                                                 := 0;       
			self                                                                    := left; 
  	  self                                                                    := [];
	
	));  
	
//Erie
 Export		Erie                                := project (inBaseErie, transform(FraudShared.Layouts.Base.Main , 

      self.Record_ID                          := 0 ;
			self.Reason_Description                 := '';
		  self.reported_date                      := map(	left.dateofreferral <>'' => left.dateofreferral ,
																											left.dateofloss     <>'' => left.dateofloss ,
																											left.dateio         <>'' => left.dateio ,
																											left.dateclosed     <>'' => left.dateclosed ,
																											left.datereopen     <>'' => left.datereopen ,
																											left.datecalc);													
			self.event_date                         := map(	left.dateofloss     <>'' => left.dateofloss ,
																											left.dateofreferral <>'' => left.dateofreferral ,
																											left.dateio         <>'' => left.dateio ,
																											left.dateclosed     <>'' => left.dateclosed ,
																											left.datereopen     <>'' => left.datereopen ,
																											left.datecalc);
		  self.event_location                     := left.state;
		  self.event_type_1                       := left.typeofloss;
		  self.investigation_referral_date_opened := left.dateio;
		  self.investigation_referral_date_closed := left.dateclosed;
		  self.customer_fraud_code_1              := left.findings;
		  self.disposition                        := if(left.filestatus <>'', stringlib.stringtouppercase(left.filestatus), 'O');
		  self.mitigated                          := if(left.savingstype in ['C','D','O','R','W'],'Y','N');
			SumAllSavings                           := SUM((decimal11_2)left.compsavings, (decimal11_2)left.deniedsavings, 
			                                               (decimal11_2)left.withdrawnsavings,(decimal11_2)left.recdsavings);
		  self.mitigated_amount                   := '$' + (string)ut.IntWithCommas((integer)(SumAllSavings));
		  self.external_referral_or_casenumber    := map(left.lawenf = 'Y' and left.lawref = 'F' => 'LAWENF_FEDERAL',
																										 left.lawenf = 'Y' and left.lawref = 'S' => 'LAWENF_STATE',
																										 left.lawenf = 'Y' and left.lawref = 'L' => 'LAWENF_LOCAL',
																										 left.lawenf = 'Y' and left.lawref = ''  => 'LAWENF_NOINFO',
																										 left.nicb = 'Y'                         => 'NICB',
																										 left.attorney = 'Y'                     => 'ATTORNEY',
																										 '');
			IsErieInsMapIndiv                      := left.TypeOfMapping = 'ERIE_INSURED_MAPPING' and (left.insuredfirstname <> '' and left.insuredlastName <> '');
			IsErieInsMapBusi                       := left.TypeOfMapping = 'ERIE_INSURED_MAPPING' and (left.insuredfirstname = '' and left.insuredlastName <> '');
			
			IsEriePartyMapIndivUnk                 := left.TypeOfMapping = 'ERIE_PARTY_MAPPING' and (left.entity ='PERSON' or left.entity ='UNKNOWN');
			IsEriePartyMapBusi                     := left.TypeOfMapping = 'ERIE_PARTY_MAPPING' and left.entity ='BUSINESS';
			
			RawFirstName                           := map(IsErieInsMapIndiv                            => left.insuredfirstName,
			                                              IsEriePartyMapIndivUnk                       => left.name_first,
			                                               '');  
			
			self.raw_first_name                    := RawFirstName; 
			
      self.raw_middle_name                   := '';
			
			RawLastName                            := map(IsErieInsMapIndiv                            => left.insuredlastName,
		                                                IsEriePartyMapIndivUnk                       => left.name_last,
			                                                ''); 
																											
			self.raw_last_name                     := RawLastName; 
			
      self.raw_orig_suffix                   := '';
			
			self.raw_full_name                     := trim(trim(RawFirstName,left,right)  + ' ' + trim(RawLastName,left,right),left, right);
			self.ssn                               := left.ssn; 
			self.dob                               := left.dob; 
			self.street_1                          := left.o_address; 
			self.street_2                          := ''; 
			self.city                              := left.o_city; 
			self.state                             := left.o_state; 
			self.zip                               := left.o_zip; 
			self.source                            := 'ERIE'; 
			  
			prepInsLastName                        := regexreplace(constants().special_char_bname, left.insuredlastName, '');
			prepName_last                          := regexreplace(constants().special_char_bname, left.name_last, '');
			
			self.business_name                     := map(IsErieInsMapBusi                            => left.insuredlastName,
			                                              IsEriePartyMapBusi                          => left.name_last,
			                                               '');                                                                              
			self.clean_business_name               := map(IsErieInsMapBusi                            => NID.clnBizName(prepInsLastName),
			                                              IsEriePartyMapBusi                          => NID.clnBizName(prepName_last),
			                                               ''); 
			self.tin                               := left.tin;    
			self.transaction_id                    := left.claimnumber;    
			self.transaction_type                  := left.responsibleparty;    
		// AID prep 
			self.address_1                         := left.address_1;
		  self.address_2                         := left.address_2; 
			
     self.classification_source.source_type                                  := Mod_MbsContext.ErieFileType;
			self.classification_source.Primary_source_Entity                        := Mod_MbsContext.EriePrimarySrcEntity; 
			self.classification_source.Expectation_of_Victim_Entities               := Mod_MbsContext.ErieExpOfVicEntities; 
			ErieIndSegment                                                          := Functions.Erie_IndustrySegment(left.typeofloss);
			self.classification_source.Industry_segment                             := ErieIndSegment;
			self.classification_Activity.Suspected_Discrepancy                      := Mod_MbsContext.ErieSuspDiscrepancy; 			
			IsErieInsuredMapping                                                    := left.TypeOfMapping = 'ERIE_INSURED_MAPPING';
			self.classification_Activity.Confidence_that_activity_was_deceitful     := if(IsErieInsuredMapping, Functions.Erie_ConfActivityDeceitful(left.findings),Mod_MbsContext.ErieConfActivityDeceitful_ne);
      self.classification_Activity.Confidence_that_activity_was_deceitful_id  := if(IsErieInsuredMapping, Functions.Erie_ConfActivityDeceitful_id(left.findings),Mod_MbsContext.ErieConfActivityDeceitful_ne_id);
			self.classification_Activity.workflow_stage_committed                   := Mod_MbsContext.ErieWrkFlowStgComtd; 
			self.classification_Activity.workflow_stage_detected                    := Mod_MbsContext.ErieWrkFlowStgDetected; 
			self.classification_Activity.Channels                                   := Mod_MbsContext.ErieChannels; 
			self.classification_Activity.category_or_fraudtype                      := 'UNKNOWN';
			ErieDesc                                                                := 'CLAIM' + ' ' + ErieIndSegment + ' ' + Functions.Erie_SubType(left.typeofloss);
			self.classification_Activity.description                                := if(IsErieInsuredMapping, ErieDesc ,'');
			self.classification_Activity.Threat                                     := Mod_MbsContext.ErieThreat;
			self.classification_Activity.Exposure                                   := if(IsErieInsuredMapping, '$'+ (string)ut.IntWithCommas((integer)left.initialamountowed),'');
			self.classification_Activity.write_off_loss                             := '';
			self.classification_Activity.Mitigated                                  := '$' + (string)ut.IntWithCommas((integer)(SumAllSavings));
			self.classification_Activity.Alert_level                                := Mod_MbsContext.ErieAlertLevel;
			self.classification_Entity.Entity_type                                  := Functions.Erie_EntityType(left.entity);
      self.classification_Entity.Entity_type_id                               := Functions.Erie_EntityType_id(left.entity);
			self.classification_Entity.Entity_sub_type                              := if(IsErieInsuredMapping, '', Mod_MbsContext.ErieEntitySubType_AsscP);
      self.classification_Entity.Entity_sub_type_id                           := if(IsErieInsuredMapping,  0, Mod_MbsContext.ErieEntitySubType_AsscP_id);
			self.classification_Entity.role                                         := if(IsErieInsuredMapping, Mod_MbsContext.ErieRole_Susp, '');
			self.classification_Entity.role_id                                      := if(IsErieInsuredMapping, Mod_MbsContext.ErieRole_Susp_id, 0);
			self.classification_Entity.Evidence                                     := Mod_MbsContext.ErieEvidence;
			self.classification_Entity.investigated_count                           := '';
		  self.did                                                                := left.did;  
			self                                                                    := left;
  	  self                                                                    := [];
	));
	
 
// Append MBS classification attributes 

  CombinedClassification := Functions.Classification(SuspectIP + GLB5 + Tiger + CFNA + TextMinedCrim + OIG + AInspection + Erie) ; 
	
	// append rid 
	
	typeof(CombinedClassification)  to_form(CombinedClassification l) := transform
	
	 prefix                      := MAP( l.source= 'GLB5'             =>  1000000000000,
								                       l.source= 'TIGER'            =>  2000000000000,
																			 l.source= 'CFNA'             =>  3000000000000,
																			 l.source= 'TEXTMINEDCRIM'    =>  400000000000,
																			 l.source= 'ERIE'             =>  5000000000000,
																			 l.source= 'ADDRESSINSPECTION'=>  6000000000000,  
																			 l.source= 'SUSPECTIPADDRESS' =>  7000000000000, 
																			 l.source= 'OIG_INDIVIDUAL'   =>  8000000000000, 
																			 l.source= 'OIG_BUSINESS'     =>  9000000000000, 
								                      0);
	SELF.Record_ID               := prefix +  L.source_rec_id;  
	self := l;
  end;

 combined       := project(CombinedClassification,to_form(left));
 // Filter header records
NewBaseRid := combined (Customer_event_id not in ['CUST_ID_NUM','CUSTOMERID']);
EXPORT Build_Base_Shared_Main := FraudShared.Build_Base_Main(pversion,NewBaseRid);

END;