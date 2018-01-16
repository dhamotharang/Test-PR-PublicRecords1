import doxie, Marital_status_indicator, Data_Services;

ds := Marital_status_indicator.file_MSI_V2;

export key_MSI_V2_did := index(ds, {did}, {ds},Data_Services.Data_location.Prefix()+'thor_data400::key::msi::'+ doxie.Version_SuperKey +'marriage_V2::did');
