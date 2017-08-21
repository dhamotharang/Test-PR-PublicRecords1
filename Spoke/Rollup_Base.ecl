import ut;
export Rollup_Base(

	dataset(Layouts.Base) pDataset
	
) :=
function

	scrubfield(string pcompany_name) :=
	function
		//find number of quotes
		numsinglequotes := length(trim(stringlib.stringfilter(pcompany_name, '\''),left,right));
		numdoublequotes := length(trim(stringlib.stringfilter(pcompany_name, '"'),left,right));

		returnstring := map(numsinglequotes = 2 or numdoublequotes = 2
													=> regexreplace('^(["\']*)(.*?)(\\1)$', trim(pcompany_name,left,right), '$2', nocase)
												,numsinglequotes = 1 or numdoublequotes = 1
													=> regexreplace('^(["\']*)(.*?)(["\']*)$', trim(pcompany_name,left,right), '$2', nocase)

													,pcompany_name
										);

		return trim(returnstring,left,right);

	end;
	
	Layouts.Base tCleanuprawfields(Layouts.Base l) :=
	transform
	
		self.rawfields.First_Name										 := scrubfield(l.rawfields.First_Name										);
		self.rawfields.Last_Name										 := scrubfield(l.rawfields.Last_Name										);
		self.rawfields.Job_Title										 := scrubfield(l.rawfields.Job_Title										);
		self.rawfields.Company_Name									 := scrubfield(l.rawfields.Company_Name									);
		self.rawfields.Validation_Date							 := scrubfield(l.rawfields.Validation_Date							);
		self.rawfields.Company_Street_Address				 := scrubfield(l.rawfields.Company_Street_Address				);
		self.rawfields.Company_City									 := scrubfield(l.rawfields.Company_City									);
		self.rawfields.Company_State								 := scrubfield(l.rawfields.Company_State								);
		self.rawfields.Company_Postal_Code					 := scrubfield(l.rawfields.Company_Postal_Code					);
		self.rawfields.Company_Phone_Number					 := scrubfield(l.rawfields.Company_Phone_Number					);
		self.rawfields.Company_Annual_Revenue				 := scrubfield(l.rawfields.Company_Annual_Revenue				);
		self.rawfields.Company_Business_Description	 := scrubfield(l.rawfields.Company_Business_Description	);
	  self																				 := l;                                                       
	
	end;
	
	pdataset_cleaned := project(pDataset, tCleanuprawfields(left));

	pDataset_Dist := distribute(pdataset_cleaned, hash64(trim(rawfields.company_name), trim(rawfields.first_name), trim(rawfields.last_name), trim(rawfields.Company_Postal_Code)));
	pDataset_sort := sort(pDataset_Dist	 
		,rawfields.First_Name																
		,rawfields.Last_Name																
		,rawfields.Job_Title										
		,rawfields.Company_Name										
		,rawfields.Company_Street_Address				
		,rawfields.Company_City									
		,rawfields.Company_State								
		,rawfields.Company_Postal_Code					
		,rawfields.Company_Phone_Number					
		,rawfields.Company_Annual_Revenue				
		,rawfields.Company_Business_Description	
		,local
	);
	
	Layouts.Base RollupUpdate(Layouts.Base l, Layouts.Base r) := 
	transform
		self.dt_first_seen 						:=	ut.EarliestDate(
																				 ut.EarliestDate(l.dt_first_seen	,r.dt_first_seen)
																				,ut.EarliestDate(l.dt_last_seen		,r.dt_last_seen	)
																			);
		self.dt_last_seen 						:= Max(l.dt_last_seen,r.dt_last_seen);
		SELF.dt_vendor_last_reported 	:= Max(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
		SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
		self.record_type							:= if(l.record_type = 'C' or r.record_type = 'C', 'C', 'H');
		self := l;

	end;

	pDataset_rollup := rollup( pDataset_sort
														,RollupUpdate(left, right)
														,rawfields.First_Name																
														,rawfields.Last_Name																
														,rawfields.Job_Title										
														,rawfields.Company_Name										
														,rawfields.Company_Street_Address				
														,rawfields.Company_City									
														,rawfields.Company_State								
														,rawfields.Company_Postal_Code					
														,rawfields.Company_Phone_Number					
														,rawfields.Company_Annual_Revenue				
														,rawfields.Company_Business_Description	
														,local
										);

	// --for update that is not full file
	dnotfull_sort 			:= sort	(pDataset_rollup
	,trim(rawfields.First_Name										)										
	,trim(rawfields.Last_Name											)									
	,trim(rawfields.Job_Title											)								
	,trim(rawfields.Company_Name									)							
	,trim(rawfields.Company_Street_Address				)
	,trim(rawfields.Company_City									)
	,trim(rawfields.Company_State									)
	,trim(rawfields.Company_Postal_Code						)
	,trim(rawfields.Company_Phone_Number					)
	,trim(rawfields.Company_Annual_Revenue				)
	,trim(rawfields.Company_Business_Description	)
	,local);
	
	
	dnotfull_group			:= group(pDataset_sort	
	,trim(rawfields.First_Name										)										
	,trim(rawfields.Last_Name											)									
	,trim(rawfields.Job_Title											)								
	,trim(rawfields.Company_Name									)							
	,trim(rawfields.Company_Street_Address				)
	,trim(rawfields.Company_City									)
	,trim(rawfields.Company_State									)
	,trim(rawfields.Company_Postal_Code						)
	,trim(rawfields.Company_Phone_Number					)
	,trim(rawfields.Company_Annual_Revenue				)
	,trim(rawfields.Company_Business_Description	)
	,local);

	dnotfull_sort_group	:= sort	(dnotfull_group	, -dt_last_seen						);

	Layouts.Base SetRecordType(Layouts.Base L, Layouts.Base R) := 
	transform
		self.record_type	:= if(l.record_type = '', 'C', r.record_type);
		self							:= r;
	end;

	dSetRecordType := group(iterate(dnotfull_sort_group, SetRecordType(left, right)));

	output_dataset := if(_Flags.IsUpdateFullFile
											,pDataset_rollup
											,dSetRecordType
										);

	return output_dataset;

end;