IMPORT $, Data_Services;

Rec := $.Layouts.Key_Layout;

//IF PROD = TRUE read key from prod, if PROD = FALSE read key from dataland 
EXPORT Key_Vendor_Src(boolean PROD = TRUE):= INDEX({Rec.source_code},Rec,$.names(PROD).name,OPT);