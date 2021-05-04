IMPORT Data_Services, Seed_Files;

EXPORT file_IdentityFraudNetwork := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_identity_fraud_network', Seed_Files.layout_IdentityFraudNetwork, CSV(HEADING(single), QUOTE('"')), OPT);