/* PRTE2_LNProperty.VV_Refresh_Data_After_UU
After doing the UU file transformation we need to grab standardized_land_use_code and may find other fields that need improvement.

This is not yet altered - I'll have to 
* move off of the old batch_in (and create new enhanced layout if needed)
* take the new base file (which now has clean address fields to tie on)
* tie it to the XREF to get the paired address
* tie that to the prct::temp::bap::ln_property_reload::assessor_records (or maybe the _dedup version)

and populate the fields we need to in the new layout.
*/

IMPORT ut, PRTE2_LNProperty, LN_PropertyV2_Services, PRTE2_Common, PRTE2_X_Ins_PropertyScramble;

EnhancedBatchIn_Layout := PRTE2_LNProperty.V_Refresh_Data_Base_Files.EnhancedBatchIn_Layout;
BaseBatchInPlusCleaningDS := PRTE2_LNProperty.V_Refresh_Data_Base_Files.BaseBatchInPlusCleaningDS;
RefreshAssessorDS := PRTE2_LNProperty.V_Refresh_Data_Base_Files.RefreshAssessorDS;

// Any better way to sort?  Maybe add recording date once we can connect to full key?
RefreshAssessorDS_Sort := SORT(RefreshAssessorDS,map_prim_range,map_predir,map_prim_name,map_addr_suffix,map_postdir,map_sec_range,map_zip5,-total_robustness_score);
RefreshAssessorDSDedup := DEDUP(RefreshAssessorDS_Sort,map_prim_range,map_predir,map_prim_name,map_addr_suffix,map_postdir,map_sec_range,map_zip5);
OUTPUT(RefreshAssessorDSDedup,,PRTE2_LNProperty.V_Refresh_Data_Base_Files.RefreshAssessorDedupName,overwrite);

NewData := JOIN(BaseBatchInPlusCleaningDS, RefreshAssessorDSDedup,
											LEFT.map_prim_range = RIGHT.map_prim_range
											AND LEFT.map_predir = RIGHT.map_predir
											AND	LEFT.map_prim_name = RIGHT.map_prim_name
											AND LEFT.map_postdir = RIGHT.map_postdir
											AND LEFT.map_sec_range = RIGHT.map_sec_range
											AND LEFT.map_zip5 = RIGHT.map_zip5
											,PRTE2_LNProperty.V_Refresh_Data_Transform_A_to_BatIn(LEFT,RIGHT)
											,left outer
											);

OUTPUT(NewData,,PRTE2_LNProperty.V_Refresh_Data_Base_Files.BaseBatchInRefreshened,overwrite);