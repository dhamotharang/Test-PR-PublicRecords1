IMPORT business_header, Census_Data, doxie, doxie_cbrs;

doxie_cbrs.mac_Selection_Declare()

EXPORT best_information(DATASET(doxie_cbrs.layout_references) bdids,
                        doxie.IDataAccess mod_access
                       ) := FUNCTION

thebest := doxie_cbrs.fn_getBaseRecs(bdids,FALSE); // filters empty addresses
allr := DEDUP(SORT(thebest,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),company_name,ALL);
best_allr := CHOOSEN(SORT(allr,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),1); //resort just IN CASE

best_rec := RECORD
  STRING bdid; // i know, not a string.
  STRING8 dt_last_seen := '';
  QSTRING120 company_name := '';
  QSTRING10 prim_range := '';
  STRING2 predir := '';
  QSTRING28 prim_name := '';
  QSTRING4 addr_suffix := '';
  STRING2 postdir := '';
  QSTRING5 unit_desig := '';
  QSTRING8 sec_range := '';
  QSTRING25 city := '';
  STRING2 state := '';
  STRING5 zip := '';
  STRING4 zip4 := '';
  STRING15 phone := ''; // International numbers
  STRING10 fein := '';
  UNSIGNED1 best_flags := 0; // also ok not a string
  BOOLEAN isCurrent := FALSE;
  BOOLEAN hasBBB := FALSE;
  UNSIGNED1 level := 0;
  STRING60 msaDesc := '';
  STRING18 county_name := '';
  STRING4 msa := '';
END;


best_rec trim_best(best_allr L) := TRANSFORM
  //SELF.blue_check := false;
  SELF.best_flags := 0;
  SELF.dt_last_seen := (STRING) L.dt_last_seen;
  SELF.bdid := IF(multiBDID,business_header.stored_bdid_val,(STRING)doxie_cbrs.subject_BDID); // FIX
  SELF := L;
END;

best_rec_trimmed := PROJECT(best_allr,trim_best(LEFT));

besr := CHOOSEN(SORT(doxie_cbrs.best_records_prs(bdids,mod_access)(prim_name <> '' AND zip <> ''),-best_flags,-dt_last_seen,level,bdid,company_name,fein,phone,prim_name,zip),1);

best_rec trans_best(besr L) := TRANSFORM
  //SELF.blue_check := false;
  SELF.best_flags := 0;
  SELF.dt_last_seen := (STRING) L.dt_last_seen;
  SELF.bdid := IF(multiBDID,business_header.stored_bdid_val,(STRING)doxie_cbrs.subject_BDID); // FIX
  SELF := L;
END;

besr_msa := PROJECT(besr,trans_best(LEFT));


best_dca := doxie_cbrs.DCA_records_dayton(IF(multiBDID,0,1),bdids);

best_dca_tbl := table(SORT(best_dca,root),{root,cnt := COUNT(GROUP)},root);

{best_dca, UNSIGNED cnt} xf_add_cnt(best_dca l, best_dca_tbl r) := TRANSFORM
  SELF.cnt := r.cnt;
  SELF := l;
END;

best_dca_cnt := JOIN(best_dca,best_dca_tbl,LEFT.root = RIGHT.root,xf_add_cnt(LEFT,RIGHT));

best_dca_rec := CHOOSEN(SORT(best_dca_cnt,-cnt,level,sub),1);

best_rec add_msa_county(best_dca_rec L, Census_Data.Key_Fips2County R) := TRANSFORM
  SELF.level := (UNSIGNED1)L.level;
  SELF.company_name := L.name;
  SELF.msaDesc := IF(L.msa <> '' AND L.msa <> '0000', ziplib.MSAToCityState(L.msa), '');
  SELF.county_name := IF (L.county <> '', R.county_name, '');
  SELF.msa := IF(L.msa <> '0000', L.msa, '');
  SELF.prim_name := IF(L.prim_range = '' AND L.predir = '' AND
             L.prim_name = '' AND L.addr_suffix = '' AND
             L.postdir = '' AND L.sec_range = '' AND L.unit_desig = '',
             L.street, L.prim_name);
  SELF.bdid := IF(multiBDID,business_header.stored_bdid_val,(STRING)doxie_cbrs.subject_BDID);
  SELF := L;
END;

best_dca_rec_trans := JOIN(best_dca_rec,Census_Data.Key_Fips2County,
                          KEYED(LEFT.state = RIGHT.state_code) AND
                          KEYED(LEFT.county[3..5] = RIGHT.county_fips),
                          add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1));
        
// Waterfall
// - highest parent bdid from DCA
// - most complete and recent header record
// - most complete and recent best_records
temp_best_information := MAP(
  COUNT(best_dca_rec_trans) > 0 => best_dca_rec_trans,
  COUNT(best_rec_trimmed) > 0 => best_rec_trimmed,
  besr_msa);
                 
RETURN temp_best_information;
END;
