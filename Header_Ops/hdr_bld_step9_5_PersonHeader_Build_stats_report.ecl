// see bottom for latest runs
// Run on: hthor p_svc_person_header

import ut, std, dops,zz_gmarcan, _control;
emailRecipients := 'gabriel.marcan@lexisnexisrisk.com'
                                    +';Debendra.Kumar@lexisnexisrisk.com'
									// +';Jose.Bello@lexisnexisrisk.com'
                                    // +';Joseph.Lezcano@lexisnexisrisk.com'
									// +';Jennifer.Butts@lexisnexisrisk.com'
									// s+';Jessica.Mills@lexisnexisrisk.com'
									 ;

wks := STD.System.Workunit.WorkunitList('',
																					username := 'jtrost2_prod',
																					jobname  := '*Ingest*')         +
       STD.System.Workunit.WorkunitList('',
																					username := 'svc_person_header',
																					jobname  := '*Ingest*');



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





output(wks,named('Candidate_Jobs'));
wks_clean := wks(wuid not in['W20150622-094347']);
wks_sorted := dedup(sort(wks_clean,wuid),job); 
output(wks_sorted,named('wks_sorted'));
layout_report := record
	string header_version := '';
	string build_start:='';
	string release_to_prod:='';
	integer days_between_releases:=0;
	integer build_duration:=0;
end;

layout_report formatReport(wks_sorted L) := TRANSFORM
			SELF.header_version := trim(L.job[8..16]);
			SELF.build_start := L.wuid[2..5]+'-'+L.wuid[6..7]+'-'+L.wuid[8..9]+' '+L.wuid[11..12]+'h'+L.wuid[13..14];
			SELF.release_to_prod := L.wuid[2..5]+'-'+L.wuid[6..7]+'-'+L.wuid[8..9]+' '+L.wuid[11..12]+'h'+L.wuid[13..14];
			SELF := L;
END;

report_shell := project(wks_sorted,formatReport(left));
output(report_shell,named('report_shell'));
dops_history := dops.GetReleaseHistory('B','N','PersonHeaderKeys');
output(dops_history,named('dops_history'));

report_shell joinDops(report_shell L, dops_history R) := transform
	SELF.release_to_prod  := R.prodwhenupdated;
    SELF.header_version   := R.prodversion[1..8];
	SELF:=L;
end;

dops_added := rollup(sort(join(report_shell,dops_history,LEFT.header_version[1..8] = RIGHT.prodversion[1..8],joinDops(LEFT,RIGHT)),
                    build_start,release_to_prod),
                    header_version,TRANSFORM(LEFT));
output(dops_added,named('dops_added'));
layout_report calcReport(dops_added L,dops_added R) 	:= TRANSFORM
				
			
				t1 													:= ut.DaysApart(	Std.Date.ConvertDateFormat(L.release_to_prod,'%Y-%m-%d', '%Y%m%d'),
																											Std.Date.ConvertDateFormat(R.release_to_prod[1..10],'%m/%d/%Y', '%Y%m%d')		);
				SELF.days_between_releases 	:= if(t1>90,0,t1);
				
				t2									 				:= ut.DaysApart(	Std.Date.ConvertDateFormat(R.release_to_prod,'%m/%d/%Y', '%Y%m%d'),
																											Std.Date.ConvertDateFormat(R.build_start,'%Y-%m-%d', '%Y%m%d')							);
        SELF.build_duration 					:= if(t2>90,0,t2);
                SELF.release_to_prod := utc_to_local(trim(R.release_to_prod));
				SELF := R;
	
	END;

full_report := sort(iterate(sort(dops_added,header_version),calcReport(LEFT,RIGHT)),-header_version);
output(full_report,named('header_build_report'));
latestVersion := full_report[1].header_version;
attachment :=   STD.Str.FindReplace(
								zz_gmarcan.mac_convertDs.toHTML(full_report,header_version,build_start,release_to_prod,days_between_releases,build_duration)
								,'</BODY></HTML>', '</BR><ul><li>Build duration = First wuid start until first release to prod</li></ul></BODY></HTML>');
STD.System.Email.SendEmailAttachText(
				emailRecipients,				 											// recipientAddress
				'PersonHeader Build Statistics Report (v'+latestVersion+')',  			// subjectText
				'Please find the latest report attached.\n\nThis report was generated by '+workunit+' (on '+_Control.ThisEnvironment.Name+').',			// bodyText
				attachment, 														 			// attachment
				'text/html',											 		  			// fileMimeType
				'PersonHeader Buils Statistics Report (v'+latestVersion+').html'  	// defaultFileName
);

// W:\Projects\Header\15-05a_BuildAssistScripts\BWR_Generate_PersonHeader_Build_stats_report.ecl
// Run on: hthor p_svc_person_header
// Previous runs
// -------------
// 20180821 W20181003-151526
// 20180724 W20180907-124234
// 20180522 W20180629-135531
// 20180423 W20180604-141816 
// 20180320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180502-131853#/stub/Summary
// 20180221 W20180418-123548
// 20180130 W20180316-105226
// W20180215-141326 20171227
// W20180126-144922 20171121
// W20171110-094851 20170925
// W20171023-160941 20170828
// W20171019-092044 20170725
// W20170816-104409 20170628
// W20170807-155002 20170522
// W20170627-134855 20170430
// W20170509-120604 20170321
// W20170404-141620 20170223 
// W20170306-083653 20170123
// W20170203-092852 20161220
// W20161230-100545
// W20161201-093304