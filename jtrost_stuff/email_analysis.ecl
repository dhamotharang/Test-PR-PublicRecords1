r_m1 := RECORD
  integer8 did;
  integer8 did_score;
  string email_address;
  string orig_first_name;
  string orig_last_name;
  string orig_address;
  string orig_city;
  string orig_state;
  string orig_zipcode;
  string orig_phone_number;
  string source_url;
  string ip_address;
  string date_timestamp;
  string gender_code;
  string orig_dob;
  string record_id;
 END;

r_om := RECORD
  integer8 did;
  integer8 did_score;
  string email_address;
  string orig_first_name;
  string orig_last_name;
  string segment;
  string flag;
  string orig_address;
  string orig_address2;
  string orig_city;
  string orig_state;
  string orig_zipcode;
 END;

ent	:=	entiera.File_Entiera_Base(orig_email<>'');
imp	:=	impulse_email.files.file_Impulse_Email_Base(email<>'');
acq	:=	DATASET(ut.foreign_dataland+'~thor_data200::base::acquireweb::20100416b', Acquireweb_Email.layouts.layout_Acquireweb_Base, THOR)(email<>'');
wa  :=  optincellphones.files.file_base(email<>'');
m1  :=  dataset(ut.foreign_dataland+'~thor_data400::out::outward_media',r_m1,flat)(email_address<>'');
om  :=  dataset(ut.foreign_dataland+'~thor_data200::base::outwardmedia_email_20091030',r_om,flat)(email_address<>'');

emailservice.mac_append_domain_flags(ent,ent_out,orig_email);
emailservice.mac_append_domain_flags(imp,imp_out,email);
emailservice.mac_append_domain_flags(acq,acq_out,email);
emailservice.mac_append_domain_flags(wa , wa_out,email);
emailservice.mac_append_domain_flags(m1 , m1_out,email_address);
emailservice.mac_append_domain_flags(om , om_out,email_address);

r1 := record
 string2   src;
 unsigned6 did;
 string100 email;
 string12  domain_type;
 string120 domain;
 string100 domain_root;
 string20  domain_ext;
 boolean   is_valid_domain_ext;
end;

ent1 := project(ent_out,transform({r1},self.src:='EN',self.email:=stringlib.stringtolowercase(left.orig_email),   self:=left));
imp1 := project(imp_out,transform({r1},self.src:='IM',self.email:=stringlib.stringtolowercase(left.email),        self:=left));
acq1 := project(acq_out,transform({r1},self.src:='AC',self.email:=stringlib.stringtolowercase(left.email),        self:=left));
wa1  := project(wa_out ,transform({r1},self.src:='WA',self.email:=stringlib.stringtolowercase(left.email),        self:=left));
m11  := project(m1_out ,transform({r1},self.src:='M1',self.email:=stringlib.stringtolowercase(left.email_address),self:=left));
om1  := project(om_out ,transform({r1},self.src:='OM',self.email:=stringlib.stringtolowercase(left.email_address),self:=left));

r1b := RECORD
  string2 src;
  unsigned6 did;
  string100 email;
  string12 domain_type;
  string120 domain;
  string100 domain_root;
  string20 domain_ext;
  boolean is_valid_domain_ext;
 END;

//concat  := (ent1+imp1+acq1+wa1+m11+om1) : persist('persist::jtrost_email1');
concat := dataset('~thor400_92::persist::jtrost_email1',r1b,flat);
//output(concat(domain='yahoo.net'),named('concat_yahoo_net'));
//output(count(concat(domain='yahoo.net')),named('concat_yahoo_net_cnt'));

output(count(dedup(sort(distribute(concat(is_valid_domain_ext=true),hash(email)),email,local),email,local)),named('unique_email_cnt'));

f1      := distribute(concat(did>0 and is_valid_domain_ext=true),hash(did));
hdr_seg := header.fn_adlsegmentation(header.file_headers).core_check_pst;

r2 := record
 f1;
 string10 ind;
 boolean  in_en;
 boolean  in_im;
 boolean  in_ac;
 boolean  in_wa;
 boolean  in_m1;
 boolean  in_om;
 boolean  has_edu;
 boolean  has_free;
 boolean  has_corp;
 boolean  has_isp;
 boolean  has_ameritrade;
 integer  email_cnt;
 integer  did_cnt;
end;

