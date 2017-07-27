// Propagate Address Field
export MAC_PADDR(field_name, address_type) := macro
self.field_name := map((address_type = 1 and (r.corp_address1_effective_date <> '' or r.corp_address1_line1 <> '' or r.corp_address1_line2 <> '')) or
                       (address_type = 2 and (r.corp_address2_effective_date <> '' or r.corp_address2_line1 <> '' or r.corp_address2_line2 <> '')) or
					   (address_type = 3 and (r.corp_ra_name <> '' or r.corp_ra_effective_date <> '' or r.corp_ra_address_line1 <> '' or r.corp_ra_address_line2 <> '')) => r.field_name,
					   l.field_name);
endmacro;