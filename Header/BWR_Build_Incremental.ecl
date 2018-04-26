// NB: UPDATE header.version_build before kicking off !!
import header,std,_control;
#workunit('name','Yogurt:'+header.version_build+' Header Ingest');
#STORED ('production', false);
#STORED ('_Validate_Year_Range_Low', '1800');
#STORED ('_Validate_Year_Range_high', ((STRING8)Std.Date.Today())[1..4]);
#OPTION ('multiplePersistInstances',FALSE);
#OPTION ('implicitSubSort',FALSE);
#OPTION ('implicitBuildIndexSubSort',FALSE);
#OPTION ('implicitJoinSubSort',FALSE);
#OPTION ('implicitGroupSubSort',FALSE);

EXPORT BWR_Build_Incremental(string filedate) := FUNCTION
basename:='~thor_data400::base::header_raw_incremental';

the_new_monthly := '~'+fileservices.SuperFileContents('~thor_data400::base::header_raw')[1].name;

// *******************************************************************************************

in_raw:=nothor(fileservices.SuperFileContents('~thor_data400::in::hdr_raw',1)[1].name); // ( thor_data400::in::quickhdr_raw )

file_version(string super) := function
        
        sub:=stringlib.stringfind(super,((STRING8)Std.Date.Today())[1..2],1);
output(dataset([{super,sub,super[sub+4..sub+5]}],{string s1, string s2, string s3}),
            named('log'),extend);        
        return super[sub+4..sub+5];
        
end;

the_eq_file_for_this_month_is_available:=not(((STRING8)Std.Date.Today())[5..6]<>file_version(in_raw));

monthly_ingest :=nothor(fileservices.SuperFileContents('~thor_data400::base::header_raw',1)[1].name);
the_full_ingest_for_this_month_is_completed := not(((STRING8)Std.Date.Today())[5..6]<>file_version(monthly_ingest));

run_full_monthly_ingest                         :=  STD.System.Email.sendemail(_control.MyInfo.EmailAddressNotify,'PLEASE RUN FULL MONTHLY HEADER !!','');
run_the_weekly_header_ingest(string filedate)    :=  Header.proc_Header.Ingest_Incremental(filedate);

report_conditions:= output(dataset([

                                {'in_raw',in_raw},
                                {'this_month',((STRING8)Std.Date.Today())[5..6]},
                                {'the_eq_file_for_this_month_is_available',if(the_eq_file_for_this_month_is_available,'Yes','No')},
                                {'the_full_ingest_for_this_month_is_completed',if(the_full_ingest_for_this_month_is_completed,'Yes','No')}
                
                                    ],{string param, string value}),named('Ingest_Status'));

run_build(string filedate) := if(the_eq_file_for_this_month_is_available
                                AND not(the_full_ingest_for_this_month_is_completed),
                
                                run_full_monthly_ingest,
                                run_the_weekly_header_ingest(filedate)
                               );

// ************************************************************************************************************************  
// NB: Update BOTH #stored AND run_date BEFORE kicking off !! No need to update version_build

run_date :=              filedate    ;

versionBuild := header.version_build : stored('versionBuild');  
check_date(string filedate):= if(filedate<>versionBuild,fail('filedate and versionBuild MUST match'));

go(string filedate)  :=  sequential(check_date(filedate), report_conditions, run_build(filedate));

return go(run_date);

end;

// W:\Projects\Header\Incremental Raw\build incremental header raw.ecl
// HeaderIngestSetup: W:\Projects\Header\suppress_header_records\BWR_HeaderIngestSetup2.ecl
// STATS: "W:\Projects\Header\Incremental Raw\Boca Header RAW Stats.ecl"

