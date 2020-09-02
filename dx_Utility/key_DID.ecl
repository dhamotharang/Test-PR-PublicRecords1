IMPORT $;

rec := $.layouts.i_did;

EXPORT key_DID := INDEX({rec.s_did},rec,$.names().i_did);

