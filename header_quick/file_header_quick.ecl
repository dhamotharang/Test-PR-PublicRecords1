import header, ut, data_services;

d1:=dataset(data_services.Data_location.prefix('default')+'thor_data400::base::quick_header', header.Layout_Header, thor);
d2 := header.fn_block_records.filter(d1);
d:= project(d2,transform({d2},self.dob:=if(left.src='TN',0,left.dob),self:=left));
export file_header_quick := d;