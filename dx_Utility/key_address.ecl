IMPORT $;

rec := $.layouts.i_address;

EXPORT key_address := INDEX({rec.prim_name,rec.st,rec.zip,rec.prim_range,rec.sec_range},rec,$.names().i_address);


