import Header, MDR;

hdr := Header.File_Headers;
seg  := distribute(pull(Header.key_ADL_segmentation), hash(did));

TS_recs := dataset('~thor_data400::base::tucs_did_20210126a',header.Layout_Header, flat);

hdr_filtered_by_src := hdr(src not in $.Filters.SRC_EXCLUSIONS and ~MDR.Source_is_DPPA(src))
					 + TS_recs
					 + Voters_Inclusions;

hdr_filtered_by_src_w_nonglb := project(hdr_filtered_by_src
	,transform({hdr, boolean Allowed_for_nonGLB, boolean Allowed_for_GLB}
		,self.Allowed_for_nonGLB := if(~mdr.Source_is_Utility(left.src) and left.src <> 'EQ', true, false)
		,self.Allowed_for_GLB    := true;
		,self := left
		));

hdr_w_seg := join(distribute(hdr_filtered_by_src_w_nonglb(did > 0), hash(did)), seg, left.did = right.did, local);

EXPORT AllowedRecs := distribute(hdr_w_seg(ind1 not in ['AMBIG', 'NOISE', 'H_MERGE', 'NO_SSN']), hash(did)) : persist('~thor::persist::emailage::allowedrecs');