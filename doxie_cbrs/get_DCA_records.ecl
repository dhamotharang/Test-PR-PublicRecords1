// retrieve DCA records
// inputs: dataset of bdids (anticipated to be mybdids)
// 	      directional for retrieving hiearchary 
//		     0: retrieve records for group
//			 1: retrieve parent records
//		    -1: retrieve best children (current license limits to only 2 children)
import DCA, ut;
export get_DCA_records(dataset(doxie_cbrs.layout_references) ds_bdids, integer directional) := 
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
	all_root_sub1 := JOIN(dedup(sort(all_hiarc,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
					 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
					 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub),
					 TRANSFORM (RIGHT),
					 KEEP (1), LIMIT (0)); //m:1 join
	
	// retrieve full dca record by root sub
	dca_full_record := DCA.Key_DCA_Root_Sub;
	
	up1 := JOIN(all_root_sub1, dca_full_record,
			  KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
			  KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub),
			  TRANSFORM (RIGHT),
			  KEEP (1), LIMIT (0)); //m:1 join

	// get parent hierarchy info
	all_root_sub2 := JOIN(dedup(sort(all_root_sub1,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
					 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
					 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub),
					 TRANSFORM (RIGHT),
					 KEEP (1), LIMIT (0)); //m:1 join
					 
	// retrieve full dca record by root sub
	up2 := JOIN(all_root_sub2, dca_full_record,
			  KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
			  KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub),
			  TRANSFORM (RIGHT),
			  KEEP (1), LIMIT (0)); //m:1 join
	
	result_set := dedup(up1 + up2,root,sub,parent_number,ALL);
	
	result_set0 := join(ds_bdids,result_set,left.bdid=right.bdid, TRANSFORM (RIGHT));
	
	return if(directional > 0, result_set, result_set0);
END;