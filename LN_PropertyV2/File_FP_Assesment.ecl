import Data_services ; 

File_Assessment_bitmap := dataset(Data_services.Data_location.Prefix('Property') + '~thor_data400::base::property_fast::assessment',LN_PropertyV2.Layouts.layout_property_common_model_base_scrubs,flat);

export File_FP_Assessment := project(File_Assessment_bitmap , LN_PropertyV2.layout_property_common_model_base);