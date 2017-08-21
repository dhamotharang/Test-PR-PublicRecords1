import header;
hdrs := Header.File_Headers;
//Get good 10 digit phones from the hdrs 
f_hdrs := hdrs((string)phone != '' and length(stringlib.stringfilter((string)phone,'0123456789')) = 10 and 
			(string)phone[7..10] != '0000' and (string)phone[7..10] != '9999');
dist_hdrs := distribute(f_hdrs,hash32((string)phone));
s_hdrs := sort(dist_hdrs,(string)phone,local) : PERSIST('~thor_data400::persist::dist_header');

export fileHeaders_filteredforBadPhones := s_hdrs;