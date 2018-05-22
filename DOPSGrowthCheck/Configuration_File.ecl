import DOPSGrowthCheck;
export Configuration_File := dataset([
    {'FCRA_LiensV2Keys','liensv2.key_liens_did_fcra','~thor_data400::key::liensv2::fcra::did_qa','10'},
    {'FCRA_LiensV2Keys','liensV2.key_liens_RMSID_FCRA','~thor_data400::key::liensv2::fcra::main::rmsid_qa','10'},
    {'FCRA_LiensV2Keys','liensv2.key_liens_main_ID_FCRA','~thor_data400::key::liensv2::fcra::main::tmsid.rmsid_qa','10'},
    {'FCRA_LiensV2Keys','liensv2.key_liens_party_id_FCRA','~thor_data400::key::liensv2::fcra::party::tmsid.rmsid_qa','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_BDID','~thor_data400::key::liensv2::fcra::qa::bdid','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_case_number','~thor_data400::key::liensv2::fcra::qa::case_number','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Filing','~thor_data400::key::liensv2::fcra::qa::filing_number','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Certificate_Number','~thor_data400::key::liensv2::fcra::qa::main::certificate_number','10'},
    {'FCRA_LiensV2Keys','LiensV2.Key_FCRA_Liens_Irs_serial_number','~thor_data400::key::liensv2::fcra::qa::main::irs_serial_number','10'}
],DOPSGrowthCheck.layouts.Configuration_Layout);