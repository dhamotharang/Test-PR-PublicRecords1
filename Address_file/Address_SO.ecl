import okc_sexual_offenders;

so_in   := okc_sexual_offenders.File_OKC_Cleaned_SearchFile;
so_filt := so_in((prim_range<>'' or prim_name<>'') and zip<>'' and err_stat[1]='S');

address_file.Layout_Clean_Address_FieldsToKeep tSO(so_filt l) := transform
 self.suffix    := l.addr_suffix;
 self.city_name := l.v_city_name;
 self.county    := l.fips_county;
 self.dt_last_seen := (unsigned3)(string)l.dt_last_reported[1..6];
 self           := l;
end;

so_      := project(so_filt,tSO(left));

so_dist  := distribute(so_,    hash(prim_range,predir,prim_name,postdir,sec_range,zip));
so_sort  := sort      (so_dist,     prim_range,predir,prim_name,postdir,sec_range,zip,-dt_last_seen,local);
so_dedup := dedup     (so_sort,     prim_range,predir,prim_name,postdir,sec_range,zip,local);

address_file.Layout_address_file tMaptoAddresslayout(so_dedup l) := transform
 self.address_id := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_so     := 'Y';
 self            := l;
 self            := [];
end;

export Address_SO := project(so_dedup,tMaptoAddresslayout(left));// : persist('~thor_data400::persist::address_so','400way');