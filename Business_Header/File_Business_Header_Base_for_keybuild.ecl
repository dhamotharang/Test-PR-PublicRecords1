import ut, lib_fileservices, header_services,mdr;

export File_Business_Header_Base_for_keybuild :=
function

in_hdr := business_header.filters.keys.business_headers_keybuild(files(,_Dataset().IsDataland).base.business_headers.keybuild);// + header.transunion_did;
in_hdr_layout := recordof(in_hdr);

////////////////////////////////////////////////////////////////////////
// Get best address from the BH_Basic_match_clean for keys
////////////////////////////////////////////////////////////////////////
in_hdr_dist 		    := distribute(in_hdr, rcid);
	
bh_basic_matchClean := distribute(persists().BHBasicMatchClean, rcid);

//*** Getting the best addresses that got from the AID process and replacing the Orig addresses
//*** for key build.
in_hdr_layout getBestAddr(in_hdr_dist l, bh_basic_matchClean r) :=  transform
		self.prim_range		:=  r.prim_range;
		self.predir				:= 	r.predir;
		self.prim_name		:=	r.prim_name;
		self.addr_suffix	:=	r.addr_suffix;
		self.postdir			:=	r.postdir;
		self.unit_desig		:=	r.unit_desig;
		self.sec_range		:=	r.sec_range;
		self.city					:=	r.city;
		self.state				:=	r.state;
		self.zip					:=	r.zip;
		self.zip4					:=	r.zip4;		
	 self := l;
end;
	
in_hdr_with_bestAddr := join(in_hdr_dist, bh_basic_matchClean,
														 left.rcid = right.rcid,
														 getBestAddr(left,right), left outer, local
														);

full_out_suppress := project(Business_Header.Prep_Build.applyDidAddressBusiness_sup2(in_hdr_with_bestAddr), Business_Header.Layout_Business_Header_Base_Plus_Orig);


	dall := Business_Header.Prep_Build.applyBusinessHeaderInj_AtEnd(full_out_suppress);
	
	dreturndataset := dall;

	return dreturndataset;

end;