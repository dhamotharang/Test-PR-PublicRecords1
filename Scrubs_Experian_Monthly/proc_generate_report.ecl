IMPORT SALT32,Scrubs,Data_Services,ExperianCred;
IMPORT Scrubs_Experian_Monthly as S;
F := S.In_File: independent;		  // input file
o := 'Scrubs_Experian_Monthly';		// orbit profile name
m := 'Experian';

loc := data_services.Data_location.Prefix('PersonHeader');
v_en := regexfind('w20.*-',nothor(fileservices.SuperFileContents(ExperianCred.SuperFile_List.Base_File))[1].name,0)[2..9];


N := S.Scrubs.FromNone(F);
U := S.Scrubs.FromExpanded(N.ExpandedInFile);
h := S.hygiene(F);											
y := h.Summary('SummaryReport');
p := h.allprofiles;

gen_hyg_report := sequential(
	OUTPUT(y,NAMED('SummaryReport_'+o),ALL),
	OUTPUT(p,NAMED('AllProfiles_'+o)  ,ALL));

disp_scrubs_report := sequential(
	output(        U.SummaryStats    ,	named(o+'_en_ErrorSummary')),      // Show errors by field and type
	output(choosen(U.AllErrors, 1000),	named(o+'_en_EyeballSomeErrors')), // Just eyeball some errors
	output(choosen(U.BadValues, 1000),	named(o+'_en_SomeErrorValues')));  // See my error field values

EXPORT proc_generate_report (boolean submitTheStats = true) := function
        orbitStats        := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o);;
        disp_orbit_report := output(orbitStats,all,named('en_OrbitReport'));
        // added 'post310' because Scrubs.ecl runs on SALT311 
        submitStats       := Scrubs.OrbitProfileStatsPost310(o,'ScrubsAlerts',orbitStats,v_en,m,CustomTag:='').SubmitStats;

        return SEQUENTIAL(
                        gen_hyg_report,
                        disp_scrubs_report,		
                        disp_orbit_report,
                         if(submitTheStats,submitStats)

        );
END;
