#workunit ('name', 'Business Header Updated Sources Stats ' + Business_Header.version);
bh_file := DATASET('~thor_data400::BASE::Business_Header', business_header.Layout_Business_Header_Base, THOR);

Layout_BH_Slim := RECORD
string2   source;
sTRING30 description;
string2   state;
unsigned4 dt_last_seen; 
unsigned4 dt_vendor_last_reported;
END;

Layout_BH_Slim SlimBH(Business_Header.Layout_Business_Header_Base L) := TRANSFORM
SELF := L;
self.description := Business_Header.TranslateSource(l.source);
END;

BH_Slim := PROJECT(BH_File, SlimBH(LEFT));

Layout_BH_Stat := RECORD
BH_Slim.source;
BH_slim.description;
BH_Slim.state;
unsigned4 latest_dt_last_seen := max(group, if(BH_Slim.dt_last_seen < 20060414,BH_Slim.dt_last_seen, 0) );
unsigned4 latest_dt_vendor_last_reported := max(group, if(BH_Slim.dt_vendor_last_reported < 20060414, BH_Slim.dt_vendor_last_reported, 0));
cnt := COUNT(GROUP);
END;

BH_Stats := TABLE(BH_Slim, Layout_BH_Stat, source, description, state, FEW);

OUTPUT(BH_Stats(latest_dt_last_seen > 20060210 or latest_dt_vendor_last_reported > 20060210),named('BusinessHeaderUpdatedSourcesAndStates'),ALL);

layout_bh_source :=
record
	bh_stats.source;
	bh_stats.description;
	BH_Stats.state;
	unsigned4 cnt := count(group);
end;

bh_source_counts := table(BH_Stats, layout_bh_source, source, description, state, few);

output(bh_source_counts, named('BusinessHeaderUpdatedSources'), all);