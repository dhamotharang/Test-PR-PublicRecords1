Import Data_Services,Seed_Files;
export file_FraudPoint := dataset(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_fraudpoint', Seed_Files.Layout_FraudPoint, csv);
