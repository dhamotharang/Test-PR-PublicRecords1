export fn_void_src_vendor_id (dataset(Layout_Header) inf)	:= function

Set_src_to_void_vendor_id :=[
								'SL'
								,'EL'
								,'AY'
							];

return	project(inf,transform(layout_header
												,SELF.vendor_id := if(left.src in Set_src_to_void_vendor_id,'',left.vendor_id)
												,self:=left));
end;