import doxie,ut;

df := Business_Header.File_Business_Header_FP(prim_name != '' or state != '');

export Key_Business_Header_Address := index(df,{string28 pn := ut.stripordinal(df.prim_name),string2 st := df.state,string10 pr := df.prim_range,zip,string8 sr := df.sec_range,__filepos},'~thor_data400::key::business_header.address_' + doxie.Version_SuperKey);
