// This script takes in a file (Either as a dataset with a RECORD definition you define, or as an ECL file/index reference), 
// and then performs a full SALT profile.  It will then take that profile and infer potential data types, show the least populated fields, etc.

// For future Workunit Identification it is suggested that you update this WORKUNIT name to something specific to the file you are profiling
#WORKUNIT('name', 'SALT_Profile_CLUE_Property');
#WORKUNIT('protect', TRUE); // Comment this out if you DON'T want your SALT profile to be protected from auto-archiving and deletion

IMPORT SALT38, SALTRoutines, KELBlackBox; 

// ---- Step 1.) Read in your data ----
RawInputDataset := KELBlackBox.FileCLUECleaned.FileCLUEPropertyCleaned;
OUTPUT(CHOOSEN(RawInputDataset, 25), NAMED('Sample_Raw_Input'));

// ---- Step 2.) If your data has Child Datasets, you need to pull them out and run SALT profiles on everything separately ----
InputDataset := PROJECT(KELBlackBox.FileCLUECleaned.FileCLUEPropertyCleaned, TRANSFORM({RECORDOF(LEFT) - searchinformationsection - claimhistoryrisksection - claimhistoryinsuredsection}, SELF := LEFT));
InputDatasetSubjectID := KELBlackBox.FileCLUECleaned.FileCLUEPropertySubjectID;
// InputDatasetRiskClaim := PROJECT(KELBlackBox.FileCLUECleaned.FileCLUEPropertyRiskClaim, TRANSFORM({RECORDOF(LEFT) - Payments}, SELF := LEFT));
InputDatasetRiskClaim := KELBlackBox.FileCLUECleaned.FileCLUEPropertyRiskClaim;
InputDatasetRiskClaimPayments := KELBlackBox.FileCLUECleaned.FileCLUEPropertyRiskClaimPayments;
// InputDatasetInsuredClaim := PROJECT(KELBlackBox.FileCLUECleaned.FileCLUEPropertyInsuredClaim, TRANSFORM({RECORDOF(LEFT) - Payments}, SELF := LEFT));
InputDatasetInsuredClaim := KELBlackBox.FileCLUECleaned.FileCLUEPropertyInsuredClaim;
InputDatasetInsuredClaimPayments := KELBlackBox.FileCLUECleaned.FileCLUEPropertyInsuredClaimPayments;

// ---- Step 3.) Run the SALT Profile against each of the datasets resulting from Step 2.  If your dataset doesn't contain a Child Dataset you can execute this on RawInputDataset ----
// The first input to SALT_Profile_Run_Everything is a dataset.
// The second input to SALT_Profile_Run_Everything is a unique identifier for the results on OUTPUT.  This is a way for you to know which Output's belong to which Dataset's.
SALT_PARTY := SALTRoutines.SALT_Profile_Run_Everything(InputDataset, 'PROPERTY');
SALT_PARTY_SubjectID := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetSubjectID, 'PROPERTY_SubjectID');
SALT_PARTY_RiskClaim := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetRiskClaim, 'PROPERTY_RiskClaim');
SALT_PARTY_RiskClaimPayments := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetRiskClaimPayments, 'PROPERTY_RiskClaimPayments');
SALT_PARTY_InsuredClaim := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetRiskClaim, 'PROPERTY_InsuredClaim');
SALT_PARTY_InsuredClaimPayments := SALTRoutines.SALT_Profile_Run_Everything(InputDatasetRiskClaimPayments, 'PROPERTY_InsuredClaimPayments');

// ---- Step 4.) Execute the above SALT_* profiles in SEQUENTIAL order ----
OUTPUT(SALT_PARTY+SALT_PARTY_SubjectID+SALT_PARTY_RiskClaim+SALT_PARTY_RiskClaimPayments+SALT_PARTY_InsuredClaim+SALT_PARTY_InsuredClaimPayments, NAMED('Total_Fields_Profiled'));