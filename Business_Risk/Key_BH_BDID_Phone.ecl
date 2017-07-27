import business_header;

df := business_header.file_business_header(phone != 0);

df2 := dedup(sort(distribute(df, hash(bdid)),bdid, phone, company_name, prim_range, prim_name, sec_range, zip, local), bdid, phone, company_name, prim_range, prim_name, sec_range, zip, local);

export Key_BH_BDID_Phone := index(df2, {bdid}, {phone, company_name, prim_range, prim_name, sec_range, zip}, '~thor_Data400::key::BH_BDID_To_Phone_QA');
