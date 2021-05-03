IMPORT $;

rec := $.layouts.i_did_daily;

EXPORT key_daily_DID := INDEX({rec.s_did},rec,$.names().i_did_daily);

