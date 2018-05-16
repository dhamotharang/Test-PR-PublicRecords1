import DOPSGrowthCheck;
export Configuration_File := dataset([
    {'FCRA_LiensV2Keys','liensv2.key_liens_main_ID_FCRA','key_liens_main_ID_FCRA','~thor_data400::key::liensv2::fcra::','::main::tmsid.rmsid','persistent_record_id','','','','','\'rmsid\',\'tmsid\',\'persistent_record_id\'','10'},
    {'FCRA_LiensV2Keys','liensv2.key_liens_party_id_FCRA','key_liens_party_id_FCRA','~thor_data400::key::liensv2::fcra::','::party::tmsid.rmsid','persistent_record_id','','','','','\'did\',\'rmsid\',\'tmsid\',\'persistent_record_id\'','10'}
],DOPSGrowthCheck.layouts.Configuration_Layout);