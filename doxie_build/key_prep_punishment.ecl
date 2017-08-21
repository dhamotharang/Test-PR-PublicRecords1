import corrections;

d := File_Punishment_Keybuilding;

corrections.Layout_CrimPunishment oldLayout(d l):= transform
	self := l;
end;

df := project(d, oldLayout(left));

export key_prep_punishment := index(df,{ok := df.offender_key, pt := df.punishment_type},{df},'~thor_data400::key::corrections_punishment_' + doxie_build.buildstate + thorlib.wuid());