old_ := dataset('~thor_data400::in::corporate_direct::supp_father',corp.Layout_Corporate_Direct_Supp_in, flat)(corp_state_origin='MN');
new_ := corp.File_Corporate_Direct_Supp_Update;

outrec1 := record
 old_.corp_state_origin;
 old_.corp_vendor;
 count_ := count(group);
 //old_.corp_process_date;
 min_process_date                    := min(group,old_.corp_process_date);
 max_process_date                    := max(group,old_.corp_process_date);
 has_corp_key                        := ave(group,if(trim(old_.corp_key)!='',1,0));
 bad_corp_key_ct                     := count(group,old_.corp_key[1..3]!=old_.corp_vendor+'-');
 has_corp_vendor                     := ave(group,if(trim(old_.corp_vendor)!='',1,0));
 has_corp_sos_charter_nbr            := ave(group,if(trim(old_.corp_sos_charter_nbr)!='',1,0));
 has_corp_legal_name                 := ave(group,if(trim(old_.corp_legal_name)!='',1,0));
 has_corp_address1_type_cd           := ave(group,if(trim(old_.corp_address1_type_cd)!='',1,0));
 has_corp_address1_type_desc         := ave(group,if(trim(old_.corp_address1_type_desc)!='',1,0));
 has_corp_address1_line1             := ave(group,if(trim(old_.corp_address1_line1)!='',1,0));
 has_corp_address1_line2             := ave(group,if(trim(old_.corp_address1_line2)!='',1,0));
 has_corp_address1_line3             := ave(group,if(trim(old_.corp_address1_line3)!='',1,0));
 has_corp_address1_effective_date    := ave(group,if(trim(old_.corp_address1_effective_date)!='',1,0));
 bad_corp_address1_effective_date_ct := count(group,length(trim(old_.corp_address1_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.corp_address1_effective_date,'0123456789'),left,right)));
 //has_corp_phone_number               := ave(group,if(trim(old_.corp_phone_number)!='',1,0));
 //has_corp_phone_number_type_cd       := ave(group,if(trim(old_.corp_phone_number_type_cd)!='',1,0));
 //has_corp_phone_number_type_desc     := ave(group,if(trim(old_.corp_phone_number_type_desc)!='',1,0));
 //has_corp_email_address              := ave(group,if(trim(old_.corp_email_address)!='',1,0));
 //has_corp_web_address                := ave(group,if(trim(old_.corp_web_address)!='',1,0));
 has_supp_filing_reference_nbr       := ave(group,if(trim(old_.supp_filing_reference_nbr)!='',1,0));
 has_supp_filing_date                := ave(group,if(trim(old_.supp_filing_date)!='',1,0));
 bad_supp_filing_date_ct             := count(group,length(trim(old_.supp_filing_date,left,right))!=length(trim(stringlib.stringfilter(old_.supp_filing_date,'0123456789'),left,right)));
 has_supp_filing_cd                  := ave(group,if(trim(old_.supp_filing_cd)!='',1,0));
 has_supp_filing_desc                := ave(group,if(trim(old_.supp_filing_desc)!='',1,0));
 has_supp_name                       := ave(group,if(trim(old_.supp_name)!='',1,0));
 has_supp_type_cd                    := ave(group,if(trim(old_.supp_type_cd)!='',1,0));
 has_supp_type_desc                  := ave(group,if(trim(old_.supp_type_desc)!='',1,0));
 has_supp_exp_date                   := ave(group,if(trim(old_.supp_exp_date)!='',1,0));
 bad_supp_exp_date_ct                := count(group,length(trim(old_.supp_exp_date,left,right))!=length(trim(stringlib.stringfilter(old_.supp_exp_date,'0123456789'),left,right)));
 has_supp_location_cd                := ave(group,if(trim(old_.supp_location_cd)!='',1,0));
 has_supp_location_desc              := ave(group,if(trim(old_.supp_location_desc)!='',1,0));
 has_supp_cont_name                  := ave(group,if(trim(old_.supp_location_desc)!='',1,0));
 has_supp_cont_title_cd              := ave(group,if(trim(old_.supp_location_desc)!='',1,0));
 has_supp_cont_title_desc            := ave(group,if(trim(old_.supp_location_desc)!='',1,0));
 has_supp_cont_fein                  := ave(group,if(trim(old_.supp_cont_fein)!='',1,0));
 has_supp_cont_ssn                   := ave(group,if(trim(old_.supp_cont_ssn)!='',1,0));
 has_supp_cont_dob                   := ave(group,if(trim(old_.supp_cont_dob)!='',1,0));
 has_supp_cont_effective_date        := ave(group,if(trim(old_.supp_cont_effective_date)!='',1,0));
 bad_supp_cont_effective_date_ct     := count(group,length(trim(old_.supp_cont_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.supp_cont_effective_date,'0123456789'),left,right)));
 has_supp_address_type_cd            := ave(group,if(trim(old_.supp_address_type_cd)!='',1,0));
 has_supp_address_type_desc          := ave(group,if(trim(old_.supp_address_type_desc)!='',1,0));
 has_supp_address_line1              := ave(group,if(trim(old_.supp_address_line1)!='',1,0));
 has_supp_address_line2              := ave(group,if(trim(old_.supp_address_line2)!='',1,0));
 has_supp_address_line3              := ave(group,if(trim(old_.supp_address_line3)!='',1,0));
 has_supp_address_effective_date     := ave(group,if(trim(old_.supp_address_effective_date)!='',1,0));
 bad_supp_address_effective_date_ct  := count(group,length(trim(old_.supp_address_effective_date,left,right))!=length(trim(stringlib.stringfilter(old_.supp_address_effective_date,'0123456789'),left,right)));
 //has_supp_phone_number               := ave(group,if(trim(old_.supp_phone_number)!='',1,0));
 //has_supp_phone_number_type_cd       := ave(group,if(trim(old_.supp_phone_number_type_cd)!='',1,0));
 //has_supp_phone_number_type_desc     := ave(group,if(trim(old_.supp_phone_number_type_desc)!='',1,0));
 //has_supp_email_address              := ave(group,if(trim(old_.supp_email_address)!='',1,0));
 //has_supp_web_address                := ave(group,if(trim(old_.supp_web_address)!='',1,0));
