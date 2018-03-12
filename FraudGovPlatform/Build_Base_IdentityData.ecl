Import ut,tools,inquiry_acclogs,FraudShared,Address; 

EXPORT Build_Base_IdentityData (
   string pversion
	,dataset(Layouts.Base.IdentityData)  inBaseIdentityData   = Files().Base.IdentityData.Built
	,dataset(Layouts.Input.IdentityData) inIdentityDataUpdate = Files().Input.IdentityData.Sprayed
	,boolean	UpdateIdentityData   = _Flags.Update.IdentityData
) := 
module 

	Functions.CleanFields(inIdentityDataUpdate ,inIdentityDataUpdateUpper); 

		Layouts.Base.IdentityData	tPrep(inIdentityDataUpdateUpper	l,integer	cnt)	:=
	transform
				
						self.process_date                   	:= (unsigned) l.ProcessDate, 
						self.dt_first_seen								:= (unsigned) l.ProcessDate; 
						self.dt_last_seen									:= (unsigned) l.ProcessDate;
						self.dt_vendor_last_reported				:= (unsigned) l.ProcessDate; 
						self.dt_vendor_first_reported				:= (unsigned) l.ProcessDate; 
						self.Unique_Id										:= 0; 
					  self.source_rec_id								:= 0;																	
						// add  address and name prep -- new change
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
		
	IdentityDataUpdate	:=	project(dedup(inIdentityDataUpdateUpper ,all),tPrep(left,counter));
	
	Mbs_ds := FraudShared.Files().Input.MBS.sprayed(status = 1);

	IdentityDataSource  := join(	IdentityDataUpdate + FraudGovPlatform.Build_Base_NAC(pversion).NACIDDTUpdate,
													Mbs_ds, 
													(unsigned6) left.Client_ID = right.gc_id and 
													right.file_type = Functions.file_type_fn('IDDT') and 
													Functions.ind_type_fn(left.customer_program) = right.ind_type and 
													left.customer_state = right.Customer_State,  
													TRANSFORM(Layouts.Base.IdentityData,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT) ,lookup); 

	// append rid 
	
	typeof(IdentityDataSource)  to_form(IdentityDataSource l) := transform
		SELF.Source_Rec_ID := hash64(
									ut.CleanSpacesAndUpper(l.Source) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_Name) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_Account_Number) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_State) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_County) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_Agency) + ',' + 														
									ut.CleanSpacesAndUpper(l.Customer_Agency_Vertical_Type) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_Program) + ',' + 
									ut.CleanSpacesAndUpper(l.Customer_Job_ID) + ',' + 
									ut.CleanSpacesAndUpper(l.Batch_Record_ID) + ',' + 
									ut.CleanSpacesAndUpper(l.Transaction_ID_Number) + ',' + 
									ut.CleanSpacesAndUpper(l.Reason_for_Transaction_Activity) + ',' + 	
									ut.CleanSpacesAndUpper(l.Date_of_Transaction) + ',' + 												
									(string)l.LexID + ',' + 
									ut.CleanSpacesAndUpper(l.Full_Name) + ',' + 
									ut.CleanSpacesAndUpper(l.Title) + ',' + 
									ut.CleanSpacesAndUpper(l.First_name) + ',' + 
									ut.CleanSpacesAndUpper(l.Middle_Name) + ',' + 
									ut.CleanSpacesAndUpper(l.Last_Name) + ',' + 
									ut.CleanSpacesAndUpper(l.Suffix) + ',' + 
									ut.CleanSpacesAndUpper(l.SSN) + ',' + 
									ut.CleanSpacesAndUpper(l.SSN4) + ',' + 
									ut.CleanSpacesAndUpper(l.Address_Type) + ',' + 
									ut.CleanSpacesAndUpper(l.Physical_Address_1) + ',' + 
									ut.CleanSpacesAndUpper(l.Physical_Address_2) + ',' + 
									ut.CleanSpacesAndUpper(l.City) + ',' + 
									ut.CleanSpacesAndUpper(l.State) + ',' + 
									ut.CleanSpacesAndUpper(l.Zip) + ',' + 
									ut.CleanSpacesAndUpper(l.Mailing_Address_1) + ',' + 
									ut.CleanSpacesAndUpper(l.Mailing_Address_2) + ',' + 
									ut.CleanSpacesAndUpper(l.Mailing_City) + ',' + 
									ut.CleanSpacesAndUpper(l.Mailing_State) + ',' + 
									ut.CleanSpacesAndUpper(l.Mailing_Zip) + ',' + 
									ut.CleanSpacesAndUpper(l.County) + ',' + 
									ut.CleanSpacesAndUpper(l.Contact_Type) + ',' + 
									ut.CleanSpacesAndUpper(l.phone_number) + ',' + 
									ut.CleanSpacesAndUpper(l.Cell_Phone) + ',' + 
									ut.CleanSpacesAndUpper(l.dob) + ',' + 
									ut.CleanSpacesAndUpper(l.Email_Address) + ',' + 
									ut.CleanSpacesAndUpper(l.Drivers_License_State) + ',' + 
									ut.CleanSpacesAndUpper(l.Drivers_License_Number) + ',' + 
									ut.CleanSpacesAndUpper(l.Bank_Routing_Number_1) + ',' + 
									ut.CleanSpacesAndUpper(l.Bank_Account_Number_1) + ',' + 
									ut.CleanSpacesAndUpper(l.Bank_Routing_Number_2) + ',' + 
									ut.CleanSpacesAndUpper(l.Bank_Account_Number_2) + ',' + 
									ut.CleanSpacesAndUpper(l.Ethnicity) + ',' + 
									ut.CleanSpacesAndUpper(l.Race) + ',' + 
									ut.CleanSpacesAndUpper(l.Case_ID) + ',' + 
									ut.CleanSpacesAndUpper(l.Client_ID) + ',' + 
									ut.CleanSpacesAndUpper(l.Head_of_Household_indicator) + ',' + 
									ut.CleanSpacesAndUpper(l.Relationship_Indicator) + ',' + 
									ut.CleanSpacesAndUpper(l.IP_Address) + ',' + 
									ut.CleanSpacesAndUpper(l.Device_ID) + ',' + 
									ut.CleanSpacesAndUpper(l.Unique_number) + ',' + 
									ut.CleanSpacesAndUpper(l.MAC_Address) + ',' + 
									ut.CleanSpacesAndUpper(l.Serial_Number) + ',' + 
									ut.CleanSpacesAndUpper(l.Device_Type) + ',' + 
									ut.CleanSpacesAndUpper(l.Device_identification_Provider) + ',' +  
									ut.CleanSpacesAndUpper(l.geo_lat) + ',' + 
									ut.CleanSpacesAndUpper(l.geo_long)); 
		self := l;
	end;

	IdentityDataRid       := project(IdentityDataSource,to_form(left));
					  		
  // Rollup Update and previous base 
  
  
	Pcombined     := If(UpdateIdentityData , inBaseIdentityData + IdentityDataRid , IdentityDataRid); 
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , -source_rec_id, -dt_last_seen,-process_date,record ,local);

	
	Layouts.Base.IdentityData RollupUpdate(Layouts.Base.IdentityData l, Layouts.Base.IdentityData r) := 
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

	
	tools.mac_WriteFile(Filenames(pversion).Base.IdentityData.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_IdentityData atribute')
	);
	
end;
