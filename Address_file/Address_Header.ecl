import Header;

src_to_filter := ['FA','FB','FP','LA','LP'];

header_in   := header.File_Headers(src not in src_to_filter);
header_filt := header_in((prim_range<>'' or prim_name<>'') and zip<>'' and (integer)zip4<>0);

address_file.Layout_Clean_Address_FieldsToKeep tHeader(header_filt l) := transform
 self := l;
end;

header_      := project   (header_filt,tHeader(left));

//sort descending on dt_last_seen should return the latest city for that zip
header_dist  := distribute(header_,    hash(prim_range,predir,prim_name,postdir,sec_range,zip));
header_sort  := sort      (header_dist,     prim_range,predir,prim_name,postdir,sec_range,zip,-dt_last_seen,local);
header_dedup := dedup     (header_sort,     prim_range,predir,prim_name,postdir,sec_range,zip,local);

address_file.Layout_address_file tMaptoAddresslayout(header_dedup l) := transform
 self.address_id := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_header := 'Y';
 self            := l;
 self            := [];
end;

export Address_Header := project(header_dedup,tMaptoAddresslayout(left));// : persist('~thor_data400::persist::address_header','thor_dell400_2');