end;

//old_stats := sort(table(old_,outrec1,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
//output(old_stats);

outrec2 := record
 new_.corp_state_origin;
 new_.corp_vendor;
 count_ := count(group);
 //new_.corp_process_date;
 min_process_date                    := min(group,new_.corp_process_date);
 max_process_date                    := max(group,new_.corp_process_date);
 has_corp_key                        := ave(group,if(trim(new_.corp_key)!='',1,0));
 bad_corp_key_ct                     := count(group,new_.corp_key[1..3]!=new_.corp_vendor+'-');
 has_corp_vendor                     := ave(group,if(trim(new_.corp_vendor)!='',1,0));
 has_corp_sos_charter_nbr            := ave(group,if(trim(new_.corp_sos_charter_nbr)!='',1,0));
 has_corp_legal_name                 := ave(group,if(trim(new_.corp_legal_name)!='',1,0));
 has_corp_address1_type_cd           := ave(group,if(trim(new_.corp_address1_type_cd)!='',1,0));
 has_corp_address1_type_desc         := ave(group,if(trim(new_.corp_address1_type_desc)!='',1,0));
 has_corp_address1_line1             := ave(group,if(trim(new_.corp_address1_line1)!='',1,0));
 has_corp_address1_line2             := ave(group,if(trim(new_.corp_address1_line2)!='',1,0));
 has_corp_address1_line3             := ave(group,if(trim(new_.corp_address1_line3)!='',1,0));
 has_corp_address1_effective_date    := ave(group,if(trim(new_.corp_address1_effective_date)!='',1,0));
 bad_corp_address1_effective_date_ct := count(group,length(trim(new_.corp_address1_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.corp_address1_effective_date,'0123456789'),left,right)));
 //has_corp_phone_number               := ave(group,if(trim(new_.corp_phone_number)!='',1,0));
 //has_corp_phone_number_type_cd       := ave(group,if(trim(new_.corp_phone_number_type_cd)!='',1,0));
 //has_corp_phone_number_type_desc     := ave(group,if(trim(new_.corp_phone_number_type_desc)!='',1,0));
 //has_corp_email_address              := ave(group,if(trim(new_.corp_email_address)!='',1,0));
 //has_corp_web_address                := ave(group,if(trim(new_.corp_web_address)!='',1,0));
 has_supp_filing_reference_nbr       := ave(group,if(trim(new_.supp_filing_reference_nbr)!='',1,0));
 has_supp_filing_date                := ave(group,if(trim(new_.supp_filing_date)!='',1,0));
 bad_supp_filing_date_ct             := count(group,length(trim(new_.supp_filing_date,left,right))!=length(trim(stringlib.stringfilter(new_.supp_filing_date,'0123456789'),left,right)));
 has_supp_filing_cd                  := ave(group,if(trim(new_.supp_filing_cd)!='',1,0));
 has_supp_filing_desc                := ave(group,if(trim(new_.supp_filing_desc)!='',1,0));
 has_supp_name                       := ave(group,if(trim(new_.supp_name)!='',1,0));
 has_supp_type_cd                    := ave(group,if(trim(new_.supp_type_cd)!='',1,0));
 has_supp_type_desc                  := ave(group,if(trim(new_.supp_type_desc)!='',1,0));
 has_supp_exp_date                   := ave(group,if(trim(new_.supp_exp_date)!='',1,0));
 bad_supp_exp_date_ct                := count(group,length(trim(new_.supp_exp_date,left,right))!=length(trim(stringlib.stringfilter(new_.supp_exp_date,'0123456789'),left,right)));
 has_supp_location_cd                := ave(group,if(trim(new_.supp_location_cd)!='',1,0));
 has_supp_location_desc              := ave(group,if(trim(new_.supp_location_desc)!='',1,0));
 has_supp_cont_name                  := ave(group,if(trim(new_.supp_cont_name)!='',1,0));
 has_supp_cont_title_cd              := ave(group,if(trim(new_.supp_cont_title_cd)!='',1,0));
 has_supp_cont_title_desc            := ave(group,if(trim(new_.supp_cont_title_desc)!='',1,0));
 has_supp_cont_fein                  := ave(group,if(trim(new_.supp_cont_fein)!='',1,0));
 has_supp_cont_ssn                   := ave(group,if(trim(new_.supp_cont_ssn)!='',1,0));
 has_supp_cont_dob                   := ave(group,if(trim(new_.supp_cont_dob)!='',1,0));
 has_supp_cont_effective_date        := ave(group,if(trim(new_.supp_cont_effective_date)!='',1,0));
 bad_supp_cont_effective_date_ct     := count(group,length(trim(new_.supp_cont_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.supp_cont_effective_date,'0123456789'),left,right)));
 has_supp_address_type_cd            := ave(group,if(trim(new_.supp_address_type_cd)!='',1,0));
 has_supp_address_type_desc          := ave(group,if(trim(new_.supp_address_type_desc)!='',1,0));
 has_supp_address_line1              := ave(group,if(trim(new_.supp_address_line1)!='',1,0));
 has_supp_address_line2              := ave(group,if(trim(new_.supp_address_line2)!='',1,0));
 has_supp_address_line3              := ave(group,if(trim(new_.supp_address_line3)!='',1,0));
 has_supp_address_effective_date     := ave(group,if(trim(new_.supp_address_effective_date)!='',1,0));
 bad_supp_address_effective_date_ct  := count(group,length(trim(new_.supp_address_effective_date,left,right))!=length(trim(stringlib.stringfilter(new_.supp_address_effective_date,'0123456789'),left,right)));
 //has_supp_phone_number               := ave(group,if(trim(new_.supp_phone_number)!='',1,0));
 //has_supp_phone_number_type_cd       := ave(group,if(trim(new_.supp_phone_number_type_cd)!='',1,0));
 //has_supp_phone_number_type_desc     := ave(group,if(trim(new_.supp_phone_number_type_desc)!='',1,0));
 //has_supp_email_address              := ave(group,if(trim(new_.supp_email_address)!='',1,0));
 //has_supp_web_address                := ave(group,if(trim(new_.supp_web_address)!='',1,0));
