import crim_common, hygenics_search;

df := dataset(Crim_Common.Name_Moxie_DOC_Punishment_Dev+'_new',
			{hygenics_search.Layout_Moxie_DOC_Punishment,unsigned8 __fpos { virtual(fileposition)}},flat,unsorted);

layout_crimpunishment into(df L) := transform
	self.orig_state := L.vendor;
	self := l;
end;

export Accurint_Punishment_As_Common := project(df,into(LEFT));