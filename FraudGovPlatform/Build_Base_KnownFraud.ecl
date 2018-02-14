Import ut,tools,inquiry_acclogs,FraudShared,Address; 

EXPORT Build_Base_KnownFraud (
   string pversion
	,dataset(Layouts.Base.KnownFraud)  inBaseKnownFraud   = Files().Base.KnownFraud.Built
	,dataset(Layouts.Input.KnownFraud) inKnownFraudUpdate = Files().Input.KnownFraud.Sprayed
	,boolean	UpdateKnownFraud   = _Flags.Update.KnownFraud
) := 
module 

	Functions.CleanFields(inKnownFraudUpdate ,inKnownFraudUpdateUpper); 

		Layouts.Base.KnownFraud	tPrep(inKnownFraudUpdateUpper	pInput,integer	cnt)	:=
	transform
				
						self.process_date                   	:= (unsigned) pInput.ProcessDate, 
						self.dt_first_seen								:= (unsigned) pInput.ProcessDate; 
						self.dt_last_seen									:= (unsigned) pInput.ProcessDate;
						self.dt_vendor_last_reported				:= (unsigned) pInput.ProcessDate; 
						self.dt_vendor_first_reported				:= (unsigned) pInput.ProcessDate; 
						self.Unique_Id										:= 0; 
					  self.source_rec_id								:= 0;
																										
						// add  address and name prep 
					  self.current											:= 'C' ; 
						cleanperson73										:= Address.cleanperson73(if(pInput.full_name <> '',pInput.full_name, pInput.first_name + ' ' + pInput.middle_name + ' ' + pInput.last_name));
						self.cleaned_name.title						:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname						:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname						:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname						:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix				:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score				:= ut.CleanSpacesAndUpper(cleanperson73[71..73]); 							
						self														:= pInput; 
						self														:= []; 
   end; 
		
	KnownFraudUpdate	:=	project(dedup(inKnownFraudUpdateUpper ,all),tPrep(left,counter));
	
	Mbs_ds := FraudShared.Files().Input.MBS.sprayed(status = 1);
	
	KnownFraudSource  := join(	KnownFraudUpdate + FraudGovPlatform.Build_Base_NAC(pversion).NACKNFDUpdate,
												Mbs_ds, 
												(unsigned6) left.Client_ID = right.gc_id and 
												right.file_type = Functions.file_type_fn('KNFD') and 
												Functions.ind_type_fn(left.customer_program) = right.ind_type and 
												left.customer_state = right.Customer_State,  
												TRANSFORM(Layouts.Base.KnownFraud,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT));


	// append rid 
	
	typeof(KnownFraudSource)  to_form(KnownFraudSource l) := transform
		SELF.Source_Rec_ID := hash64(ut.CleanSpacesAndUpper(l.Source) + ',' + 
								ut.CleanSpacesAndUpper(l.customer_name) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_account_number) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_state) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_county) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_agency) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_agency_vertical_type) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_event_id) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_date) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_time) + ',' +  
								ut.CleanSpacesAndUpper(l.reported_by) + ',' +  
								ut.CleanSpacesAndUpper(l.event_date) + ',' +  
								ut.CleanSpacesAndUpper(l.event_end_date) + ',' +  
								ut.CleanSpacesAndUpper(l.event_location) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_1) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_2) + ',' +  
								ut.CleanSpacesAndUpper(l.event_type_3) + ',' +  
								(string) l.case_id + ',' +  
								ut.CleanSpacesAndUpper(l.client_id) + ',' +  
								ut.CleanSpacesAndUpper(l.head_of_household_indicator) + ',' +  
								ut.CleanSpacesAndUpper(l.relationship_indicator) + ',' +  
								(string)l.lexid + ',' +  
								ut.CleanSpacesAndUpper(l.title) + ',' +  
								ut.CleanSpacesAndUpper(l.first_name) + ',' +  
								ut.CleanSpacesAndUpper(l.middle_name) + ',' +  
								ut.CleanSpacesAndUpper(l.last_name) + ',' +  
								ut.CleanSpacesAndUpper(l.orig_suffix) + ',' +  
								ut.CleanSpacesAndUpper(l.full_name) + ',' +  
								ut.CleanSpacesAndUpper(l.name_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.ssn) + ',' +  
								ut.CleanSpacesAndUpper(l.ssn_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.dob) + ',' +  
								ut.CleanSpacesAndUpper(l.dob_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.Drivers_License_Number) + ',' +  
								ut.CleanSpacesAndUpper(l.Drivers_License_State) + ',' +  
								ut.CleanSpacesAndUpper(l.drivers_license_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.physical_address_1) + ',' +  
								ut.CleanSpacesAndUpper(l.physical_address_2) + ',' +  
								ut.CleanSpacesAndUpper(l.city) + ',' +  
								ut.CleanSpacesAndUpper(l.state) + ',' +  
								ut.CleanSpacesAndUpper(l.zip) + ',' +  
								ut.CleanSpacesAndUpper(l.physical_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_address_1) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_address_2) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_city) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_state) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_zip) + ',' +  
								ut.CleanSpacesAndUpper(l.mailing_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.address_date) + ',' +  
								ut.CleanSpacesAndUpper(l.address_type) + ',' +  
								ut.CleanSpacesAndUpper(l.county) + ',' +  
								ut.CleanSpacesAndUpper(l.phone_number) + ',' +  
								ut.CleanSpacesAndUpper(l.phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.cell_phone) + ',' +  
								ut.CleanSpacesAndUpper(l.cell_phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.work_phone) + ',' +  
								ut.CleanSpacesAndUpper(l.work_phone_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_type) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_date) + ',' +  
								ut.CleanSpacesAndUpper(l.carrier) + ',' +  
								ut.CleanSpacesAndUpper(l.contact_location) + ',' +  
								ut.CleanSpacesAndUpper(l.contact) + ',' +  
								ut.CleanSpacesAndUpper(l.call_records) + ',' +  
								ut.CleanSpacesAndUpper(l.in_service) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.email_address_type) + ',' +  
								ut.CleanSpacesAndUpper(l.email_date) + ',' +  
								ut.CleanSpacesAndUpper(l.host) + ',' +  
								ut.CleanSpacesAndUpper(l.alias) + ',' +  
								ut.CleanSpacesAndUpper(l.location) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address_fraud_code) + ',' +  
								ut.CleanSpacesAndUpper(l.ip_address_date) + ',' +  
								ut.CleanSpacesAndUpper(l.version) + ',' +  
								ut.CleanSpacesAndUpper(l.isp) + ',' +  
								ut.CleanSpacesAndUpper(l.device_id) + ',' +  
								ut.CleanSpacesAndUpper(l.device_date) + ',' +  
								ut.CleanSpacesAndUpper(l.device_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.unique_number) + ',' +  
								ut.CleanSpacesAndUpper(l.mac_address) + ',' +  
								ut.CleanSpacesAndUpper(l.serial_number) + ',' +  
								ut.CleanSpacesAndUpper(l.device_type) + ',' +  
								ut.CleanSpacesAndUpper(l.device_identification_provider) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_routing_number_1) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_number_1) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_1_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_routing_number_2) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_number_2) + ',' +  
								ut.CleanSpacesAndUpper(l.bank_account_2_risk_code) + ',' +  
								(string)l.appended_provider_id + ',' +  
								ut.CleanSpacesAndUpper(l.business_name) + ',' +  
								ut.CleanSpacesAndUpper(l.tin) + ',' +  
								ut.CleanSpacesAndUpper(l.fein) + ',' +  
								ut.CleanSpacesAndUpper(l.npi) + ',' +  
								ut.CleanSpacesAndUpper(l.tax_preparer_id) + ',' +  
								ut.CleanSpacesAndUpper(l.business_type_1) + ',' +  
								ut.CleanSpacesAndUpper(l.business_date) + ',' +  
								ut.CleanSpacesAndUpper(l.business_risk_code) + ',' +  
								ut.CleanSpacesAndUpper(l.Customer_Program) + ',' +  
								ut.CleanSpacesAndUpper(l.start_date) + ',' +  
								ut.CleanSpacesAndUpper(l.end_date) + ',' +  
								ut.CleanSpacesAndUpper(l.amount_paid) + ',' +  
								ut.CleanSpacesAndUpper(l.region_code) + ',' +  
								ut.CleanSpacesAndUpper(l.investigator_id) + ',' +  
								ut.CleanSpacesAndUpper(l.reason_description) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_case_id) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_date_opened) + ',' +  
								ut.CleanSpacesAndUpper(l.investigation_referral_date_closed) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_fraud_code_1) + ',' +  
								ut.CleanSpacesAndUpper(l.customer_fraud_code_2) + ',' +  
								ut.CleanSpacesAndUpper(l.type_of_referral) + ',' +  
								ut.CleanSpacesAndUpper(l.referral_reason) + ',' +  
								ut.CleanSpacesAndUpper(l.disposition) + ',' +  
								ut.CleanSpacesAndUpper(l.mitigated) + ',' +  
								ut.CleanSpacesAndUpper(l.mitigated_amount) + ',' +  
								ut.CleanSpacesAndUpper(l.external_referral_or_casenumber) + ',' +  
								ut.CleanSpacesAndUpper(l.cleared_fraud) + ',' +  
								ut.CleanSpacesAndUpper(l.reason_cleared_code));		 
		self := l;
	end;
	KnownFraudRid       := project(KnownFraudSource,to_form(left));		
	
  // Rollup Update and previous base 
	Pcombined     := If(UpdateKnownFraud , inBaseKnownFraud + KnownFraudRid , KnownFraudRid); 	
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , -source_rec_id, -dt_last_seen,-process_date,record ,local);
			
	Layouts.Base.KnownFraud RollupUpdate(Layouts.Base.KnownFraud l, Layouts.Base.KnownFraud r) := 
	transform
		SELF.dt_first_seen := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		SELF.dt_last_seen := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous rid 
		self.current := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self := l;
	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,Record																						
														,except process_date, dt_first_seen ,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported, source_rec_id ,local
										);

	
	tools.mac_WriteFile(Filenames(pversion).Base.KnownFraud.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);
	
end;