// Previous incremental runs (not documenting monthly runs - see protected wuids):
// -------------------------------------------------------------------------------
// +-----------------+----------------+----------------+--------+
// |HeaderIngestSetup|Inputs_set      |Raw (Inc / Full)|Version |
// +-----------------+----------------+----------------+--------+
// | ||W20171128-221708|20171128|W20171129-091650
// +-----------------+----------------+----------------+--------+
// |W20171121-144303 |W20171121-144212|
// +-----------------+----------------+----------------+--------+
// |W20171114-152017 |W20171114-145118|W20171115-115327|20171115|
// +-----------------+----------------+----------------+--------+
// |W20171107-155624 |W20171107-154641|W20171107-160721|20171107|
// +-----------------+----------------+----------------+--------+
// |W20171031-154938 |W20171031-153446|W20171031-160501|20171031|
// +-----------------+----------------+----------------+--------+
//                                                      20171025| full
// +-----------------+----------------+----------------+--------+
// |                                  |W20171018-111804|20171017|
// +-----------------+----------------+----------------+--------+
// |W20171003-122040 |W20171003-122131|W20171003-125029|20171003|
// +-----------------+----------------+----------------+--------+
//                                    |W20170920-080643|20170920|
//                                    |W20170913-083305|20170913|
// +-----------------+----------------+----------------+--------+
// |W20170905-185337 |W20170905-185414|W20170905-234244|20170905|
// +-----------------+----------------+----------------+--------+
// |W20170821-155211 |W20170821-155347|W20170821-221753|20170821|
// +-----------------+----------------+----------------+--------+
// |W20170814-215948 | 
// +-----------------+----------------+----------------+--------+
// |W20170808-121831 |W20170808-121858|W20170808-143218|20170808| W20170809-081114 
// +-----------------+----------------+----------------+--------+
// |W20170731-223450 |W20170731-223727||20170731| // manually updated dl2 aid in building
// +-----------------+----------------+----------------+--------+
// |W20170724-093639 |W20170724-093709|W20170725-155905|20170725|
// +-----------------+----------------+----------------+--------+
// |W20170717-112508 |W20170717-112654|W20170717-121308|20170717| W20170717-135530, W20170717-172431  
// +-----------------+----------------+----------------+--------+
// |W20170710-111240 |W20170710-111324|W20170710-114234|20170710| W20170711-082335, W20170711-163950
// +-----------------+----------------+----------------+--------+
// |W20170705-113953 |W20170705-114030|W20170705-122152|20170705|
// +-----------------+----------------+----------------+--------+
// |W20170628-115502 |W20170628-115544| Full           |20170628|
// +-----------------+----------------+----------------+--------+
// |W20170623-152056 |W20170623-152252|W20170624-101332|20170623|
// +-----------------+----------------+----------------+--------+
// |W20170613-121131 |W20170613-134205|W20170613-153042|20170613| ,14-143715
// +-----------------+----------------+----------------+--------+
// |W20170606-122913 |W20170606-123541|W20170606-142545|20170606|
// +-----------------+----------------+----------------+--------+
// |W20170531-150134 |W20170531-172652|W20170531-172652|20170531|
// +-----------------+----------------+----------------+--------+
// |W20170522-111449 |W20170522-111526|W20170522-130349|20170522| ,150538,165433,3-083249,4-205050
// +-----------------+----------------+----------------+--------+
// |W20170516-143750 |W20170516-143824|W20170516-151624|20170516|, W20170517-205348
// +-----------------+----------------+----------------+--------+
// |W20170509-111128 |W20170509-111404|W20170509-113234|20170509| recovred wuids: W20170510-141448,W20170510-142746,W20170511-061607
// +-----------------+----------------+----------------+--------+
// |W20170430-111751 |W20170430-112006|   Full         |20170340|
// +-----------------+----------------+----------------+--------+
// |W20170425-115523 |W20170425-115650|W20170425-132603|20170425|
// |                 |                |W20170425-151920|        |
// +-----------------+----------------+----------------+--------+
// |W20170411-124008 |W20170411-124350|W20170411-131015|20170411|
// |                 |                |W20170413-100107|        |
// +-----------------+----------------+----------------+--------+
// |W20170404-123654 |    N/A         |W20170404-132905|20170404|
// |                 |                |W20170405-124647|        |
// +-----------------+----------------+----------------+--------+

// W20170328-113217 0328 - incr     W20170328-115417                    // Continued on W20170329-132855
// W20170321-131628 0321 - full
// W20170316-095616 0316 - incr
// W20170301-095957 20170301 (incremental) // skipping property and ASL // Continued on: W20170302-163916
// W20170207-154753 20170207 (incremental)                              // Continued on: W20170208-153007
// W20170202-154838 20170131 (incremental)
// W20170113-160807
// W20170103-132843
// W20161220-100943 (FULL)
// W20161213-101135
// W20161206-105506
// W20161114-130718
// W20161005-090526
// W20160927-132402
// W20160910-222747
