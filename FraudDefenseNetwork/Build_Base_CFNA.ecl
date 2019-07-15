import ut, tools, address, didville, DID_Add ;

export Build_Base_CFNA ( 
   string pversion
	,dataset(Layouts.Base.CFNA)  inBaseCFNA   = Files().Base.CFNA.QA
	,dataset(Layouts.Input.CFNA) inCFNAUpdate = Files().Input.CFNA.Sprayed
	,boolean                     UpdateCFNA   = FraudDefenseNetwork._Flags.Update.CFNA
) := 
module 

	unsigned	CFNAMaxRecordID	:=	if(UpdateCFNA, max(inBaseCFNA,source_rec_id), 0)	:	global; 
	
	Functions.CleanFields(inCFNAUpdate ,inCFNAUpdateUpper); 

	Layouts.Base.CFNA	tPrep(Layouts.Input.CFNA	pInput,integer	cnt)	:=
	transform				
           self.process_date                    := (unsigned) pversion, 
           self.Unique_Id                       := 0; 
           self.Source                          := 'CFNA'; 
           self.date_application                := FraudDefenseNetwork.Functions.fSlashedMDYtoCYMD(pInput.date_application);
           self.Date_Fraud_Detected             := FraudDefenseNetwork.Functions.fSlashedMDYtoCYMD(pInput.Date_Fraud_Detected);
           self.Date_Fraud_Reported_LN          := FraudDefenseNetwork.Functions.fSlashedMDYtoCYMD(pInput.Date_Fraud_Reported_LN);
						self.dt_first_seen                   := (unsigned)self.Date_Fraud_Detected [1..8]; 
						self.dt_last_seen                    := (unsigned)self.Date_Fraud_Detected [1..8];
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  self.source_rec_id							       :=	CFNAMaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ;   
           self.address_1                       := Address.Addr1FromComponents(pInput.street_address, '','', '', '', '', '');
           self.address_2                       := Address.Addr2FromComponents(pInput.city, pInput.state, pInput.zip_code); 
						self                                 := pInput; 
						self                                 := []; 
   end; 
		
	CFNAUpdate	:=	project(dedup(inCFNAUpdateUpper(first_name <> '' and last_name <>'')  ,all),tPrep(left,counter));
		
	Standardize_Name(CFNAUpdate, first_name,middle_name,last_name, suffix, CFNANameCleaned); 
	
	Standardize_Address(CFNANameCleaned, CFNAAddrCleaned); 
	
	Standardize_Phone(CFNAAddrCleaned, phone_number	,CFNAPhoneCleaned	,clean_phones.phone_number	,,true); 
	
	Mac_LexidAppend(CFNAPhoneCleaned, CFNAWithIDL);
	
		// Rollup Update and previous base 
	Pcombined     := if(UpdateCFNA , inBaseCFNA + CFNAWithIDL , CFNAWithIDL); 	
	pDataset_Dist := distribute(Pcombined, hash(Application_ID));	
	pDataset_sort := sort(pDataset_Dist ,  
													customer_ID,
													vendor_ID,
													appended_LexID,
													Date_Fraud_Reported_LN,
													first_name,
													middle_name,
													Last_name,
													suffix,
													street_address,
													city,
													state,
													zip_code,
													Phone_Number,
													SSN,
													DOB,
													Driver_License_Number,
													Driver_License_State,
													IP_Address,
													Email_Address,
													Device_Identification,
													Device_identification_Provider,
													Origination_Channel,
													Income,
													Own_or_Rent,
													Location_Identifier,
													Other_Application_Identifier,
													Other_Application_Identifier2,
													Other_Application_Identifier3,
													Date_Application,
													Time_Application,
													Application_ID ,
													FraudPoint_Score,
													Date_Fraud_Detected,
													Financial_Loss,
													Gross_Fraud_Dollar_Loss,
													Application_Fraud,
													Primary_Fraud_Code,
													Secondary_Fraud_Code,
													Source_Identifier,
													LN_Product_ID,
													LN_Sub_Product_ID,
													Industry,
		                    Fraud_Index_Type,-dt_last_seen,-process_date,local);
			
	FraudDefenseNetwork.Layouts.Base.CFNA RollupUpdate(FraudDefenseNetwork.Layouts.Base.CFNA l, FraudDefenseNetwork.Layouts.Base.CFNA r) := 
	transform
		self.dt_first_seen                    := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen                     := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported          := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported         := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id                    := if(r.source_rec_id < l.source_rec_id,r.source_rec_id, l.source_rec_id); // leave always previous rid 
		self.current                          := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self                                  := l;

	end;

	pDataset_rollup := rollup( pDataset_sort,	                         
		left.customer_ID                     =      right.customer_ID                           and
		left.vendor_ID                       =      right.vendor_ID                             and
		left.appended_LexID                  =      right.appended_LexID                        and
		left.Date_Fraud_Reported_LN          =      right.Date_Fraud_Reported_LN                and
		left.first_name                      =      right.first_name                            and
		left.middle_name                     =      right.middle_name                           and
		left.Last_name                       =      right.Last_name                             and
		left.suffix                          =      right.suffix                                and
		left.street_address                  =      right.street_address                        and
		left.city                            =      right.city                                  and
		left.state                           =      right.state                                 and
		left.zip_code                        =      right.zip_code                              and
		left.Phone_Number                    =      right.Phone_Number                          and
		left.SSN                             =      right.SSN                                   and
		left.DOB                             =      right.DOB                                   and
		left.Driver_License_Number           =      right.Driver_License_Number                 and
		left.Driver_License_State            =      right.Driver_License_State                  and
		left.IP_Address                      =      right.IP_Address                            and
		left.Email_Address                   =      right.Email_Address                         and
		left.Device_Identification           =      right.Device_Identification                 and
		left.Device_identification_Provider  =      right.Device_identification_Provider        and
		left.Origination_Channel             =      right.Origination_Channel                   and
		left.Income                          =      right.Income                                and
		left.Own_or_Rent                     =      right.Own_or_Rent                           and
		left.Location_Identifier             =      right.Location_Identifier                   and
		left.Other_Application_Identifier    =      right.Other_Application_Identifier          and
		left.Other_Application_Identifier2   =      right.Other_Application_Identifier2         and
		left.Other_Application_Identifier3   =      right.Other_Application_Identifier3         and
		left.Date_Application                =      right.Date_Application                      and
		left.Time_Application                =      right.Time_Application                      and
		left.Application_ID                  =      right.Application_ID                        and
		left.FraudPoint_Score                =      right.FraudPoint_Score                      and
		left.Date_Fraud_Detected             =      right.Date_Fraud_Detected                   and
		left.Financial_Loss                  =      right.Financial_Loss                        and
		left.Gross_Fraud_Dollar_Loss         =      right.Gross_Fraud_Dollar_Loss               and
		left.Application_Fraud               =      right.Application_Fraud                     and
		left.Primary_Fraud_Code              =      right.Primary_Fraud_Code                    and
		left.Secondary_Fraud_Code            =      right.Secondary_Fraud_Code                  and
		left.Source_Identifier               =      right.Source_Identifier                     and
		left.LN_Product_ID                   =      right.LN_Product_ID                         and
		left.LN_Sub_Product_ID               =      right.LN_Sub_Product_ID                     and
		left.Industry                        =      right.Industry                              and
		left.Fraud_Index_Type                =      right.Fraud_Index_Type
		,RollupUpdate(left, right)	, local);

	tools.mac_WriteFile(Filenames(pversion).Base.CFNA.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_CFNA atribute')
	);
	
end;
