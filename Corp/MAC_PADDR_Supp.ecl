// Propagate Address Field
export MAC_PADDR_Supp(field_name, address_type) := macro
self.field_name := map((address_type = 1 and (r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '')) or
                       (address_type = 2 and (r.supp_address_effective_date <> '' or r.supp_address_line1 <> '' or r.supp_address_line2 <> ''))  => r.field_name,
					   l.field_name);
endmacro;