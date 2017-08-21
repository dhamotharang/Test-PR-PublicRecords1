import crim_common;

df := dataset('~thor_data400::in::court_crim_activity_' + crim_common.Version_Development,layout_accurint_Activity_in,flat);

layout_activity into(df L) := transform
	self := L;
end;

export Accurint_Activity_As_Common := project(df,into(LEFT));