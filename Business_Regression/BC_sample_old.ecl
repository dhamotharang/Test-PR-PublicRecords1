import business_header;

Base := business_header.File_Business_Contacts_father;

business_regression.MAC_BC_Sample(base, base_smpl)

export BC_sample_old := base_smpl : persist('bc_sample_old');