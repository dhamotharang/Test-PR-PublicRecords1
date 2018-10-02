Import ut, tools, Address; 

EXPORT Build_Base_AInspection ( 
   string pversion
	,dataset(Layouts.Base.AInspection)  inBaseAInspection   = Files().Base.AInspection.QA
	,dataset(Layouts.Input.AInspection) inAInspectionUpdate = Files().Input.AInspection.Sprayed
	,boolean                            UpdateAInspection   = FraudDefenseNetwork._Flags.Update.AInspection
) := 
module 

	unsigned	AInspectionMaxRecordID	:= if(UpdateAInspection, max(inBaseAInspection,source_rec_id), 0)	:	global; // For full initial load as its not update
	
	Functions.CleanFields(inAInspectionUpdate ,inAInspectionUpdateUpper); 

	Layouts.Base.AInspection	tPrep(Layouts.Input.AInspection	pInput,integer	cnt)	:=
	transform
				
           self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'AInspection'; 
						self.dt_first_seen                   := (unsigned)pInput.dt_first_reported [1..8]; 
						self.dt_last_seen                    := (unsigned)pInput.dt_last_reported [1..8];
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  self.source_rec_id							       :=	AInspectionMaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ;  
           self.address_1                       := Address.Addr1FromComponents(pInput.address, pInput.suffix,'', '', '', '', '');
           self.address_2                       := Address.Addr2FromComponents(pInput.city, pInput.state, pInput.zip_code); 
						self                                 := pInput; 
						self                                 := []; 
   end;
	 
	AInspectionProj	 :=	project(dedup(inAInspectionUpdateUpper(prim_name <> '' and zip <>''), all),tPrep(left,counter));
	
	Standardize_Address(AInspectionProj, AInspectionUpdate); 
	
	// Rollup Update and previous base 
	Pcombined       := If(UpdateAInspection , inBaseAInspection + AInspectionUpdate , AInspectionUpdate); 	
	pDataset_Dist   := distribute(Pcombined, hash(clean_address.prim_name));	
	pDataset_sort   := sort(Pcombined , record , -dt_last_seen,-process_date,local);
			
	Layouts.Base.AInspection RollupUpdate(Layouts.Base.AInspection l, Layouts.Base.AInspection r) := 
	transform
		self.dt_first_seen                       := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen                        := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 							:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported            := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id                       := if(r.source_rec_id < l.source_rec_id,r.source_rec_id, l.source_rec_id); // leave always previous rid 
		self.current							                  := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self                                     := l;
	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,Record																						
														,except process_date, dt_first_seen ,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported, source_rec_id , current, local
										        );

	
	tools.mac_WriteFile(Filenames(pversion).Base.AInspection.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_AInspection atribute')
	);
	
end;
