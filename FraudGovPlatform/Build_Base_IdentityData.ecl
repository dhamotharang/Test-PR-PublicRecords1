Import ut,tools,inquiry_acclogs,FraudShared,Address; 

EXPORT Build_Base_IdentityData (
   string pversion
	,dataset(Layouts.Base.IdentityData)  inBaseIdentityData   = Files().Base.IdentityData.Built
	,dataset(Layouts.Input.IdentityData) inIdentityDataUpdate = Files().Input.IdentityData.Sprayed
	,boolean	UpdateIdentityData   = _Flags.Update.IdentityData
) := 
module 

	unsigned	IdentityDataMaxRecordID	:=	if(UpdateIdentityData, max(inBaseIdentityData,source_rec_id), 0)	:	global; // For full initial load as its not update

	Functions.CleanFields(inIdentityDataUpdate ,inIdentityDataUpdateUpper); 

		Layouts.Base.IdentityData	tPrep(inIdentityDataUpdateUpper	pInput,integer	cnt)	:=
	transform
				
				    self.process_date                    := (unsigned) pversion, 
						self.Unique_Id                       := 0; 
						self.Source                          := 'IDDT'; 
						self.dt_first_seen                   := (unsigned)pInput.Date_of_Transaction [1..8]; 
						self.dt_last_seen                    := (unsigned)pInput.Date_of_Transaction [1..8];
						self.dt_vendor_last_reported         := (unsigned) pversion;
						self.dt_vendor_first_reported        := (unsigned) pversion;
					  self.source_rec_id							     :=	 IdentityDataMaxRecordID + cnt ;																			
						// add  address and name prep 
					  self.current                         := 'C' ; 
						cleanperson73 											 := Address.cleanperson73(pInput.full_name);
						self.cleaned_name.title              := ut.CleanSpacesAndUpper(cleanperson73[1..5]); 
						self.cleaned_name.fname              := ut.CleanSpacesAndUpper(cleanperson73[6..25]);
						self.cleaned_name.mname              := ut.CleanSpacesAndUpper(cleanperson73[26..45]); 
						self.cleaned_name.lname              := ut.CleanSpacesAndUpper(cleanperson73[46..65]);
						self.cleaned_name.name_suffix        := ut.CleanSpacesAndUpper(cleanperson73[66..70]); 
						self.cleaned_name.name_score         := ut.CleanSpacesAndUpper(cleanperson73[71..73]); 	
						self                                 := pInput; 
						self                                 := []; 
   end; 
		
	IdentityDataUpdate	:=	project(dedup(inIdentityDataUpdateUpper ,all),tPrep(left,counter));
	
	//Standardize_Name(IdentityDataUpdate, first_name, middle_name, last_name, suffix, IdentityDataUpdateCleaned); 

  // Rollup Update and previous base 
	Pcombined     := If(UpdateIdentityData , inBaseIdentityData + IdentityDataUpdate , IdentityDataUpdate); 	
	pDataset_Dist := distribute(Pcombined, hash(Transaction_ID_Number));	
	pDataset_sort := sort(pDataset_Dist , -Transaction_ID_Number, -dt_last_seen,-process_date,record  ,local);
			
	Layouts.Base.IdentityData RollupUpdate(Layouts.Base.IdentityData l, Layouts.Base.IdentityData r) := 
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
