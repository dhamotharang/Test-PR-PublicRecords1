import address_file,DayBatchPCNSR;

pcnsr_in   := daybatchpcnsr.File_PCNSR;
pcnsr_filt := pcnsr_in((prim_range<>'' or prim_name<>'') and zip<>'' and err_stat[1]='S');

address_file.Layout_Clean_Address_FieldsToKeep tHeader(pcnsr_filt l) := transform
 self.suffix       := l.addr_suffix;
 self.city_name    := l.v_city_name;
 self.county       := l.county[3..5];
 self.dt_last_seen := (unsigned3)l.refresh_date;
 self              := l;
end;

pcnsr_      := project   (pcnsr_filt,tHeader(left));

pcnsr_dist  := distribute(pcnsr_,    hash(prim_range,predir,prim_name,postdir,sec_range,zip));
pcnsr_sort  := sort      (pcnsr_dist,     prim_range,predir,prim_name,postdir,sec_range,zip,-dt_last_seen,local);
pcnsr_dedup := dedup     (pcnsr_sort,     prim_range,predir,prim_name,postdir,sec_range,zip,local);

address_file.Layout_address_file tMaptoAddresslayout(pcnsr_dedup l) := transform
 self.address_id := hash64(l.prim_range,l.prim_name,l.sec_range,l.zip);
 self.src_pcnsr  := 'Y';
 self            := l;
 self            := [];
end;

export Address_PCNSR := project(pcnsr_dedup,tMaptoAddresslayout(left));// : persist('~thor_data400::persist::address_PCNSR','thor_dell400_2');