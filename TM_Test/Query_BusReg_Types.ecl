br_base := BusReg.File_BusReg_Company(bdid <> 0, CORPCODE <> '' or SOS_CODE <> '' or FILING_COD <> '');

layout_br_type := record
br_base.bdid;
br_base.CORPCODE;
br_base.SOS_CODE;
br_base.FILING_COD;
end;

br_base_types := table(br_base, layout_br_type);

count(br_base_types);

output(enth(br_base_types, 500),all);
