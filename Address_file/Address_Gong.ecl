import gong;

gong_in   := gong.File_GongBase;
gong_filt := gong_in((prim_range<>'' or prim_name<>'') and z5<>'' and err_stat[1]='S');

address_file.Layout_Clean_Address_FieldsToKeep tGong(gong_filt l) := transform
 self.city_name := l.v_city_name;
 self.zip       := l.z5;
 self.zip4      := l.z4;
 self.county    := l.county_code[3..5];
 self           := l;
end;

gong_      := project   (gong_filt,tGong(left));

gong_dist  := distribute(gong_,    hash(prim_range,predir,prim_name,postdir,sec_range,zip));
gong_sort  := sort      (gong_dist,     prim_range,predir,prim_name,postdir,sec_range,zip,local);
gong_dedup := dedup     (gong_sort,     prim_range,predir,prim_name,postdir,sec_range,zip,local);

address_file.Layout_address_file tMaptoAddresslayout(gong_dedup l) := transform
 self.address_id := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_gong   := 'Y';
 self            := l;
 self            := [];
end;

export Address_Gong := project(gong_dedup,tMaptoAddresslayout(left));// : persist('~thor_data400::persist::address_gong','thor400_92');