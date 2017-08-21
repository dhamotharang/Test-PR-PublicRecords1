// Sample output for D&B, States: TX, IA

sample_states := ['TX', 'IA'];

// Companies
layout_bdid_date := record
unsigned6 bdid;
unsigned6 group_id;
string2 source;
unsigned4 dt_last_seen;
string2 state;
string1 phone_active;
string1 active_dnb;
end;

bh_active_base := dataset('~thor_data400::TMTEST::bh_active_base_dnb', layout_bdid_date, flat);

layout_bdid_list := record
bh_active_base.bdid;
end;

dnb_company_sample_list_init := table(bh_active_base(state in sample_states), layout_bdid_list);
dnb_company_sample_list := dedup(dnb_company_sample_list_init, all);

// Contacts
layout_bc_slim := record
unsigned6 seq;
unsigned6 bdid;
unsigned6 group_id;
unsigned6 did;
unsigned4 dt_last_seen;
string2 source;
string2 state;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
qstring35 company_title;
string1 active_dnb;
end;

bc_active_base_dnb := dataset('~thor_dell400_2::TMTEST::bc_active_base_dnb',layout_bc_slim,flat);

dnb_contact_sample_list := bc_active_base_dnb(state in sample_states);

// Format sample output
bhb := Business_Header.File_Business_Header_Best;

layout_company_sample := record
  string12  bdid;
  string120 company_name := '';
  string120 addr1 := '';
  string30  city := '';
  string2	  state := '';
  string5	  zip :='';
  string4	  zip4 := '';
  string10  phone := '';
  string9   fein := '';
  string1   lf := '\n';
end;

layout_contact_sample := record
  string12  bdid;
  string12  did;
  string120 company_name := '';
  string120 addr1 := '';
  string30  city := '';
  string2	  state := '';
  string5	  zip :='';
  string4	  zip4 := '';
  string10  phone := '';
  string20  fname := '';
  string20  mname := '';
  string20  lname := '';
  string5   name_suffix := '';
  string30  company_title := '';
  string1   lf := '\n';
end;

ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_company_sample FormatCompanySample(Business_Header.Layout_BH_Best l, layout_bdid_list r) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.company_name := stringlib.stringfilterout(l.company_name, '"');

self.addr1 := 
			ops(l.prim_range) + 
			ops(l.predir) + 
			ops(l.prim_name) +
			ops(l.addr_suffix) +
			ops(l.postdir) +
				if(ut.tails(l.prim_name, ops(l.unit_desig) + ops(l.sec_range)),
					'',
					ops(l.unit_desig) + ops(l.sec_range));
self.city := l.city;
self.state := l.state;
self.zip := if(l.zip = 0, '', intformat(l.zip, 5, 1));
self.zip4 := if(l.zip4 <> 0, intformat(l.zip4, 4, 1), '');

self.phone := if(l.phone <> 0, intformat(l.phone, 10, 1), '');
self.fein := if(l.fein <> 0, intformat(l.fein, 9, 1), '');
end;


layout_contact_sample FormatContactSample(Business_Header.Layout_BH_Best l, layout_bc_slim r) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.did := intformat(r.did, 12, 1);
self.company_name := stringlib.stringfilterout(l.company_name, '"');

self.addr1 := 
			ops(l.prim_range) + 
			ops(l.predir) + 
			ops(l.prim_name) +
			ops(l.addr_suffix) +
			ops(l.postdir) +
				if(ut.tails(l.prim_name, ops(l.unit_desig) + ops(l.sec_range)),
					'',
					ops(l.unit_desig) + ops(l.sec_range));
self.city := l.city;
self.state := l.state;
self.zip := if(l.zip = 0, '', intformat(l.zip, 5, 1));
self.zip4 := if(l.zip4 <> 0, intformat(l.zip4, 4, 1), '');

self.phone := if(l.phone <> 0, intformat(l.phone, 10, 1), '');
self.fname := r.fname;
self.mname := r.mname;
self.lname := r.lname;
self.name_suffix := r.name_suffix;
self.company_title := r.company_title;
end;

bh_company_sample := join(bhb,
                          dnb_company_sample_list,
			           left.bdid = right.bdid,
			           FormatCompanySample(left, right),
			           hash);

count(bh_company_sample);
output(bh_company_sample);
count(bh_company_sample(stringlib.stringfilter(company_name, '"') <> ''));		 
					 
bh_contact_sample := join(bhb,
                          dnb_contact_sample_list,
			           left.bdid = right.bdid,
			           FormatContactSample(left, right),
			           hash);

count(bh_contact_sample);
output(bh_contact_sample);
count(bh_contact_sample(stringlib.stringfilter(company_name, '"') <> ''));	

// Output in fixed format
output(bh_company_sample,,'OUT::DNB_Company_Sample_Fixed', overwrite);

output(bh_contact_sample,,'OUT::DNB_Contact_Sample_Fixed', overwrite);
/*
// Output in CSV format
output(bh_company_sample,,'OUT::DNB_Company_Sample_CSV',csv(
heading(
'bdid,company_name,addr1,city,state,zip,zip4,phone,fein\n',single),
separator(','),
terminator('\n'),
quote('"')),overwrite);

output(bh_contact_sample,,'OUT::DNB_Contact_Sample_CSV',csv(
heading(
'bdid,did,company_name,addr1,city,state,zip,zip4,phone,fname,mname,lname,name_suffix,company_title\n',single),
separator(','),
terminator('\n'),
quote('"')),overwrite);
*/