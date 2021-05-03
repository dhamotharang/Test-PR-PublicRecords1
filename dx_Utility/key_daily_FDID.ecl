IMPORT $;

rec := $.layouts.i_fdid_daily;

EXPORT key_daily_FDID := INDEX({rec.fdid},rec - fdid,$.names().i_fdid_daily);

