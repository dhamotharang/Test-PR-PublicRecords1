import DNB, DCA, InfoUSA, EBR;

// Append Employee Counts and Revenue Information to BBB Member file
bbb_members := BBB.bbb_clean_bdid;

layout_demographics := record
unsigned6 bdid;
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// DCA Info
unsigned3 dca_number_employees := 0;
unsigned6 dca_revenues := 0;
// Infousa Info
unsigned3 infousa_number_employees := 0;
unsigned6 infousa_revenues := 0;
// Experian Business Reports
unsigned3 ebr_number_employees := 0;
unsigned6 ebr_revenues := 0
end;


// Initialize demographics from BBB base member file
layout_demographics InitDemographics(bbb_members l) := transform
self := l;
end;

bbb_dmg_init := project(bbb_members(bdid <> 0), InitDemographics(left));
bbb_dmg_dist := distribute(bbb_dmg_init, hash(bdid));

// Append D&B Info
db := DNB.File_DNB_Base(bdid <> 0, record_type = 'C', active_duns_number = 'Y');

layout_db_info := record
db.bdid;
unsigned3 dnb_number_employees := (unsigned3)db.employees_total;
unsigned6 dnb_revenues := if(db.annual_sales_volume_sign <> '-', (unsigned6)db.annual_sales_volume, 0);
end;

db_info := table(db, layout_db_info);
db_info_dist := distribute(db_info, hash(bdid));
db_info_sort := sort(db_info_dist, bdid, -dnb_revenues, -dnb_number_employees, local);
db_info_dedup := dedup(db_info_sort, bdid, local);

layout_demographics AppendDNBInfo(layout_demographics l, layout_db_info r) := transform
self.dnb_revenues := r.dnb_revenues;
self.dnb_number_employees := r.dnb_number_employees;
self := l;
end;

bbb_dmg_dnb := join(bbb_dmg_dist,
                    db_info_dedup,
			     left.bdid = right.bdid,
			     AppendDNBInfo(left, right),
			     left outer,
			     local);

// Append DCA Info
dcaf := DCA.File_DCA_Base(bdid <> 0);

layout_dca_info := record
dcaf.bdid;
unsigned3 dca_number_employees := (unsigned3)dcaf.EMP_NUM;
unsigned6 dca_revenues := (unsigned6)dcaf.Sales;
end;

dca_info := table(dcaf, layout_dca_info);
dca_info_dist := distribute(dca_info, hash(bdid));
dca_info_sort := sort(dca_info_dist, bdid, -dca_revenues, -dca_number_employees, local);
dca_info_dedup := dedup(dca_info_sort, bdid, local);

layout_demographics AppendDCAInfo(layout_demographics l, layout_dca_info r) := transform
self.dca_revenues := r.dca_revenues;
self.dca_number_employees := r.dca_number_employees;
self := l;
end;

bbb_dmg_dca := join(bbb_dmg_dnb,
                    dca_info_dedup,
			     left.bdid = right.bdid,
			     AppendDCAInfo(left, right),
			     left outer,
			     local);
				
// Append Experian Business Report Information

// Map signed field digit to number
integer Map_Signed_Field(string sfield) :=
         (integer)
          (map(sfield[length(trim(sfield))] in ['{','A','B','C','D','E','F','G','H','I'] => '+',
              sfield[length(trim(sfield))] in ['}','j','k','l','m','n','o','p','q','r'] => '-',
              '+') +

           map(sfield[length(trim(sfield))] in ['{','}'] => sfield[1..(length(trim(sfield))-1)] + '0',
               sfield[length(trim(sfield))] in ['A','j'] => sfield[1..(length(trim(sfield))-1)] + '1',
               sfield[length(trim(sfield))] in ['B','k'] => sfield[1..(length(trim(sfield))-1)] + '2',
               sfield[length(trim(sfield))] in ['C','l'] => sfield[1..(length(trim(sfield))-1)] + '3',
               sfield[length(trim(sfield))] in ['D','m'] => sfield[1..(length(trim(sfield))-1)] + '4',
               sfield[length(trim(sfield))] in ['E','n'] => sfield[1..(length(trim(sfield))-1)] + '5',
               sfield[length(trim(sfield))] in ['F','o'] => sfield[1..(length(trim(sfield))-1)] + '6',
               sfield[length(trim(sfield))] in ['G','p'] => sfield[1..(length(trim(sfield))-1)] + '7',
               sfield[length(trim(sfield))] in ['H','q'] => sfield[1..(length(trim(sfield))-1)] + '8',
               sfield[length(trim(sfield))] in ['I','r'] => sfield[1..(length(trim(sfield))-1)] + '9',
               sfield[length(trim(sfield))]));

