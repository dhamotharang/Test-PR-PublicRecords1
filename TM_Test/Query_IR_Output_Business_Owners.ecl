import ut, Business_Header;

// Get list of Business Owners by bdid, did
bc_owners := Business_Header.BC_Owner;

layout_did_list := record
bc_owners.did;
end;

bc_owners_list := table(bc_owners(did <> 0), layout_did_list);
bc_owners_list_dedup := dedup(bc_owners_list, did, all);

bc := Business_Header.File_Business_Contacts_Base;

layout_bdid_did_list := record
bc.bdid;
bc.did;
end;

bc_list := table(bc(did <> 0, bdid <> 0), layout_bdid_did_list);
bc_list_dedup := dedup(bc_list, bdid, did, all);

layout_bdid_did_list SelectOwnerBDIDs(layout_bdid_did_list l, layout_did_list r) := transform
self := l;
end;

bc_owners_bdid := join(bc_list_dedup,
                       bc_owners_list_dedup,
				   left.did = right.did,
				   SelectOwnerBDIDs(left, right),
				   hash);
				   
// IR Base Sample
layout_sample := record
// From Business Header Best Record
	unsigned6 bdid;
	qstring120 company_name := '';
	qstring10 prim_range := '';
	string2   predir := '';
	qstring28 prim_name := '';
	qstring4  addr_suffix := '';
	string2   postdir := '';
	qstring5  unit_desig := '';
	qstring8  sec_range := '';
	qstring25 city := '';
	string2   state := '';
	unsigned3 zip := 0;
	unsigned2 zip4 := 0;
	unsigned6 phone := 0;
	unsigned4 fein := 0;        // Federal Tax ID
	unsigned1 best_flags := 0;
	string2   source := '';	   // source type (non-blank only if DPPA_State is non-blank)
     string2   DPPA_State := ''; // If nonblank, indicates state code for a DPPA restricted record
unsigned4 dt_last_seen := 0;
unsigned3 base_record_count := 0;
// Source Data Record Counts
unsigned3 corp_record_cnt := 0;
unsigned3 ucc_record_cnt := 0;
//unsigned3 fbn_record_cnt := 0;
unsigned3 busreg_record_cnt := 0;
unsigned3 bk_record_cnt := 0;
unsigned3 lj_record_cnt := 0;
unsigned3 gb_record_cnt := 0;
unsigned3 irs5500_record_cnt := 0;
unsigned3 dnb_record_cnt := 0;
// D&B Info
unsigned3 dnb_number_employees := 0;
unsigned6 dnb_revenues := 0;
// DCA Info
unsigned3 dca_number_employees := 0;
unsigned6 dca_revenues := 0;
// Infousa Info
unsigned3 infousa_number_employees := 0;
unsigned6 infousa_revenues := 0;
// Lien/Judgment Info
unsigned6 amount;
// Business Owner information
unsigned3 bo_cnt := 0;
// Bankruptcy Info
unsigned4 bk_dt_last_seen := 0;
end;

ir_sample := dataset('TMTEMP::IR_Sample', layout_sample, flat);

// Output the business owners for these businesses
layout_bdid_did_list GetSampleOwnersDID(layout_bdid_did_list l, layout_sample r) := transform
self := l;
end;

ir_sample_owners_list := join(bc_owners_bdid,
                              ir_sample,
			               left.bdid = right.bdid,
			               GetSampleOwnersDID(left, right),
			   			lookup);
						
ir_sample_owners_list_dedup := dedup(ir_sample_owners_list, all);
						
Business_Header.Layout_Business_Contact_Full GetSampleOwners(Business_Header.Layout_Business_Contact_Full l, layout_bdid_did_list r) := transform
self := l;
end;

ir_sample_owners := join(bc,
                         ir_sample_owners_list_dedup,
					left.bdid = right.bdid and
					left.did = right.did,
					GetSampleOwners(left, right),
					lookup);
					
ir_sample_owners_dist := distribute(ir_sample_owners, hash(bdid));
ir_sample_owners_sort := sort(ir_sample_owners_dist, bdid, did, ut.TitleRank(company_title), local);
ir_sample_owners_dedup := dedup(ir_sample_owners_sort, bdid, did, local);
ir_sample_owners_sort1 := sort(ir_sample_owners_dedup, bdid, ut.TitleRank(company_title), local);
ir_sample_owners_dedup1 := dedup(ir_sample_owners_sort1, bdid, keep(5), local);

layout_sample_owners_out := record
string12 bdid;
string12 did;
string120 company_name;
string35 company_title;
string20 fname;
string20 mname;
string20 lname;
string5  name_suffix;
end;

layout_sample_owners_out FormatOutput(Business_Header.Layout_Business_Contact_Full l) := transform
self.bdid := intformat(l.bdid, 12, 1);
self.did := intformat(l.did, 12, 1);
self := l;
end;

ir_sample_out := project(ir_sample_owners_dedup1, FormatOutput(left)) : persist('TMTEMP::IR_Sample_Owners');

count(ir_sample_out);

output(ir_sample_out,,'TMTEMP::IR_Sample_Owners_CSV',csv(
heading('bdid,did,company_name,company_title,fname,mname,lname,name_suffix\n'),
separator(','),
terminator('\n'),
quote('"')));


