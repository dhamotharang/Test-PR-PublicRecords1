import doxie;

dWithfpos	:=	dataset('~thor_data400::base::Vehicles_' + version,{layout_vehicles, unsigned8 __fpos {virtual(fileposition)}},flat,unsorted,__compressed__);

df := dWithfpos(own_1_bdid != '' or own_2_bdid != '' or reg_1_bdid != '' or reg_2_bdid != '');

dfrec := record
	df;
	unsigned6	bdid;
end;

dfrec into_df(df L, integer C) := transform
	self.bdid := choose(C,(integer)L.own_1_bdid, (integer)L.own_2_bdid, (integer)L.reg_1_bdid, (integer)L.reg_2_bdid);
	self := L;
end;

df2 := normalize(df,4,into_df(LEFT,COUNTER));

df3 := df2(bdid != 0);

export Key_Vehicles_BDID := index(df3,{bdid, __fpos},'~thor_data400::key::vehlic_BDID_' + doxie.Version_SuperKey);
