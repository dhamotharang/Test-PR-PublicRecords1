import doxie, Marital_status_indicator, ut;

ds := Marital_status_indicator.file_MSI_V2;

export key_MSI_V2_did := index(ds, {did}, {ds},'~thor_data400::key::msi::'+ doxie.Version_SuperKey +'::marriage_V2::did');
