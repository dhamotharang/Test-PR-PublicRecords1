old:

1. SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
   SELF.Rule := c;
		
2. le.sec_range_num = ri.sec_range_num  => le.sec_range_num_weight100,

3. iComp := (DID_score + MAX(addr_score,prim_range_num_score + prim_range_alpha_score + prim_range_fract_score + prim_name_num_score + prim_name_alpha_score + sec_range_num_score + sec_range_alpha_score) + MAX(locale_score,city_score + st_score + zip_score)) / 100 + outside;


new:

1.  SHARED match_candidates(ih).layout_matches match_join(match_candidates(ih).layout_candidates le,match_candidates(ih).layout_candidates ri,UNSIGNED2 c,UNSIGNED outside=0) := TRANSFORM
	  nbrsOnly (string str) := REGEXREPLACE('[^0-9]',str,'');
    notNull  (string str) := nbrsOnly(str) <> '';
		isNullx  (string str) := nbrsOnly(str) =  '';
		hasMatch (string str1, string str2) := IF(ut.nowords(str2) = 1 AND length(nbrsOnly(str2)) > 1,datalib.stringfind(str1,nbrsOnly(str2),1) > 0,FALSE);
		
		isRangeNameMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.prim_name,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.prim_name,le.prim_range));
		isRangeSecMatch  := (isNullx(le.prim_range) and notNull(ri.prim_range) and hasMatch(le.sec_range_num,ri.prim_range)) OR 
		                    (isNullx(ri.prim_range) and notNull(le.prim_range) and hasMatch(ri.sec_range_num,le.prim_range));
		isSecNameMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and hasMatch(le.prim_name,ri.sec_range_num))  OR 
		                    (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and hasMatch(ri.prim_name,le.sec_range_num));
		isRangeNameMisMatch := (isNullx(le.prim_range) and notNull(ri.prim_range) and isNullx(le.sec_range) and isNullx(ri.sec_range) and 
		                        notNull(le.prim_name) and not datalib.stringfind(le.prim_name,nbrsOnly(ri.prim_range),1) > 0) OR
		                       (isNullx(ri.prim_range) and notNull(le.prim_range) and isNullx(le.sec_range_num) and isNullx(ri.sec_range_num) and 
													  notNull(ri.prim_name) and not datalib.stringfind(ri.prim_name,nbrsOnly(le.prim_range),1) > 0);
		isRangeSecMisMatch  := (isNullx(le.prim_range)        and notNull(ri.prim_range) and isNullx(nbrsOnly(le.prim_name)) and isNullx(nbrsOnly(ri.prim_name)) and
		                        notNull(le.sec_range_num) and datalib.stringfind(le.sec_range_num,nbrsOnly(ri.prim_range),1) = 0) OR
		                       (isNullx(ri.prim_range)        and notNull(le.prim_range) and 
													  notNull(ri.sec_range_num) and datalib.stringfind(ri.sec_range_num,nbrsOnly(le.prim_range),1) = 0);
		isSecNameMisMatch   := (isNullx(le.sec_range_num)  and notNull(ri.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
		                        notNull(le.prim_name)  and datalib.stringfind(le.prim_name,nbrsOnly(ri.sec_range_num),1) = 0) OR
		                       (isNullx(ri.sec_range_num)  and notNull(le.sec_range_num)  and isNullx(le.prim_range) and isNullx(ri.prim_range) and
													  notNull(ri.prim_name)  and datalib.stringfind(ri.prim_name,nbrsOnly(le.sec_range_num),1) = 0);
		bonus := MAP(isRangeNameMatch    or isRangeSecMatch or isSecNameMatch       =>  3,
                 isRangeNameMisMatch or isRangeSecMisMatch or isSecNameMisMatch => -9999,
		             le.prim_name_alpha <> '' and ri.prim_name_alpha = '' and le.prim_name_num = '' and ri.prim_name_num <> '' => -3,
								 ri.prim_name_alpha <> '' and le.prim_name_alpha = '' and ri.prim_name_num = '' and le.prim_name_num <> '' => -3,
								 0);  
	SELF.Rule := c;
	
2. trim(le.sec_range_num,left,right) = trim(ri.sec_range_num,left,right)  => le.sec_range_num_weight100,
 
3. iComp := (DID_score + MAX(addr_score,prim_range_num_score + prim_range_alpha_score + prim_range_fract_score + prim_name_num_score + prim_name_alpha_score + sec_range_num_score + sec_range_alpha_score) + MAX(locale_score,city_score + st_score + zip_score)) / 100 + outside + bonus;
