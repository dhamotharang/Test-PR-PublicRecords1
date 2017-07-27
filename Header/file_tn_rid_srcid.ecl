import TransUnionCred,ut;

as_source := distribute(TransUnionCred.as_source(,true),hash((unsigned)party_id));
tn_did    := distribute(header.File_TN_did,hash((unsigned)vendor_id));

header.Layout_RID_SrcID t(as_source l, tn_did r) := transform
 self := l;
 self := r;
end;

j1 := join(as_source,tn_did
				,   (unsigned)left.party_id   = (unsigned)right.vendor_id
				and ut.NNEQ(left.ssn,right.ssn)
				and left.fname      = right.fname
				and left.mname      = right.mname
				and left.lname      = right.lname
				and left.prim_range = right.prim_range
				and left.prim_name  = right.prim_name
				and	ut.NNEQ(left.sec_range, right.sec_range)
				and left.zip        = right.zip
				and ut.nneq_date(left.clean_dob, right.dob)
				and	ut.NNEQ_Phone(left.phone,right.phone)
		   ,t(left,right)
			 ,local
		  );

new_tn_rid_srcid := dedup(j1,record);

export file_tn_rid_srcid := new_tn_rid_srcid:persist('~thor_data400::persist::file_tn_rid_srcid');