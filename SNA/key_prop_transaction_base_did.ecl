import Data_Services,doxie;
export key_prop_transaction_base_did := index(SNA.prop_transaction_base, {did}, {ln_fares_id}, Data_Services.Data_location.Prefix('NONAMEGIVEN')+'thor_data400::key::sna::property_transaction_did_'+ doxie.Version_SuperKey);
