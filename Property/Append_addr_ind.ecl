IMPORT ut;

EXPORT Append_addr_ind(dataset(Property.layout_header_append.inrec) in) := FUNCTION

addresses := dataset(ut.foreign_aprod + 'thor_data400::base::insuranceheader::unique_addresses',Property.layout_header_append.addrrec,thor);

concat := join(in,addresses,
            left.did = right.did AND
						left.prim_range = right.prim_range AND
 					  left.prim_name = right.prim_name   AND
					  left.sec_range = right.sec_range   AND
						left.city = right.city AND
						left.st   = right.st,
						transform(Property.layout_header_append.outrec,
						          self.addr_ind      := right.addr_ind,
											self.best_addr_ind := right.best_addr_ind,
											self := left, self:=[]), left outer, hash);
											
return concat;
end;
