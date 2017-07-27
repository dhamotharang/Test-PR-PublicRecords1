import doxie, Marital_status_indicator, ut;

ds := marital_status_indicator.file_best_data; 

EXPORT key_MSI_best_did := index(ds, {did}, {ds},'~thor_data400::key::msi::'+ doxie.Version_SuperKey +'::best_data::did');