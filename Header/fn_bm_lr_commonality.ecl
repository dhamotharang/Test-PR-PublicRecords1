import ut;

//the suffix comparison in the old basic_match doesn't handle nneq's
//there are some differences in the handling of SSN's and DOB's in the old BM and LR
//1) BM matches on partial information but keeps the "fuller" value between the left and right datasets
//2) LR is projecting to layout_pairmatch so we do not have the ability to keep the "fuller" value

suffix_unk(string s1, string s2) := 
	ut.is_unk(s1) and ut.is_unk(s2) or
	ut.is_unk(s1) and s2='' or
	s1='' and ut.is_unk(s2);
	
phones_match(string p1, string p2) := 
	p1 = p2 or 
	stringlib.stringfind(p1, p2, 1) > 0 or
	stringlib.stringfind(p2, p1, 1) > 0;
	
export fn_bm_lr_commonality(
				 qstring20		l_fname
				,qstring20		l_lname
				,qstring10		l_prim_range
				,qstring28		l_prim_name
				,qstring5		l_zip
				,qstring20		r_fname
				,qstring20		r_lname
				,qstring10		r_prim_range				
				,qstring28		r_prim_name
				,qstring5		r_zip				
				,qstring20		l_mname
				,qstring20		r_mname
				,qstring5		l_name_suffix
				,qstring5		r_name_suffix
				,qstring8		l_sec_range
				,qstring8		r_sec_range
				,qstring10		l_phone
				,qstring10		r_phone
				,string2		l_src		
				,string2		r_src
				,unsigned8   l_RawAID 
				,unsigned8   r_RawAID 
				)

	:= function

	s:=

			l_fname			= r_fname
		and	l_lname			= r_lname
		and	if((l_prim_name		= r_prim_name
		and	l_prim_range	= r_prim_range
		and	l_zip			= r_zip
		and	l_sec_range=r_sec_range) or (l_RawAID <>0 and r_RawAID<>0 and l_RawAID = r_RawAID),true,false)
		and	ut.firstname_match(l_mname,r_mname)>0
		and (ut.NNEQ_Suffix(l_name_suffix, r_name_suffix) or suffix_unk(l_name_suffix,r_name_suffix))
		and	phones_match(trim(l_phone,all),trim(r_phone,all))
		and l_src			= r_src			
	   ;

	return s;

end;