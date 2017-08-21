
gongh := Gong.File_History;
f_gongh := gongh(phone10 != '' and length(stringlib.stringfilter(phone10,'0123456789')) = 10 and 
			phone10[7..10] != '0000' and phone10[7..10] != '9999' and publish_code != 'N');

d_gongh	:=	dedup(f_gongh,phone10,all);
s_gongh := sort(distribute(d_gongh,hash32(phone10)),phone10,local) : PERSIST('~thor_data400::persist::dist_gongH');

export fileGongH_filteredforBadPhonesandNP := s_gongh;
