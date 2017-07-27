import ut;

file_header_wa_out := dataset('~thor_data400::base::header_wa',{unsigned6 did},flat);

export file_header_wa:=IF(thorlib.nodes() = 400, file_header_wa_out,distribute(file_header_wa_out,hash(did))); 


