﻿IMPORT Data_Services,Seed_Files;
EXPORT file_FraudDefender := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_frauddefender',Seed_Files.Layout_FraudDefender,CSV(HEADING(1)));