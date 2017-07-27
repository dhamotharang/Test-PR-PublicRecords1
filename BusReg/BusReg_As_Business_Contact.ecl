import business_header, ut;
//project company contacts into contacts as header format
Business_Header.Layout_Business_Contact_Full slim(Layout_BusReg_Contact L, Layout_BusReg_Company R) := transform
 self.did := 0;
 self.dt_first_seen := (unsigned4)l.dt_first_seen;
 self.dt_last_seen := (unsigned4)l.dt_last_seen;
 self.vendor_id := (qstring34)l.br_id;
 self.zip := (unsigned3)l.zip;
 self.zip4 := (unsigned3)l.zip4;
 self.phone := (unsigned6)l.phone;
 self.ssn := (unsigned4)l.ssn;
 self.source := 'BR';
 self.company_title := MapTitleCode(l.title);
 self.title := l.name_prefix;
 self.fname := l.name_first;
 self.mname := l.name_middle;
 self.lname := l.name_last;
 self.name_score := Business_Header.CleanName(l.name_first, l.name_middle, l.name_last, l.name_suffix)[142];
 self.city := l.p_city_name;
 self.state := l.st;
 self.county := '';
 self.email_address := '';
 self.company_name := r.company_name;
 self.company_source_group := IF(r.filing_num <> '',
                               (STRING34)(trim(r.filing_num)+trim(r.company_name)),
                               '');
 self.company_prim_range := r.mail_prim_range;
 SELF.company_predir := r.mail_predir;
 SELF.company_prim_name := r.mail_prim_name;
 SELF.company_addr_suffix := r.mail_addr_suffix;
 SELF.company_postdir := r.mail_postdir;
 SELF.company_unit_desig := r.mail_unit_desig;
 SELF.company_sec_range := r.mail_sec_range;
 SELF.company_city := r.mail_v_city_name;
 SELF.company_state := r.mail_st;
 SELF.company_zip := (unsigned3)r.mail_zip;
 SELF.company_zip4 := (unsigned2)r.mail_zip4;
 SELF.company_phone := (unsigned6)r.company_phone10;
 SELF.company_fein := (unsigned4)r.co_fei;
 self := l;
end;

d_contact := distribute(file_busreg_contact,hash(br_id));
d_company := distribute(file_busreg_company,hash(br_id));

BusReg_Contacts := join(d_contact,d_company,left.br_id=right.br_id,slim(left,right),left outer,local);

EXPORT BusReg_As_Business_Contact := BusReg_Contacts((INTEGER)name_score < 3, Business_Header.CheckPersonName(fname, mname, lname, name_suffix)) : PERSIST('TEMP::BusReg_Contacts_As_BC');