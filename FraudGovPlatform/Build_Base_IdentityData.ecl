Import ut,tools,FraudShared; 

EXPORT Build_Base_IdentityData (
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed
	,dataset(Layouts.Base.IdentityData) inBaseIdentityData = IF(_Flags.Update.IdentityData, Files().Base.IdentityData.Built, DATASET([], Layouts.Base.IdentityData))
	,dataset(Layouts.Input.IdentityData) inIdentityDataUpdate = Files().Input.IdentityData.Sprayed
	,boolean UpdateIdentityData  = _Flags.Update.IdentityData
) := 
module 

	Layouts.Base.IdentityData	tPrep(inIdentityDataUpdate	l)	:=
	transform
		self.process_date := (unsigned) l.ProcessDate, 
		self.dt_first_seen := (unsigned) l.ProcessDate; 
		self.dt_last_seen := (unsigned) l.ProcessDate;
		self.dt_vendor_last_reported := (unsigned) l.FileDate; 
		self.dt_vendor_first_reported := (unsigned) l.FileDate; 
		self.source_rec_id := l.unique_id;																
		self.current := 'C' ; 
		self := l; 			
		self := []; 
   end; 
		
	IdentityDataUpdate	:=	project(inIdentityDataUpdate,tPrep(left));
	
	IdentityDataSource := join(	IdentityDataUpdate,
							MBS_Sprayed(status = 1), 
							left.Customer_Account_Number = (string)right.gc_id AND 
							left.file_type = right.file_type  AND
							left.ind_type = right.ind_type AND 
							left.customer_State = right.Customer_State AND
							left.Customer_County = right.Customer_County AND 	
							left.Customer_Agency_Vertical_Type = right.Customer_Vertical
							,TRANSFORM(Layouts.Base.IdentityData,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT) ,lookup); 

  // Rollup Update and previous base 
  
	Pcombined     := If(UpdateIdentityData , inBaseIdentityData + IdentityDataSource , inBaseIdentityData); 
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , source_rec_id, -process_date, -did, -clean_address.err_stat,local);
	
	Layouts.Base.IdentityData RollupUpdate(Layouts.Base.IdentityData l, Layouts.Base.IdentityData r) := 
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
		,Customer_Account_Number, source_rec_id ,local);
	
	tools.mac_WriteFile(Filenames(pversion).Base.IdentityData.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			  Build_Base_File
			, Promote(pversion).buildfiles.New2Built
		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_IdentityData atribute')
	);
	
end;
