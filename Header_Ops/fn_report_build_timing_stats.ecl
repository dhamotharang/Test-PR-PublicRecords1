// see bottom for latest runs
// Run on: hthor p_svc_person_header

import ut, std, dops, _control, header;

EXPORT fn_report_build_timing_stats(string emailList) := FUNCTION

wks := nothor(STD.System.Workunit.WorkunitList('',
                                    username := 'jtrost2_prod',
                                    jobname  := '*Ingest*'))         +
       nothor(STD.System.Workunit.WorkunitList('',
                                    username := 'svc_person_header',
                                    jobname  := '*Ingest*'));

utc_to_local(string in_time) := function

        _format := '%m/%d/%Y %T';  // eg // 11/01/2016 15:59:57

        loc := Std.Date.SecondsToString(Std.date.CurrentSeconds(~false), _format);
        utc := Std.Date.SecondsToString(Std.date.CurrentSeconds(~true), _format);
        utc_time_diff := ((integer)loc[12..13])-((integer)utc[12..13]);

        f1 := STD.Str.Find(in_time,'/',1);
        f2 := STD.Str.Find(in_time,'/',2);
        p1 := STD.Str.Find(in_time,' ',1);
        c1 := STD.Str.Find(in_time,':',1);
        c2 := STD.Str.Find(in_time,':',2);

        in_month:=in_time[1..(f1-1)];
        in_day:=in_time[(f1+1)..(f2-1)];
        in_year:=in_time[(f2+1)..(p1-1)];
        hr:=in_time[(p1+1)..(c1-1)];
        mn_:=in_time[(c1+1)..(c2-1)];
        mn := if(length(mn_)=1,'0'+mn_,mn_);
        sc:=in_time[(c2+1)..];

        in_hour:=((integer)hr);
        utc_to_local_hour_raw := in_hour+utc_time_diff;
        utc_to_local_hour := map( (utc_to_local_hour_raw<0 ) =>  24+utc_to_local_hour_raw,
                                  (utc_to_local_hour_raw>23) =>  24-utc_to_local_hour_raw,
                                                                  utc_to_local_hour_raw    );
        day_down := (utc_to_local_hour_raw<0);
        day_up := (utc_to_local_hour_raw>23);

        gr := STD.Date.FromGregorianYMD((integer)in_year,(integer)in_month,(integer)in_day);
        gr_sft := map (day_down => gr-1,
                       day_up   => gr+1,
                                   gr   );

        sft_dt := STD.Date.ToGregorianYMD(gr_sft);
        out_year:=((string)sft_dt.year);
        out_month:=if(sft_dt.month<=9,'0'+((string)sft_dt.month),((string)sft_dt.month));
        out_day:=if(sft_dt.day<=9,'0'+((string)sft_dt.day),((string)sft_dt.day));
        utc_to_local_hour_s := ((string)utc_to_local_hour);
        utc_to_local_hour_ := if(length(utc_to_local_hour_s)=1,'0'+utc_to_local_hour_s,utc_to_local_hour_s);
        ret := out_year+'-'+out_month+'-'+out_day+' '+utc_to_local_hour_+'h'+mn;

        return ret;
end;

wks_clean := wks(wuid not in['W20150622-094347']);
wks_sorted := dedup(sort(wks_clean,wuid),job); 

layout_report := record
    string8 header_version := '';
    string build_start:='';
    string release_to_prod:='';
    integer days_between_releases:=0;
    integer build_duration:=0;
end;

layout_report formatReport(wks_sorted L) := TRANSFORM
            SELF.header_version := regexfind('[0-9]{8}',L.job,0);
            SELF.build_start := L.wuid[2..5]+'-'+L.wuid[6..7]+'-'+L.wuid[8..9]+' '+L.wuid[11..12]+'h'+L.wuid[13..14];
            SELF.release_to_prod := L.wuid[2..5]+'-'+L.wuid[6..7]+'-'+L.wuid[8..9]+' '+L.wuid[11..12]+'h'+L.wuid[13..14];
            SELF := L;
END;

report_shell := project(wks_sorted,formatReport(left));
dops_history := dops.GetReleaseHistory('B','N','PersonHeaderKeys');

report_shell joinDops(report_shell L, dops_history R) := transform
    SELF.release_to_prod  := R.prodwhenupdated;
    SELF.header_version   := R.prodversion[1..8];
    SELF:=L;
end;

report_shell rollit(report_shell L, report_shell R) := TRANSFORM
    
    SELF.build_start      := min(L.build_start,R.build_start);
    SELF := L;
END;

dops_added := rollup(sort(join(report_shell,dops_history,LEFT.header_version[1..8] = RIGHT.prodversion[1..8],joinDops(LEFT,RIGHT)),
                    header_version,release_to_prod),
                    header_version,rollit(LEFT,RIGHT));

layout_report calcReport(dops_added L,dops_added R)     := TRANSFORM


                t1 := ut.DaysApart(    Std.Date.ConvertDateFormat(L.release_to_prod,'%Y-%m-%d', '%Y%m%d'),
                                Std.Date.ConvertDateFormat(R.release_to_prod[1..10],'%m/%d/%Y', '%Y%m%d')        );
                SELF.days_between_releases     := if(t1>90,0,t1);

                t2  := ut.DaysApart( std.Date.ConvertDateFormat(R.release_to_prod,'%m/%d/%Y', '%Y%m%d'),
                                         Std.Date.ConvertDateFormat(R.build_start,'%Y-%m-%d', '%Y%m%d')           );
        
        SELF.build_duration                     := if(t2>90,0,t2);
                SELF.release_to_prod := utc_to_local(trim(R.release_to_prod));
                SELF := R;

    END;

full_report  := dops_added[1] + sort(iterate(sort(dops_added[2..],header_version),calcReport(LEFT,RIGHT)),-header_version);

latestVersion:= full_report[1].header_version;
attachment   := STD.Str.FindReplace(
                                header.mac_convertDs.toHTML(full_report,header_version,build_start,release_to_prod,days_between_releases,build_duration)
                                ,'</BODY></HTML>', '</BR><ul><li>Build duration = First wuid start until first release to prod</li></ul></BODY></HTML>');
email_report:=
STD.System.Email.SendEmailAttachText(
                emailList,                                                                // recipientAddress
                'PersonHeader Build Statistics Report (v'+latestVersion+')',              // subjectText
                'Please find the latest report attached.\n\nThis report was generated by '+workunit+' (on '+_Control.ThisEnvironment.Name+').',            // bodyText
                attachment,                                                               // attachment
                'text/html',                                                              // fileMimeType
                'PersonHeader Buils Statistics Report (v'+latestVersion+').html'          // defaultFileName
);

do_all := sequential(
                    output(wks,named('Candidate_Jobs')),
                    output(wks_sorted,named('wks_sorted')),
                    output(report_shell,named('report_shell')),
                    output(dops_history,named('dops_history')),
                    output(dops_added,named('dops_added')),
                    output(full_report,named('header_build_report')),
                    email_report;  
);

RETURN do_all;

END;