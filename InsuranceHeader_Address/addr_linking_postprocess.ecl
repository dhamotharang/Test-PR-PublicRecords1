IMPORT insuranceheader_address,idl_header,InsuranceHeader_Incremental;

EXPORT addr_linking_postprocess (dataset(idl_header.Layout_Header_Link) hdr, boolean isTest = FALSE, BOOLEAN Incremental = FALSE) := FUNCTION

disthdr       := distribute(hdr,hash(did));
Addresslink    := MAP ( isTest => files().Addr_link_sfds_test , 
                       Incremental => InsuranceHeader_Incremental.Files.IncHierarchy_Current_DS,
											            files().addr_link_sfds); 
linked        := distribute(Addresslink,hash(did)); 
	 
//add the address group id from the last linking process
j := join(disthdr,linked,
           left.did = right.did and
           left.prim_range = right.prim_range and
					 left.prim_name = right.prim_name and
					 left.sec_range = right.sec_range,
					 transform(IDL_Header.Layout_Header_address,
					           self.address_group_id := right.address_group_id,
                     self.segment := [],                     
										 self.best_addr_ind    := [],
										 self.src_cnt := (integer) right.src_cnt,
					           self := left, self := []),local);

dedupj := dedup(sort(j,did,rid,local),did,rid,local);

return dedupj;
end;