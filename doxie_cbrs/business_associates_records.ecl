IMPORT doxie_cbrs, business_header, Doxie;

doxie_cbrs.mac_Selection_Declare()

EXPORT business_associates_records(DATASET(doxie_cbrs.layout_references) bdids, doxie.IDataAccess mod_access) := FUNCTION

bhrl := doxie_cbrs.layout_relatives;

bhkr := Business_Header.Key_Business_Relatives;

bhrl tGetRelatives(bdids l, bhkr r) := TRANSFORM
  SELF.inBDID := l.bdid;
  SELF.match_bdid := r.bdid1;
  SELF.bdid := r.bdid2;
  SELF.phone := '';
  SELF.fein := '';
  SELF.phone_m := r.phone;
  SELF.fein_m := r.fein;
  SELF := r;
END;


relatives_mixed := JOIN(bdids, bhkr,
  KEYED(LEFT.bdid = RIGHT.bdid1) AND (
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
  tGetRelatives(LEFT, RIGHT),
  LIMIT(5000, SKIP), KEEP(50));
        
dedup_relatives_mixed := DEDUP(relatives_mixed,bdid,ALL);

gid_key := Business_Header.Key_BH_SuperGroup_BDID;

out_rec := doxie_cbrs.layout_business_associates.out_rec;
out_rec add_gid(dedup_relatives_mixed L,gid_key R) := TRANSFORM
  SELF := R;
  SELF := L;
END;

rel_gid := JOIN(dedup_relatives_mixed,gid_key,
        KEYED(LEFT.bdid = RIGHT.bdid),
        add_gid(LEFT,RIGHT),
        KEEP(1), LIMIT(0));
        
dedup_rel_gid := DEDUP(rel_gid,group_id,ALL);

bhkb := Business_Header.Key_BH_Best;

// Get the best records for all relatives
out_rec SelectBest(dedup_rel_gid l, bhkb r) := TRANSFORM
  SELF.zip := IF (r.zip > 0, INTFORMAT(r.zip,5,1), '');
  SELF.zip4 := IF(r.zip4 > 0, INTFORMAT(r.zip4,4,1), '');
  SELF.phone := IF(r.phone > 0, (STRING)r.phone, '');
  SELF.fein := IF(r.fein > 0, (STRING)r.fein, '');
  SELF.dt_last_seen := IF(r.dt_last_seen > 0, (STRING)r.dt_last_seen, '');
  SELF := r;
  SELF := l;
END;

relatives_best_ps := JOIN(dedup_rel_gid, bhkb,
                       KEYED(LEFT.bdid = RIGHT.bdid) AND 
                       doxie.compliance.isBusHeaderSourceAllowed(RIGHT.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
                       SelectBest(LEFT, RIGHT),
                       KEEP(1), LIMIT(0));

                   
RETURN CHOOSEN(SORT(relatives_best_ps,company_name),Max_BusinessAssociates_val);
END;
