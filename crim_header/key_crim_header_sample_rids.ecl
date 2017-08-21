import doxie,ngcdl2;

ds := pull(ngcdl2.Keys.matchsample(conf>=47));

layout_sample_rids := record
unsigned6 rid;
end;
layout_sample_rids to_slim_sample(ds l,integer c) := transform
self.rid := choose(c,l.rid1,l.rid2);
end;
df := normalize(ds,2,to_slim_sample(left,counter));

export key_crim_header_sample_rids := 
		index(df,{unsigned6 i_rid := rid},{df},'~thor_data400::key::crim_header_sample_rids_' + doxie.Version_SuperKey);
