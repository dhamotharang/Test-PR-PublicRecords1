import header,ut,header_slimsort;
h := header.file_headers;
export Layout_Name_Address := record
	h.did;
	header_slimsort.Layout_Name_Address_NoDID;
end;