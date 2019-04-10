Import ut,tools,FraudShared; 

EXPORT Build_Base_Deltabase (
	 string pversion
	,dataset(FraudShared.Layouts.Input.mbs) MBS_Sprayed = FraudShared.Files().Input.MBS.sprayed   
	,dataset(Layouts.Base.Deltabase) inBaseDeltabase = IF(_Flags.Update.Deltabase, Files().Base.Deltabase.Built, DATASET([], Layouts.Base.Deltabase))
	,dataset(Layouts.Input.Deltabase) inDeltabaseUpdate = Files().Input.Deltabase.Sprayed
	,boolean UpdateDeltabase = _Flags.Update.Deltabase
) := 
module 
					
	Layouts.Base.Deltabase	tPrep(inDeltabaseUpdate	l)	:=
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
		
	DeltabaseUpdate	:=	project(inDeltabaseUpdate,tPrep(left));
	
	MBS_Deltabase	:= MBS_Sprayed(status = 1 and regexfind('DELTA', fdn_file_code, nocase));

	DeltabaseSource := join(
		DeltabaseUpdate,
		MBS_Deltabase, 
		left.Customer_Account_Number = (string)right.gc_id,
		TRANSFORM(FraudGovPlatform.Layouts.Base.Deltabase,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT) ,lookup); 

  // Rollup Update and previous base
  
	Pcombined := If(UpdateDeltabase , inBaseDeltabase + DeltabaseSource , DeltabaseSource); 
	pDataset_Dist := distribute(Pcombined, InqLog_ID);
	pDataset_sort := sort(pDataset_Dist , InqLog_ID, -process_date, -did, -clean_address.err_stat,local);

	
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
        ,InqLog_ID ,local);

	tools.mac_WriteFile(Filenames(pversion).Base.Deltabase.New,pDataset_rollup,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			  Build_Base_File
 			, Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_Deltabase atribute')
	);
	
end;
