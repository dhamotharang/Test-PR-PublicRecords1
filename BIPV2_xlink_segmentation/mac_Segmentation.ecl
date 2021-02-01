EXPORT mac_Segmentation(inputFile, isKeyedJoin = TRUE, inReference_field = 'reference') := functionmacro
import BizLinkFull, BIPV2_xlink_segmentation;
#UNIQUENAME(result_trim)
%result_trim% := BIPV2_xlink_segmentation.mac_trim_biz_layout(inputFile, inReference_field);//add ind field to results_seleid
#UNIQUENAME(forSegmentation)
%forSegmentation% := %result_trim%(results_seleid[1].score < BIPV2_xlink_segmentation.Constants.segmentation_threshold);//segmentation candidates
#UNIQUENAME(resultsSeg)
%resultsSeg% := BIPV2_xlink_segmentation.mac_ind_weight_adjustments(%forSegmentation%, isKeyedJoin); //weight adjustments
#UNIQUENAME(resultCombine)
%resultCombine% := %result_trim%(results_seleid[1].score >= BIPV2_xlink_segmentation.Constants.segmentation_threshold) + %resultsSeg%;//combine all results
#UNIQUENAME(OutputAllFields) 
%OutputAllFields% := JOIN(inputFile, %resultCombine%, left.inReference_field = right.reference_biz, TRANSFORM(RECORDOF(LEFT),
																																																		SELF.results_seleid := RIGHT.results_seleid;
																																																		SELF := LEFT;),LEFT OUTER,HASH);//join with input file																																																				
#UNIQUENAME(sortSeleResults)
%sortSeleResults% := PROJECT(%OutputAllFields%, TRANSFORM(RECORDOF(left), 
                                                                  self.results_seleid := sort(left.results_seleid,-Weight,-(seleid=LEFT.Results[1].seleid),-seleid);//same as Process_Biz_Layouts.CombineAllScores
																																	self := left;));//sort by weight in descending order
#UNIQUENAME(NewScoredOutput)																					
SALT44.MAC_External_AddPcnt(%sortSeleResults%,BizLinkFull.Process_Biz_Layouts.LayoutScoredFetch,Results_seleid,RECORDOF(inputFile),27,%NewScoredOutput%);//re-calculate scores																																																																																														
return %NewScoredOutput%;
endmacro;

