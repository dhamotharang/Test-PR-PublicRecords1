IMPORT $;

drecs := DATASET([], $.layouts.i_bdid);

EXPORT key_bdid := INDEX(drecs, {bdid}, {drecs}, $.names().i_bdid);
