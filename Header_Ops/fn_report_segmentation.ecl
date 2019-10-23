// ******************************************************************************************
import STD, data_services,Watchdog,doxie_build,$;

EXPORT fn_report_segmentation(string emailList):=function

  // inputs:
  lc:=data_services.foreign_prod;

Watchdog_File_Best_marketing          := dataset(lc+'thor_data400::base::watchdog_best_marketing'       ,{Watchdog.File_Best_marketing}         ,thor);
doxie_build_file_fcra_header_building := dataset(lc+'thor_data400::base::file_fcra_header_building_prod',{doxie_build.file_fcra_header_building},thor);
doxie_build_file_header_building      := dataset(lc+'thor_data400::base::file_header_building_prod'     ,{doxie_build.file_header_building}     ,thor);

hf0 := dedup(sort(join(distribute(doxie_build_file_fcra_header_building,hash64(did)), distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);
hn0 := dedup(sort(join(distribute(doxie_build_file_header_building,hash64(did))     , distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);
hm0 := dedup(sort(join(distribute(Watchdog_File_Best_marketing,hash64(did))         , distribute(Watchdog.File_Best,hash64(did)), LEFT.did = RIGHT.did,local),did,local),did,local);

output(count(dedup(sort(doxie_build_file_fcra_header_building   ,did,local),did,local)),named('count_file_fcra_header_building'));
output(count(dedup(sort(doxie_build_file_header_building        ,did,local),did,local)),named('count_file_header_building')     );
output(count(dedup(sort(Watchdog_File_Best_marketing            ,did,local),did,local)),named('count_File_Best_marketing')      );

output(count(hf0),named('count_fcra'));
output(count(hn0),named('count_nfcra'));
output(count(hm0),named('count_marketing'));

seg_f   := table(hf0   ,{adl_ind,cnt := count(group)},adl_ind,few);
seg_n   := table(hn0   ,{adl_ind,cnt := count(group)},adl_ind,few);
seg_m   := table(hm0   ,{adl_ind,cnt := count(group)},adl_ind,few);

send_report(dataset(recordof(seg_f)) ds,string emailList, string bVersion,string ref, string vType) := function
    
        // record sets to report
        rsTotalRecs := project(ds,transform($.email_reporting.recValuePair, self.v1 := LEFT.adl_ind, self.v2 := (string)LEFT.cnt));

        // styles to use in the form { integer sizeInPercentOfDefault; boolean boldFlag; boolean italicFlag; }
        normalTextStyle := dataset ([{ 100, false, false }], $.email_reporting.recTextStyle);
        largeBoldTextStyle := dataset ([{ 120, true, false }], $.email_reporting.recTextStyle);
        boldTextStyle := dataset ([{ 100, true, false }], $.email_reporting.recTextStyle);
        largeItalicTextStyle := dataset ([{ 120, false, true }], $.email_reporting.recTextStyle);
        italicTextStyle := dataset ([{ 100, false, true }], $.email_reporting.recTextStyle);

        // overall report header
        rsHeader := dataset([
            { boldTextStyle,   'Person Header LexID Segmentation' },
            { italicTextStyle, 'Update Frequency: Monthly' },            
            { italicTextStyle, 'Build version: '+bVersion },    
            { normalTextStyle, '' },
            { italicTextStyle, 'Reference: '+ref },
            { boldTextStyle,   vType }
            ], $.email_reporting.recHeader);

        // header and styles for record sets
        rsValuePairBlock := dataset([
            { 'Segment', 'Record Count', rsTotalRecs, boldTextStyle, normalTextStyle, '12A' }
            ], $.email_reporting.recValuePairBlock);

        // call the function to do the work
        string attachment := $.email_reporting.fnEmailWithAttachedReport(
                emailList,
                bVersion+' Header '+vType+' LexID Segmentation Stats',
                'Double-click attachment (do not use outlook preview feature)',
                'application/excel',
                bVersion+' Header '+vType+' LexID Segmentation Stats.xls',
                rsHeader,
                rsValuePairBlock);
                
        return output(attachment);
end;
        
wu := (string)STD.System.Job.WUID();

getVname (string superfile, string v_end = ':') := FUNCTION

    FileName:=fileservices.GetSuperFileSubName(superfile,1);
    v_strt  := stringlib.stringfind(FileName,'_20',1)+1;
    v_endd    := stringlib.stringfind(FileName[v_strt..],v_end,1);
    v_name  := FileName[v_strt..v_strt+if(v_endd<1,length(FileName),v_endd)-2];

    RETURN v_name;

END;

hv := trim(nothor(getVname(data_services.foreign_prod +'thor_data400::base::file_header_building')));
mv := trim(nothor(getVname(data_services.foreign_prod +'thor_data400::BASE::Watchdog_Best_marketing')));


do_all := sequential(
                     output(seg_f,named('count_seg_fcra'));
                     output(seg_n,named('count_seg_nfcra'));
                     output(seg_m,named('count_seg_marketing'));
                     output(hm0(trim(adl_ind)=''));
                     output(hv, named('Header_Version')),
                     output(mv, named('Watchdog_Marketing_Version')),
                     send_report(seg_n,emailList,hv,wu,'nFCRA'),
                     send_report(seg_f,emailList,hv,wu,'FCRA'),
                     send_report(seg_m,emailList,mv,wu,'Marketing')
);
return do_all;

END;