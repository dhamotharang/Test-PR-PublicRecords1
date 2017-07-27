
import risk_indicators, bs_services;

export GetBS_Services_History(DATASET (risk_indicators.Layout_InstandID_NuGen) iid_results, string20 TestDataTableName) := FUNCTION

	Test_Data_Table_Name := stringlib.stringtouppercase(TestDataTableName);
	
	bs_services.Layouts.out add_history(iid_results le, seed_files.Key_BS_Services rt) := transform			
			addrcount := map(rt.address_children.addr15.address_seq_no<>0 => 15,
							 rt.address_children.addr14.address_seq_no<>0 => 14,
							 rt.address_children.addr13.address_seq_no<>0 => 13,
							 rt.address_children.addr12.address_seq_no<>0 => 12,
							 rt.address_children.addr11.address_seq_no<>0 => 11,
							 rt.address_children.addr10.address_seq_no<>0 => 10,
							 rt.address_children.addr9.address_seq_no<>0 => 9,
							 rt.address_children.addr8.address_seq_no<>0 => 8,
							 rt.address_children.addr7.address_seq_no<>0 => 7,
							 rt.address_children.addr6.address_seq_no<>0 => 6,
							 rt.address_children.addr5.address_seq_no<>0 => 5,
							 rt.address_children.addr4.address_seq_no<>0 => 4,
							 rt.address_children.addr3.address_seq_no<>0 => 3,
							 rt.address_children.addr2.address_seq_no<>0 => 2,
							 rt.address_children.addr1.address_seq_no<>0 => 1,
							 0);
			
			addresses_children := project(rt.address_children.addr1, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr2, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr3, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr4, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr5, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr6, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr7, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr8, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr9, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr10, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr11, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr12, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr13, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr14, transform(bs_services.layouts.addresses, self := left, self := [])) +
																 project(rt.address_children.addr15, transform(bs_services.layouts.addresses, self := left, self := []));
																 
			self.addresses_children := if(addrcount=0, 
																		dataset([], bs_services.layouts.addresses), // create empty dataset instead of using what is in the seed file
																		choosen(addresses_children, addrcount));
			
			best_empty := rt.best_data.did=0 and rt.best_data.phone='' and rt.best_data.fname='' and rt.best_data.lname='';
			
			seed_best := project(rt.best_data, transform(bs_services.layouts.best_info, 
																																self := left; 
																																self := [])) +
										dataset([],bs_services.layouts.best_info);
										
			best_count := if(best_empty, 0, 1);
			
			// self.best_information_children := if(best_empty,seed_best,dataset([],bs_services.layouts.best_info));  // compiler doesn't like this line, use choosen instead
			self.best_information_children := choosen(seed_best, best_count);

			self := le;
	end;
	
	// Join the input data to the red flags key
	with_bs_history := Join(iid_results, seed_files.Key_BS_Services,  
													keyed(right.dataset_name=Test_Data_Table_Name) and 
													keyed(right.hashvalue=Seed_Files.Hash_InstantID((string20)left.fname,(string20)left.lname,
																																					(string9)left.ssn,Risk_Indicators.nullstring,
																																					(string5)left.in_zipCode,(string10)left.phone10,Risk_Indicators.nullstring)), 
											add_history(LEFT, RIGHT), LEFT OUTER, KEEP(1));
	
  RETURN with_bs_history;
	
END;
