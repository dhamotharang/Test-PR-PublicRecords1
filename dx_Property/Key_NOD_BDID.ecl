IMPORT $;

inFile := $.Layouts.i_bdid;

EXPORT Key_NOD_BDID := INDEX(
  {inFile.bdid},
  {inFile.fid}, 
  $.names().i_nod_bdid
  );
