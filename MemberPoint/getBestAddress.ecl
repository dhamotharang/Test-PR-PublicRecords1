import AddrBest,ut	;
	
	export dataset(AddrBest.Layout_BestAddr.batch_out_final) 
									getBestAddress(dataset (MemberPoint.Layouts.BestExtended) dsBestE, MemberPoint.IParam.BatchParams BatchParams) :=  function
																	
		dsForBestAdd := project(ungroup(dsBestE),
			transform(AddrBest.Layout_BestAddr.Batch_in,
				self.acctno 			:= (string) left.seq,
				self.did 					:= left.did, 
				self.ssn 					:= if(left.best_ssn <> '',left.best_ssn,left.ssn), 
				self.name_first 	:= if(left.best_fname <> '',left.best_fname,left.fname ),
				self.name_middle 	:= if(left.best_fname <> '',left.best_mname,left.mname ),
				self.name_last 		:= if(left.best_fname <> '',left.best_lname,left.lname ),
				self.name_suffix 	:= left.best_name_suffix,
				self.dob 					:= if(left.best_dob <> '', left.best_dob,left.dob),
				self.prim_range		:= left.c_best_prim_range;
				self.predir				:= left.c_best_predir;
				self.prim_name		:= left.c_best_prim_name;
				self.suffix				:= left.c_best_addr_suffix;
				self.postdir			:= left.c_best_postdir;
				self.unit_desig		:= left.c_best_unit_desig;
				self.sec_range		:= left.c_best_sec_range;
				self.p_city_name	:= left.c_best_p_city_name,
				self.st						:= left.c_best_st,
				self.z5						:= left.c_best_z5,
				self 							:= [] ));									

		AddrParams  := module(project(BatchParams, AddrBest.IParams.SearchParams,opt))
			export boolean IncludeMinors 	:= FALSE;
			export boolean OnlyReturnSuccessfullyCleanedAddresses	:= true;
		end;
		dsBestAddressPre0 	:= AddrBest.Records(dsForBestAdd,AddrParams).best_records;
		
		dsBestAddress	:= project(dsBestAddressPre0, 
			transform(recordof(dsBestAddressPre0),
				self.fips_county 	:= INTFORMAT(ut.St2Code(left.st),2, 1)+left.fips_county,
				self							:= left));
			
		//dsBestAddress := dsBestAddressPre((unsigned)name_score between AddrParams.minNameScore and AddrParams.maxNameScore);
		return dsBestAddress;
	end;	
