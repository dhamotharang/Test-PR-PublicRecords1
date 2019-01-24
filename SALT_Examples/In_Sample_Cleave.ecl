// Sample business data
sample_input_data := dataset('~salt_demo::sample_users_guide_input_data', Layout_Sample, flat);
export In_Sample_Cleave := project(sample_input_data,
                            transform(Layout_Sample_Cleave,
							          // set identifier initially to unique record id
//							          self.bdid := left.rcid,
                    self.pscore := 0;
									  self := left));
// Changed for each iteration of internal linking
//export In_Sample_Cleave := dataset('~temp::bdid::MyModule::it1', Layout_Sample_Cleave, flat);
