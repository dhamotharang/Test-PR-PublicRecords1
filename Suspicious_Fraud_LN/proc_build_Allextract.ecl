import Suspicious_Fraud_LN, ut;

#workunit('name','Identity Fraud Network Extract');
#OPTION('AllowedClusters','thor400_30,thor400_20');

rundate := ut.GetDate;

build_ssn_extract := Suspicious_Fraud_LN.build_ssn(rundate);
build_address_extract := Suspicious_Fraud_LN.build_Address(rundate);
build_phone_extract := Suspicious_Fraud_LN.build_phone(rundate);
build_stats := suspicious_fraud_LN.out_STRATA_population_stats(rundate);
output_extract_samples := suspicious_fraud_LN.out_extract_samples;

export 	proc_Build_Allextract := sequential(build_ssn_extract, build_address_extract, build_phone_extract, build_stats, output_extract_samples);


 
