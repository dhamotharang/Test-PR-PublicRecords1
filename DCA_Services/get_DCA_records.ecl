/* retrieve DCA records
 inputs: dataset of bdids (anticipated to be mybdids)
 	      up_directional - Valid Values (1-5) Number parent records to retrieve (1st - fifth) 
 			  down_directional - Valid Values (-1 to -2) number children (subsidiary) children, down 1 or 2 levels
	There are 2 exportable attributes, norm and denorm.
  The norm attribute returns the records normalized or "flat", while the denorm attribute
   returns the records denormalized or with child dataset/records.
*/
IMPORT DCA, ut;

EXPORT get_DCA_records(DATASET(DCA_Services.Layouts.Layout_DCA_in) ds_bdids, 
											integer up_directional = 1, 
											integer down_directional =-1) := MODULE

		// get root subs by BDID
		dca_hiarc := DCA.Key_DCA_Hierarchy_BDID;
		dca_full_record := DCA.Key_DCA_Root_Sub;
		
		all_hiarc := JOIN(ds_bdids, dca_hiarc,
						 KEYED (left.bdid > 0 and LEFT.bdid = RIGHT.bdid),
						 TRANSFORM(recordof(dca_hiarc),SELF := RIGHT),
             KEEP (100), LIMIT (ut.limits.MAX_DCA_PER_BDID)); //
		
		all_hiarc_clean := DEDUP(SORT(all_hiarc,bdid,level),bdid);
		
		all_axis := JOIN(all_hiarc_clean,dca_full_record,
										 KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
										 KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub),
										 TRANSFORM(DCA_Services.Layouts.Layout_DCA_out,SELF.passed_bdid := LEFT.bdid, SELF := RIGHT),
										 KEEP (1), LIMIT (0)); // m:1
		
		// Many cases the parent and the first level "child" have the same bdid, in these cases 
		// the highest level record is choosen as the axis or starting point.
		
		// get hierarchy by root sub
		dca_root_sub := DCA.Key_DCA_Hierarchy_Root_Sub;
		
		dca_root_sub_plus := RECORD
			UNSIGNED6 passed_bdid := 0;
			RECORDOF(dca_root_sub);
			STRING20 parent_number := '';
		END;
				
		// get parent hierarchy info starting from the "axis" record
		all_root_up1 := JOIN(dedup(sort(all_hiarc_clean,parent_root,parent_sub),parent_root,parent_sub),dca_root_sub,
						 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
						 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub),
						 TRANSFORM(dca_root_sub_plus,SELF.passed_bdid := LEFT.bdid, SELF := RIGHT),
						 KEEP (1), LIMIT (0)); // m:1

		// For cases where there are multiple owners (joint ventures) slim down record set to only
		// keep records where the parent root and child root match. In addition, construct the parent_number
		// to be used later for matching the specific owner when multiple owners exist.
		all_root_up1_clean := PROJECT(all_root_up1(root = parent_root or parent_root = ''),
														TRANSFORM(dca_root_sub_plus,
																		SELF.parent_number := IF(LEFT.parent_root != '' and LEFT.parent_sub != '',
																														 LEFT.parent_root + '-' + LEFT.parent_sub,''),
																		SELF := LEFT));
			
		DCA_Services.Layouts.Layout_DCA_out xform_dca_out(dca_root_sub_plus l, dca_full_record r, INTEGER1 tree_pos) := TRANSFORM
			SELF.passed_bdid := l.passed_bdid;
			SELF.tree_pos := tree_pos;
			SELF := r;
		END;
		
		// get full parent 1 info
		up1 := JOIN(all_root_up1_clean, dca_full_record,
					KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
					KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub) and
					left.parent_number = RIGHT.parent_number,
					xform_dca_out(LEFT,RIGHT,1),
					KEEP (1), LIMIT (0));
		
		// get parent lev 2 hierarchy
		all_root_up2 := JOIN(dedup(sort(all_root_up1_clean,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
						 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
						 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub),
						 TRANSFORM(dca_root_sub_plus,SELF.passed_bdid := LEFT.passed_bdid, SELF := RIGHT),
						 KEEP (1), LIMIT (0)); // m:1
		
		// For cases where there are multiple owners (joint ventures) slim down record set to only
		// keep records where the parent root and child root match. In addition, construct the parent_number
		// to be used later for matching the specific owner when multiple owners exist.
		all_root_up2_clean := PROJECT(all_root_up2(root = parent_root or parent_root = ''),
															TRANSFORM(dca_root_sub_plus,
																			SELF.parent_number := IF(LEFT.parent_root != '' and LEFT.parent_sub != '',
																														 LEFT.parent_root + '-' + LEFT.parent_sub,''),
																			SELF := LEFT));
		
		// get full parent 2 info
		up2 := JOIN(all_root_up2_clean, dca_full_record,
					KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
					KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub) and
					left.parent_number = RIGHT.parent_number,
					xform_dca_out(LEFT,RIGHT,2),
					KEEP (1), LIMIT (0)); // m:1
		
		// get parent lev 3 hierarchy info
		all_root_up3 := JOIN(dedup(sort(all_root_up2_clean,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
						 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and 
						 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub) and
             left.parent_root = RIGHT.parent_root,
						 TRANSFORM(dca_root_sub_plus,SELF.passed_bdid := LEFT.passed_bdid, SELF := RIGHT),
						 KEEP (1), LIMIT (0));
		
		// For cases where there are multiple owners (joint ventures) slim down record set to only
		// keep records where the parent root and child root match. In addition, construct the parent_number
		// to be used later for matching the specific owner when multiple owners exist.
		all_root_up3_clean := PROJECT(all_root_up3(root = parent_root or parent_root = ''),
															TRANSFORM(dca_root_sub_plus,
																			SELF.parent_number := IF(LEFT.parent_root != '' and LEFT.parent_sub != '',
																														 LEFT.parent_root + '-' + LEFT.parent_sub,''),
																			SELF := LEFT));
			
		// get full parent 3 info
		up3 := JOIN(all_root_up3_clean, dca_full_record,
					KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
					KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub) and
					left.parent_number = RIGHT.parent_number,
					xform_dca_out(LEFT,RIGHT,3),
					KEEP (1), LIMIT (0));
		
		// get parent lev 4 hierarchy info
		all_root_up4 := JOIN(dedup(sort(all_root_up3_clean,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
						 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
						 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub) and 
						 left.parent_root = RIGHT.parent_root,
						 TRANSFORM(dca_root_sub_plus,SELF.passed_bdid := LEFT.passed_bdid, SELF := RIGHT),
						 KEEP (1), LIMIT (0));
		
		// For cases where there are multiple owners (joint ventures) slim down record set to only
		// keep records where the parent root and child root match. In addition, construct the parent_number
		// to be used later for matching the specific owner when multiple owners exist.
		all_root_up4_clean := PROJECT(all_root_up4(root = parent_root or parent_root = ''),
															TRANSFORM(dca_root_sub_plus,
																				SELF.parent_number := IF(LEFT.parent_root != '' and LEFT.parent_sub != '',
																														 LEFT.parent_root + '-' + LEFT.parent_sub,''),
																				SELF := LEFT));
		
		// get full parent 4 info
		up4 := JOIN(all_root_up4_clean, dca_full_record,
					KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
					KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub) and
					left.parent_number = RIGHT.parent_number,
					xform_dca_out(LEFT,RIGHT,4),
					KEEP (1), LIMIT (0));
		
		// get parent lev 5 hierarchy info
		all_root_up5 := JOIN(dedup(sort(all_root_up4_clean,parent_root,parent_sub),parent_root,parent_sub), dca_root_sub,
						 KEYED (left.parent_root <> '' and LEFT.parent_root = RIGHT.root) and
						 KEYED (left.parent_sub <> '' and LEFT.parent_sub = RIGHT.sub) and
             left.parent_root = RIGHT.parent_root, 
						 TRANSFORM(dca_root_sub_plus,SELF.passed_bdid := LEFT.passed_bdid, SELF := RIGHT),
						 KEEP (1), LIMIT (0));
		
		// For cases where there are multiple owners (joint ventures) slim down record set to only
		// keep records where the parent root and child root match. In addition, construct the parent_number
		// to be used later for matching the specific owner when multiple owners exist.
		all_root_up5_clean := PROJECT(all_root_up5(root = parent_root or parent_root = ''),
															TRANSFORM(dca_root_sub_plus,
																			SELF.parent_number := IF(LEFT.parent_root != '' and LEFT.parent_sub != '',
																														 LEFT.parent_root + '-' + LEFT.parent_sub,''),
																			SELF := LEFT));
		
		// get full parent 5 info
		up5 := JOIN(all_root_up5_clean, dca_full_record,
					KEYED (left.root <> '' and LEFT.root = RIGHT.root) and
					KEYED (left.sub <> '' and LEFT.sub = RIGHT.sub) and
					left.parent_number = RIGHT.parent_number,
					xform_dca_out(LEFT,RIGHT,5),
					KEEP (1), LIMIT (0));
		
		// build result based on level requested
		up_result_set_comb := map(up_directional =1 => up1,
															up_directional =2 => up1 + up2,
															up_directional =3 => up1 + up2 + up3,
															up_directional =4 => up1 + up2 + up3 + up4,
																										up1 + up2 + up3 + up4 + up5); //Default
		
		// Sort the parent records to have the records to ensure in level descending order
		parent_result_set := DEDUP(SORT(up_result_set_comb,passed_bdid,-level,root,sub,parent_number),ALL);
			
		dca_parent_sub := DCA.Key_DCA_Hierarchy_Parent_to_Child_Root_Sub;
		
		dca_parent_sub_plus := RECORD
			UNSIGNED6 passed_bdid := 0;
			UNSIGNED2 sub_group_id1 := 0;
			UNSIGNED2 sub_group_id2 := 0;
			RECORDOF(dca_parent_sub);
		END;
		
		// get children hierarchy info starting from the "axis" record
		// Get first level child hierarchy info
		all_root_sub1 := JOIN(dedup(sort(all_axis,root,sub),root,sub),dca_parent_sub,
						 KEYED (left.root <> '' and LEFT.root = RIGHT.parent_root) and
						 KEYED (left.sub <> '' and LEFT.sub = RIGHT.parent_sub) and 
						 (LEFT.sub != RIGHT.child_sub),
						 TRANSFORM(dca_parent_sub_plus, SELF.passed_bdid := LEFT.bdid, SELF := RIGHT),
						 LIMIT (ut.limits.MAX_DCA_CHILDREN_PER_LEVEL));

		DCA_Services.Layouts.Layout_DCA_out xform_dca_out_sub(dca_parent_sub_plus l, dca_full_record r, INTEGER1 tree_pos) := TRANSFORM
			SELF.passed_bdid := l.passed_bdid;
			SELF.tree_pos := tree_pos;
			SELF.sub_group_id1 := l.sub_group_id1;
			SELF.sub_group_id2 := l.sub_group_id2;
			SELF := r;
		END;
		
		// get full child level 1 info
		sub1 := JOIN(all_root_sub1, dca_full_record,
									KEYED (LEFT.child_root <> '' and LEFT.child_root = RIGHT.root) and
									KEYED (LEFT.child_sub <> '' and LEFT.child_sub = RIGHT.sub) and
									LEFT.parent_root + '-' + LEFT.parent_sub = RIGHT.parent_number,
									xform_dca_out_sub(LEFT,RIGHT,-1),
									KEEP (1), LIMIT (0));
		
		// Many cases were there are multiple records for the same root/sub combination were the difference
		// is the level, dedup and keep the highest (lowest number) level.
		sub1_clean := DEDUP(SORT(sub1,passed_bdid,root,sub,level),root,sub);
		
		// Add the sub group ids to allow calling routine to know which subsidiarys are grouped together.
		DCA_Services.Layouts.Layout_DCA_out Add_sub_id1(DCA_Services.Layouts.Layout_DCA_out l, DCA_Services.Layouts.Layout_DCA_out r) := TRANSFORM
			SELF.sub_group_id1 := IF(l.passed_bdid = r.passed_bdid,l.sub_group_id1+1,1);
			SELF := r;
		END;
				
		sub1_hier := ITERATE(sub1_clean,Add_sub_id1(LEFT,RIGHT));
			
		// get child level 2 hierachy info
		all_root_sub2 := JOIN(sub1_hier,dca_parent_sub,
						 KEYED (left.root <> '' and LEFT.root = RIGHT.parent_root) and
						 KEYED (left.sub <> '' and LEFT.sub = RIGHT.parent_sub),
						 TRANSFORM(dca_parent_sub_plus,SELF.passed_bdid := LEFT.passed_bdid, SELF.sub_group_id1 := LEFT.sub_group_id1, SELF := RIGHT),
						 LIMIT (ut.limits.MAX_DCA_CHILDREN_PER_LEVEL));
			
		// get full child level 2 info
		sub2 := JOIN(all_root_sub2, dca_full_record,
									KEYED (LEFT.child_root <> '' and LEFT.child_root = RIGHT.root) and
									KEYED (LEFT.child_sub <> '' and LEFT.child_sub = RIGHT.sub) and
									LEFT.parent_root + '-' + LEFT.parent_sub = RIGHT.parent_number,
									xform_dca_out_sub(LEFT,RIGHT,-2),
									KEEP (1), LIMIT (0));
		
		// Many cases were there are multiple records for the same root/sub combination were the difference
		// is the level, dedup and keep the highest (lowest number) level.
		sub2_clean := DEDUP(SORT(sub2,passed_bdid,sub_group_id1,root,sub,level),root,sub);
		
		// Add the sub group ids to allow calling routine to know which subsidiarys are grouped together.
		DCA_Services.Layouts.Layout_DCA_out Add_sub_id2(DCA_Services.Layouts.Layout_DCA_out l, DCA_Services.Layouts.Layout_DCA_out r) := TRANSFORM
			SELF.sub_group_id2 := IF(l.sub_group_id1 = r.sub_group_id1,l.sub_group_id2+1,1);
			SELF := r;
		END;
				
		sub2_hier := ITERATE(sub2_clean,Add_sub_id2(LEFT,RIGHT));
		
		// build result based on level requested
		sub_result_set_comb := MAP(down_directional =-1 => sub1_hier,
																											 sub1_hier + sub2_hier); //Default

		sub_result_set := DEDUP(SORT(sub_result_set_comb,passed_bdid,sub_group_id1,sub_group_id2),ALL);
		
		// Combine results and sort to group the results for each passed bdid	
		SHARED norm_temp := SORT(parent_result_set + all_axis + sub_result_set,passed_bdid,sub_group_id1,sub_group_id2,-tree_pos);
	
		// Group the sub records on the bdid and the first level of the subsidiaries
		result_sub_grouped1 := GROUP(norm_temp(sub_group_id1 != 0),passed_bdid,sub_group_id1);
			
		Layouts.layout_subs_level1 Rollup_subs(Layouts.Layout_DCA_out l, DATASET(Layouts.Layout_DCA_out) allRows) := TRANSFORM
				SELF.subs_level2 := CHOOSEN(allRows[2..],100); // The first record is the "parent" of the level 2 subsidiaries, exclude.
				SELF.num_level2_subs := COUNT(allRows) -1; // Subtract one since "parent" is removed line above
				SELF := l;
				SELF := [];
		END;
			
		// Add the subsdiary (sub level 2) records as children to there parent (sub level 1)
		result_subs := ROLLUP(result_sub_grouped1, GROUP, Rollup_subs(LEFT, ROWS(LEFT)));
			
		Layouts.Layout_DCA_norm Rollup_results(Layouts.Layout_DCA_out axis_rec, DATASET(Layouts.Layout_DCA_out) allRows) := TRANSFORM
			SELF.parent_up1 := CHOOSEN(allRows(tree_pos = 1),1); 
			SELF.parent_up2 := CHOOSEN(allRows(tree_pos = 2),1);	
			SELF.parent_up3 := CHOOSEN(allRows(tree_pos = 3),1);
			SELF.parent_up4 := CHOOSEN(allRows(tree_pos = 4),1);	
			SELF.parent_up5 := CHOOSEN(allRows(tree_pos = 5),1);	
			SELF := axis_rec;
			SELF := [];
		END;

		// Sort and group to ensure axis record (tree_pos of 0) is the first record of the group
		result_set_norm_sgrp := GROUP(SORT(norm_temp,passed_bdid,if(tree_pos = 0,0,1),sub_group_id1,sub_group_id2,-tree_pos),passed_bdid);
		result_par := ROLLUP(result_set_norm_sgrp, GROUP, Rollup_results(LEFT, ROWS(LEFT)));
		
		Layouts.Layout_DCA_norm Denorm_results(Layouts.Layout_DCA_norm l, DATASET(Layouts.layout_subs_level1) allRows) := TRANSFORM
				SELF.subs_level1 := CHOOSEN(allRows,100);
				SELF.num_level1_subs := COUNT(allRows);
				SELF := l;
		END;
		
		// Merge the subsidiary records with the parent/axis record
		EXPORT denorm := DENORMALIZE(result_par,result_subs,
																LEFT.passed_bdid = RIGHT.passed_bdid,
																GROUP,Denorm_results(LEFT,ROWS(RIGHT)));
		
	  EXPORT norm := norm_temp;

END;