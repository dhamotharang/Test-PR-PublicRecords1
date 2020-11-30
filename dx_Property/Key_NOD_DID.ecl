IMPORT $;

inFile := $.Layouts.i_did;

EXPORT Key_NOD_DID := INDEX(
  {inFile.did},
  {inFile.fid},
  $.names().i_nod_did
  );
