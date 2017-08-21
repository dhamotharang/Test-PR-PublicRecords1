import ut,header,mdr;

inf := header.file_headers(header.Blocked_data());

header.mac_populate_matchrecs(inf,outf,'propagated_header_matchrecs',true)

export Propagated_header_matchrecs := outf;