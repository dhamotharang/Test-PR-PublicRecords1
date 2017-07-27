export Mac_GetPropertyCode(in_prop,out_prop,key, Fares_file_name,Fares_field_name,
				prop_code,prop_field_new) := MACRO

#uniquename(getnewfield)

	recordof(in_prop) %getnewfield%(in_prop l, key r) :=transform
		self.prop_field_new := if(L.prop_field_new = '',r.long_desc,l.prop_field_new);
		self := l;
	END;
	
	out_prop := join(in_prop,key,keyed(right.file_name=Fares_file_name) and 
								 keyed(right.field_name=Fares_field_name) and
								 keyed(left.vendor_source_flag = right.field_name2) and 
								 keyed(left.prop_code = right.code),%getnewfield%(left,right),
							left outer, keep(1));
	
	
ENDMACRO;


	