unsigned3 Map_EBR_Number_Employees(string7 empl_size, string20 empl_desc) := 
            map((unsigned3) empl_size <> 0 => (unsigned3) empl_size,
		      empl_desc <> '' => (unsigned6)((trim(empl_desc))[(Stringlib.Stringfind(trim(empl_desc), ' - ', 1) + 3)..]),
			 0);

unsigned6 Map_EBR_Revenues(string7 sales_actual, string20 sales_desc) := 
            map(Map_Signed_Field(sales_actual) > 0 => (unsigned6) Map_Signed_Field(sales_actual) * 1000,
		      Map_Signed_Field(sales_actual) < 0 => 0,
		      sales_desc <> '' => ((unsigned6)((trim(sales_desc))[(Stringlib.Stringfind(trim(sales_desc), ' - ', 1) + 3)..])) * 1000,
			 0);

ebrf := EBR.File_5600_Demographic_Data_Base;

layout_ebr_info := record
ebrf.bdid;
unsigned3 ebr_number_employees := Map_EBR_Number_Employees(ebrf.EMPL_SIZE_ACTUAL, ebrf.EMPL_SIZE_DESC);
unsigned6 ebr_revenues := Map_EBR_Revenues(ebrf.SALES_ACTUAL, ebrf.SALES_DESC);
ebrf.EMPL_SIZE_ACTUAL;
ebrf.EMPL_SIZE_DESC;
ebrf.SALES_ACTUAL;
ebrf.SALES_DESC;
end;

ebr_info := table(ebrf, layout_ebr_info);
ebr_info_dist := distribute(ebr_info, hash(bdid));
ebr_info_sort := sort(ebr_info_dist, bdid, -ebr_revenues, -ebr_number_employees, local);
ebr_info_dedup := dedup(ebr_info_sort, bdid, local);

//output(ebr_info_dedup(ebr_revenues <> 0));
//output(ebr_info_dedup(ebr_number_employees <> 0));

layout_demographics AppendEBRInfo(layout_demographics l, layout_ebr_info r) := transform
self.ebr_revenues := r.ebr_revenues;
self.ebr_number_employees := r.ebr_number_employees;
self := l;
end;

bbb_dmg_ebr := join(bbb_dmg_dca,
                    ebr_info_dedup,
			     left.bdid = right.bdid,
			     AppendEBRInfo(left, right),
			     left outer,
			     local);

// Append InfoUSA Info
iusa := InfoUSA.File_ABIUS_Company_Base(bdid <> 0);

layout_iusa_info := record
unsigned6 bdid;
unsigned3 infousa_number_employees;
unsigned6 infousa_revenues;
end;

layout_iusa_info GetIUSAInfo(iusa l) := transform
self.infousa_number_employees := map((unsigned3)l.TOTAL_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.TOTAL_EMPLOYEES_ACTUAL,
                                          (unsigned3)l.NUM_EMPLOYEES_ACTUAL <> 0 => (unsigned3)l.NUM_EMPLOYEES_ACTUAL,
								  l.EMPLOYEE_SIZE_CD <> '' => case(l.EMPLOYEE_SIZE_CD,
								    'A' => 4,
								    'B' => 9,
								    'C' => 19,
								    'D' => 49,
								    'E' => 99,
								    'F' => 249,
								    'G' => 499,
								    'H' => 999,
								    'I' => 4999,
								    'J' => 9999,
								    'K' => 10000,
								     0),
								  0);
self.infousa_revenues := case(l.SALES_VOLUME_CD,
                                    'A' => 250000,
                                    'B' => 750000,
                                    'C' => 1750000,
                                    'D' => 3750000,
                                    'E' => 7500000,
                                    'F' => 15000000,
                                    'G' => 35000000,
                                    'H' => 75000000,
                                    'I' => 300000000,
                                    'J' => 750000000,
                                    'K' => 1000000000,
							 0);
