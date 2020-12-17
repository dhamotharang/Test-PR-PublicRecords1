IMPORT Census_Data, doxie_cbrs, business_header, ut, STD;

EXPORT fn_best_information(
  DATASET(doxie_cbrs.layout_references) in_group_ids,
  BOOLEAN in_use_supergroup
) :=
FUNCTION
  temp_filter_on_ids := 
    JOIN (in_group_ids, Business_Header.Key_BH_SuperGroup_BDID,
      LEFT.bdid=RIGHT.bdid,
      TRANSFORM (RIGHT),
      KEEP (1), LIMIT (0));

  best_rec := $.layout_best_info;
  
  best_dca := doxie_cbrs.fn_DCA_records_dayton(in_group_ids,in_use_supergroup);
  
  best_dca_tbl := table(SORT(best_dca,root),{root,cnt := COUNT(GROUP)},root);
  
  {best_dca, UNSIGNED cnt} xf_add_cnt(best_dca l, best_dca_tbl r) := TRANSFORM
    SELF.cnt := r.cnt;
    SELF := l;
  END;
  
  best_dca_cnt := JOIN(best_dca,best_dca_tbl,LEFT.root = RIGHT.root,xf_add_cnt(LEFT,RIGHT));
  
  best_dca_rec := DEDUP(GROUP(SORT(best_dca_cnt,group_id,-cnt,level,sub),group_id),group_id,LEFT);
  
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
    SELF.bdid := (STRING)l.group_id;
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
    SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, '');
    SELF.fromdca := TRUE;
    SELF := L;
    SELF := []; // dt_last_seen, fein, best_flags
  END;
  
  best_dca_rec_trans := JOIN(best_dca_rec,Census_Data.Key_Fips2County,
    KEYED(LEFT.state = RIGHT.state_code AND
    LEFT.county[3..5] = RIGHT.county_fips),
    add_msa_county(LEFT,RIGHT), LEFT OUTER, KEEP (1));
                            
  temp_filter_on_ids keepl(temp_filter_on_ids l) := TRANSFORM
    SELF := l;
  END;
  
  temp_filter_on_ids_not_in_dca := JOIN(temp_filter_on_ids,best_dca_rec_trans,(STRING)LEFT.group_id=RIGHT.bdid,keepl(LEFT),LEFT only);
  ut.mac_slim_back(temp_filter_on_ids_not_in_dca,doxie_cbrs.layout_references,group_ids_not_in_dca);

  besr :=
    DEDUP(
      GROUP(
        SORT(
          doxie_cbrs.fn_best_records_prs(
            PROJECT(
              group_ids_not_in_dca,
              TRANSFORM(
                doxie_cbrs.layout_supergroup,
                SELF.level := 0,
                SELF.group_id := 0,
                SELF := LEFT)),
            in_use_supergroup)(
            prim_name <> '' AND
            zip <> ''),
          group_id,
          -best_flags,
          -dt_last_seen,
          level,
          bdid,
          company_name,
          fein,
          phone,
          prim_name,
          zip),
        group_id),
      group_id,
      LEFT);
  
  best_rec trans_best(besr L) := TRANSFORM
    //SELF.blue_check := false;
    SELF.best_flags := 0;
    SELF.dt_last_seen := (STRING)L.dt_last_seen;
    SELF.bdid := (STRING)l.group_id;
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
    SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, '');
    SELF := L;
  END;
  
  besr_msa := PROJECT(besr,trans_best(LEFT));
          
  temp_filter_on_ids_not_in_dca_or_best_rec := JOIN(temp_filter_on_ids_not_in_dca,besr_msa,(STRING)LEFT.group_id=RIGHT.bdid,keepl(LEFT),LEFT only);
  ut.mac_slim_back(temp_filter_on_ids_not_in_dca_or_best_rec,doxie_cbrs.layout_references,group_ids_not_in_dca_or_best_rec);
  
  thebest := doxie_cbrs.fn_getBaseRecs(group_ids_not_in_dca_or_best_rec,in_use_supergroup); // filters empty addresses
  allr := DEDUP(GROUP(SORT(thebest,group_id,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),group_id),group_id,LEFT);
  best_allr := allr;//CHOOSEN(SORT(allr,-dt_last_seen,bdid,company_name,fein,phone,prim_name,zip),1); //resort just IN CASE
  
  best_rec trim_best(best_allr L) := TRANSFORM
    //SELF.blue_check := false;
    SELF.best_flags := 0;
    SELF.dt_last_seen := (STRING)L.dt_last_seen;
    SELF.bdid := (STRING)l.group_id;
      // The following condition filters out blank phone numbers and numbers whose last seven digits (chars, actually) are zeroes.
    SELF.phone := IF(STD.Str.FilterOut(L.phone[MAX(1, LENGTH(TRIM(L.phone))-6)..], '0') != '', L.phone, '');
    SELF := L;
  END;
  
  best_rec_trimmed := PROJECT(best_allr,trim_best(LEFT));
  
  RETURN best_dca_rec_trans +
         besr_msa +
         best_rec_trimmed;
  
END;
