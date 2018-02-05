Import ut,tools,inquiry_acclogs,FraudShared,Address; 

EXPORT Build_Base_InquiryLogs (
   string pversion
	,dataset(Layouts.Base.InquiryLogs)  inBaseInquiryLogs   = Files().Base.InquiryLogs.Built
	,dataset(Layouts.Input.InquiryLogs) inInquiryLogsUpdate = Files().Input.InquiryLogs.Sprayed
	,boolean	UpdateInquiryLogs   = _Flags.Update.InquiryLogs
) := 
module 

	Functions.CleanFields(inInquiryLogsUpdate ,inInquiryLogsUpdateUpper); 

		Layouts.Base.InquiryLogs	tPrep(inInquiryLogsUpdateUpper	l,integer	cnt)	:=
	transform
						self.process_date                   	:= (unsigned) l.ProcessDate, 
						self.dt_first_seen								:= (unsigned) l.ProcessDate; 
						self.dt_last_seen									:= (unsigned) l.ProcessDate;
						self.dt_vendor_last_reported				:= (unsigned) l.ProcessDate; 
						self.dt_vendor_first_reported				:= (unsigned) l.ProcessDate; 
						self.Unique_Id										:= 0; 
					  self.source_rec_id								:= 0;																			
						// add  address and name prep 
					  self.current											:= 'C' ; 
						cleanperson73										:= Address.cleanperson73(l.full_name);
						self.cleaned_name.title						:= ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname						:= ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname						:= ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname						:= ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix				:= ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score				:= ut.CleanSpacesAndUpper(cleanperson73[71..73]); 							
						self														:= l; 
						self														:= []; 
   end; 
		
	InquiryLogsUpdate	:=	project(dedup(inInquiryLogsUpdateUpper ,all),tPrep(left,counter));
	
	Mbs_ds := FraudShared.Files().Input.MBS.sprayed(status = 1);

	InquiryLogsSource  := join(		InquiryLogsUpdate,
													Mbs_ds, 
													(unsigned6) left.Client_ID = right.gc_id and 
													right.file_type = Functions.file_type_fn('IDDT') and 
													Functions.ind_type_fn(left.customer_program) = right.ind_type and 
													left.customer_state = right.Customer_State,  
													TRANSFORM(Layouts.Base.InquiryLogs,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT));
	// append rid 
	
	typeof(InquiryLogsSource)  to_form(InquiryLogsSource l) := transform
		SELF.Source_Rec_ID := hash64(ut.CleanSpacesAndUpper(l.Source) + ',' + 
								(string)l.InqLog_ID + ',' + 
								ut.CleanSpacesAndUpper(l.Client_ID) + ',' + 
								ut.CleanSpacesAndUpper(l.Transaction_ID_Number) + ',' + 
								ut.CleanSpacesAndUpper(l.Date_of_Transaction) + ',' + 
								ut.CleanSpacesAndUpper(l.Case_ID) + ',' + 
								(string)l.client_uid + ',' + 
								ut.CleanSpacesAndUpper(l.Customer_Program) + ',' + 
								ut.CleanSpacesAndUpper(l.Reason_for_Transaction_Activity) + ',' + 
								ut.CleanSpacesAndUpper(l.inquiry_source) + ',' + 
								ut.CleanSpacesAndUpper(l.customer_county) + ',' + 
								ut.CleanSpacesAndUpper(l.customer_state) + ',' + 
								ut.CleanSpacesAndUpper(l.customer_agency_vertical_type) + ',' + 
								ut.CleanSpacesAndUpper(l.ssn) + ',' + 
								ut.CleanSpacesAndUpper(l.dob) + ',' + 
								(string)l.lexid + ',' + 
								ut.CleanSpacesAndUpper(l.full_name) + ',' + 
								ut.CleanSpacesAndUpper(l.title) + ',' + 
								ut.CleanSpacesAndUpper(l.first_name) + ',' + 
								ut.CleanSpacesAndUpper(l.middle_name) + ',' + 
								ut.CleanSpacesAndUpper(l.last_name) + ',' + 
								ut.CleanSpacesAndUpper(l.suffix) + ',' + 
								ut.CleanSpacesAndUpper(l.full_address) + ',' + 
								ut.CleanSpacesAndUpper(l.physical_address) + ',' + 
								ut.CleanSpacesAndUpper(l.city) + ',' + 
								ut.CleanSpacesAndUpper(l.state) + ',' + 
								ut.CleanSpacesAndUpper(l.zip) + ',' + 
								ut.CleanSpacesAndUpper(l.county) + ',' + 
								ut.CleanSpacesAndUpper(l.mailing_address) + ',' + 
								ut.CleanSpacesAndUpper(l.mailing_city) + ',' + 
								ut.CleanSpacesAndUpper(l.mailing_state) + ',' + 
								ut.CleanSpacesAndUpper(l.mailing_zip) + ',' + 
								ut.CleanSpacesAndUpper(l.mailing_county) + ',' + 
								ut.CleanSpacesAndUpper(l.phone_number) + ',' + 
								(string)l.ultid + ',' + 
								(string)l.orgid + ',' + 
								(string)l.seleid + ',' + 
								ut.CleanSpacesAndUpper(l.tin) + ',' + 
								ut.CleanSpacesAndUpper(l.Email_Address) + ',' + 
								(string)l.appended_provider_id + ',' + 
								(string)l.lnpid + ',' + 
								ut.CleanSpacesAndUpper(l.npi) + ',' + 
								ut.CleanSpacesAndUpper(l.ip_address) + ',' + 
								ut.CleanSpacesAndUpper(l.device_id) + ',' + 
								ut.CleanSpacesAndUpper(l.professional_id) + ',' + 
								ut.CleanSpacesAndUpper(l.bank_routing_number_1) + ',' + 
								ut.CleanSpacesAndUpper(l.bank_account_number_1) + ',' + 
								ut.CleanSpacesAndUpper(l.Drivers_License_State) + ',' + 
								ut.CleanSpacesAndUpper(l.Drivers_License_Number) + ',' + 
								ut.CleanSpacesAndUpper(l.geo_lat) + ',' + 
								ut.CleanSpacesAndUpper(l.geo_long) + ',' + 
								ut.CleanSpacesAndUpper(l.reported_date)	); 
		self := l;
	end;

	InquiryLogsRid       := project(InquiryLogsSource,to_form(left));														
  // Rollup Update and previous base 
	Pcombined     := If(UpdateInquiryLogs , inBaseInquiryLogs + InquiryLogsRid , InquiryLogsRid); 
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , -source_rec_id, -dt_last_seen,-process_date,record ,local);
			
	Layouts.Base.InquiryLogs RollupUpdate(Layouts.Base.InquiryLogs l, Layouts.Base.InquiryLogs r) := 
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

	
	tools.mac_WriteFile(Filenames(pversion).Base.InquiryLogs.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_InquiryLogs atribute')
	);
	
end;
