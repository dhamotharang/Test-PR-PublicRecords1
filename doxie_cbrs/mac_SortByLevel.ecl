import doxie, doxie_raw;
doxie.MAC_Header_Field_Declare();

export mac_SortByLevel(inf, outfile, sort1 = 'true', sort2 = 'true', sort3 = 'true') := macro

temprec := record
	inf;
	unsigned1 level := 200;
end;

temprec addlv(inf l, unsigned1 lv) := transform
	self.level := lv;
	self := l;
end;

wlv := join(inf, doxie_cbrs.ds_SupergroupLevels(), left.bdid = right.bdid, addlv(left, right.level), left outer, lookup);

srt := sort(wlv, level, sort1, sort2, sort3);

ut.MAC_Slim_Back(srt, recordof(inf), outfile)

endmacro;