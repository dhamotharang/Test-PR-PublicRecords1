Import ut,tools,inquiry_acclogs; 

EXPORT Build_Base_Glb5 (
   string pversion
	,dataset(Layouts.Base.Glb5)  inBaseGlb5   = Files().Base.Glb5.QA
	,dataset(Layouts.Input.Glb5) inGlb5Update = Files().Input.Glb5.Sprayed
	,boolean                     UpdateGlb5   = FraudDefenseNetwork._Flags.Update.Glb5
) := 
module 

// UpdateGlb5 = false for full load. UpdateGlb5 = true should be update append 

	parsed        := inquiry_acclogs.fnMapCommon_Accurint('FDN').clean  ; 
  FilteredData  := Parsed (~inquiry_acclogs.FnTranslations.is_Disable_Observation(allowflags) and GLB_purpose = '5'); 
  inGlb5Update0 := Inquiry_AccLogs.fn_clean_and_parse(FilteredData) : persist(Persistnames.glb5);

	unsigned	Glb5MaxRecordID	:=	if(UpdateGlb5, max(inBaseGlb5,source_rec_id), 0)	:	global; // For full initial load as its not update
	
	FraudDefenseNetwork.Functions.CleanFields(inGlb5Update0 ,inGlb5UpdateUpper); 

		FraudDefenseNetwork.Layouts.Base.Glb5	tPrep(inGlb5UpdateUpper	pInput,integer	cnt)	:=
	transform
				
				    self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'GLB5'; 
						self.dt_first_seen                   := (unsigned)pInput.datetime [1..8]; 
						self.dt_last_seen                    := (unsigned)pInput.datetime [1..8];
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  self.source_rec_id							     :=	 Glb5MaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ; 
						self.cleaned_name.title              := pInput.title; 
						self.cleaned_name.fname              := pInput.fname; 
						self.cleaned_name.mname              := pInput.mname; 
						self.cleaned_name.lname              := pInput.lname; 
						self.cleaned_name.name_suffix        := pInput.name_suffix; 
						self.cleaned_name.name_score         := pInput.name_score ; 
						self                                 := pInput; 
						self                                 := []; 
   end; 
		
	Glb5Update	:=	project(dedup(inGlb5UpdateUpper(linkid<>'')  ,all),tPrep(left,counter));

  // Rollup Update and previous base 
	Pcombined     := If(UpdateGlb5 , inBaseGlb5 + Glb5Update , Glb5Update); 	
	pDataset_Dist := distribute(Pcombined, hash(transaction_id));	
	pDataset_sort := sort(pDataset_Dist , -transaction_id, -dt_last_seen,-process_date,record  ,local);
			
	Layouts.Base.Glb5 RollupUpdate(Layouts.Base.Glb5 l, Layouts.Base.Glb5 r) := 
	transform
		self.dt_first_seen 													:= ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 					        	      := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 								:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported               := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						              := if(r.source_rec_id < l.source_rec_id,r.source_rec_id, l.source_rec_id); // leave always previous rid 
		self.current							                  := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,Record																						
														,except process_date, dt_first_seen ,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported, source_rec_id , current,local
										);

	
	tools.mac_WriteFile(Filenames(pversion).Base.Glb5.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Glb5 atribute')
	);
	
end;
