IMPORT $, Data_Services, doxie;

rec := $.Layouts.Key_Layout;

EXPORT Key_Vendor_Src(STRING version = doxie.Version_SuperKey) := 
  INDEX({rec.source_code},rec,$.names(version).i_vendor_src, OPT);
