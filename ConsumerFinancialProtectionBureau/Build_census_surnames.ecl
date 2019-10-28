import $, std;
export build_census_surnames(string data_source) := function
    OriginalLayout := $.layouts.original_namecensus;
    RawData := dataset(data_source, OriginalLayout, CSV(Heading(1)));
    $.layouts.namecensus CFPB_convert(OriginalLayout L, unsigned4 rsid, unsigned4 date) := TRANSFORM
        self.name := L.field1;
        self.name_rank := (UNSIGNED3) L.field2;
        self.name_count := (UNSIGNED3) L.field3;
        self.prop100k := (UDECIMAL5_2) L.field4;
        self.cum_prop100k := (UDECIMAL9_2) L.field5;
        self.pctwhite := (UDECIMAL4_2) L.field6;
        self.pctblack := (UDECIMAL4_2) L.field7;
        self.pctapi := (UDECIMAL4_2) L.field8;
        self.pctaian := (UDECIMAL4_2) L.field9;
        self.pct2prace := (UDECIMAL4_2) L.field10;
        self.pcthispanic := (UDECIMAL4_2) L.field11;
        self.record_sid := rsid;
        self.dt_vendor_first_reported := date;
        self.global_src_id := 0;
        self.is_latest := true;
    END;
    return PROJECT(rawdata, CFPB_convert(left, counter, std.Date.CurrentDate()));
end;