#WORKUNIT('name','Find Uncategorized Crim Offenses');

IMPORT crim_offense_cat, STD;

rpt_date := (STRING8)Std.Date.Today();
rpt_yymm := rpt_date[1..6];

offense_data := dataset(
                    crim_offense_cat.filenames().doc_offenses,
                    crim_offense_cat.layouts.offense_layout,
                    CSV(Heading(1),separator(['^|^']))
                    );
