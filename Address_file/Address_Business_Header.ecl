import business_header,mdr;

business_header_in   := business_header.File_Business_Header(not MDR.sourceTools.SourceIsLnPropertyV2(source));
business_header_filt := business_header_in((prim_range<>'' or prim_name<>'') and zip<>0 and zip4<>0);

rec := record
 address_file.Layout_Clean_Address_FieldsToKeep;
 business_header_filt.source;
end;

rec tBusinessHeader(business_header_filt l) := transform
 self.source       := l.source;
 self.suffix       := l.addr_suffix;
 self.city_name    := l.city;
 self.st           := l.state;
 self.zip          := (string5)intformat(l.zip,5,1);
 self.zip4         := (string4)intformat(l.zip4,4,1);
 self.dt_last_seen := (unsigned3)l.dt_last_seen[1..6];
 self              := l;
end;

business_header_      := project   (business_header_filt,tBusinessHeader(left));

business_header_dist  := distribute(business_header_,    hash(prim_range,predir,prim_name,postdir,sec_range,zip));
business_header_sort  := sort      (business_header_dist,     prim_range,predir,prim_name,postdir,sec_range,zip,-dt_last_seen,local);
business_header_dedup := dedup     (business_header_sort,     prim_range,predir,prim_name,postdir,sec_range,zip,local);

address_file.Layout_address_file tMaptoAddresslayout(business_header_dedup L) := transform
 self.address_id     := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_bus_header := if(MDR.sourceTools.SourceIsGong_Government(l.source),'G','Y');
 self                := l;
 self                := [];
end;

export Address_Business_Header := project(business_header_dedup,tMaptoAddresslayout(left));// :persist('~thor_data400::persist::address_business_header','400way');