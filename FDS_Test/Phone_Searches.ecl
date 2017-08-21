export Phone_Searches(

	dataset(Layout_Consumer.Temporary.StandardizeInput) pDataset

) :=
module

	//shared ssn_filter 										:= (unsigned)pDataset.Extract.ssn != 0 AND pDataset.Extract.name = '' and pDataset.Extract.Address = '';
	shared ssn_name_filter 								:= length(trim(pDataset.Extract.ssn,left,right)) = 9 AND pDataset.Extract.name != '' and pDataset.Extract.Address = '';
	shared PartialSsn_Name_filter 				:= (unsigned)pDataset.Extract.ssn != 0 and length(trim(pDataset.Extract.ssn,left,right)) != 9 and pDataset.Extract.name != '' and pDataset.Extract.Address = '';
	shared Name_Address_filter 						:= pDataset.Extract.name != '' and pDataset.Extract.Address != '' and pDataset.Extract.City != '' and pDataset.Extract.State != '' and pDataset.Extract.zip_code != '';
	shared Name_City_State_Zip_filter 		:= pDataset.Extract.name != ''  and pDataset.Extract.Address = '' and pDataset.Extract.City != '' and pDataset.Extract.State != '' and pDataset.Extract.zip_code != '';
	shared Name_City_State_filter 				:= pDataset.Extract.name != ''  and pDataset.Extract.Address = '' and pDataset.Extract.City != '' and pDataset.Extract.State != '' and pDataset.Extract.zip_code = '';
	shared Name_City_filter 							:= pDataset.Extract.name != ''  and pDataset.Extract.Address = '' and pDataset.Extract.City != '' and pDataset.Extract.State  = '' and pDataset.Extract.zip_code = '';
	shared Name_Zip_filter 								:= pDataset.Extract.name != ''  and pDataset.Extract.Address = '' and pDataset.Extract.City = '' and pDataset.Extract.State = '' and pDataset.Extract.Zip_code != '';
	shared Name_State_filter 							:= pDataset.Extract.name != ''  and pDataset.Extract.Address = '' and pDataset.Extract.City = '' and pDataset.Extract.State != '' and pDataset.Extract.zip_code = '';
	//shared Address_Only_filter 						:= pDataset.Extract.Address != '' and pDataset.Extract.name = '' and pDataset.Extract.Business_name = '';
	shared Phone_only_filter 							:= (unsigned)pDataset.Extract.phone_number != 0 and pDataset.Extract.Business_name = '';
	shared did_filter											:= pDataset.did != 0;
	
	shared ffilter(unsigned2 pFilter) :=
	function
	
		lfilter :=
					//if(pFilter = 1		,(ssn_filter 											)	,(not ssn_filter 											))
			//and 
			if(pFilter = 2		,(ssn_name_filter 								)	,(not ssn_name_filter 								))
			and if(pFilter = 3		,(PartialSsn_Name_filter 					)	,(not PartialSsn_Name_filter 					))
			and if(pFilter = 4		,(Name_Address_filter 						)	,(not Name_Address_filter 						))
			and if(pFilter = 5		,(Name_City_State_Zip_filter 			)	,(not Name_City_State_Zip_filter 			))
			and if(pFilter = 6		,(Name_City_State_filter 					)	,(not Name_City_State_filter 					))
			and if(pFilter = 7		,(Name_City_filter 								)	,(not Name_City_filter 								))
			and if(pFilter = 8		,(Name_Zip_filter 								)	,(not Name_Zip_filter 								))
			and if(pFilter = 9		,(Name_State_filter 							)	,(not Name_State_filter 							))
//			and if(pFilter = 10		,(Address_Only_filter 						)	,(not Address_Only_filter 						))
			and if(pFilter = 11		,(Phone_only_filter 							)	,(not Phone_only_filter 							))
//			and if(pFilter = 12		,(did_filter 											)	,(not did_filter 											))
			;
			
		return lfilter;
	
	end;

	export full_file												:= pDataset;
//	export ssn_search												:= pDataset(ffilter(1	));									
	export ssn_name_search 									:= pDataset(ffilter(2	));
	export PartialSsn_Name_search						:= pDataset(ffilter(3	));
	export Name_Address_search 							:= pDataset(ffilter(4	));
	export Name_City_State_Zip_search 			:= pDataset(ffilter(5	));
	export Name_City_State_search 					:= pDataset(ffilter(6	));
	export Name_City_search 								:= pDataset(ffilter(7	));
	export Name_Zip_search 									:= pDataset(ffilter(8	));
	export Name_State_search 								:= pDataset(ffilter(9	));
//	export Address_Only_search 							:= pDataset(ffilter(10));
	export Phone_only_search 								:= pDataset(ffilter(11));
	export has_did			 										:= pDataset(did_filter	);
	export other_search 										:= pDataset(ffilter(13));
	
	export countfull_file												:= count(full_file											);
	//export countssn_search											:= count(ssn_search											);									
	export countssn_name_search 								:= count(ssn_name_search 								);
	export countPartialSsn_Name_search					:= count(PartialSsn_Name_search					);
	export countName_Address_search 						:= count(Name_Address_search 						);
	export countName_City_State_Zip_search 			:= count(Name_City_State_Zip_search 		);
	export countName_City_State_search 					:= count(Name_City_State_search 				);
	export countName_City_search 								:= count(Name_City_search 							);
	export countName_Zip_search 								:= count(Name_Zip_search 								);
	export countName_State_search 							:= count(Name_State_search 							);
	//export countAddress_Only_search 						:= count(Address_Only_search 						);
	export countPhone_only_search 							:= count(Phone_only_search 							);
	export counthas_did 												:= count(has_did 												);
	export countother_search 										:= count(other_search 									);
	export count_all_searches										:= 
	//		countssn_search										
	//	+ 
		countssn_name_search 							
		+ countPartialSsn_Name_search
		+ countName_Address_search 					
		+ countName_City_State_Zip_search 		
		+ countName_City_State_search 				
		+ countName_City_search 				
		+ countName_Zip_search 							
		+ countName_State_search 						
//		+ countAddress_Only_search 					
		+ countPhone_only_search 						
//		+ counthas_did 									
		+ countother_search 									
		;
                                                        
end;