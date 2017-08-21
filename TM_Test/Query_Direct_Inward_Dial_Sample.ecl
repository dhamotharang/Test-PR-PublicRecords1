import DNB, InfoUSA;

// Select companies for Direct Inward Dial test
//   HQ location
//   Employees >= 50

// select 500 from Dun & Bradstreet
dbf := DNB.File_DNB_Base;

dbf_filtered := dbf(bdid <> 0,
                    duns_number <> '',
                    active_duns_number = 'Y',
				record_type = 'C',
				trade_style = '',
				telephone_number <> '',
				(integer)employees_here >= 50,
				parent_duns_number = '',
				ultimate_duns_number = '',
				headquarters_duns_number = '',
				(integer)type_of_establishment = 0,
				street <> '',
				city <> '',
				state <> '',
				zip_code <> '',
				business_name <> '');
				
dbf_sample := enth(dbf_filtered, 500);

output(dbf_sample, all);

// select 500 from InfoUSA
iusa := InfoUSA.File_ABIUS_Company_Base;

iusa_filtered := iusa(bdid <> 0,
                      abi_number <> '',
				  (integer)ultimate_parent_num = 0,
				  (integer)subsidiary_parent_num = 0,
				  employee_size_cd in ['D','E','F','G','H','I','J','K'],
				  company_name <> '',
				  phone <> '',
				  street1 <> '',
				  city1 <> '',
				  state1 <> '',
				  zip1_5 <> '');

iusa_sample := enth(iusa_filtered, 500);

output(iusa_sample, all);

// output record
layout_out := record
string12  bdid;
string2   source;
string100 company_name;
string30  street;
string20  city;
string2   state;
string5   zip;
string10  phone;
end;


sample_combined := project(dbf_sample,
                           transform(layout_out,
					            self.bdid := intformat(left.bdid, 12, 1),
							  self.source := 'D',
							  self.company_name := Stringlib.StringToUpperCase(left.business_name),
							  self.phone := left.telephone_number,
							  self.street := Stringlib.StringToUpperCase(left.street);
							  self.city := Stringlib.StringToUpperCase(left.city);
							  self.zip := left.zip_code,
							  self := left)) +
			    project(iusa_sample,
                           transform(layout_out,
					            self.bdid := intformat(left.bdid, 12, 1),
							  self.source := 'IA',
							  self.company_name := Stringlib.StringToUpperCase(left.company_name),
							  self.street := Stringlib.StringToUpperCase(left.street1),
							  self.city := Stringlib.StringToUpperCase(left.city1),
							  self.state := left.state1,
							  self.zip := left.zip1_5,
							  self := left));
							  
sample_sorted := sort(sample_combined, (integer)bdid);

output(sample_sorted, all);

			    