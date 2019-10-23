import doxie, header, ut;

export   Key_FCRA_EN_AptBuildings_pre(string filedate):=function

df := header.fn_ApartmentBuildings(true,filedate);

return index(df,{prim_range, prim_name, zip, suffix, predir}, {apt_cnt, did_cnt}, 
                                 ut.Data_Location.Person_header + 'thor_data400::key::fcra::en_hdr_apt_bldgs_' + doxie.Version_SuperKey);
end;