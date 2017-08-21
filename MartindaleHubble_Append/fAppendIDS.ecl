import ut,watchdog, business_header, did_add,  header_slimsort,didville;

export fAppendIDS(
	
	dataset(Layouts.Standardized) pStandardizedDataset

) :=
function
	
	Did_matchset := ['A','D'];

	// DID using the contact name, contact address
	DID_Add.MAC_Match_Flex(
			pStandardizedDataset			//infile
		 ,Did_matchset                     //matchset,						//see above
		 ,NONE                           //ssn_field
		 ,dob                                 //, dob_field
		 ,fname            //, fname_field
		 ,mname            //, mname_field
		 ,lname            //,lname_field
		 ,name_suffix      //, suffix_field, 
		 ,prim_range    //prange_field
		 ,prim_name     //, pname_field
		 ,sec_range     //, srange_field
		 ,zip           //, zip_field
		 ,st            //, state_field
		 ,none                       //, phone_field,
		 ,did                                 //DID_field,   			
		 ,Layouts.Standardized                          //outrec, 
		 ,true                                 //bool_outrec_has_score
		 ,did_score                         //, DID_Score_field,	//these should default to zero in definition
		 ,75  //low score threshold         //low_score_threshold,	//dids with a score below here will be dropped
		 ,DidDataset                          //	 outfile,
	)

	//match to watchdog
	watchdogbest := Watchdog.Key_Watchdog_nonglb;

	best_address_record :=
	record
		layouts.standardized;
		watchdog.Layout_best_flags best_person_info;
	end;
		
	best_address_record tgetpersonbestinfo(layouts.standardized l, watchdogbest r) :=
	transform
		self.best_person_info := r;
		self := l;
	end;

	did_best := join(DidDataset,				
					watchdogbest,
				left.did = right.did,
				tgetpersonbestinfo(left,right)
				,keyed
				,left outer
				);

	all_best_layout := 
	record
		best_address_record;
		business_header.Layout_BH_Best best_business_info;
	end;

	bhbest := Business_Header.Key_BH_Best;

	all_best_layout tgetBHbest(did_best l, bhbest r) :=
	transform
		self := l;
		self.best_business_info := r;
	end;

	company_best := join(did_best,
						bhbest,
						(unsigned6)left.best_person_info.bdid = right.bdid,
						tgetBHbest(left,right),
						keyed
						,left outer
						);
						
	layouts.Out_allfields tOutput(company_best l) :=
	transform
		self := l;
	end;

	return project(company_best, tOutput(left));

end;