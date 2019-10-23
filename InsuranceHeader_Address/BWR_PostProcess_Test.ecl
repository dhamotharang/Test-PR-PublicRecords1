import idl_header;

hdr  := distribute(idl_header.files.DS_IDL_POLICY_HEADER_BASE,hash(did));

post    := InsuranceHeader_Address.addr_linking_postprocess(hdr,FALSE);
hier    := InsuranceHeader_Address.addr_hier_validities(post).records;
					 
export records := join(hdr,hier,
	                       left.did = right.did and
								         left.rid = right.rid,
                         transform(idl_header.Layout_Header_Link,
												           self.addr_ind := IF(left.did=right.did and left.rid=right.rid,right.addr_ind,left.addr_ind),
																	 self.addressstatus := IF(left.did=right.did and left.rid=right.rid,right.addressstatus,left.addressstatus),
																	 self.addresstype   := IF(left.did=right.did and left.rid=right.rid,right.addresstype,left.addresstype),
												           self := left),
								         left outer,hash);
				
OUTPUT(records,,'~thor::address_linking::address_hier::test',OVERWRITE);


