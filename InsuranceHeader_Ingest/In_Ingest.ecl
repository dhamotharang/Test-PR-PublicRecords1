IMPORT IDL_Header;

dsBoca       :=     idl_header.files.DS_BOCA_HEADER_BASE (fname <>'' and lname <>'');                   
updated_data :=     Add_Update_BocaData(dsBoca).getRecords +
                    Add_Update_InsuranceData(IDL_Header.Files.DS_IDL_POLICY_HEADER_FATHER).getRecords ;
										
EXPORT In_Ingest := updated_data :persist('temp::rawheader::ingest::full');