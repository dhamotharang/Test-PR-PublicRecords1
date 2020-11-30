IMPORT $;

inFile := $.Layouts.i_bdid;

EXPORT Key_Foreclosures_BDID := INDEX(
  {inFile.bdid},
  {inFile.fid},
  $.names().i_foreclosure_bdid
  );
