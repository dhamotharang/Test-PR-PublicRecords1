/*--SOAP--
<message name="InstantID_Group_Raw" wuTimeout="300000">
  <part name="BDID" type="xsd:string"/>
 </message>
*/
/*--INFO-- This service displays raw InstantID risk information for the group
  which includes the selected BDID */

export InstantID_Group_Raw() := macro

string14 bdid_val := '' : stored('BDID');


bh_group_fetched := doxie_cbrs.getSupergroup((unsigned6)bdid_val);
					

// Get the 'best' information for this group of bdids
doxie_cbrs.mac_best_records(bh_group_fetched,best_group_info)

// Map to input format with clean address
Business_Risk.Layout_Input CompanyInput(best_group_info l, unsigned4 cnt) := transform

a1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                         l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);
						 
a2 := Address.Addr2FromComponents(l.city, l.state, l.zip);

clean_addr := address.CleanAddress182(a1, a2);

self.score := 100;
self.seq := cnt;
self.prim_range := clean_addr[1..10];
self.predir := clean_addr[11..12];
self.prim_name := clean_addr[13..40];
self.addr_suffix := clean_addr[41..44];
self.postdir := clean_addr[45..46];
self.unit_desig := clean_addr[47..56];
self.sec_range := clean_addr[57..65];
self.p_city_name := clean_addr[90..114];
self.st := clean_addr[115..116];
self.z5 := clean_addr[117..121];
self.zip4 := clean_addr[122..125];
self.lat := clean_addr[146..155];
self.long := clean_addr[156..166];
self.addr_type := clean_addr[139];
self.addr_status := clean_addr[179..182];
self.fein := l.fein;
self.phone10 := l.phone;
self := l;
end;

best_group_in := project(best_group_info, CompanyInput(left, counter));

//output(best_group_in, named('Group_Best_Company_Information_Clean'), all);

// Append company risk data
result_company := Business_Risk.InstantID_Function(best_group_in, true);

output(result_company, named('InstantID_Group_Company_Raw_Result'), all);

// Get business contacts for this group of BDIDs
bck := Business_Header.Key_Business_Contacts_BDID;

Business_Header.Layout_Business_Contact_Full GetContacts(bh_group_fetched l, bck r) := transform
self := r;
end;

contacts_init := join(bh_group_fetched,
                      bck,
					  keyed(left.bdid = right.bdid),
					  GetContacts(left, right));
					  
//output(contacts_init(from_hdr='N'), named('Group_Company_Contacts'), all);

// Assign a sequence number
layout_contact_temp := record
unsigned4 seq;
contacts_init;
end;

layout_contact_temp AssignSeq(contacts_init l, unsigned4 cnt) := transform
self.seq := cnt;
self := l;
end;

contacts_seq := project(contacts_init(from_hdr='N'), AssignSeq(left, counter));

// Map to risk input format with clean address
Risk_Indicators.Layout_Input ContactInput(contacts_seq l) := transform

a1 := Address.Addr1FromComponents(l.prim_range, l.predir, l.prim_name,
                         l.addr_suffix, l.postdir, l.unit_desig, l.sec_range);
						 
a2 := Address.Addr2FromComponents(l.city, l.state, (string5)if(l.zip <> 0, intformat(l.zip, 5, 1), ''));

clean_addr := AddrCleanLib.CleanAddress182(a1, a2);

self.seq := l.seq;
self.prim_range := clean_addr[1..10];
self.predir := clean_addr[11..12];
self.prim_name := clean_addr[13..40];
self.addr_suffix := clean_addr[41..44];
self.postdir := clean_addr[45..46];
self.unit_desig := clean_addr[47..56];
self.sec_range := clean_addr[57..65];
self.p_city_name := clean_addr[90..114];
self.st := clean_addr[115..116];
self.z5 := clean_addr[117..121];
self.zip4 := clean_addr[122..125];
self.lat := clean_addr[146..155];
self.long := clean_addr[156..166];
self.addr_type := clean_addr[139];
self.addr_status := clean_addr[179..182];
self.suffix := l.name_suffix;
self.country := '';
self.ssn := (string9)if(l.ssn <> 0, intformat(l.ssn, 9, 1), '');
self.dob := '';
self.age := '';
self.employer_name := l.company_name;
self.phone10 := if(l.phone <> 0, intformat(l.phone, 10, 1), '');
self.wphone10 := if(l.company_phone <> 0, intformat(l.company_phone, 10, 1), '');
self := l;
end;

