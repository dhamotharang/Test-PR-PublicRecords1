import header, ut, data_services,dx_header;

d1:=dataset(data_services.foreign_prod+'thor_data400::base::quick_header', header.Layout_Header, thor);
d2 := header.fn_block_records.filter(d1);
d:= project(d2,transform(dx_header.layout_header,self.dob:=if(left.src='TN',0,left.dob),self:=left));
export file_header_quick := d;