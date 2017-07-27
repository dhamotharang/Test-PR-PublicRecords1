import doxie, Marital_status_indicator;

ds := Marital_status_indicator.file_MSI_V1;
// ds := dataset('~jshaw::inferred_marriage', layout_final, thor);

export key_MSI_V1_did := index(ds, {did}, {ds},'~thor_data400::key::msi::'+ doxie.Version_SuperKey +'::marriageV1::did');