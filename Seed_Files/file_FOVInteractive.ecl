IMPORT Data_Services,Foreclosure_Vacancy, Seed_Files;

EXPORT file_FOVInteractive := DATASET('~thor_data400::base::testseed_FOV_Interactive', Foreclosure_Vacancy.layouts.Final_Interactive_seed, CSV(HEADING(1), SEPARATOR(',')) );