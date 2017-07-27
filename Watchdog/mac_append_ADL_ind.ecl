import watchdog,header;
export Mac_append_ADL_ind(infile, outfile) := macro

#uniquename(seg_header)
%seg_header% := Header.fn_ADLSegmentation(header.file_headers).core_check_pst;
#uniquename(t_ind)
recordof(infile) %t_ind%(infile le, %seg_header% ri):= transform 
self.adl_ind := ri.ind;
self := le;
end;

outfile := join(distribute(infile, hash(did)), 
				     distribute(%seg_header%, hash(did)),
					 left.did = right.did,
					 %t_ind%(left, right),
					 left outer,
					 local);
					 
endmacro;