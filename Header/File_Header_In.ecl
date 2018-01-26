import ut,eq_hist,Std,data_Services;

export file_header_in(boolean pFastHeader=false) := module

shared rec_monthly := record
header.file_header_in_weekly.Layout AND NOT [   
                                                 filler1,
                                                 name_change,
                                                 addr_change,
                                                 ssn_change,
                                                 former_name_change,
                                                 new_rec,
                                                 filler2 ];
ebcdic string10 blank2;
ebcdic string43 blank3;
end;

SHARED rec_monthly_old :=record

    rec_monthly AND NOT [
                                         current_address_date_last_reported,
                                         former1_address_date_last_reported,
                                         former2_address_date_last_reported,
                                         blank2,
                                         blank3 ];
    ebcdic string1 blank2;
    ebcdic string43 blank3;
end;

//same layout in header.file_header_in_weekly
shared rec_weekly := record
        string8  eq_as_of_dt;
        file_header_in_weekly.Layout;
end;

shared rec_weekly_old := record

          rec_weekly AND NOT  [
                                current_address_date_last_reported,
                                former1_address_date_last_reported,
                                former2_address_date_last_reported,
                                filler1,name_change,addr_change,ssn_change,
                                former_name_change,new_rec,filler2
                               ],
                               
          EBCDIC string1 filler1;
          EBCDIC string1 name_change;
          EBCDIC string1 addr_change;
          EBCDIC string1 ssn_change;
          EBCDIC string1 former_name_change;
          EBCDIC string1 new_rec;
          EBCDIC string38 filler2;

end;

lc:=data_Services.Data_location.prefix('header_quick');


EXPORT monthly_file :=	dataset(lc+'thor_data400::in::hdr_raw',rec_monthly,flat) +
                        project(dataset(lc+'thor_data400::in::hdr_supplement2',rec_monthly_old,flat),transform(rec_monthly,SELF:=LEFT,SELF:=[]));

EXPORT weekly_file  := dataset('~thor400_84::in::eq_weekly_with_as_of_date2',rec_weekly,flat)+
               project(dataset('~thor400_84::in::eq_weekly_with_as_of_date',rec_weekly_old,flat),
                       transform(rec_weekly,SELF:=LEFT,SELF:=[]));

//all this is in the attempt to avoid the monthly data from re-cleaning/DID'ing (header.preprocess)
//when the addition of a new weekly file would trigger the UID to re-sequence

shared monthly_file1 := project(monthly_file,transform(header.layout_eq_src,self:=left,self:=[]));

//EQ and EH (EQ history restored) are concatenated in EQ source key but if both sources are sequenced independent of one another,
//two entities will endup with the same uid causing queries to randomly display the wrong one - bug 80773
max_uid:=max(eq_hist.file.base,uid);
shared seed:=if(pFastHeader,999999999999,max_uid);

src_rec:=header.layouts_SeqdSrc.EQ_src_rec;

header.Mac_Set_Header_Source(monthly_file1,header.layout_eq_src,src_rec,'EQ',withUID,seed);

export eq_uid_monthly := withUID;

//counter is safe provided that that the monthly file has less than 100B records
//UID's still need to be unique across the monthly & weekly data in the event
//weekly data is ever introduced into the full header

//putting this date here means that the 
//Header EQ Src key would need to change
//if the Weekly data were ever added

fn_convert_to_days(integer pInput) := 
                 (((integer)(((string)pInput)[1..4])*365)
                + ((integer)(((string)pInput)[5..6])* 12)
                + ((integer)(((string)pInput)[7..8])    )
                );
                
r_layout_header_in_with_as_of_dt := record
string8 eq_as_of_dt;
integer eq_as_of_dt_in_days;
integer today_in_days;
boolean within_range;
header.layout_header_in;
end;

r_layout_header_in_with_as_of_dt t_map_weekly(weekly_file le, integer c) := transform
self.eq_as_of_dt         := le.eq_as_of_dt;
self.eq_as_of_dt_in_days := fn_convert_to_days((integer)le.eq_as_of_dt);
self.today_in_days       := fn_convert_to_days((integer)(STRING8)Std.Date.Today());
self.within_range        := ut.DaysApart((STRING8)Std.Date.Today(),le.eq_as_of_dt)        <= header.sourcedata_month.v_nbr_of_days_to_keep;
self.src                 := 'WH';
self.uid                 := c + seed + 100000000000;
self                     := le;
self                     := [];
end;

export eq_uid_weekly  := project(weekly_file,t_map_weekly(left,counter))(within_range=true) : persist('~thor_data400::headerbuild_eq_src_weekly');

end;