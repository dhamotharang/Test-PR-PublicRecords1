import LN_TU, header, ut;

/*
hdr_lt_recs  := header.transunion_did(src='LT');
ds_lt_as_src := ln_tu.File_In_LN_TU_Normalized;

r1 := record
 unsigned6 rid;
 recordof(ds_lt_as_src);
end;

r1 t_j1(ds_lt_as_src le, hdr_lt_recs ri) := transform
 self.rid := ri.rid;
 self     := le;
end;

//did a global join to avoid string/qstring join inabilities
shared j1 := join(ds_lt_as_src,hdr_lt_recs,
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
		         );
		   
//project into ln_tu as_source layout
LN_TU.Layout_In_Header_UID_SRC t_project_lt_as_src(j1 le) := transform
 self := le;
end;

new_lt_as_src := dedup(project(j1,t_project_lt_as_src(left)),record);
//in the event of a re-run, take the output and add to the superfile below
*/

export LN_TU_as_Source := dataset(ut.foreign_prod+'~thor_data400::base::header_transunion_lt_as_source',ln_tu.Layout_In_Header_UID_SRC,flat);