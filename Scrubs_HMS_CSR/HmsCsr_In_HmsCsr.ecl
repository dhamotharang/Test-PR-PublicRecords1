in_data := dataset('~thor400_data::base::hms_csr::hms_csrcredential::20151030', HmsCsr_Layout_HmsCsr, thor);
export HmsCsr_In_HmsCsr := project(in_data,
                            transform(recordof(in_data),
							          // set identifier initially to unique record id
							          //self.bdid := left.rcid,
									  self := left));