IMPORT doxie, doxie_raw;
doxie.MAC_Header_Field_Declare();

EXPORT mac_SortByLevel(inf, outfile, sort1 = 'TRUE', sort2 = 'TRUE', sort3 = 'TRUE') := MACRO

temprec := RECORD
  inf;
  UNSIGNED1 level := 200;
END;

temprec addlv(inf l, UNSIGNED1 lv) := TRANSFORM
  SELF.level := lv;
  SELF := l;
END;

wlv := JOIN(inf, doxie_cbrs.ds_SupergroupLevels(), 
  LEFT.bdid = RIGHT.bdid, 
  addlv(LEFT, RIGHT.level),
  LEFT OUTER, lookup);

srt := SORT(wlv, level, sort1, sort2, sort3);

ut.MAC_Slim_Back(srt, RECORDOF(inf), outfile)

ENDMACRO;
