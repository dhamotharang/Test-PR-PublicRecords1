import mdr, ut, header_slimsort, did_add, didville, ln_tu;

//logic
//step 1: externally did the data, only keep those records that did'd
//step 2: join existing header records to the source data -> intent is to establish uid/rid linking for header src key (LT only)
//step 3: project results from step 2 into current LT src layout
//step 4: project results from step 2 into rid_srcid layout

export mod_transunion(dataset(recordof(header.Layout_Header)) in_hdr) :=
module

transunion_only := in_hdr(mdr.sourceTools.SourceIsTransUnion(src));

header.Layout_Header t_re_did_prep(header.Layout_Header le) := transform
 self.did := 0;
 self     := le;
end;

p_re_did_prep := project(transunion_only,t_re_did_prep(left));

matchset := ['A','Z','D','P','S'];

did_add.MAC_Match_Flex
	(p_re_did_prep, matchset,					
	 ssn, dob, fname, mname, lname, name_suffix, 
	 prim_range, prim_name, sec_range, zip, st, phone, 
	 DID, header.Layout_Header, false, DID_Score_field,
	 75, re_did)

trans_did := re_did;// : persist('jtrost_transunion_did');

got_a_did := trans_did(did>0);

lt := got_a_did(src='LT');
tu := got_a_did(src='TU');

//output(lt,,'~thor_data400::base::header_transunion_lt_20070806',__compressed__,overwrite);
//output(tu,,'~thor_data400::base::header_transunion_tu_20070806',__compressed__,overwrite);

//as of the 20070724 header the counts were...
//lt records            1,193,834,500   
//lt records that did'd 1,112,061,381   
//tu records              425,055,421   
//tu records that did'd   358,170,323 

//fileservices.createsuperfile('~thor_data400::base::header_transunion_lt');
//fileservices.createsuperfile('~thor_data400::base::header_transunion_tu');
//fileservices.createsuperfile('~thor_data400::base::header_transunion');

//fileservices.addsuperfile('~thor_data400::base::header_transunion_lt','~thor_data400::base::header_transunion_lt_20070806');
//fileservices.addsuperfile('~thor_data400::base::header_transunion_tu','~thor_data400::base::header_transunion_tu_20070806');
//fileservices.addsuperfile('~thor_data400::base::header_transunion','~thor_data400::base::header_transunion_lt');
//fileservices.addsuperfile('~thor_data400::base::header_transunion','~thor_data400::base::header_transunion_tu');

shared lt_recs := dataset('~thor_data400::base::header_transunion_lt',header.Layout_Header,flat);

//this superfile has both LT and TU records in the header layout
//this will be treated as an in-line dataset and applied to doxie_build.fn_file_header_building and header.proc_int_to_string_for_despray
export transunion_records := dataset('~thor_data400::base::header_transunion',header.Layout_Header,flat);

ds_lt_as_src := ln_tu.File_In_LN_TU_Normalized;

r1 := record
 unsigned6 rid;
 recordof(ds_lt_as_src);
end;

r1 t_j1(ds_lt_as_src le, lt_recs ri) := transform
 self.rid := ri.rid;
 self     := le;
end;


shared j1 := join(ds_lt_as_src,lt_recs,
                  left.orig_perm_id = right.vendor_id   and
		          left.orig_ssn     = right.ssn         and
		          left.clean_name[6..25]  = right.fname and
		          left.clean_name[26..45] = right.mname and
		          left.clean_name[46..65] = right.lname and
		          left.clean[1..10]       = right.prim_range and
		          left.clean[13..40]      = right.prim_name  and
		          left.clean[57..64]      = right.sec_range  and
		          left.clean[117..121]    = right.zip,
		          t_j1(left,right)
		         );// : persist('jtrost_transunion_lt_join_to_src');
		   
//project into ln_tu as_source layout
LN_TU.Layout_In_Header_UID_SRC t_project_lt_as_src(j1 le) := transform
 self := le;
end;

new_lt_as_src := dedup(project(j1,t_project_lt_as_src(left)),record);
//output(new_lt_as_src,,'~thor_data400::base::header_transunion_lt_as_source_20070806',__compressed__,overwrite);

//above dataset created and added to superfile below
export transunion_lt_as_source := dataset('~thor_data400::base::header_transunion_lt_as_source',ln_tu.Layout_In_Header_UID_SRC,flat);

//project to rid_srcid layout
header.Layout_RID_SrcID t_project_to_rid_srcid(j1 le) := transform
 self := le;
end;

new_lt_rid_srcid := dedup(project(j1,t_project_to_rid_srcid(left)),record);
//output(new_lt_rid_srcid,,'~thor_data400::base::header_transunion_lt_rid_srcid_20070806',__compressed__,overwrite);

//above dataset created and added to superfile below
export transunion_lt_rid_srcid := dataset('~thor_data400::base::header_transunion_lt_rid_srcid',header.Layout_RID_SrcID,flat);

end;