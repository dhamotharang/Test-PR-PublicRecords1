EXPORT build_strNbrNameFile := MODULE
e1    := dataset([],BIPV2_Company_Names.layouts.layout_names);
d1    := output(e1,,BIPV2_Company_Names.files.StrNbr_Name);
s1    := fileservices.createsuperfile(BIPV2_Company_Names.files.StrNbr_SF_Name);
p1    := FileServices.PromoteSuperFileList([BIPV2_Company_Names.files.StrNbr_SF_Name], BIPV2_Company_Names.files.StrNbr_Name, TRUE);
newsf := sequential(d1,s1,p1); 
nsf := if( not fileservices.superfileexists(BIPV2_Company_Names.files.StrNbr_SF_Name),newsf);
BIPV2_Company_Names.functions.mac_go(BIPV2_Company_Names.files.Company_StoreNbr_Names,CnpName,cnp_nameid,cnp_name);
d2 := output(CnpName,,BIPV2_Company_Names.files.StrNbr_Name,overwrite);
p2 := FileServices.PromoteSuperFileList([BIPV2_Company_Names.files.StrNbr_SF_Name], BIPV2_Company_Names.files.StrNbr_Name, TRUE);
export bd := sequential(nsf,d2,p2);
END;
