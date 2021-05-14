IMPORT $;

EXPORT key_autokey_payload := INDEX({$.layouts.i_autokey_payload.fakeid}, 
  $.layouts.i_autokey_payload, $.names().i_autokey_payload);
