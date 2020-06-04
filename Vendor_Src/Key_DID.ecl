Import Data_Services, ut, doxie,vendor_src;

vendorsrc_base :=PROJECT(Vendor_Src.Files().base.built(source_code<>''), TRANSFORM(Vendor_Src.layouts.Base-[county_text],SELF:=LEFT));

export Key_DID := index(vendorsrc_base,{source_code},{vendorsrc_base},Data_Services.Data_location.Prefix('vendor_src')+'thor_data400::key::vendor_src_info::vendor_source_' + doxie.Version_SuperKey );

