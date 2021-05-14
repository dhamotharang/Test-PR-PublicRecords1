EXPORT mac_ind_weight_adjustments(trimRes, isKeyedJoin) := FUNCTIONMACRO;
IMPORT BIPV2_Segmentation,BIPV2_xlink_segmentation;
  #UNIQUENAME(seg)
	%seg% 		:= BIPV2_Segmentation.KeyRead(,false).Key;
	
	#UNIQUENAME(trimResNorm)
	%trimResNorm% := NORMALIZE(trimRes,LEFT.results_seleid,TRANSFORM({unsigned id; recordof(LEFT.results_seleid) res;}, SELF.id := LEFT.reference_biz; SELF.res := RIGHT;));
	
	#UNIQUENAME(trimReswSegKeyed)													 
	%trimReswSegKeyed% := JOIN(%trimResNorm%,%seg%,
                      KEYED(LEFT.res.seleid=RIGHT.seleid),
                       TRANSFORM(RECORDOF(LEFT),
														 SELF.res.ind := IF(TRIM(RIGHT.category) in BIPV2_xlink_segmentation.Constants.CATEGORY_WITH_NO_SUBCATEGORY, TRIM(RIGHT.category), TRIM(RIGHT.category)+'_'+TRIM(RIGHT.subCategory));                            
														 SELF := LEFT;), LEFT outer, keep(1)); //populate indicator field
 	#UNIQUENAME(trimReswSegReg)													 
	%trimReswSegReg% := JOIN(%trimResNorm%,PULL(%seg%),
                      LEFT.res.seleid=RIGHT.seleid,
                       TRANSFORM(RECORDOF(LEFT),
														 SELF.res.ind := IF(TRIM(RIGHT.category) in BIPV2_xlink_segmentation.Constants.CATEGORY_WITH_NO_SUBCATEGORY, TRIM(RIGHT.category), TRIM(RIGHT.category)+'_'+TRIM(RIGHT.subCategory));                            
														 SELF := LEFT;), LEFT outer, keep(1), hash); //populate indicator field
														 
	#UNIQUENAME(trimResSeg)
	%trimResSeg% := IF(isKeyedJoin, %trimReswSegKeyed%, %trimReswSegReg%);
	
  #UNIQUENAME(applyPenalty)
  %applyPenalty% := PROJECT(%trimResSeg%, TRANSFORM(recordof(LEFT),
                      SELF.res.weight := IF(LEFT.res.ind in BIPV2_xlink_segmentation.Constants.GOOD_CLUSTERS, LEFT.res.weight, LEFT.res.weight - BIPV2_xlink_segmentation.Constants.bad_cluster_penalty);
                      SELF := LEFT;));
											
	#UNIQUENAME(trimResParentOnly)
	%trimResParentOnly% := PROJECT(trimRes,TRANSFORM(recordof(LEFT),SELF.results_seleid:=[],SELF:=LEFT));
	
	#UNIQUENAME(trimResParentDenormed)
	%trimResParentDenormed% := DENORMALIZE(DISTRIBUTE(%trimResParentOnly%, reference_biz),DISTRIBUTE(%applyPenalty%, id),
																				LEFT.reference_biz = RIGHT.id, 
																				TRANSFORM(RECORDOF(LEFT),
																				SELF.results_seleid := LEFT.results_seleid + RIGHT.res,															
																				SELF := LEFT), LOCAL);
																
	RETURN %trimResParentDenormed%;
ENDMACRO;
