IMPORT Business_Header;

EXPORT getRelatives_ds(DATASET(doxie_cbrs.layout_references) thebdids) :=
FUNCTION

precs := thebdids;

bhrl := doxie_cbrs.layout_relatives;
//bhrf := Business_Header.File_Business_Relatives_Plus;
bhkr := Business_Header.Key_Business_Relatives;

bhrl tGetRelatives(precs l, bhkr r) := TRANSFORM
  SELF.inBDID := l.bdid;
  SELF.match_bdid := r.bdid1;
  SELF.bdid := r.bdid2;
  SELF.phone := '';
  SELF.fein := '';
  SELF.phone_m := r.phone;
  SELF.fein_m := r.fein;
  SELF := r;
END;




relatives_mixed := JOIN(precs, bhkr,
        KEYED(LEFT.bdid = RIGHT.bdid1),
        tGetRelatives(LEFT, RIGHT),
        LIMIT(50000, SKIP), KEEP(10000));

relatives_simple := relatives_mixed(NOT rel_group);
relatives_complex := relatives_mixed(rel_group);

bhkrg := Business_Header.Key_Business_Relatives_Group;

bhrl GetRelativefpos(relatives_complex l, bhkrg r) :=
TRANSFORM
  SELF.inBDID := l.bdid;
  SELF.bdid := IF(l.match_bdid<>r.bdid,r.bdid,SKIP);
  SELF.rel_group := FALSE;
  SELF.phone := '';
  SELF.fein := '';
  SELF.phone_m := l.phone != '';
  SELF.fein_m := l.fein != '';
  SELF := l;
END;
relatives_groups := JOIN(relatives_complex, bhkrg,
                          KEYED(LEFT.bdid = RIGHT.group_id), GetRelativefpos(LEFT,RIGHT),
                          LIMIT(50000,SKIP), KEEP(10000));

relatives1 := IF(COUNT(relatives_complex) = 0,
        relatives_simple,
        relatives_simple + relatives_groups);

relatives1_sort := SORT(relatives1, bdid);

bhrl RollRelationships(relatives1_sort l, relatives1_sort r) := TRANSFORM
  SELF.corp_charter_number := IF(l.corp_charter_number, l.corp_charter_number, r.corp_charter_number);
  SELF.business_registration := IF(l.business_registration, l.business_registration, r.business_registration);
  SELF.bankruptcy_filing := IF(l.bankruptcy_filing, l.bankruptcy_filing, r.bankruptcy_filing);
  SELF.duns_number := IF(l.duns_number, l.duns_number, r.duns_number);
  SELF.duns_tree := IF(l.duns_tree, l.duns_tree, r.duns_tree);
  SELF.edgar_cik := IF(l.edgar_cik, l.edgar_cik, r.edgar_cik);
  SELF.name := IF(l.name, l.name, r.name);
  SELF.name_address := IF(l.name_address, l.name_address, r.name_address);
  SELF.name_phone := IF(l.name_phone, l.name_phone, r.name_phone);
  SELF.gong_group := IF(l.gong_group, l.gong_group, r.gong_group);
  SELF.ucc_filing := IF(l.ucc_filing, l.ucc_filing, r.ucc_filing);
  SELF.fbn_filing := IF(l.fbn_filing, l.fbn_filing, r.fbn_filing);
  SELF.fein_m := IF(l.fein_m, l.fein_m, r.fein_m);
  SELF.phone_m := IF(l.phone_m, l.phone_m, r.phone_m);
  SELF.addr := IF(l.addr, l.addr, r.addr);
  SELF.dca_company_number := l.dca_company_number OR r.dca_company_number;
  SELF.dca_hierarchy := l.dca_hierarchy OR r.dca_hierarchy;
  SELF.abi_number := l.abi_number OR r.abi_number;
  SELF.abi_hierarchy := l.abi_hierarchy OR r.abi_hierarchy;
  SELF := l;
END;

relatives_rollup := ROLLUP(relatives1_sort,
  LEFT.bdid = RIGHT.bdid,
  RollRelationships(LEFT, RIGHT));

// If we took any group relatives, rollup the relationship bits.
relatives := IF(COUNT(relatives_complex) = 0,
        relatives1,
        relatives_rollup);
        
UNSIGNED1 addit(BOOLEAN b) := IF(b, 1, 0);
        
bhrl countem(relatives l) := TRANSFORM //same effect, just compiles better
  SELF.relationships :=
    ((addit(l.corp_charter_number) +
    addit(l.business_registration) +
    addit(l.bankruptcy_filing) +
    addit(l.duns_number))*2 +
    (addit(l.duns_tree) +
    addit(l.edgar_cik) +
    addit(l.name) +
    addit(l.name_address) +
    addit(l.name_phone) +
    addit(l.gong_group))*2 +
    (addit(l.ucc_filing) +
    addit(l.fbn_filing) +
    addit(l.fein_m) +
    addit(l.phone_m) +
    addit(l.addr))*2 +
    (addit(l.mail_addr) +
    addit(l.rel_group) +
    addit(l.dca_company_number) +
    addit(l.dca_hierarchy) +
    addit(l.abi_number) +
    addit(l.abi_hierarchy))*2) DIV 2;
  SELF := l;
END;

relatives_counted := PROJECT(relatives, countem(LEFT));

RETURN relatives_counted;

END;
