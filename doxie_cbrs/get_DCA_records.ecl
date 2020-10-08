// retrieve DCA records
// inputs: dataset of bdids (anticipated to be mybdids)
// directional for retrieving hiearchary
// 0: retrieve records for group
// 1: retrieve parent records
// -1: retrieve best children (current license limits to only 2 children)
IMPORT DCA, ut;
EXPORT get_DCA_records(DATASET(doxie_cbrs.layout_references) ds_bdids, INTEGER directional) :=
FUNCTION

  message := MAP(directional > 0 => 'going up',
        directional < 0 => 'going down',
        'show me');

  // get root subs by BDID
  dca_hiarc := DCA.Key_DCA_Hierarchy_BDID;
  
  all_hiarc :=
    JOIN(ds_bdids, dca_hiarc,
         KEYED(LEFT.bdid = RIGHT.bdid) AND
         LEFT.bdid > 0,
         TRANSFORM(RIGHT),
         LIMIT(ut.limits.MAX_DCA_PER_BDID), KEEP(100) );
    
  // get hierarchy by root sub
  dca_root_sub := DCA.Key_DCA_Hierarchy_Root_Sub;
  
  // get parent hierarchy info
  all_root_sub1 := JOIN(DEDUP(SORT(all_hiarc,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
    KEYED (LEFT.parent_root <> '' AND LEFT.parent_root = RIGHT.root) AND
    KEYED (LEFT.parent_sub <> '' AND LEFT.parent_sub = RIGHT.sub),
    TRANSFORM (RIGHT),
    KEEP (1), LIMIT (0)); //m:1 join
  
  // retrieve full dca record by root sub
  dca_full_record := DCA.Key_DCA_Root_Sub;
  
  up1 := JOIN(all_root_sub1, dca_full_record,
    KEYED (LEFT.root <> '' AND LEFT.root = RIGHT.root) AND
    KEYED (LEFT.sub <> '' AND LEFT.sub = RIGHT.sub),
    TRANSFORM (RIGHT),
    KEEP (1), LIMIT (0)); //m:1 join

  // get parent hierarchy info
  all_root_sub2 := JOIN(DEDUP(SORT(all_root_sub1,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
    KEYED (LEFT.parent_root <> '' AND LEFT.parent_root = RIGHT.root) AND
    KEYED (LEFT.parent_sub <> '' AND LEFT.parent_sub = RIGHT.sub),
    TRANSFORM (RIGHT),
    KEEP (1), LIMIT (0)); //m:1 join
           
  // retrieve full dca record by root sub
  up2 := JOIN(all_root_sub2, dca_full_record,
    KEYED (LEFT.root <> '' AND LEFT.root = RIGHT.root) AND
    KEYED (LEFT.sub <> '' AND LEFT.sub = RIGHT.sub),
    TRANSFORM (RIGHT),
    KEEP (1), LIMIT (0)); //m:1 join
  
  result_set := DEDUP(up1 + up2,root,sub,parent_number,ALL);
  
  result_set0 := JOIN(ds_bdids,result_set,LEFT.bdid=RIGHT.bdid, 
    TRANSFORM (RIGHT));
  
  RETURN IF(directional > 0, result_set, result_set0);
END;
