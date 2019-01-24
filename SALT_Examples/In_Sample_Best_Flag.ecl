// Sample business data
sample_input_data := dataset('~salt_demo::sample_users_guide_input_data', Layout_Sample, flat);
export In_Sample_Best_Flag := project(sample_input_data,
                                      transform(Layout_Sample_Best_Flag,
							                                  // set identifier initially to unique record id
//							                                  self.bdid := left.rcid,
							                                  self.fein := if(left.fein <> 0, intformat(left.fein, 9, 1), ''),
							                                  self.phone := if(left.phone <> 0, (qstring10)left.phone, ''),
							                                  self.company_name_flag := '',
							                                  self.fein_flag := '',
							                                  self.phone_flag := '',
							                                  self := left));
// Changed for each iteration of internal linking
//export In_Sample_Best_Flag := dataset('~temp::bdid::MyModule::it1', Layout_Sample_Best_Flag, flat);
