EXPORT File_Scoring := module

pplus := File_Phonesplus_Base;

export layout := record
pplus.datefirstseen;
pplus.datelastseen;
pplus.fname;
pplus.mname;
pplus.lname;
pplus.prim_range;
pplus.predir;
pplus.prim_name;
pplus.addr_suffix;
pplus.postdir;
pplus.unit_desig;
pplus.sec_range;
pplus.p_city_name;
pplus.v_city_name;
pplus.state;
pplus.zip5;
pplus.zip4;
pplus.geo_lat;
pplus.geo_long;
pplus.geo_blk;
pplus.cellphone;
pplus.hhid;
pplus.did;
pplus.ListingType;
pplus.confidencescore;
pplus.glb_dppa_flag;
end;

export base := dataset('~thor_data400::base::phonesplusv2_scoring', layout, thor);
end;