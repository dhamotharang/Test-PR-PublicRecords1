Import ut,tools,FraudShared; 

EXPORT Build_Base_Main (
   string pversion
) := 
module 

	// Rollup Main Base 
	pBaseFile := MapToCommon(pversion).NewBase:independent;
	pDataset_sort := sort(pBaseFile , record, -dt_last_seen,-process_date);
			
	pDataset_sort RollupBase(pDataset_sort l, pDataset_sort r) := 
	transform
		self.dt_first_seen 													:= ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen); 
		self.dt_last_seen 					        	      := max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 								:= max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported               := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		SELF.source_rec_id						              := if(l.source_rec_id < r.source_rec_id,l.source_rec_id, r.source_rec_id); // leave always previous rid 
    self.Record_id                              := if(l.record_id < r.record_id,l.record_id, r.record_id);		
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupBase(left, right)
														,Record																						
														,except process_date, dt_first_seen ,dt_last_seen,dt_vendor_last_reported,dt_vendor_first_reported, source_rec_id , record_id
										);
	// Return
	
	ut.MAC_Append_Rcid (pDataset_rollup,UID,addUID);

  // Append Industry type description 
	
	Shared Combined        := join (addUID , FraudShared.Files().Input.MBSFdnIndType.Sprayed(status = 1), 
																			 left.classification_Permissible_use_access.ind_type = right.ind_type , 
																		   transform (FraudShared.Layouts.Base.main , 
																		   self.classification_Permissible_use_access.ind_type_description := StringLib.StringToUppercase(right.description), 
																		   self.classification_source.Industry_segment                     := if(FraudShared.platform.source = 'FDN' and left.source not in ['ERIE','GLB5'],StringLib.StringToUppercase(right.description),left.classification_source.Industry_segment), 
																			 self := left), left outer , lookup ); 
																							 
	Shared Anonimized := Anonymize(Combined);
	
	Shared Demo_Data_Anon	:= Files(pversion).Input.DemoData.Sprayed;
	Shared Demo_Data_Orig	:= Files(pversion).Input.DemoData.Used;
	
	
	tools.mac_WriteFile(Filenames(pversion).Base.Main_Orig.New,Combined+Demo_Data_Orig,Build_Base_File);
	tools.mac_WriteFile(Filenames(pversion).Base.Main_Anon.New,Anonimized+Demo_Data_Anon,Build_Base_File_Anonymized);
	

	export full_build :=
		 sequential(
			 Build_Base_File
			,Build_Base_File_Anonymized
			,Promote(pversion).buildfiles.New2Built

		);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping FDN.Build_Base_Main atribute')
	);	
end;