pnames_rec := record
 string175 listing_name;
 string1   lf;
 string70  pname1;
 string3   pname1_score;
 string70  cname1;
 string70  pname2;
 string3   pname2_score;
 string70  cname2;
 string70  pname3;
 string3   pname3_score;
 string70  cname3;
 string70  pname4;
 string3   pname4_score;
 string70  cname4;
 string70  pname5;
 string3   pname5_score;
 string70  cname5;
end;

dQsentname := distribute(sort(dataset('~thor_data400::in::qsent_cn',pnames_rec,flat),listing_name),hash(listing_name));

dQsentmaster := distribute(sort(dataset('~thor_data400::in::qsent::20060109::master_file',qsent.Layout_Qsent_Master, CSV(HEADING(0), SEPARATOR(['\t']), TERMINATOR(['\r\n', '\n']))),listing_name),hash(listing_name));

temp_rec := record
 qsent.Layout_Qsent_Master_Clean;
 string90 csz;
end;

temp_rec join_pnames(dQsentmaster l, dQsentname r) := transform
 self := l;
 self.pname1       := r.pname1;
 self.pname1_score := r.pname1_score;
 self.cname1       := r.cname1;
 self.pname2       := r.pname2;
 self.pname2_score := r.pname2_score;
 self.cname2       := r.cname2;
 self.pname3       := r.pname3;
 self.pname3_score := r.pname3_score;
 self.cname3       := r.cname3;
 self.pname4       := r.pname4;
 self.pname4_score := r.pname4_score;
 self.cname4       := r.cname4;
 self.pname5       := r.pname5;
 self.pname5_score := r.pname5_score;
 self.cname5       := r.cname5;
 self.clean_addr   := '';
 self.csz          := trim(l.city,left,right)+' '+trim(l.st,left,right)+' '+trim(l.zip9,left,right);
end;

dQsent_pnames := join(dQsentmaster,dQsentname,
                     trim(left.listing_name[1..175],left,right)=trim(right.listing_name[1..175],left,right),
					 join_pnames(left,right),
					 left outer,local);
					 
Address.MAC_Address_Clean(dQsent_pnames,addr1,csz,true,dQsent_pnames_addr);					 
					 					 
qsent.Layout_Qsent_Master_Clean map_clean_addr(dQsent_pnames_addr l) := transform
 self.clean_addr := l.clean;
 self            := l;
end;

dQsent_clean := project(dQsent_pnames_addr,map_clean_addr(left));

output(dQsent_clean,,'in::qsent::20060109::master_file_clean',__compressed__,overwrite);