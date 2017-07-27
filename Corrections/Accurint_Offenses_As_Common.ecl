import crim_common;

df := dataset(Crim_Common.Name_Moxie_DOC_Offenses_Dev+'_new',
			{crim_common.Layout_Moxie_DOC_Offenses.new,unsigned8 __fpos { virtual(fileposition)}},flat,unsorted);

layout_offense_common into(df L) := transform
	self.county_of_origin := L.cty_conv;
	self.orig_state := L.vendor;
	self := L;
end;

export Accurint_Offenses_As_Common := project(df,into(LEFT));