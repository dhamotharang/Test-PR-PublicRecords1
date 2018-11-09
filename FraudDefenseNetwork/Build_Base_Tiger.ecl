Import ut, tools, address, didville, DID_Add ;

EXPORT Build_Base_Tiger ( 
   string pversion
	,dataset(Layouts.Base.Tiger)  inBaseTiger   = Files().Base.Tiger.QA
	,dataset(Layouts.Input.Tiger) inTigerUpdate = Files().Input.Tiger.Sprayed
	,boolean                    UpdateTiger     = FraudDefenseNetwork._Flags.Update.Tiger
) := 
module 
	unsigned	TigerMaxRecordID	:=	If(UpdateTiger ,max(inBaseTiger,source_rec_id)	, 0):	global;
	
	Functions.CleanFields(inTigerUpdate ,inTigerUpdateUpper); 
		
	Layouts.Base.Tiger	tPrep(FraudDefenseNetwork.Layouts.Input.Tiger	pInput,integer	cnt)	:=
	transform				
				    self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'TIGR'; 
						self.DOB                             := FraudDefenseNetwork.Functions.fSlashedMDYtoCYMD(pInput.DOB);
						self.app_date                        := FraudDefenseNetwork.Functions.fSlashedMDYtoCYMD(pInput.app_date);
						self.dt_first_seen                   := (unsigned)self.app_date;  
						self.dt_last_seen                    := (unsigned)self.app_date;  
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  self.source_rec_id							       := TigerMaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ;    
           self.address_1                       := Address.Addr1FromComponents(pInput.address1, '','', '', '', '', '');
           self.address_2                       := Address.Addr2FromComponents(pInput.city, pInput.state, pInput.zipcode); 
           self                                 := pInput;
           self                                 := []; 
   end; 
		
	TigerUpdate	:=	project(dedup(inTigerUpdateUpper(LAST_NAME <> '' and FIRST_NAME <>'')  ,all),tPrep(left,counter));
	
  
	Standardize_Name(TigerUpdate, FIRST_NAME,MID_NAME,LAST_NAME,NAMESUFFIX,  TigerNamecleaned);
 	
	Standardize_Address(TigerNameCleaned, TigerAddrCleaned); 	
	
	Standardize_Phone(TigerAddrCleaned, home_phone	,TigerHomePhCleaned	,clean_phones.phone_number	,,true); 
	Standardize_Phone(TigerHomePhCleaned, cell_phone	,TigerPhoneCleaned	,clean_phones.cell_phone	,,true); 
	
	FraudDefenseNetwork.Mac_LexidAppend(TigerPhoneCleaned, TigerUpdateCleaned);
	
		// Rollup Update and previous base 
		
	Pcombined     := If(UpdateTiger , inBaseTiger + TigerUpdateCleaned , TigerUpdateCleaned); 	
	pDataset_Dist := distribute(Pcombined, hash(app_number));	
	pDataset_sort := sort(pDataset_Dist , 
	                      App_Number,
													Loan_Number,
													Primary_Fraud_Code,
													Location_Identifier,
													FIRST_NAME,
													MID_NAME,
													LAST_NAME,
													HOME_PHONE,
													CELL_PHONE,
													SSN,
													EMAIL,
													OWN_RENT_OTHER,
													CUST_ID_TYPE,
													CUST_ID_NUM,
													CUST_ID_SOURCE,
													DOB,
													App_Source,
													IP_ADDRESS,
													ADDRESS1,
													CITY,
													STATE,
													ZIPCODE,
													NET_INCOME,
													FP1_Score,
													FP2_Score,
												 -app_date,-process_date,   local);
		
Layouts.Base.Tiger RollupUpdate(Layouts.Base.Tiger l, Layouts.Base.Tiger r) := 
	transform
		self.dt_first_seen                   := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen                    := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported         := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported        := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id                   := if((integer)l.source_rec_id < (integer)r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous rid 
		self.current                         := if(l.current = 'C' or r.current = 'C', 'C', 'H');
   // self.vendor_ID                              := '18393';		
		self                                 := l;
	end;

	pDataset_rollup := rollup( pDataset_sort,
														 
		left.App_Number             =  right.App_Number               and 
		left.Loan_Number            =  right.Loan_Number              and 
		left.Primary_Fraud_Code     =  right.Primary_Fraud_Code       and
		left.Location_Identifier    =  right.Location_Identifier      and
		left.FIRST_NAME             =  right.FIRST_NAME               and
		left.MID_NAME               =  right.MID_NAME                 and
		left.LAST_NAME              =  right.LAST_NAME                and
		left.HOME_PHONE             =  right.HOME_PHONE               and
		left.CELL_PHONE             =  right.CELL_PHONE               and
		left.SSN                    =  right.SSN                      and
		left.EMAIL                  =  right.EMAIL                    and
		left.OWN_RENT_OTHER         =  right.OWN_RENT_OTHER           and
		left.CUST_ID_TYPE           =  right.CUST_ID_TYPE             and
		left.CUST_ID_NUM            =  right.CUST_ID_NUM              and
		left.CUST_ID_SOURCE         =  right.CUST_ID_SOURCE           and
		left.DOB                    =  right.DOB                      and
		left.App_Source             =  right.App_Source               and
		left.IP_ADDRESS             =  right.IP_ADDRESS               and
		left.ADDRESS1               =  right.ADDRESS1                 and
		left.CITY                   =  right.CITY                     and
		left.STATE                  =  right.STATE                    and
		left.ZIPCODE                =  right.ZIPCODE                  and
		left.NET_INCOME             =  right.NET_INCOME               and
   	left.FP1_Score              =  right.FP1_Score                and 
		left.FP2_Score              =  right.FP2_Score                and 
		left.app_date               =  right.app_date			 					 
				,RollupUpdate(left, right)	, local									
										);

	
	tools.mac_WriteFile(Filenames(pversion).Base.Tiger.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Tiger atribute')
	);
	
end;
