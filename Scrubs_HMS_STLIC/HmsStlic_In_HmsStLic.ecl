in_data := dataset('~thor400_data::base::hms_stl::hms_statelicense::20150909', HmsStlic_Layout_HmsStLic, thor);
// sample_data := dataset('~thor400_data::base::hms_stl::hms_statelicense::20150507', Layout_Sample, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['\'','"'])));
export HmsStlic_In_HmsStLic := project(in_data,
                            transform(recordof(in_data),
							          // set identifier initially to unique record id
							          //self.bdid := left.rcid,
									  self := left));