import prof_license;

df := dataset('~thor_data400::base::prof_licenses_BUILDING',prof_license.layout_proflic_out,flat);

prof_license.layout_proflic_out into(df L) := transform
	self := l;
end;

export file_proflicense_keybuilt := project(df,into(LEFT));