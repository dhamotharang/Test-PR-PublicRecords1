Import ut,tools,FraudShared; 

EXPORT Build_Base_Deltabase (
   string pversion
	,dataset(Layouts.Base.Deltabase)  inBaseDeltabase   = Files().Base.Deltabase.Built
	,dataset(Layouts.Input.Deltabase) inDeltabaseUpdate = Files().Input.Deltabase.Sprayed
	,boolean	UpdateDeltabase   = _Flags.Update.Deltabase
) := 
module 

		Layouts.Base.Deltabase	tPrep(inDeltabaseUpdate	l)	:=
	transform
			self.process_date							:= (unsigned) l.ProcessDate, 
			self.dt_first_seen						:= (unsigned) l.ProcessDate; 
			self.dt_last_seen							:= (unsigned) l.ProcessDate;
			self.dt_vendor_last_reported		:= (unsigned) l.ProcessDate; 
			self.dt_vendor_first_reported		:= (unsigned) l.ProcessDate; 
			self.source_rec_id						:= l.unique_id;																
			self.current									:= 'C' ; 
			self												:= l; 			
			self												:= []; 
   end; 
		
	DeltabaseUpdate	:=	project(inDeltabaseUpdate,tPrep(left));
	
	MBS_Layout := Record
		FraudShared.Layouts.Input.MBS;
		unsigned1 Deltabase := 0;
	end;
	MBS	:= FraudShared.Files().Input.MBS.sprayed;

	DeltabaseSource := join(	DeltabaseUpdate,
									MBS(status = 1), 
									(unsigned6) left.Customer_Account_Number = right.gc_id AND 
									left.file_type = right.file_type  AND
									left.ind_type = right.ind_type
									,TRANSFORM(FraudGovPlatform.Layouts.Base.Deltabase,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT) ,lookup); 

  // Rollup Update and previous base 
  
	Pcombined     := If(UpdateDeltabase , inBaseDeltabase + DeltabaseSource , inBaseDeltabase); 
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , source_rec_id, -process_date, -did, -clean_address.err_stat,local);

	
	Layouts.Base.Deltabase RollupUpdate(Layouts.Base.Deltabase l, Layouts.Base.Deltabase r) := 
	transform
		SELF.dt_first_seen := ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		SELF.dt_last_seen := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported := max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id := if(l.dt_vendor_last_reported < r.dt_vendor_last_reported,l.source_rec_id, r.source_rec_id); // leave always previous rid 
		SELF.Unique_Id := if(l.dt_vendor_last_reported < r.dt_vendor_last_reported,l.Unique_Id, r.Unique_Id); // leave always previous Unique_Id 
		self.current := if(l.current = 'C' or r.current = 'C', 'C', 'H');
		self := l;
	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,source_rec_id ,local
										);
	
	tools.mac_WriteFile(Filenames(pversion).Base.Deltabase.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Deltabase atribute')
	);
	
end;
