import wk_ut,ut;
GetDFUWorkunit(string pWuid, string pesp = wk_ut._constants.LocalEsp) := FUNCTION

              dfuLayout := RECORD
                    STRING TimeStarted          {XPATH('TimeStarted')};
                    STRING TimeStopped          {XPATH('TimeStopped')};
                    STRING SourceLogicalName    {XPATH('SourceLogicalName')};
              END;
              OutRec1 := RECORD
                    DATASET(dfuLayout) Fred{XPATH('/result')};
              END;
              raw := HTTPCALL('http://' + pesp + ':8010/FileSpray/GetDFUWorkunit.xml?wuid=' + pWuid , 'GET', 'text/xml', OutRec1,xpath('GetDFUWorkunitResponse')); 
              return normalize(dataset(raw),left.Fred,transform({ string dfu, dfuLayout},self.dfu:=pWuid, self := right));
        end;

Get_DFUInfo(string filename, string pesp = wk_ut._constants.LocalEsp,string dfu_overwrite='') := FUNCTION
        dfu := if(dfu_overwrite<>'', dfu_overwrite,wk_ut.get_DFUInfo(filename).DFUInfo[1].wuid);
        return project(GetDFUWorkunit(dfu,pesp),TRANSFORM(
                                                {string TargetLogicalName, recordof(LEFT), real4 duration_hours},
                                                SELF.TargetLogicalName:=trim(filename),
                                                
                                                date_diff := ut.DaysApart(regexreplace('-',left.timeStopped,''),
                                                                          regexreplace('-',left.timeStarted,'')  )*24;
                                                             
                                                time_diff := (   ((real8)(left.timeStopped[12..13])+
                                                                  (real8)(left.timeStopped[15..16])/60+
                                                                  (real8)(left.timeStopped[18..19])/60/60)
                                                                 -
                                                                 ((real8)(left.timeStarted[12..13])+
                                                                  (real8)(left.timeStarted[15..16])/60+
                                                                  (real8)(left.timeStarted[18..19])/60/60)
                                                             );
                                                self.dfu := trim(LEFT.dfu);
                                                self.TimeStarted:=trim(LEFT.TimeStarted);
                                                self.TimeStopped:=trim(LEFT.TimeStopped);
                                                self.duration_hours:=date_diff+time_diff;
                                                self:=LEFT));
end;
getInfo(string filedate):=
sequential(
output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_segmentation::'+filedate+'::did_ind'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::address'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::dln'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::dob'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::lfz'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::name'),named('file_copy_log'),extend)
,output(Get_DFUInfo(  '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ph'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ssn'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::ssn4'),named('file_copy_log'),extend)
,output(Get_DFUInfo(  '~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::zip_pr'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::refs::relative'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader_xlink::'+filedate+'::did::sup::rid'),named('file_copy_log'),extend)

,output(Get_DFUInfo(   '~thor_data400::key::header::'+filedate+'::relatives_v3'),named('file_copy_log'),extend)
,output(Get_DFUInfo( '~thor_data400::base::insurance_header::'+filedate+'::relative',,'D20170901-061429'),named('file_copy_log'),extend)

,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::did'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::dln'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::insuranceheader::'+filedate+'::allpossiblessns'),named('file_copy_log'),extend)
,output(Get_DFUInfo(   '~thor_data400::key::header::'+filedate+'::addr_unique_expanded'),named('file_copy_log'),extend)
,output(Get_DFUInfo('~thor_data400::key::fcra::header::'+filedate+'::addr_unique_expanded'),named('file_copy_log'),extend)
);

getInfo('20180821'); // run on hthor

// W:\Projects\Header\15-05a_BuildAssistScripts\header_dfu_info_copy_from_alpha.ecl
// run on hthor (svc_person_header is ok)
// NB: Note filedate on line 36 above
// Previous runs
// -------------
/*
0821 W20180923-120649
0522 W20180620-102701
0423 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180518-103952#/stub/Summary
0320 http://prod_esp.br.seisint.com:8010/?Widget=WUDetailsWidget&Wuid=W20180414-141748#/stub/Summary

// */
// 0221 W20180316-104609
// 0130 W20180301-162004
// 1227 W20180205-130949
// 1121 W20180103-134640 
// 1025 W20171129-120326
// W20171023-162553 0925
// W20171019-083255 0828
// W20170906-111748 0725
//                  0628 
// W20170711-142226 0522
// W20170605-152235 0430
// W20170501-160442 0321
// W20170222-101253 0123
// W20170109-103448 1220