r2 x1(f1 le, hdr_seg ri) := transform
 self.ind            := ri.ind;
 self.in_en          := le.src='EN';
 self.in_im          := le.src='IM';
 self.in_ac          := le.src='AC';
 self.in_wa          := le.src='WA';
 self.in_m1          := le.src='M1';
 self.in_om          := le.src='OM';
 self.has_edu        := le.domain_type='edu';
 self.has_free       := le.domain_type='free';
 self.has_corp       := le.domain_type='corp' and le.domain_root<>'ameritrade';
 self.has_isp        := le.domain_type='isp';
 self.has_ameritrade := le.domain_root='ameritrade';
 self.email_cnt      := 1;
 self.did_cnt        := 1;
 self                := le;
end;

p1       := join(f1,hdr_seg,left.did=right.did,x1(left,right),local);
p1_dist1 := dedup(sort(distribute(p1,hash(did)),did,email,local),did,email,local);
p1_dist2 := dedup(sort(distribute(p1,hash(email)),email,did,local),email,did,local);
p1_dist3 := dedup(sort(distribute(p1,hash(email)),email,did,src,local),email,did,src,local);

//output(count(p1(domain_ext='.mil')),named('mils'));
//output(count(p1),named('p1_dist1_cnt'));
//output(sort(p1_dist1(did=147979062574),email),all);

r2 x2(r2 le, r2 ri) := transform
 self.in_en          := if(le.in_en         =true,le.in_en,         ri.in_en);
 self.in_im          := if(le.in_im         =true,le.in_im,         ri.in_im);
 self.in_ac          := if(le.in_ac         =true,le.in_ac,         ri.in_ac);
 self.in_wa          := if(le.in_wa         =true,le.in_wa,         ri.in_wa);
 self.in_m1          := if(le.in_m1         =true,le.in_m1,         ri.in_m1);
 self.in_om          := if(le.in_om         =true,le.in_om,         ri.in_om);
 self.has_edu        := if(le.has_edu       =true,le.has_edu,       ri.has_edu);
 self.has_free       := if(le.has_free      =true,le.has_free,      ri.has_free);
 self.has_corp       := if(le.has_corp      =true,le.has_corp,      ri.has_corp);
 self.has_isp        := if(le.has_isp       =true,le.has_isp,       ri.has_isp);
 self.has_ameritrade := if(le.has_ameritrade=true,le.has_ameritrade,ri.has_ameritrade);
 self.email_cnt      := le.email_cnt+1;
 self                := le;
end;

p2 := rollup(p1_dist1,left.did=right.did,x2(left,right),local) : persist('persist::jtrost_email2');
//output(count(p2),named('p2_cnt'));

f_test := p2(has_edu=false and has_free=false and has_corp=false and has_isp=false and has_ameritrade=false);
//output(count(f_test),named('no_specified_domain_type_cnt'));
//output(f_test,named('no_specified_domain_type_sample'));

r2 x3(r2 le, r2 ri) := transform
 self.in_en          := if(le.in_en         =true,le.in_en,         ri.in_en);
 self.in_im          := if(le.in_im         =true,le.in_im,         ri.in_im);
 self.in_ac          := if(le.in_ac         =true,le.in_ac,         ri.in_ac);
 self.in_wa          := if(le.in_wa         =true,le.in_wa,         ri.in_wa);
 self.in_m1          := if(le.in_m1         =true,le.in_m1,         ri.in_m1);
 self.in_om          := if(le.in_om         =true,le.in_om,         ri.in_om);
 self.has_edu        := if(le.has_edu       =true,le.has_edu,       ri.has_edu);
 self.has_free       := if(le.has_free      =true,le.has_free,      ri.has_free);
 self.has_corp       := if(le.has_corp      =true,le.has_corp,      ri.has_corp);
 self.has_isp        := if(le.has_isp       =true,le.has_isp,       ri.has_isp);
 self.has_ameritrade := if(le.has_ameritrade=true,le.has_ameritrade,ri.has_ameritrade);
 self.did_cnt        := le.did_cnt+1;
 self                := le;
end;

p3 := rollup(p1_dist2,left.email=right.email,x3(left,right),local) : persist('persist::jtrost_email3');
//output(count(p3),named('unique_emails_with_did1'));
//output(choosen(p3(domain_root='ameritrade' and ind='CORE'),1000),named('ameritrade_sample'));
output(count(p3(domain_type='corp')),named('corp_cnt'));
output(count(p3(domain_type='edu')),named('edu_cnt'));
f3 := p3(did_cnt>1);
//output(count(f3),named('f3_cnt'));

r2 x5(r2 le, r2 ri) := transform
 self := le;
end;

j1 := join(p1,f3,left.email=right.email,x5(left,right));
//output(choosen(sort(j1,email),1000),named('emails_with_more_than_one_did_sample'));

