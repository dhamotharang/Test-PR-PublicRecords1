import DOPSGrowthCheck;
export Configuration_File := dataset([
    {'FCRA_LiensV2Keys','liensv2.key_liens_did_fcra','key_liens_did_fcra','~thor_data400::key::liensv2::fcra::did_qa','rmsid,tmsid','','','','','10'},
    {'FCRA_LiensV2Keys','liensV2.key_liens_RMSID_FCRA','key_liens_RMSID_FCRA','~thor_data400::key::liensv2::fcra::main::rmsid_qa','rmsid,tmsid','','','','','10'},
    {'FCRA_LiensV2Keys','liensv2.key_liens_main_ID_FCRA','key_liens_main_ID_FCRA','~thor_data400::key::liensv2::fcra::main::tmsid.rmsid_qa','rmsid,tmsid','','','','','10'},
    {'FCRA_LiensV2Keys','liensv2.key_liens_party_id_FCRA','key_liens_party_id_FCRA','~thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa','rmsid,tmsid','','','','','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_BDID','Key_FCRA_Liens_BDID','~thor_data400::key::liensv2::fcra::qa::bdid','p_bdid','','','','','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_case_number','Key_FCRA_Liens_case_number','~thor_data400::key::liensv2::fcra::qa::case_number','case_number, filing_state','','','','','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Filing','Key_FCRA_Liens_Filing','~thor_data400::key::liensv2::fcra::qa::filing_number','filing_number, filing_state','','','','','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Certificate_Number','Key_FCRA_Liens_Certificate_Number','~thor_data400::key::liensv2::fcra::qa::main::certificate_number','certificate_number','','','','','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Irs_serial_number','Key_FCRA_Liens_Irs_serial_number','~thor_data400::key::liensv2::fcra::qa::main::irs_serial_number','irs_serial_number,agency_state','','','','','10'}
],DOPSGrowthCheck.layouts.Configuration_Layout);