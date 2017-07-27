import gong, gong_v2, doxie;

f := project(Gong_v2.proc_roxie_keybuild_prep_current(phone10 != ''),
             transform(gong_v2.Layout_bscurrent_raw, self:=left, self := []));

export key_phone_gongv2 := INDEX(f, 
{phone10},
{f}, 
Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10_' + doxie.Version_SuperKey);