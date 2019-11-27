#WORKUNIT('name','Find Uncategorized Crim Offenses');
IMPORT crim_offense_cat, STD;
pUseProd := false;
rpt_date := (STRING8)Std.Date.Today();
rpt_yymm := rpt_date[1..6];
offense_layout := crim_offense_cat.layouts.offense_layout;
original_layout := RECORD
    string str,
    string str2
    END;
offense_data := dataset(crim_offense_cat.filenames().doc_offenses,
                        original_layout,
                        CSV(Heading(2),separator(['^|^']))
                        );
just_offense_charge := record
    offense_layout.offensecharge
    end;
just_offense_charge remove_quotes(original_layout L) := TRANSFORM, skip(L.str2[1] = '')
    Self.offensecharge := trim(
        if( L.str2[length(L.str2)] = '"',
            L.str[2..],
            L.str
            ),
        left,
        right
        );
    END;
offense_charges := project(offense_data, remove_quotes(left));
old_base := dataset(crim_offense_cat.Filenames(pUseProd).base, crim_offense_cat.layouts.base_layout, thor, __compressed__, opt);
uncategorized_offenses := join(offense_charges, old_base, left.offensecharge = right.offensecharge,left only);

output(uncategorized_offenses, {offensecharge}, crim_offense_cat.filenames(pUseprod).new_offenses+rpt_date, overwrite);
//count(new_offenses);