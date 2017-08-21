import Data_services ; 

File_deed_bitmap := dataset(Data_services.Data_location.Prefix('Property') +'~thor_data400::base::property_fast::deed_mortgage',LN_PropertyV2.Layouts.layout_deed_mortgage_common_model_base_scrubs,flat);

export File_deed := project(File_deed_bitmap, LN_PropertyV2.layout_deed_mortgage_common_model_base);
