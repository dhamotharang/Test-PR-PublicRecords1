export ExtractAllAddressType(inHeader) := functionmacro
   SlimRec := record
      inHeader.Seleid;
	 string1 all_address_type;
   end;
   
   dedupHeader := dedup(project(inHeader, 
                                transform(SlimRec,
						            self.all_address_type := if(left.address_type_derived='','U',left.address_type_derived),
								  self                  := left)), 
				    Seleid, all_address_type, all, hash);
   
   groupSlimRec := group(sort(distribute(dedupHeader, hash32(seleid)), seleid, local), seleid, local);
   
   rollupTypes  := rollup(groupSlimRec, 
                          true,
					 transform(SlimRec,
					           self.all_address_type := map(left.all_address_type = 'U' or right.all_address_type = 'U' => 'U',
							                              left.all_address_type = right.all_address_type              => left.all_address_type,
													'H'),
                                    self := left));
         
  return ungroup(rollupTypes);
endmacro;