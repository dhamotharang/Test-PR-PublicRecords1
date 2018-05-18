﻿Import ut,tools,FraudShared; 

EXPORT Build_Base_KnownFraud (
   string pversion
	,dataset(Layouts.Base.KnownFraud)  inBaseKnownFraud   = Files().Base.KnownFraud.Built
	,dataset(Layouts.Input.KnownFraud) inKnownFraudUpdate = Files().Input.KnownFraud.Sprayed
	,boolean	UpdateKnownFraud   = _Flags.Update.KnownFraud
) := 
module 

		Layouts.Base.KnownFraud	tPrep(inKnownFraudUpdate l)	:=
	transform
			self.process_date							:= (unsigned) l.ProcessDate, 
			self.dt_first_seen						:= (unsigned) l.ProcessDate; 
			self.dt_last_seen							:= (unsigned) l.ProcessDate;
			self.dt_vendor_last_reported		:= (unsigned) l.ProcessDate; 
			self.dt_vendor_first_reported		:= (unsigned) l.ProcessDate; 
			self.source_rec_id						:= l.unique_id;
			// add  address and name prep 
			self												:= l; 
			self												:= []; 
   end; 
		
	KnownFraudUpdate	:=	project(inKnownFraudUpdate ,tPrep(left)); 
	
	Mbs_ds := FraudShared.Files().Input.MBS.sprayed(status = 1);
	
	KnownFraudSource  := join(	KnownFraudUpdate,
												Mbs_ds, 
												(unsigned6) left.Customer_Account_Number = right.gc_id and 
												left.file_type = right.file_type  AND
												left.ind_type = right.ind_type AND 
												( 
													left.Deltabase = 1											
													OR 
													(	left.Deltabase = 0 AND														
														left.customer_State = right.Customer_State AND
														left.Customer_County = right.Customer_County AND 	
														left.Customer_Agency_Vertical_Type = right.Customer_Vertical
													)
												),												
												TRANSFORM(Layouts.Base.KnownFraud,SELF.Source := RIGHT.fdn_file_code; SELF := LEFT));

  // Rollup Update and previous base 
	Pcombined     := If(UpdateKnownFraud , inBaseKnownFraud + KnownFraudSource , inBaseKnownFraud); 	
	pDataset_Dist := distribute(Pcombined, source_rec_id);
	pDataset_sort := sort(pDataset_Dist , source_rec_id, -process_date, -did, -clean_address.err_stat ,local);
			
	Layouts.Base.KnownFraud RollupUpdate(Layouts.Base.KnownFraud l, Layouts.Base.KnownFraud r) := 
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
														,source_rec_id, local
										);

	tools.mac_WriteFile(Filenames(pversion).Base.KnownFraud.New,pDataset_rollup,Build_Base_File);
	// tools.mac_WriteFile(Filenames(pversion).Base.KnownFraud.New,KnownFraudSource,Build_Base_File);

// Return
	export full_build :=
		 sequential(
			 Build_Base_File
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Build_Base_KnownFraud atribute')
	);
	
end;
