export Process_Deletes(

	 dataset(Layouts.Base.companies	)	pDeletesFile
	,dataset(Layouts.Base.CompaniesForBIP2	) pBaseCompanies

) :=
function

	laydelete := {pDeletesFile.rawfields.duns_number,pDeletesFile.date_last_seen};
	
	dDeletesTable		:= table			(pDeletesFile	,laydelete);
	dDeletesDist 		:= distribute	(dDeletesTable,hash64(trim(duns_number)));
	dDeletesSort		:= sort				(dDeletesDist	,duns_number,-date_last_seen,local);	//use date last seen because vendor last reported is not always populated
	dUniqueDeletes	:= dedup			(dDeletesSort	,duns_number,local);

	dsetActiveDuns :=
				 join( distribute(pBaseCompanies	,hash64(trim(rawfields.duns_number)))
							,dUniqueDeletes
							,left.rawfields.duns_number = right.duns_number
							,transform(Layouts.Base.CompaniesForBIP2,
								self.active_duns_number := if(		right.duns_number <> ''	
																							and right.date_last_seen >= left.date_last_seen
																									,'N'	
																									,left.active_duns_number);
								self										:= left;
							)
							,left outer
							,local
				);

	DNB_Base_Updated_Rollup_Sort 			:= sort(dsetActiveDuns, rawfields.duns_number, local);
	DNB_Base_Updated_Rollup_Grpd 			:= group(DNB_Base_Updated_Rollup_Sort, rawfields.duns_number, local);
	DNB_Base_Updated_Rollup_Grpd_Sort := sort(DNB_Base_Updated_Rollup_Grpd, -date_last_seen, -date_first_seen);

	Layouts.Base.CompaniesForBIP2 SetRecordType(Layouts.Base.CompaniesForBIP2 l, Layouts.Base.CompaniesForBIP2 r) := transform
	self.record_type 				:= if(l.active_duns_number = 'N' or r.active_duns_number = 'N'	,Utilities.RecordType.Deleted	,r.record_type				);
	self.active_duns_number := if(l.active_duns_number = 'N' or r.active_duns_number = 'N'	,'N'													,r.active_duns_number	);
	self := r;
	END;

	dreturndataset := group(iterate(DNB_Base_Updated_Rollup_Grpd_Sort, SetRecordType(left, right)));

	return dreturndataset;

end;