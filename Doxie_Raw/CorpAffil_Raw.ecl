//============================================================================
// Attribute: CorpAffil_raw.  Used by view source service and comp-report.
// Function to get corporate affiliation records by did.
// Return dataset of doxie_crs.layout_corp_affiliations_records.
//============================================================================

import doxie_files, doxie_crs, Doxie, corp2, ut,codes, NID;

export CorpAffil_Raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		unsigned keepn = 150
) := FUNCTION

//**** Find the corp keys
ck := join(dids, Corp2.Key_cont_did,
					 keyed(left.did = right.did),
					 transform({Corp2.Key_cont_did}, self := right),
					 keep(keepn));

//**** Find the contacts
c2 := join(ck, Corp2.Key_Cont_Corpkey,
					 keyed(left.corp_key = right.corp_key) and
					 left.did = right.did,
					 transform({Corp2.Key_Cont_Corpkey}, self := right),
					 limit(ut.limits.default, skip));

//***** Dedup the contacts to prepare for the next join
// perhaps, rollup would be better: fetch more appropriate fname, mname, title, etc.
c2s := sort(c2, 	corp_key, corp_state_origin, corp_sos_charter_nbr, did, -corp_process_date, -dt_last_seen, cont_title_desc = '', ut.TitleRank(cont_title_desc), record);
c2d := dedup(c2s, corp_key, corp_state_origin, corp_sos_charter_nbr, did);

//**** Find the corps
c2corp := Corp2.Key_Corp_Corpkey;
midrec := record
	c2corp.corp_key, 
	c2corp.corp_legal_name, 
	c2corp.corp_name_comment;
	c2corp.corp_addr1_zip5, 
	c2corp.corp_addr1_prim_name, 
	c2corp.corp_addr1_prim_range, 
	c2corp.corp_process_date, 
	c2corp.corp_status_date, 
	c2corp.corp_filing_date, 
	c2corp.corp_inc_date, 
	c2corp.dt_last_seen,
	c2corp.corp_status_desc;
	c2corp.corp_status_comment;
	c2corp.corp_address1_type_desc;
	c2corp.corp_addr1_predir;
	c2corp.corp_addr1_addr_suffix;
	c2corp.corp_addr1_postdir;
	c2corp.corp_addr1_unit_desig;
	c2corp.corp_addr1_sec_range;
	c2corp.corp_addr1_p_city_name;
	c2corp.corp_addr1_state;
	c2corp.corp_addr1_zip4;
	c2corp.corp_for_profit_ind;
	c2corp.DotID;
	c2corp.EmpID;
	c2corp.POWID;
	c2corp.ProxID;
	c2corp.SELEID;  
	c2corp.OrgID;
	c2corp.UltID;
end;
cc := join(ck, c2corp,
					 keyed(left.corp_key = right.corp_key),
					 transform(midrec, self := right),
					 limit(ut.limits.default, skip));


//***** Dedup the corps to prepare for the next join
ccs := sort(cc,   corp_key, corp_legal_name, corp_status_desc, -corp_process_date, -corp_status_date, -corp_inc_date, -corp_filing_date, -dt_last_seen,
	IF(corp_addr1_zip5!='',0,1), IF(corp_addr1_prim_name!='',0,1), IF(corp_addr1_prim_range!='',0,1), record);
ccd := dedup(ccs, corp_key, corp_legal_name, corp_status_desc,
	IF(corp_addr1_zip5!='',0,1), IF(corp_addr1_prim_name!='',0,1), IF(corp_addr1_prim_range!='',0,1));
//**** Join to the corp record in the style of Corp.Corporate_Affiliations and to match moxie


outrec := doxie_crs.layout_corp_affiliations_records;
outrec tra(c2d l, ccd r) := transform
	self.did := l.did;
	self.bdid := l.bdid;
	self.DotID := l.DotID;
	self.empID := l.EmpID;
	self.POWID := l.POWID;
	self.ProxID := l.ProxID;
	self.SELEID := l.SELEID;
	self.OrgID := l.OrgID;
	self.UltID := l.UltID;
	self.state_origin := l.corp_state_origin;
	self.charter_number := l.corp_sos_charter_nbr;
	self.corporation_name := r.corp_legal_name;
	self.corporation_name_comment := r.corp_name_comment;
	self.corporation_status := r.corp_status_desc;
	self.corporation_status_comment := r.corp_status_comment;
	self.corp_process_date := map(r.corp_process_date <> '' => r.corp_process_date,
							l.corp_process_date); //Changed to r as the left was picking up the wrong filing date (due to sort and dedupe) not the actual for the record
	self.filing_date := map(r.corp_status_date <> '' => r.corp_status_date,
													r.corp_filing_date <> '' => r.corp_filing_date,
							r.corp_inc_date);
	self.contact_name := l.cont_name;
	self.affiliation := l.cont_title_desc;
	self.title := l.cont_title;
	self.fname := l.cont_fname;
	self.mname := l.cont_mname;
	self.lname := l.cont_lname;
	self.name_suffix := l.cont_name_suffix;
	self.address_type := r.corp_address1_type_desc;
	self.prim_range := r.corp_addr1_prim_range;
	self.predir := r.corp_addr1_predir;
	self.prim_name := r.corp_addr1_prim_name;
	self.suffix := r.corp_addr1_addr_suffix;
	self.postdir := r.corp_addr1_postdir;
	self.unit_desig := r.corp_addr1_unit_desig;
	self.sec_range := r.corp_addr1_sec_range;
	self.city_name := r.corp_addr1_p_city_name;
	self.st := r.corp_addr1_state;
	self.zip := r.corp_addr1_zip5;
	self.zip4 := r.corp_addr1_zip4;
	self.record_date := if(r.dt_last_seen = 0, '', (string8)r.dt_last_seen);
	self.record_type := case(l.record_type,	'C' => 'CURRENT',
																					'H' => 'HISTORICAL', '');
	self.corp_for_profit_ind := r.corp_for_profit_ind;
	self.corp_for_profit_ind_decoded := codes.corp2.CORP_FOR_PROFIT_IND(r.corp_for_profit_ind);
	self.phones := [];
end;

p := join(sort(c2d, corp_key, -dt_last_seen), ccd,
					left.corp_key = right.corp_key,
					tra(left, right),
					keep(100));

//***** Sort and dedup
Corp_Affiliations_Sort := sort(p, state_origin, charter_number, lname, NID.PreferredFirstNew(fname), corporation_name, corporation_status, affiliation, if(affiliation <> '', 0, 1), ut.TitleRank(affiliation),  
																	-filing_date, -record_Date, record);
Corp_Affiliations_Dedup := dedup(Corp_Affiliations_Sort, state_origin, charter_number, lname, NID.PreferredFirstNew(fname), corporation_name, corporation_status, affiliation);

Corp_Affiliations_FinalSort := sort(Corp_Affiliations_Dedup, state_origin, charter_number, lname, NID.PreferredFirstNew(fname), corporation_name, affiliation, -filing_date, -record_Date, record);

return Corp_Affiliations_FinalSort(dateVal = 0 or (unsigned4)(filing_date[1..6]) <= dateVal);
END;