end;

new_stats := sort(table(new_,outrec2,corp_state_origin,corp_vendor,few),corp_state_origin,corp_vendor);
output(new_stats);
/*
stat_rec := record
 decimal2 counter_;
 string35 condition;
 string10 old_val;
 string10 new_val;
 real4    delta;
end;

stat_rec mapa(old_stats l, new_stats r) := transform
 self.counter_  := 1;
 self.condition := 'corp_state_origin + corp_vendor';
 self.old_val   := l.corp_state_origin+' - '+l.corp_vendor;
 self.new_val   := r.corp_state_origin+' - '+r.corp_vendor;
 self           := [];
end;

stat_rec mapb(old_stats l, new_stats r) := transform
 self.counter_  := 2;
 self.condition := 'count_';
 self.old_val   := (string10) l.count_;
 self.new_val   := (string10) r.count_;
 self           := [];
end;
		  
stat_rec mapc(old_stats l, new_stats r) := transform
 self.counter_  := 3;
 self.condition := 'min_process_date';
 self.old_val   := l.min_process_date;
 self.new_val   := r.min_process_date;
 self           := [];
end;

stat_rec mapd(old_stats l, new_stats r) := transform
 self.counter_  := 4;
 self.condition := 'max_process_date';
 self.old_val   := l.max_process_date;
 self.new_val   := r.max_process_date;
 self           := [];
end;

stat_rec mape(old_stats l, new_stats r) := transform
 self.counter_  := 5;
 self.condition := 'has_corp_key';
 self.old_val   := (string10)l.has_corp_key;
 self.new_val   := (string10)r.has_corp_key;
 self.delta     := l.has_corp_key - r.has_corp_key
end;
		  
stat_rec mapf(old_stats l, new_stats r) := transform
 self.counter_  := 6;
 self.condition := 'bad_corp_key_ct';
 self.old_val   := (string10)l.bad_corp_key_ct;
 self.new_val   := (string10)r.bad_corp_key_ct;
 self           := [];
end;
		 
stat_rec mapg(old_stats l, new_stats r) := transform
 self.counter_  := 7;
 self.condition := 'has_corp_vendor';
 self.old_val   := (string10)l.has_corp_vendor;
 self.new_val   := (string10)r.has_corp_vendor;
 self.delta     := l.has_corp_vendor - r.has_corp_vendor;
end;

stat_rec maph(old_stats l, new_stats r) := transform
 self.counter_  := 8;
 self.condition := 'has_corp_sos_charter_nbr';
 self.old_val   := (string10)l.has_corp_sos_charter_nbr;
 self.new_val   := (string10)r.has_corp_sos_charter_nbr;
 self.delta     := l.has_corp_sos_charter_nbr - r.has_corp_sos_charter_nbr;
end;

stat_rec mapi(old_stats l, new_stats r) := transform
 self.counter_  := 9;
 self.condition := 'has_corp_legal_name';
 self.old_val   := (string10)l.has_corp_legal_name;
 self.new_val   := (string10)r.has_corp_legal_name;
 self.delta     := l.has_corp_legal_name - r.has_corp_legal_name;
end;

stat_rec mapj(old_stats l, new_stats r) := transform
 self.counter_  := 10;
 self.condition := 'has_corp_address1_type_cd';
 self.old_val   := (string10)l.has_corp_address1_type_cd;
 self.new_val   := (string10)r.has_corp_address1_type_cd;
 self.delta     := l.has_corp_address1_type_cd - r.has_corp_address1_type_cd;
end;
		  
stat_rec mapk(old_stats l, new_stats r) := transform
 self.counter_  := 11;
 self.condition := 'has_corp_address1_type_desc';
 self.old_val   := (string10)l.has_corp_address1_type_desc;
 self.new_val   := (string10)r.has_corp_address1_type_desc;
 self.delta     := l.has_corp_address1_type_desc - r.has_corp_address1_type_desc;
end;

stat_rec mapl(old_stats l, new_stats r) := transform
 self.counter_  := 12;
 self.condition := 'has_corp_address1_line1';
 self.old_val   := (string10)l.has_corp_address1_line1;
 self.new_val   := (string10)r.has_corp_address1_line1;
 self.delta     := l.has_corp_address1_line1 - r.has_corp_address1_line1;
end;

stat_rec mapm(old_stats l, new_stats r) := transform
 self.counter_  := 13;
 self.condition := 'has_corp_address1_line2';
 self.old_val   := (string10)l.has_corp_address1_line2;
 self.new_val   := (string10)r.has_corp_address1_line2;
 self.delta     := l.has_corp_address1_line2 - r.has_corp_address1_line2;
end;

stat_rec mapn(old_stats l, new_stats r) := transform
 self.counter_  := 14;
 self.condition := 'has_corp_address1_line3';
 self.old_val   := (string10)l.has_corp_address1_line3;
 self.new_val   := (string10)r.has_corp_address1_line3;
 self.delta     := l.has_corp_address1_line3 - r.has_corp_address1_line3;
end;

stat_rec mapo(old_stats l, new_stats r) := transform
 self.counter_  := 15;
 self.condition := 'has_corp_address1_effective_date';
 self.old_val   := (string10)l.has_corp_address1_effective_date;
 self.new_val   := (string10)r.has_corp_address1_effective_date;
 self.delta     := l.has_corp_address1_effective_date - r.has_corp_address1_effective_date;
end;

stat_rec mapp(old_stats l, new_stats r) := transform
 self.counter_  := 16;
 self.condition := 'bad_corp_address1_effective_date_ct';
 self.old_val   := (string10)l.bad_corp_address1_effective_date_ct;
 self.new_val   := (string10)r.bad_corp_address1_effective_date_ct;
 self.delta     := [];
end;

stat_rec mapq(old_stats l, new_stats r) := transform
 self.counter_  := 17;
 self.condition := 'has_corp_phone_number';
 self.old_val   := (string10)l.has_corp_phone_number;
 self.new_val   := (string10)r.has_corp_phone_number;
 self.delta     := l.has_corp_phone_number - r.has_corp_phone_number;
end;

//stat_rec mapr(old_stats l, new_stats r) := transform
// self.counter_  := 18;
// self.condition := 'has_corp_phone_number_type_cd';
// self.old_val   := (string10)l.has_corp_phone_number_type_cd;
// self.new_val   := (string10)r.has_corp_phone_number_type_cd;
// self.delta     := l.has_corp_phone_number_type_cd - r.has_corp_phone_number_type_cd;
//end;

//stat_rec maps(old_stats l, new_stats r) := transform
// self.counter_  := 19;
// self.condition := 'has_corp_phone_number_type_desc';
// self.old_val   := (string10)l.has_corp_phone_number_type_desc;
// self.new_val   := (string10)r.has_corp_phone_number_type_desc;
// self.delta     := l.has_corp_phone_number_type_desc - r.has_corp_phone_number_type_desc;
//end;

//stat_rec mapt(old_stats l, new_stats r) := transform
// self.counter_  := 20;
// self.condition := 'has_corp_email_address';
// self.old_val   := (string10)l.has_corp_email_address;
// self.new_val   := (string10)r.has_corp_email_address;
// self.delta     := l.has_corp_email_address - r.has_corp_email_address;
//end;

//stat_rec mapu(old_stats l, new_stats r) := transform
// self.counter_  := 21;
// self.condition := 'has_corp_web_address';
// self.old_val   := (string10)l.has_corp_web_address;
// self.new_val   := (string10)r.has_corp_web_address;
// self.delta     := l.has_corp_web_address - r.has_corp_web_address;
//end;

stat_rec mapv(old_stats l, new_stats r) := transform
 self.counter_  := 22;
 self.condition := 'has_supp_filing_reference_nbr';
 self.old_val   := (string10)l.has_supp_filing_reference_nbr;
 self.new_val   := (string10)r.has_supp_filing_reference_nbr;
 self.delta     := l.has_supp_filing_reference_nbr - r.has_supp_filing_reference_nbr;
end;

stat_rec mapw(old_stats l, new_stats r) := transform
 self.counter_  := 23;
 self.condition := 'has_supp_filing_date';
 self.old_val   := (string10)l.has_supp_filing_date;
 self.new_val   := (string10)r.has_supp_filing_date;
 self.delta     := l.has_supp_filing_date - r.has_supp_filing_date;
end;

stat_rec mapx(old_stats l, new_stats r) := transform
 self.counter_  := 24;
 self.condition := 'bad_supp_filing_date_ct';
 self.old_val   := (string10)l.bad_supp_filing_date_ct;
 self.new_val   := (string10)r.bad_supp_filing_date_ct;
 self.delta     := l.bad_supp_filing_date_ct - r.bad_supp_filing_date_ct;
end;

stat_rec mapy(old_stats l, new_stats r) := transform
 self.counter_  := 25;
 self.condition := 'has_supp_filing_cd';
 self.old_val   := (string10)l.has_supp_filing_cd;
 self.new_val   := (string10)r.has_supp_filing_cd;
 self.delta     := l.has_supp_filing_cd - r.has_supp_filing_cd;
end;

stat_rec mapz(old_stats l, new_stats r) := transform
 self.counter_  := 26;
 self.condition := 'has_supp_filing_desc';
 self.old_val   := (string10)l.has_supp_filing_desc;
 self.new_val   := (string10)r.has_supp_filing_desc;
 self.delta     := l.has_supp_filing_desc - r.has_supp_filing_desc;
end;

stat_rec mapaa(old_stats l, new_stats r) := transform
 self.counter_  := 27;
 self.condition := 'has_supp_name';
 self.old_val   := (string10)l.has_supp_name;
 self.new_val   := (string10)r.has_supp_name;
 self.delta     := l.has_supp_name - r.has_supp_name;
end;

stat_rec mapab(old_stats l, new_stats r) := transform
 self.counter_  := 28;
 self.condition := 'has_supp_type_cd';
 self.old_val   := (string10)l.has_supp_type_cd;
 self.new_val   := (string10)r.has_supp_type_cd;
 self.delta     := l.has_supp_type_cd - r.has_supp_type_cd;
end;

stat_rec mapac(old_stats l, new_stats r) := transform
 self.counter_  := 29;
 self.condition := 'has_supp_type_desc';
 self.old_val   := (string10)l.has_supp_type_desc;
 self.new_val   := (string10)r.has_supp_type_desc;
 self.delta     := l.has_supp_type_desc - r.has_supp_type_desc;
end;

stat_rec mapad(old_stats l, new_stats r) := transform
 self.counter_  := 30;
 self.condition := 'has_supp_exp_date';
 self.old_val   := (string10)l.has_supp_exp_date;
 self.new_val   := (string10)r.has_supp_exp_date;
 self.delta     := l.has_supp_exp_date - r.has_supp_exp_date;
end;

stat_rec mapae(old_stats l, new_stats r) := transform
 self.counter_  := 31;
 self.condition := 'bad_supp_exp_date_ct';
 self.old_val   := (string10)l.bad_supp_exp_date_ct;
 self.new_val   := (string10)r.bad_supp_exp_date_ct;
 self.delta     := [];
end;

stat_rec mapaf(old_stats l, new_stats r) := transform
 self.counter_  := 32;
 self.condition := 'has_supp_location_cd';
 self.old_val   := (string10)l.has_supp_location_cd;
 self.new_val   := (string10)r.has_supp_location_cd;
 self.delta     := l.has_supp_location_cd - r.has_supp_location_cd;
end;

stat_rec mapag(old_stats l, new_stats r) := transform
 self.counter_  := 33;
 self.condition := 'has_supp_location_desc';
 self.old_val   := (string10)l.has_supp_location_desc;
 self.new_val   := (string10)r.has_supp_location_desc;
 self.delta     := l.has_supp_location_desc - r.has_supp_location_desc;
end;

stat_rec mapah(old_stats l, new_stats r) := transform
 self.counter_  := 34;
 self.condition := 'has_supp_cont_name';
 self.old_val   := (string10)l.has_supp_cont_name;
 self.new_val   := (string10)r.has_supp_cont_name;
 self.delta     := l.has_supp_cont_name - r.has_supp_cont_name;
end;

stat_rec mapai(old_stats l, new_stats r) := transform
 self.counter_  := 35;
 self.condition := 'has_supp_cont_title_cd';
 self.old_val   := (string10)l.has_supp_cont_title_cd;
 self.new_val   := (string10)r.has_supp_cont_title_cd;
 self.delta     := l.has_supp_cont_title_cd - r.has_supp_cont_title_cd;
end;

stat_rec mapaj(old_stats l, new_stats r) := transform
 self.counter_  := 36;
 self.condition := 'has_supp_cont_title_desc';
 self.old_val   := (string10)l.has_supp_cont_title_desc;
 self.new_val   := (string10)r.has_supp_cont_title_desc;
 self.delta     := l.has_supp_cont_title_desc - r.has_supp_cont_title_desc;
end;

stat_rec mapak(old_stats l, new_stats r) := transform
 self.counter_  := 37;
 self.condition := 'has_supp_cont_fein';
 self.old_val   := (string10)l.has_supp_cont_fein;
 self.new_val   := (string10)r.has_supp_cont_fein;
 self.delta     := l.has_supp_cont_fein - r.has_supp_cont_fein;
end;

stat_rec mapal(old_stats l, new_stats r) := transform
 self.counter_  := 38;
 self.condition := 'has_supp_cont_ssn';
 self.old_val   := (string10)l.has_supp_cont_ssn;
 self.new_val   := (string10)r.has_supp_cont_ssn;
 self.delta     := l.has_supp_cont_ssn - r.has_supp_cont_ssn;
end;

stat_rec mapam(old_stats l, new_stats r) := transform
 self.counter_  := 39;
 self.condition := 'has_supp_cont_dob';
 self.old_val   := (string10)l.has_supp_cont_dob;
 self.new_val   := (string10)r.has_supp_cont_dob;
 self.delta     := l.has_supp_cont_dob - r.has_supp_cont_dob;
end;

stat_rec mapan(old_stats l, new_stats r) := transform
 self.counter_  := 40;
 self.condition := 'has_supp_cont_effective_date';
 self.old_val   := (string10)l.has_supp_cont_effective_date;
 self.new_val   := (string10)r.has_supp_cont_effective_date;
 self.delta     := l.has_supp_cont_effective_date - r.has_supp_cont_effective_date;
end;

stat_rec mapao(old_stats l, new_stats r) := transform
 self.counter_  := 41;
 self.condition := 'bad_supp_cont_effective_date_ct';
 self.old_val   := (string10)l.bad_supp_cont_effective_date_ct;
 self.new_val   := (string10)r.bad_supp_cont_effective_date_ct;
 self.delta     := [];
end;

stat_rec mapap(old_stats l, new_stats r) := transform
 self.counter_  := 42;
 self.condition := 'has_supp_address_type_cd';
 self.old_val   := (string10)l.has_supp_address_type_cd;
 self.new_val   := (string10)r.has_supp_address_type_cd;
 self.delta     := l.has_supp_address_type_cd - r.has_supp_address_type_cd;
end;

stat_rec mapaq(old_stats l, new_stats r) := transform
 self.counter_  := 43;
 self.condition := 'has_supp_address_type_desc';
 self.old_val   := (string10)l.has_supp_address_type_desc;
 self.new_val   := (string10)r.has_supp_address_type_desc;
 self.delta     := l.has_supp_address_type_desc - r.has_supp_address_type_desc;
end;

stat_rec mapar(old_stats l, new_stats r) := transform
 self.counter_  := 44;
 self.condition := 'has_supp_address_line1';
 self.old_val   := (string10)l.has_supp_address_line1;
 self.new_val   := (string10)r.has_supp_address_line1;
 self.delta     := l.has_supp_address_line1 - r.has_supp_address_line1;
end;

stat_rec mapas(old_stats l, new_stats r) := transform
 self.counter_  := 45;
 self.condition := 'has_supp_address_line2';
 self.old_val   := (string10)l.has_supp_address_line2;
 self.new_val   := (string10)r.has_supp_address_line2;
 self.delta     := l.has_supp_address_line2 - r.has_supp_address_line2;
end;

stat_rec mapat(old_stats l, new_stats r) := transform
 self.counter_  := 46;
 self.condition := 'has_supp_address_line3';
 self.old_val   := (string10)l.has_supp_address_line3;
 self.new_val   := (string10)r.has_supp_address_line3;
 self.delta     := l.has_supp_address_line3 - r.has_supp_address_line3;
end;

stat_rec mapau(old_stats l, new_stats r) := transform
 self.counter_  := 47;
 self.condition := 'has_supp_address_effective_date';
 self.old_val   := (string10)l.has_supp_address_effective_date;
 self.new_val   := (string10)r.has_supp_address_effective_date;
 self.delta     := l.has_supp_address_effective_date - r.has_supp_address_effective_date;
end;

stat_rec mapav(old_stats l, new_stats r) := transform
 self.counter_  := 48;
 self.condition := 'bad_supp_address_effective_date_ct';
 self.old_val   := (string10)l.bad_supp_address_effective_date_ct;
 self.new_val   := (string10)r.bad_supp_address_effective_date_ct;
 self.delta     := l.bad_supp_address_effective_date_ct - r.bad_supp_address_effective_date_ct;
end;

//stat_rec mapaw(old_stats l, new_stats r) := transform
// self.counter_  := 49;
// self.condition := 'has_supp_phone_number';
// self.old_val   := (string10)l.has_supp_phone_number;
// self.new_val   := (string10)r.has_supp_phone_number;
// self.delta     := l.has_supp_phone_number - r.has_supp_phone_number;
//end;

//stat_rec mapax(old_stats l, new_stats r) := transform
// self.counter_  := 50;
// self.condition := 'has_supp_phone_number_type_cd';
// self.old_val   := (string10)l.has_supp_phone_number_type_cd;
// self.new_val   := (string10)r.has_supp_phone_number_type_cd;
// self.delta     := l.has_supp_phone_number_type_cd - r.has_supp_phone_number_type_cd;
//end;

//stat_rec mapay(old_stats l, new_stats r) := transform
// self.counter_  := 51;
// self.condition := 'has_supp_phone_number_type_desc';
// self.old_val   := (string10)l.has_supp_phone_number_type_desc;
// self.new_val   := (string10)r.has_supp_phone_number_type_desc;
// self.delta     := l.has_supp_phone_number_type_desc - r.has_supp_phone_number_type_desc;
//end;

//stat_rec mapaz(old_stats l, new_stats r) := transform
// self.counter_  := 52;
// self.condition := 'has_supp_email_address';
// self.old_val   := (string10)l.has_supp_email_address;
// self.new_val   := (string10)r.has_supp_email_address;
// self.delta     := l.has_supp_email_address - r.has_supp_email_address;
//end;

//stat_rec mapaaa(old_stats l, new_stats r) := transform
// self.counter_  := 53;
// self.condition := 'has_supp_web_address';
// self.old_val   := (string10)l.has_supp_web_address;
// self.new_val   := (string10)r.has_supp_web_address;
// self.delta     := l.has_supp_web_address - r.has_supp_web_address;
//end;

a   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapa(left,right),lookup);
b   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapb(left,right),lookup);
c   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapc(left,right),lookup);
d   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapd(left,right),lookup);
e   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mape(left,right),lookup);
f   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapf(left,right),lookup);
g   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapg(left,right),lookup);
h   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,maph(left,right),lookup);
i   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapi(left,right),lookup);
j   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapj(left,right),lookup);
k   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapk(left,right),lookup);
l   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapl(left,right),lookup);
m   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapm(left,right),lookup);
n   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapn(left,right),lookup);
o   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapo(left,right),lookup);
p   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapp(left,right),lookup);
q   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapq(left,right),lookup);
r   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapr(left,right),lookup);
s   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,maps(left,right),lookup);
t   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapt(left,right),lookup);
u   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapu(left,right),lookup);
v   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapv(left,right),lookup);
w   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapw(left,right),lookup);
x   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapx(left,right),lookup);
y   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapy(left,right),lookup);
z   := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapz(left,right),lookup);
aa  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaa(left,right),lookup);
ab  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapab(left,right),lookup);
ac  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapac(left,right),lookup);
ad  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapad(left,right),lookup);
ae  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapae(left,right),lookup);
af  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaf(left,right),lookup);
ag  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapag(left,right),lookup);
ah  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapah(left,right),lookup);
ai  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapai(left,right),lookup);
aj  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaj(left,right),lookup);
ak  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapak(left,right),lookup);
al  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapal(left,right),lookup);
am  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapam(left,right),lookup);
an  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapan(left,right),lookup);
ao  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapao(left,right),lookup);
ap  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapap(left,right),lookup);
aq  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaq(left,right),lookup);
ar  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapar(left,right),lookup);
as_ := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapas(left,right),lookup);
at  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapat(left,right),lookup);
au  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapau(left,right),lookup);
av  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapav(left,right),lookup);
aw  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaw(left,right),lookup);
ax  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapax(left,right),lookup);
ay  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapay(left,right),lookup);
az  := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaz(left,right),lookup);
aaa := join(old_stats,new_stats,left.corp_state_origin=right.corp_state_origin,mapaaa(left,right),lookup);

concat := sort(a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t+u+v+w+x+y+z
              +aa+ab+ac+ad+ae+af+ag+ah+ai+aj+ak+al+am+an+ao+ap+aq+ar+as_+at+au+av+aw+ax+ay+az
			  +aaa
              ,counter_);
output(concat,all);
*/	