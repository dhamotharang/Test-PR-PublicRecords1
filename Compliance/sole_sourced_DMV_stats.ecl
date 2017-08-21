

layout_direct_dmv :=
	RECORD
		unsigned6 did;
		string2 src;
		qstring9 ssn;
		integer4 dob;
		qstring20 fname;
		qstring20 mname;
		qstring20 lname;
		qstring5 name_suffix;
		qstring10 prim_range;
		string2 predir;
		qstring28 prim_name;
		qstring4 suffix;
		string2 postdir;
		qstring10 unit_desig;
		qstring8 sec_range;
		qstring25 city_name;
		string2 st;
		qstring5 zip;
		qstring4 zip4;
		string did_segment;
		boolean src_is_dmv;
		boolean src_is_not_dmv;
		boolean has_ssn;
		boolean has_dob;
	 END;

//-------------DIDs

direct_dmv_DIDs_all := DATASET('~thor400_92::persist::ckelly::dids_direct_dmv_sourced_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_direct_dmv_DIDs_all := TABLE(direct_dmv_DIDs_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_direct_dmv_DIDs_all, DID_segment, skew(1.0)),ALL,named('tbl_direct_dmv_DIDs_all'));

tbl_direct_dmv_DIDs_CORE := TABLE(direct_dmv_DIDs_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(direct_dmv_DIDs_all.src), did_count := count(group)}, src, few);
output(sort(tbl_direct_dmv_DIDs_CORE, src, skew(1.0)),ALL,named('tbl_direct_dmv_DIDs_CORE'));


//-------------DIDNames

direct_dmv_DIDNames_all := DATASET('~thor400_92::persist::ckelly::didnames_direct_dmv_sourced_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_direct_dmv_DIDNames_all := TABLE(direct_dmv_DIDNames_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_direct_dmv_DIDNames_all, DID_segment, skew(1.0)),ALL,named('tbl_direct_dmv_DIDNames_all'));

tbl_direct_dmv_DIDNames_CORE := TABLE(direct_dmv_DIDNames_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(direct_dmv_DIDNames_all.src), did_count := count(group)}, src, few);
output(sort(tbl_direct_dmv_DIDNames_CORE, src, skew(1.0)),ALL,named('tbl_direct_dmv_DIDNames_CORE'));

//-------------DIDAddrs

direct_dmv_DIDAddrs_all := DATASET('~thor400_92::persist::ckelly::didAddrs_direct_dmv_sourced_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_direct_dmv_DIDAddrs_all := TABLE(direct_dmv_DIDAddrs_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_direct_dmv_DIDAddrs_all, DID_segment, skew(1.0)),ALL,named('tbl_direct_dmv_DIDAddrs_all'));

tbl_direct_dmv_DIDAddrs_CORE := TABLE(direct_dmv_DIDAddrs_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(direct_dmv_DIDAddrs_all.src), did_count := count(group)}, src, few);
output(sort(tbl_direct_dmv_DIDAddrs_CORE, src, skew(1.0)),ALL,named('tbl_direct_dmv_DIDAddrs_CORE'));

//-------------DIDSSNs

direct_dmv_DIDSSNs_all := DATASET('~thor400_92::persist::ckelly::didSSNs_direct_dmv_sourced_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_direct_dmv_DIDSSNs_all := TABLE(direct_dmv_DIDSSNs_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_direct_dmv_DIDSSNs_all, DID_segment, skew(1.0)),ALL,named('tbl_direct_dmv_DIDSSNs_all'));

tbl_direct_dmv_DIDSSNs_CORE := TABLE(direct_dmv_DIDSSNs_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(direct_dmv_DIDSSNs_all.src), did_count := count(group)}, src, few);
output(sort(tbl_direct_dmv_DIDSSNs_CORE, src, skew(1.0)),ALL,named('tbl_direct_dmv_DIDSSNs_CORE'));

//-------------DIDDOBs

direct_dmv_DIDDOBs_all := DATASET('~thor400_92::persist::ckelly::didDOBs_direct_dmv_sourced_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_direct_dmv_DIDDOBs_all := TABLE(direct_dmv_DIDDOBs_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_direct_dmv_DIDDOBs_all, DID_segment, skew(1.0)),ALL,named('tbl_direct_dmv_DIDDOBs_all'));

tbl_direct_dmv_DIDDOBs_CORE := TABLE(direct_dmv_DIDDOBs_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(direct_dmv_DIDDOBs_all.src), did_count := count(group)}, src, few);
output(sort(tbl_direct_dmv_DIDDOBs_CORE, src, skew(1.0)),ALL,named('tbl_direct_dmv_DIDDOBs_CORE'));

//-------------no_ssn_if_no_dmv

no_ssn_if_no_dmv_all := DATASET('~thor400_92::persist::ckelly::no_ssn_if_no_dmv_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_no_ssn_if_no_dmv_all := TABLE(no_ssn_if_no_dmv_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_no_ssn_if_no_dmv_all, DID_segment, skew(1.0)),ALL,named('tbl_no_ssn_if_no_dmv_all'));

tbl_no_ssn_if_no_dmv_CORE := TABLE(no_ssn_if_no_dmv_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(no_ssn_if_no_dmv_all.src), did_count := count(group)}, src, few);
output(sort(tbl_no_ssn_if_no_dmv_CORE, src, skew(1.0)),ALL,named('tbl_no_ssn_if_no_dmv_CORE'));

//-------------no_dob_if_no_dmv

no_dob_if_no_dmv_all := DATASET('~thor400_92::persist::ckelly::no_dob_if_no_dmv_all_dmvs_201312', layout_direct_dmv,THOR);

tbl_no_dob_if_no_dmv_all := TABLE(no_dob_if_no_dmv_all, {DID_segment, did_count := count(group)}, DID_segment, few);
output(sort(tbl_no_dob_if_no_dmv_all, DID_segment, skew(1.0)),ALL,named('tbl_no_dob_if_no_dmv_all'));

tbl_no_dob_if_no_dmv_CORE := TABLE(no_dob_if_no_dmv_all(DID_segment = 'CORE'), {src, translate_src := MDR.sourceTools.fTranslateSource(no_dob_if_no_dmv_all.src), did_count := count(group)}, src, few);
output(sort(tbl_no_dob_if_no_dmv_CORE, src, skew(1.0)),ALL,named('tbl_no_dob_if_no_dmv_CORE'));
	
EXPORT sole_sourced_DMV_stats := '';