import ut;
export proc_build_keys(string filedate) := function

in_ds := misc2.file_in_md5_ssn;

layout_out := record
data16 	hval;
end;
layout_out in_to_base(in_ds l) := transform
self.hval := stringlib.string2data(l.hval_s);
end;
kf := project(in_ds, in_to_base(left));

Key_md5_val := index(kf,
			{hval}, {kf}, '~thor_data400::key::md5::'+filedate+'::ssn');
			
do_it :=  buildindex(key_md5_val,few);

return sequential(do_it);
end;
