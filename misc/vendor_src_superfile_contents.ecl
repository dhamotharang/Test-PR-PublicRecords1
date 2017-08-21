import Inquiry_AccLogs;

email:='john.freibaum@lexisnexis.com';
#WORKUNIT('name','Header Non Updating Logical Key Rename'):

FAILURE(fileservices.sendemail(email,'Header Non Updating Logical Key Rename FAILURE','Header Non Updating Logical Key Rename FAILURE'+' Review '+workunit+FAILMESSAGE)),
SUCCESS(fileservices.sendemail(email,'Header Non Updating Logical Key Rename SUCCESS','Header Non Updating Logical Key Rename SUCCESS'+' Review '+workunit+'\n\n'
+'PRODUCTION THOR SOURCE FILES\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::HDR_FNAME_NGRAM_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::hdr_fname_ngram_qa')+'\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::HDR_LNAME_NGRAM_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::hdr_lname_ngram_qa')+'\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::HDR_PHONETIC_FNAME_TOP10_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::hdr_phonetic_fname_top10_qa')+'\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::HDR_PHONETIC_LNAME_TOP10_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::hdr_phonetic_lname_top10_qa')+'\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::RI::NAME_FREQUENCY_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::ri::name_frequency_qa')+'\n'
+'----------------------------------------------------------\n'
+'THOR_DATA400::KEY::VENDOR_SRC_INFO::VENDOR_SOURCE_QA\n'
+Inquiry_AccLogs.FlattenDataset('~thor_data400::key::vendor_src_info::vendor_source_qa')+'\n'
));
