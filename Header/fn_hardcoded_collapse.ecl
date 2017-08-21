export fn_hardcoded_collapse(dataset(recordof(layout_header)) header_in) := function

	header_out:=join(header_in, file_hardcoded_collapse
								,left.rid=right.old_rid
								,transform({layout_header}
										,self.did:=if(right.old_rid>0,right.new_rid,left.did)
										,self:=left)
								,left outer
								,lookup);

	return header_out;

end;