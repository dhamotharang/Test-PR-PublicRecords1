IMPORT $, Data_Services;

rec := $.Layouts.i_grouprid_encrypted;

EXPORT Key_Group_RID_Encrypted(UNSIGNED1 data_env = Data_Services.data_env.iNonFCRA) := INDEX({rec.group_rid},
                                                    rec,
                                                    $.Names(data_env).i_grouprid_encrypted);
