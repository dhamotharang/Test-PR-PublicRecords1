import LN_Property, doxie, standard, ut, doxie_ln, NID, LN_PropertyV2;

export key_addr_fid_prep(boolean isFast=false) := FUNCTION

persistPrefix := if (isFast,'property_fast','ln_property');

// owners when using LN data
fs0   := LN_PropertyV2_Fast.CleanSearch(false);
fs1   := LN_PropertyV2_Fast.CleanSearch(true, true);

fs		:= if(isFast,fs1,fs0);
fa		:= if(isFast,LN_PropertyV2_Fast.Files.basedelta.assessment,ln_propertyv2.File_Assessment);
fd		:= if(isFast,LN_PropertyV2_Fast.Files.basedelta.deed_mortg,ln_propertyv2.File_Deed);
fafd	:= if(isFast,LN_PropertyV2_Fast.Files.basedelta.addl_frs_d,ln_propertyv2.File_addl_fares_deed);

all_prop_ddp := doxie_ln.Fn_ComputeOwnerForKeyv2(fs,fa,fd,fafd).records;

// owners when keeping LN out
fs_noln := fs(ln_fares_id[1] <> 'D');
fa_noln := fa(ln_fares_id[1] <> 'D');
fd_noln := fd(ln_fares_id[1] <> 'D');

fs_nofares := fs(ln_fares_id[1] <> 'R');
fa_nofares := fa(ln_fares_id[1] <> 'R');
fd_nofares := fd(ln_fares_id[1] <> 'R');

noln_prop_ddp := doxie_ln.Fn_ComputeOwnerForKeyv2(fs_noln,fa_noln,fd_noln,fafd).records;

nofares_prop_ddp :=doxie_ln.Fn_ComputeOwnerForKeyv2(fs_nofares,fa_nofares,fd_nofares,fafd).records;

// Get all the properties ready for the key
dd00 := LN_PropertyV2_Fast.CleanSearch(false);
dd01 := LN_PropertyV2_Fast.CleanSearch(true);
dd02 := if(isFast,dd01,dd00);
dd0 := dd02(prim_name!='' and zip!='');

dd0_rec := {dd0.prim_name,dd0.prim_range,dd0.zip,dd0.predir,dd0.postdir,dd0.suffix,dd0.sec_range,dd0.lname, dd0.fname, dd0.name_suffix, dd0.source_code,dd0.ln_fares_id};

dd0_rec make_dd0_rec(dd0 l) := transform
	self.fname := NID.PreferredFirstVersionedStr(l.fname, NID.version);
	self := l;
end;

dd0_ddp := dedup(sort(distribute(project(dd0, make_dd0_rec(left)), hash(prim_name, zip, prim_range)),record, local),
			record, local);



ddr := record
	dd0_rec;
	boolean owner := false;
	boolean LN_owner := false;
	boolean nofares_owner := false;
end;

//Append the LN owner flag 
ddr addLNowner(dd0_ddp l, all_prop_ddp r) := transform
	self.LN_owner := r.zip5 <> '';
	self := l;
end;

dd1 := join(dd0_ddp, all_prop_ddp,
		   left.prim_name = right.prim_name and 
		   left.prim_range = right.prim_range and 
		   left.zip = right.zip5 and 
		   left.predir = right.predir and 
		   left.postdir = right.postdir and 
		   left.suffix = right.addr_suffix and 
		   left.sec_range = right.sec_Range and 
		   left.lname = right.lname and  
		   left.fname = right.fname and
		   left.name_suffix = right.name_suffix,
		   addLNowner(left, right), left outer, local);
		   
//Append the owner flag 
ddr addowner(dd1 l, noln_prop_ddp r) := transform
	self.owner := r.zip5 <> '';
	self := l;
end;

dd := join(dd1, noln_prop_ddp,
		   left.prim_name = right.prim_name and 
		   left.prim_range = right.prim_range and 
		   left.zip = right.zip5 and 
		   left.predir = right.predir and 
		   left.postdir = right.postdir and 
		   left.suffix = right.addr_suffix and 
		   left.sec_range = right.sec_Range and 
		   left.lname = right.lname and  
		   left.fname = right.fname and
		   left.name_suffix = right.name_suffix,
		   addowner(left, right), left outer, local);


ddr addnofaresowner(dd l,  nofares_prop_ddp r) := transform
	self.nofares_owner :=r.zip5 <>'';
	self := l;
end;

ddd := join(dd,nofares_prop_ddp,
		   left.prim_name = right.prim_name and 
		   left.prim_range = right.prim_range and 
		   left.zip = right.zip5 and 
		   left.predir = right.predir and 
		   left.postdir = right.postdir and 
		   left.suffix = right.addr_suffix and 
		   left.sec_range = right.sec_Range and 
		   left.lname = right.lname and  
		   left.fname = right.fname and
		   left.name_suffix = right.name_suffix,
		   addnofaresowner(left, right), left outer, local);
		   
dkey_addr_fid_prep := ddd;// : persist('persist::'+persistPrefix+'_addr_fid');

return dkey_addr_fid_prep;
END;