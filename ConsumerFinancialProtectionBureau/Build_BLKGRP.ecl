import $, std;
export build_BLKGRP(boolean pUseProd = false, boolean isfcra = false) := function
    data_source := $.Filenames(, pUseProd, isfcra).BaseBLKGRP_in;
    originalLayout := $.layouts.original_BLKGRP;
    RawData := if( pUseProd,
        dataset(data_source, originalLayout, CSV(Heading(1))),
        choosen(dataset(data_source, originalLayout, CSV(Heading(1))),200) //debug faster
    );

    $.layouts.BLKGRP CFPB_convert(originalLayout L, unsigned4 rsid, unsigned4 date) := TRANSFORM
        self.seqno := (unsigned2) L.field1;
        self.GEOID10_BlkGrp := L.field2;
        self.State_FIPS10 := L.field3;
        self.County_FIPS10 := L.field4;
        self.Tract_FIPS10 := L.field5;
        self.BlkGrp_FIPS10:=  (unsigned2)L.field6;
        self.Total_Pop:=  (unsigned2)L.field7;
        self.Hispanic_Total:=  (unsigned2)L.field8;
        self.Non_Hispanic_Total:=  (unsigned2)L.field9;
        self.NH_White_alone:=  (unsigned2)L.field10;
        self.NH_Black_alone:=  (unsigned2)L.field11;
        self.NH_AIAN_alone:=  (unsigned2)L.field12;
        self.NH_API_alone:=  (unsigned2)L.field13;
        self.NH_Other_alone:=  (unsigned2)L.field14;
        self.NH_Mult_Total:=  (unsigned2)L.field15;
        self.NH_White_Other:=  (unsigned2)L.field16;
        self.NH_Black_Other:=  (unsigned2)L.field17;
        self.NH_AIAN_Other:=  (unsigned2)L.field18;
        self.NH_Asian_HPI:=  (unsigned2)L.field19;
        self.NH_API_Other:=  (unsigned2)L.field20;
        self.NH_Asian_HPI_Other:=  (unsigned2)L.field21;
        self.record_sid := rsid;
        self.dt_vendor_first_reported := date;
        self.global_src_id := 0;
        self.is_latest := true;

    END;

    return PROJECT(RawData, CFPB_convert(left, counter, std.Date.CurrentDate()));

END;
