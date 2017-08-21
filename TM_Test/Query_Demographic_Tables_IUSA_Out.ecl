import Business_Header, DNB, DCA, InfoUSA, EBR;

// Extract list of of BDIDs with non-blank, non-PO-Box adrreses
bhb := Business_Header.File_Business_Header_Best;

layout_bdid_list := record
unsigned6 bdid;
unsigned6 group_id := 0;
end;

bhb_nba := project(bhb(zip <> 0, prim_name <> '', prim_name[1..6] <> 'PO BOX'),
                   transform(layout_bdid_list, self := left));

bhg := Business_Header.File_Super_Group;

// Add the group ids			    
bhb_nba_grp := join(bhb_nba,
                    bhg,
				left.bdid = right.bdid,
				transform(layout_bdid_list, self.group_id := right.group_id, self := left),
				hash);

bh := Business_Header.File_Business_Header;

// select non InfoUSA Business Header records
bh_list_init := project(bh(source not in ['IA','ID','IF','II']),
                        transform(layout_bdid_list, self := left));
				    
bh_list_dedup := dedup(bh_list_init, bdid, all);

bh_list_noniusa := join(bh_list_dedup,
                       bhb_nba_grp,
				   left.bdid = right.bdid,
				   transform(layout_bdid_list, self := right),
				   hash);

output(bh_list_noniusa,,'TMTEST::Demographic_BDID_List_NonIUSA', overwrite);				   
output(count(bh_list_noniusa), named('Business_Header_BDID_Non_IUSA'));
				   
bh_list_noniusa_gid := dedup(bh_list_noniusa, group_id, all);

output(count(bh_list_noniusa_gid), named('Business_Header_Group_Non_IUSA'));

				   
// Select InfoUsa Records with non-blank addresses
iusa_list_init := project(bh(source in ['IA','ID','IF','II']),
                        transform(layout_bdid_list, self := left));
				    
iusa_list_dedup := dedup(iusa_list_init, bdid, all);
			   
iusa_list := join(iusa_list_dedup,
                  bhb_nba_grp,
			   left.bdid = right.bdid,
			   transform(layout_bdid_list, self := right),
			   hash);

output(iusa_list,,'TMTEST::Demographic_BDID_List_IUSA', overwrite);				   
output(count(iusa_list), named('InfoUSA_BDID'));
			 
iusa_list_gid := dedup(iusa_list, group_id, all);

output(count(iusa_list_gid), named('InfoUSA_Group'));

// Find BDID overlap and non-overlap
bh_bdid_only := join(bh_list_noniusa,
                     iusa_list,
				 left.bdid = right.bdid,
				 transform(layout_bdid_list, self := left),
				 left only,
				 hash);
				 
output(count(bh_bdid_only), named('Business_Header_BDID_Only'));

iusa_bdid_only := join(bh_list_noniusa,
                       iusa_list,
				   left.bdid = right.bdid,
				   transform(layout_bdid_list, self := right),
				   right only,
				   hash);
				 
output(count(iusa_bdid_only), named('InfoUSA_BDID_Only'));

bh_iusa_bdid_overlap := join(bh_list_noniusa,
                             iusa_list,
				         left.bdid = right.bdid,
				         transform(layout_bdid_list, self := left),
				         hash);

output(count(bh_iusa_bdid_overlap), named('Business_Header_InfoUSA_BDID_Overlap'));

// Find Group overlap and non-overlap
bh_gid_only := join(bh_list_noniusa_gid,
                     iusa_list_gid,
				 left.group_id = right.group_id,
				 transform(layout_bdid_list, self := left),
				 left only,
				 hash);
				 
output(count(bh_gid_only), named('Business_Header_Group_Only'));

iusa_gid_only := join(bh_list_noniusa_gid,
                      iusa_list_gid,
				  left.group_id = right.group_id,
				  transform(layout_bdid_list, self := right),
				  right only,
				  hash);
				 
output(count(iusa_gid_only), named('InfoUSA_Group_Only'));

bh_iusa_gid_overlap := join(bh_list_noniusa_gid,
                            iusa_list_gid,
				        left.group_id = right.group_id,
				        transform(layout_bdid_list, self := left),
				        hash);

output(count(bh_iusa_gid_overlap), named('Business_Header_InfoUSA_Group_Overlap'));

// Combined BDID list
bdid_list := dedup(bh_list_noniusa + iusa_list, bdid, all);

// Append Employee Counts and Revenue Information to Combined BDID List
layout_demographics := record
unsigned6 bdid;
unsigned6 group_id;
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


// Initialize demographics from combined list
layout_demographics InitDemographics(bdid_list l) := transform
self := l;
end;

dmg_init := project(bdid_list, InitDemographics(left));
dmg_dist := distribute(dmg_init, hash(bdid));

db := DNB.File_DNB_Base(bdid <> 0, record_type = 'C', active_duns_number = 'Y',
                        (integer)zip <> 0, prim_name <> '', prim_name[1..6] <> 'PO BOX');

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

dmg_dnb := join(dmg_dist,
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

dmg_dca := join(dmg_dnb,
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

dmg_ebr := join(dmg_dca,
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

dmg_iusa := join(dmg_ebr,
                     iusa_info_dedup,
			      left.bdid = right.bdid,
			      AppendIUSAInfo(left, right),
			      left outer,
			      local);
				 
layout_bdid_revenue := record
unsigned6 bdid;
unsigned6 group_id;
unsigned6 revenues;
string2 source;
end;

layout_bdid_number_employees := record
unsigned6 bdid;
unsigned6 group_id;
unsigned3 number_employees;
string2 source;
end;
				 
revenue_table := project(dmg_iusa(dnb_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.dnb_revenues, self.source := 'D', self := left)) +
			  project(dmg_iusa(dca_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.dca_revenues, self.source := 'DC', self := left)) +
			  project(dmg_iusa(infousa_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.infousa_revenues, self.source := 'IA', self := left)) +
			  project(dmg_iusa(ebr_revenues <> 0),
                         transform(layout_bdid_revenue, self.revenues := left.ebr_revenues, self.source := 'EB', self := left));

output(revenue_table,,'TMTEST::Demographic_Revenue_Table',overwrite);

number_employees_table := project(dmg_iusa(dnb_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.dnb_number_employees, self.source := 'D', self := left)) +
			           project(dmg_iusa(dca_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.dca_number_employees, self.source := 'DC', self := left)) +
			           project(dmg_iusa(infousa_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.infousa_number_employees, self.source := 'IA', self := left)) +
			           project(dmg_iusa(ebr_number_employees <> 0),
                                  transform(layout_bdid_number_employees, self.number_employees := left.ebr_number_employees, self.source := 'EB', self := left));

output(number_employees_table,,'TMTEST::Demographic_Number_Employees_Table',overwrite);

