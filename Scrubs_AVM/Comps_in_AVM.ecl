import avm_v2,data_services;
EXPORT Comps_in_AVM := dataset(Data_Services.foreign_prod+'thor_data400::base::avm_v2_comps',avm_v2.layouts.layout_hedonic_base,thor);