contact_group_in := project(contacts_seq, ContactInput(left));

//output(contact_group_in, named('Group_Company_Contacts_Clean'), all);

// Append contact risk data
contacts_risk := Risk_Indicators.InstantID_Function(contact_group_in, 0, 8);

boolean has(string src, string str) := stringlib.stringfind(src,str,1) > 0;
						
unsigned1 TitleRank(string title) :=
map((has(title, 'CEO') or has(title, 'OWNER')) AND 
		~has(title, 'WIFE') => 1,
	has(title, 'PRESIDENT') AND 
		~has(title, 'VICE') and
		~has(title, 'V PRES') and
		~has(title, 'V-PRES') and
		~has(title, 'WIFE') => 1,
	has(title, 'PRINCIPAL') => 1,
	has(title, 'PARTNER') and
		~has(title, 'LTD PARTNER') => 1,
	has(title, 'CHAIRMAN') => 1,
	has(title, 'CHIEF EXECUTIVE') => 1,
	has(title, 'CFO') => 1,
	(has(title, 'GENERAL MANAGER') or has(title, 'GENERAL MGR') or has (title, 'GNRL MGR')) and
		~has(title, 'MANAGER FINANCE') and
		~has(title, 'MANAGER/SALES') => 2,
	has(title, 'COO') => 2,
	has(title, 'CIO') => 2,
	has(title, 'CTO') => 2,
	has(title, 'CMO') => 2,
	has(title, 'CSO') => 2,
	has(title, 'EVP') => 3,
	has(title, 'SVP') => 3,
	(has(title, 'SENIOR') or has(title, 'EXECUTIVE')) and
	(has(title, 'VP') or has(title, 'PRESIDENT')) => 3,
	has(title, 'PRESIDENT') OR has(title, 'VP') => 4,
	has(title, 'DIR') => 5,
	has(title, 'MAN') or has(title,'MGR') => 6,
	title = '' => 30,
	31);

// Append company contact information to result
Business_Risk.Layout_Contact_Output AppendCompanyContactInfo(contacts_risk l, contacts_seq r) := transform
self.bdid := r.bdid;
self.contact_score := r.contact_score;
self.vendor_id := r.vendor_id;
self.contact_dt_first_seen := r.dt_first_seen; 
self.contact_dt_last_seen := r.dt_last_seen;
self.source := r.source;
self.record_type := r.record_type;
self.from_hdr := r.from_hdr;
self.glb := r.glb;
self.dppa := r.dppa;
self.company_title := r.company_title;
self.company_department := r.company_department;
self.company_source_group := r.company_source_group;
self.company_name := r.company_name;
self.company_prim_range := r.company_prim_range;
self.company_predir := r.company_predir;
self.company_prim_name := r.company_prim_name;
self.company_addr_suffix := r.company_addr_suffix;
self.company_postdir := r.company_postdir;
self.company_unit_desig := r.company_unit_desig;
self.company_sec_range := r.company_sec_range;
self.company_city := r.company_city;
self.company_state := r.company_state;
self.company_zip := r.company_zip;
self.company_zip4 := r.company_zip4;
self.company_phone := r.company_phone;
self.company_fein := r.company_fein;
// InstantID Information
self.verify_addr := IF(l.addrmultiple,'O','');
self.verify_dob := IF(l.dobscore BETWEEN 80 AND 100,'Y','N');
self.NAS_summary := l.socsverlevel;
self.NAP_summary := l.phoneverlevel;
self.CVI := risk_indicators.cviScore(self.NAP_Summary, self.NAS_summary, l.isPOTS, l);
self.ri := risk_indicators.reasonCodes(l, 6, 'InstantID');
self.fua := risk_indicators.getActionCodes(l, 4, self.NAS_summary, self.NAP_summary);
self.owner_flag := has(Stringlib.StringToUpperCase(r.company_title), 'OWNER') and 
		~has(Stringlib.StringToUpperCase(r.company_title), 'WIFE');
self.company_title_rank := TitleRank(Stringlib.StringToUpperCase(r.company_title));
self.officer_flag := ~self.owner_flag and self.company_title_rank = 1;
self := l;
end;

result_contacts := join(contacts_risk,
                        contacts_seq,
						left.seq = right.seq,
						AppendCompanyContactInfo(left, right));
						
output(sort(result_contacts, company_title_rank, seq), named('InstantID_Group_Company_Contacts_Raw_Result'), all);

endmacro;

