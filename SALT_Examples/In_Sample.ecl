// Sample business data
sample_input_data := dataset('~salt_demo::sample_users_guide_input_data', Layout_Sample, flat);
export In_Sample := project(sample_input_data,
                            transform(recordof(sample_input_data),
							          // set identifier initially to unique record id
							          self.bdid := left.rcid,
									  self := left));
// Changed for each iteration of internal linking
//export In_Sample := dataset('~temp::bdid::MyModule::it1', Layout_Sample, flat);
