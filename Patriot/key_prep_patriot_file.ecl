﻿// ---------------------------------------------------------------
// For delta rollup logic (dx_common.mac_incremental_rollup) use:
//  $.key_patriot_delta_rid
// ---------------------------------------------------------------

export key_prep_patriot_file := index(patriot.File_Patriot_keybuild,
{
pty_key,
source,
orig_pty_name,
orig_vessel_name,
country,
name_type,
cname,
title,
fname,
mname,
lname,
suffix,
a_score,
prim_range,
predir,
prim_name,
addr_suffix,
postdir,
unit_desig,
sec_range,
p_city_name,
v_city_name,
st,
zip},{patriot.file_patriot_keybuild},'~thor_Data400::key::patriot_File_Full_' + thorlib.wuid());