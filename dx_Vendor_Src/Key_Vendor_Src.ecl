IMPORT $, Data_Services;

Rec := $.Layouts.Key_Layout;

prefix:= Data_Services.Data_location.Prefix('vendor_src');

//IF PROD = TRUE read key from prod, if PROD = FALSE read key from dataland 
EXPORT Key_Vendor_Src(boolean PROD = TRUE):= 
                                            INDEX({Rec.source_code},
					                                       Rec, 
							                                       IF(PROD,prefix + data_services.foreign_prod + $.names().name, prefix + data_services.foreign_dataland + $.names().name),OPT);

