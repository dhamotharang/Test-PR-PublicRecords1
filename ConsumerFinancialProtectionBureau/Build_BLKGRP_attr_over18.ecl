import $, std;
export Build_BLKGRP_attr_over18(string data_source) := function
    OriginalLayout :=  $.layouts.original_BLKGRP_attr_over18;
    RawData := dataset(data_source, originalLayout, CSV(Heading(1)));
    $.layouts.BLKGRP_attr_over18 CFPB_convert(originalLayout L,  unsigned4 rsid, unsigned4 date) := TRANSFORM
        self.GeoInd := L.field1;
        self.geo_pr_White := (REAL4) L.field2;
        self.geo_pr_Black := (REAL4) L.field3;
        self.geo_pr_AIAN := (REAL4) L.field4;
        self.geo_pr_API :=  (REAL4) L.field5;
        self.geo_pr_mult_other :=  (REAL4) L.field6;
        self.geo_pr_Hispanic :=  (REAL4) L.field7;
        self.here :=  (REAL4) L.field8;
        self.here_given_white :=  (REAL4) L.field9;
        self.here_given_black :=  (REAL4) L.field10;
        self.here_given_aian :=  (REAL4) L.field11;
        self.here_given_api :=  (REAL4) L.field12;
        self.here_given_mult_other :=  (REAL4) L.field13;
        self.here_given_hispanic := (REAL4) L.field14;
        self.record_sid := rsid;
        self.dt_vendor_first_reported := date;
        self.global_src_id := 0;
        self.is_latest := true;
    END;
    return PROJECT(rawdata, CFPB_convert(left, counter, std.Date.CurrentDate()));
end;