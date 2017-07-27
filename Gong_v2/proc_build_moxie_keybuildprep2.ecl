import Gong_v2,Address;

d := Gong_v2.proc_build_moxie_keybuildprep;

//create city table

layoutcitytbl := record
d.p_city_name;
d.z5;
d.__filepos;

end;

cityTbl  := dedup(table(d,layoutcitytbl),p_city_name,z5,__filepos,all);



Address.MAC_Multi_City(cityTbl,p_city_name,z5,multiCityfile);
cityOut:= dedup(multiCityfile,p_city_name,__filepos,all): persist(Gong_v2.thor_cluster +'persist::gong::ziptocityTbl');									



export proc_build_moxie_keybuildprep2 := cityOut;