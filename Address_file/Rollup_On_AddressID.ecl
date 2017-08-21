import ut;

files_in := Address_file.Address_Header
          + Address_file.Address_Business_Header
		  + Address_file.Address_PCNSR
		  + Address_file.Address_Property
		  + Address_file.Address_Gong
		  + Address_file.Address_SO;

files_dist := distribute(files_in,hash(address_id));
files_sort := sort(      files_dist,   address_id,local);

fn_keep_the_nonblank(string left_val, string right_val) := function
 
 string return_val := if(left_val<>'',left_val,right_val);
 
 return return_val;
end;

address_file.Layout_address_file tRollupOnAddressID(files_sort l, files_sort r) := transform
 self.address_id     := if(l.address_id    <>0, l.address_id    ,r.address_id);
 self.src_header     := fn_keep_the_nonblank(l.src_header,    r.src_header);
 self.src_bus_header := fn_keep_the_nonblank(l.src_bus_header,r.src_bus_header);
 self.src_pcnsr      := fn_keep_the_nonblank(l.src_pcnsr,     r.src_pcnsr);
 self.src_gong       := fn_keep_the_nonblank(l.src_gong,      r.src_gong);
 self.src_property   := fn_keep_the_nonblank(l.src_property,  r.src_property);
 self.src_so         := fn_keep_the_nonblank(l.src_so,        r.src_so);
 self.resident_flag  := '';
 self.business_flag  := '';
 self.govt_flag      := '';
 self.prim_range     := fn_keep_the_nonblank(l.prim_range,r.prim_range);
 self.predir         := fn_keep_the_nonblank(l.predir,    r.predir);
 self.prim_name      := fn_keep_the_nonblank(l.prim_name, r.prim_name);
 self.suffix         := '';
 self.postdir        := fn_keep_the_nonblank(l.postdir,   r.postdir);
 self.unit_desig     := '';
 self.sec_range      := fn_keep_the_nonblank(l.sec_range ,r.sec_range);
 self.city_name      := if((l.city_name <>'' and l.dt_last_seen>r.dt_last_seen) or trim(r.city_name)='',l.city_name,r.city_name);
 self.st             := if((l.st        <>'' and l.dt_last_seen>r.dt_last_seen) or trim(r.st)       ='',l.st       ,r.st);
 self.zip            := fn_keep_the_nonblank(l.zip,       r.zip);
 self.zip4           := '';
 self.county         := '';
 self.dt_last_seen   := ut.max2(l.dt_last_seen,r.dt_last_seen);
end;

pRollupOnAddressID := rollup(files_sort,left.address_id=right.address_id,tRolluponAddressID(left,right),local);
pReClean           := address_file.Reclean_Address(pRollupOnAddressID);

export Rollup_On_AddressID := pReClean;