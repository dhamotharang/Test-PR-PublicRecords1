import doxie_cbrs, business_header;

doxie_cbrs.mac_Selection_Declare()

export business_associates_records(dataset(doxie_cbrs.layout_references) bdids) := FUNCTION

		bhrl := doxie_cbrs.layout_relatives;

		bhkr := index({unsigned6 bdid1},
									 {  unsigned6 bdid2,  boolean corp_charter_number,  boolean business_registration,  boolean bankruptcy_filing,  boolean duns_number,  boolean duns_tree,  boolean edgar_cik,  boolean name,  boolean name_address,  boolean name_phone,  boolean gong_group,  boolean ucc_filing,  boolean fbn_filing,  boolean fein,  boolean phone,  boolean addr,  boolean mail_addr,  boolean dca_company_number,  boolean dca_hierarchy,  boolean abi_number,  boolean abi_hierarchy,  boolean lien_properties,  boolean liens_v2,  boolean rel_group,  unsigned8 __internal_fpos__},
									 Constants.Key_Business_Header_Relatives_BDID);
		bhrl tGetRelatives(bdids l, bhkr r) := TRANSFORM
			self.inBDID := l.bdid;
			SELF.match_bdid := r.bdid1;
			SELF.bdid := r.bdid2;
			SELF.phone := '';
			SELF.fein := '';
			SELF.phone_m := r.phone;
			SELF.fein_m := r.fein;
			SELF := r;
		END;


		relatives_mixed := JOIN(bdids, bhkr,
																										keyed(LEFT.bdid = RIGHT.bdid1) and (
																										RIGHT.corp_charter_number OR
																										RIGHT.business_registration OR
																										RIGHT.bankruptcy_filing OR
																										RIGHT.duns_number OR
																										RIGHT.duns_tree OR
																										RIGHT.edgar_cik OR
																										RIGHT.name_address OR
																										RIGHT.name_phone OR
																										RIGHT.gong_group OR
																										RIGHT.ucc_filing OR
																										RIGHT.fbn_filing OR
																										RIGHT.fein OR
																										RIGHT.addr OR
																										RIGHT.mail_addr OR
																										RIGHT.dca_company_number OR
																										RIGHT.dca_hierarchy OR
																										RIGHT.abi_number OR
																										RIGHT.abi_hierarchy
																										),
																										tGetRelatives(left, RIGHT),
																										limit(5000, skip), keep(50));
						
		dedup_relatives_mixed := dedup(relatives_mixed,bdid,ALL);

		gid_key := index({unsigned6 bdid}, {unsigned6 group_id}, Constants.Key_SuperGroup_Bdid);

		gid_rel_rec := RECORD
			unsigned6 group_id;
			dedup_relatives_mixed;
		END;

		typeof(gid_rel_rec) add_gid(dedup_relatives_mixed L,gid_key R) := TRANSFORM
			SELF := R;
			SELF := L;
		END;

		rel_gid := join(dedup_relatives_mixed,gid_key,
																		keyed(LEFT.bdid = RIGHT.bdid),
																		add_gid(LEFT,RIGHT),
																		keep(1), limit(0));
						
		dedup_rel_gid := dedup(rel_gid,group_id,ALL);			

		bhkb := index({ unsigned6 bdid }, 
									{unsigned6 bdid,  unsigned4 dt_last_seen,  qstring120 company_name,  qstring10 prim_range,  string2 predir,  qstring28 prim_name,  qstring4 addr_suffix,  string2 postdir,  qstring5 unit_desig,  qstring8 sec_range,  qstring25 city,  string2 state,  unsigned3 zip,  unsigned2 zip4,  unsigned6 phone,  unsigned4 fein,  unsigned1 best_flags,  string2 source,  string2 dppa_state,  unsigned8 __internal_fpos__}, 
									Constants.Key_BH_Best);
// Get the best records for all relatives
		typeof(dedup_rel_gid) SelectBest(dedup_rel_gid l, bhkb r) := TRANSFORM
			self.zip := if (r.zip > 0, INTFORMAT(r.zip,5,1), '');
			self.zip4 := if(r.zip4 > 0, INTFORMAT(r.zip4,4,1), '');
			self.phone := if(r.phone > 0, (string)r.phone, '');
			self.fein := if(r.fein > 0, (string)r.fein, '');
			SELF.dt_last_seen := if(r.dt_last_seen > 0, (string)r.dt_last_seen, '');
			SELF := r;
			SELF := l;
		END;

		relatives_best_ps := JOIN(dedup_rel_gid, bhkb,
																											 keyed(LEFT.bdid = RIGHT.bdid),
																											 SelectBest(LEFT, RIGHT),
																											 keep(1), limit(0));
   
		return choosen(sort(relatives_best_ps,company_name),Max_BusinessAssociates_val);					   
END;