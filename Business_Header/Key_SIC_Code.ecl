import doxie, data_services;

f := Business_Header.BH_BDID_SIC();

layout_sic_index := record
f.bdid;
f.sic_code;
end;

fprep := table(f, layout_sic_index);
fdedup := dedup(fprep, all);

export Key_SIC_Code := index(fdedup,{bdid}, {sic_code},data_services.data_location.prefix() + 'thor_data400::key::business_header.SIC_Code_' + doxie.Version_SuperKey);