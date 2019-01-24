// Sample business data
sample_input_data := dataset('~salt_demo::sample_users_guide_input_data', Layout_Sample, flat);
export In_Sample_Best := project(sample_input_data,
                            transform(Layout_Sample_Best,
							          // set identifier initially to unique record id
//							          self.bdid := left.rcid,
									  self.fein := if(left.fein <> 0, intformat(left.fein, 9, 1), '');
									  self.phone := if(left.phone <> 0, (qstring10)left.phone, '');
									  self := left));
// Changed for each iteration of internal linking
//export In_Sample_Best := dataset('~temp::bdid::TMM_Test6::it1', Layout_Sample_Best, flat);