p4 := rollup(p1_dist3,left.email=right.email,x3(left,right),local) : persist('persist::jtrost_email4');
//output(count(p4),named('unique_emails_with_did2'));

r3 := record
 p2.ind;
 p2.has_edu;
 p2.has_free;
 p2.has_corp;
 p2.has_isp;
 p2.has_ameritrade;
 count_ := count(group);
end;

r4 := record
 p2.email_cnt;
 integer did_cnt := count(group);
end;

r5 := record
 p3.did_cnt;
 integer email_cnt := count(group);
end;

r6 := record
 p2.ind;
 count_ := count(group);
end;

r7 := record
 p1_dist3.src;
 integer src_cnt := count(group);
end;

r8 := record
 p4.in_ac;
 p4.in_en;
 p4.in_im;
 p4.in_wa;
 p4.in_m1;
 p4.in_om;
 count_ := count(group);
end;

r9a := record
 concat.domain_root;
 //concat.domain_type;
 integer ttl_root_cnt            := count(group);
 integer has_did                 := count(group,concat.did>0);
 integer foreign_tld_cnt         := count(group,concat.domain_ext='foreign_tld');
 integer has_did_and_foreign_cnt := count(group,concat.did>0 and concat.domain_ext='foreign_tld');
 integer com_cnt                 := count(group,concat.domain_ext='.com');
 integer net_cnt                 := count(group,concat.domain_ext='.net');
 integer edu_cnt                 := count(group,concat.domain_ext='.edu');
 integer other_cnt               := count(group,concat.domain_ext<>'.com' and concat.domain_ext<>'.net' and concat.domain_ext<>'.edu');
end;

r9b := record
 concat.domain_root;
 concat.domain_ext;
 count_ := count(group);
end;

r9c := record
 concat.domain_root;
 concat.domain_type;
 count_ := count(group);
end;

ta7_prep := dedup(sort(distribute(concat(is_valid_domain_ext=true),hash(email)),email,-did,local),email,local);

ta7a := table(ta7_prep,r9a,domain_root/*,domain_type*/,few);
ta7b := dedup(sort(table(ta7_prep,r9b,domain_root,domain_ext,few),domain_root,-count_),domain_root);
ta7c := dedup(sort(table(ta7_prep,r9c,domain_root,domain_type,few),domain_root,-count_),domain_root);

//output(ta7a(domain_root='yahoo'),named('ta7a_yahoo'));
//output(count(ta7a(domain_root='yahoo')),named('ta7a_yahoo_cnt'));

r9d := record
 ta7a;
 string20 top_ext;
end;

r9d x6(ta7a le, ta7b ri) := transform
 self.top_ext := ri.domain_ext;
 self         := le;
end;

j2 := join(ta7a,ta7b,left.domain_root=right.domain_root,x6(left,right));

r9e := record
 j2;
 string12 top_type;
end;

r9e x7(j2 le, ta7c ri) := transform
 self.top_type := ri.domain_type;
 self          := le;
end;

j3 := join(j2,ta7c,left.domain_root=right.domain_root,x7(left,right));

r10 := record
 p3.domain_type;
 count_ := count(group);
end;

ta1  := sort(table(p2,r3,ind,has_edu,has_free,has_corp,has_isp,has_ameritrade,few),ind,-has_edu,-has_corp,-has_ameritrade,-has_isp,-has_free);
ta2  := sort(table(p2,r4,email_cnt,few),email_cnt);
ta3  := sort(table(p3,r5,did_cnt,few),did_cnt);
ta4  := sort(table(p2,r6,ind,few),ind);
ta5  := sort(table(p1_dist3,r7,src,few),-src_cnt);
ta6  := sort(table(p4,r8,in_en,in_im,in_ac,in_wa,in_m1,in_om,few),-count_,-in_ac,-in_en,-in_im,in_m1,in_om,-in_wa);
ta8  := sort(table(p3,r10,domain_type,few),-count_);

output(ta1,all,named('email_types_by_segment'));
output(ta4,named('email_population_by_segment'));
output(choosen(ta2,1000),named('nbr_of_emails_per_person_distribution'));
output(choosen(ta3,1000),named('nbr_of_people_per_email_distribution'));
output(ta5,named('email_did_combinations_per_source'));
output(ta6,named('overlapping_emails_per_source'));
output(choosen(sort(j3,-ttl_root_cnt),1000),named('stats_on_the_top_1k_domains'));
output(ta8,named('domain_type_distribution'));