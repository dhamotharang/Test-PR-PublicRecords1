bhb := Business_Header.File_Business_Header_Best;

// Non-blank, Non-PO Box, Non-Rural Route addresses
bhb_filtered := bhb(prim_name <> '', zip <> 0,
                    prim_name[1..7] <> 'PO BOX', prim_name[1..3] not in ['RR ', 'HC ']);
				
// Create 1MM record sample
bhb_sample := enth(bhb_filtered, 1000000);

layout_sample_out := record
  string12  bdid;
  string120 CompanyName := '';
  string120 addr1 := '';
  string30  city := '';
  string2	  state := '';
  string5	  zip :='';
  string4	  zip4 := '';
  string10  phone := '';
end;

ops(STRING s) := IF(s = '', '', TRIM(s) + ' ');

layout_sample_out FormatBest(Business_Header.Layout_BH_Best l) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.CompanyName := l.company_name;

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
end;

bhb_formatted_out := project(bhb_sample, FormatBest(left));
bhb_formatted_out_sort := sort(bhb_formatted_out, bdid);


output(choosen(bhb_formatted_out_sort, 500),all);

// Output in CSV format
output(bhb_formatted_out_sort,,'OUT::Tim_Humphrey_Sample_Companies',csv(
heading(
'bdid,CompanyName,addr1,city,state,zip,zip4,phone\n',single),
separator('|'),
terminator('\n'),
quote('')),overwrite);

// Get officers to go with companies
bc := Business_Header.File_Business_Contacts;

layout_bdid_list := record
bhb_sample.bdid;
end;

sample_bdid_list := table(bhb_sample, layout_bdid_list);

bc_sample := join(bc,
                  sample_bdid_list,
			   left.bdid = right.bdid,
			   transform(Business_Header.Layout_Business_Contact_Full, self := left),
			   lookup);
			   
layout_contact_out := record
string12  bdid;
string20  fname;
string20  mname;
string20  lname;
string5   name_suffix;
string35  company_title;   // Title of Contact at Company if available
string120 addr1 := '';
string30  city := '';
string2	state := '';
string5	zip :='';
string4	zip4 := '';
string10  phone := '';
end;

layout_contact_out FormatContact(Business_Header.Layout_Business_Contact_Full l) := transform
self.bdid := intformat(l.bdid, 12, 1);
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
self := l;
end;

bc_formatted_out := project(bc_sample(ut.TitleRank(company_title) <= 5), FormatContact(left));
bc_formatted_out_sort := sort(dedup(bc_formatted_out,bdid, lname, fname, mname, name_suffix, company_title, all), bdid);

output(choosen(bc_formatted_out_sort, 500),all);

// Output in CSV format
output(bc_formatted_out_sort,,'OUT::Tim_Humphrey_Sample_Contacts',csv(
heading(
'bdid,fname,mname,lname,name_suffix,company_title,addr1,city,state,zip,zip4,phone\n',single),
separator('|'),
terminator('\n'),
quote('')),overwrite);
