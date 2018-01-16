import doxie, Marital_status_indicator, Data_Services;

ds := Marital_status_indicator.file_MSI_V1;
// ds := dataset('~jshaw::inferred_marriage', layout_final, thor);

export key_MSI_V1_did := index(ds, {did}, {ds},Data_Services.Data_location.Prefix()+'thor_data400::key::msi::'+ doxie.Version_SuperKey +'::marriageV1::did');