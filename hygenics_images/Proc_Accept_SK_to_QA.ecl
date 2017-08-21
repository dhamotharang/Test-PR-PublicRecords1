import promotesupers;

promotesupers.MAC_SK_Move_v2('~criminal_images::key::Matrix_Images_did', 'Q', do1, 2);
promotesupers.MAC_SK_Move_v2('~criminal_images::key::Matrix_Images', 'Q', do2, 2);

export Proc_Accept_SK_to_QA := sequential(do1, do2);