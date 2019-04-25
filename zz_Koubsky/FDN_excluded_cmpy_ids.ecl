EXPORT FDN_excluded_cmpy_ids := module

shared exclusion_list := dataset('~nkoubsky::fdn::glb_excluded_ids',{string non_ins_company_id, string insurance_company_id, string non_insurance_gcid}, csv(heading(single)));

EXPORT non_ins_company_id_list := set(exclusion_list(non_ins_company_id <> ''), non_ins_company_id);
EXPORT insurance_company_id_list := set(exclusion_list(insurance_company_id <> ''), insurance_company_id);
EXPORT non_insurance_gcid_list := set(exclusion_list(non_insurance_gcid <> ''), non_insurance_gcid);

// output(non_ins_company_id_list);
// output(insurance_company_id_list);
// output(non_insurance_gcid_list);
end;