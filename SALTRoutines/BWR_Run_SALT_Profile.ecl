// This script takes in a file (Either as a dataset with a RECORD definition you define, or as an ECL file/index reference), 
// and then performs a full SALT profile.  It will then take that profile and infer potential data types, show the least populated fields, etc.

// For future Workunit Identification it is suggested that you update this WORKUNIT name to something specific to the file you are profiling
#WORKUNIT('name', 'SALT_Profile');
#WORKUNIT('protect', TRUE); // Comment this out if you DON'T want your SALT profile to be protected from auto-archiving and deletion

IMPORT SALT35, SALTRoutines; 

// ---- Step 1.) Read in your data ----
RawInputDataset := DATASET('~' + ClaimsMedicalSolutions.Files.FILE_BASE_PARTY_SF[29..], ClaimsMedicalSolutions.Layouts.Parties_Rec_new, THOR, __COMPRESSED__);
OUTPUT(CHOOSEN(RawInputDataset, 25), NAMED('Sample_Raw_Input'));

// ---- Step 2.) If your data has Child Datasets, you need to pull them out and run SALT profiles on everything separately ----
InputDataset := PROJECT(RawInputDataset, TRANSFORM({RECORDOF(LEFT)-PolicyIDs-Roles-PartyPhoneNos}, SELF := LEFT));
InputDatasetPolicyIDs := PROJECT(RawInputDataset.PolicyIDs, TRANSFORM({RECORDOF(LEFT)}, SELF := LEFT));
InputDatasetRoles := PROJECT(RawInputDataset.Roles, TRANSFORM({RECORDOF(LEFT)}, SELF := LEFT));
InputDatasetPhoneNos := PROJECT(RawInputDataset.PartyPhoneNos, TRANSFORM({RECORDOF(LEFT)}, SELF := LEFT));

// ---- Step 3.) Run the SALT Profile against each of the datasets resulting from Step 2.  If your dataset doesn't contain a Child Dataset you can execute this on RawInputDataset ----
// The first input to SALT_Profile_Run_Everything is a dataset.
// The second input to SALT_Profile_Run_Everything is a unique identifier for the results on OUTPUT.  This is a way for you to know which Output's belong to which Dataset's.
SALT_PARTY := SALTRoutines.SALT_Profile_Run_Everything(InputDataset, 'PARTY');
SALT_PARTY_PolicyIDs := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetPolicyIDs, 'PARTY_PolicyIDs');
SALT_PARTY_Roles := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetRoles, 'PARTY_Roles');
SALT_PARTY_PhoneNos := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetPhoneNos, 'PARTY_PhoneNos');

// ---- Step 4.) Execute the above SALT_* profiles in SEQUENTIAL order ----
OUTPUT(SALT_PARTY+SALT_PARTY_PolicyIDs+SALT_PARTY_Roles+SALT_PARTY_PhoneNos, NAMED('Total_Fields_Profiled'));