self := l;
end;

iusa_info := project(iusa, GetIUSAInfo(left));
iusa_info_dist := distribute(iusa_info, hash(bdid));
iusa_info_sort := sort(iusa_info_dist, bdid, -infousa_revenues, -infousa_number_employees, local);
iusa_info_dedup := dedup(iusa_info_sort, bdid, local);

layout_demographics AppendIUSAInfo(layout_demographics l, layout_iusa_info r) := transform
self.infousa_revenues := r.infousa_revenues;
self.infousa_number_employees := r.infousa_number_employees;
self := l;
end;

bbb_dmg_iusa := join(bbb_dmg_ebr,
                     iusa_info_dedup,
			      left.bdid = right.bdid,
			      AppendIUSAInfo(left, right),
			      left outer,
			      local);
				 
layout_bdid_revenue := record
unsigned6 bdid;
unsigned6 revenues;
string2 source;
end;

layout_bdid_number_employees := record
unsigned6 bdid;
unsigned3 number_employees;
string2 source;
end;
				 
revenue_table := project(bbb_dmg_iusa(dnb_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.dnb_revenues, self.source := 'D', self := left)) +
			  project(bbb_dmg_iusa(dca_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.dca_revenues, self.source := 'DC', self := left)) +
			  project(bbb_dmg_iusa(infousa_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.infousa_revenues, self.source := 'IA', self := left)) +
			  project(bbb_dmg_iusa(ebr_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.ebr_revenues, self.source := 'EB', self := left));

output(revenue_table,,'TMTEST::BBB_Revenue_Table',overwrite);

number_employees_table := project(bbb_dmg_iusa(dnb_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.dnb_number_employees, self.source := 'D', self := left)) +
			           project(bbb_dmg_iusa(dca_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.dca_number_employees, self.source := 'DC', self := left)) +
			           project(bbb_dmg_iusa(infousa_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.infousa_number_employees, self.source := 'IA', self := left)) +
			           project(bbb_dmg_iusa(ebr_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.ebr_number_employees, self.source := 'EB', self := left));

output(number_employees_table,,'TMTEST::BBB_Number_Employees_Table',overwrite);

// Keep highest revenue amount
revenue_table_sort := sort(revenue_table, bdid, -revenues, local);
revenue_table_dedup := dedup(revenue_table_sort, bdid, local);

// Keep highest employee count
number_employees_table_sort := sort(number_employees_table, bdid, -number_employees, local);
number_employees_table_dedup := dedup(number_employees_table_sort, bdid, local);

// Append Revenue and Employee Counts to output file
layout_bbb_demographic_out := record
string12 bdid;
string6  bbb_id;
string60 company_name;
string100 address;
string12 country;
string14 phone;
string12 revenues := '';
string7  number_employees := '';
end;

bbb_members_init := project(bbb_members,
                            transform(layout_bbb_demographic_out,
					   self.bdid := if(left.bdid <> 0, intformat(left.bdid, 12, 1), ''),
					   self := left));
bbb_members_dist := distribute(bbb_members_init((unsigned6)bdid <> 0), hash((unsigned6)bdid));

layout_bbb_demographic_out AppendRevenues(bbb_members_dist l, layout_bdid_revenue r) := transform
self.revenues := if(r.revenues <> 0, intformat(r.revenues, 12, 1), '');
self := l;
end;

bbb_revenue_append := join(bbb_members_dist,
                           revenue_table_dedup,
					  (unsigned6)left.bdid = right.bdid,
					  AppendRevenues(left, right),
					  left outer,
					  local);
					  
layout_bbb_demographic_out AppendNumberEmployees(bbb_revenue_append l, layout_bdid_number_employees r) := transform
self.number_employees := if(r.number_employees <> 0, intformat(r.number_employees, 7, 1), '');
self := l;
end;

bbb_number_employees_append := join(bbb_revenue_append,
                                    number_employees_table_dedup,
					           (unsigned6)left.bdid = right.bdid,
					           AppendNumberEmployees(left, right),
					           left outer,
					           local);

bbb_members_append := bbb_members_init((unsigned6)bdid = 0) + bbb_number_employees_append;

output(bbb_members_append,,'TMTEST::BBB_Demographics_Append',overwrite);
