import Data_services,LN_PropertyV2_Fast ; 

File_deed_bitmap := dataset(
														 LN_PropertyV2_Fast.filenames.baseFull.deed_mortg
														,LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs
														,flat,opt);

export File_deed := project(File_deed_bitmap, LN_PropertyV2.layout_deed_mortgage_common_model_base);
