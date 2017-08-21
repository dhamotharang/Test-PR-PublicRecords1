export fn_get_title_from_header (dataset(header.Layout_Header) p) := function

titles:=table(header.file_headers,{did,title},did,title,local,few) :independent;

return join(distribute(p,hash(did)),distribute(titles,hash(did))
					,left.did=right.did
					,transform({p}
											,self.title:=right.title
											,self:=left)
					,left outer
					,local);
end;