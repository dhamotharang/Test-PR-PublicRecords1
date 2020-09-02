IMPORT SALT32,Scrubs,Data_Services;
IMPORT Scrubs_TUCS as S;
F := S.In_File: independent;		  // input file
o := 'Scrubs_TUCS';		// orbit profile name
m := 'TUCS';

loc := data_services.Data_location.Prefix('PersonHeader');
v_tc := regexfind('w20.*-',nothor(fileservices.SuperFileContents(loc+'thor400::base::transunion_PTrak'))[1].name,0)[2..9];


N := S.Scrubs.FromNone(F);
U := S.Scrubs.FromExpanded(N.ExpandedInFile);
h := S.hygiene(F);											
y := h.Summary('SummaryReport');
p := h.allprofiles;

gen_hyg_report := sequential(
	OUTPUT(y,NAMED('SummaryReport_'+o),ALL),
	OUTPUT(p,NAMED('AllProfiles_'+o)  ,ALL));

disp_scrubs_report := sequential(
	output(        U.SummaryStats    ,	named(o+'_tc_ErrorSummary')),      // Show errors by field and type
	output(choosen(U.AllErrors, 1000),	named(o+'_tc_EyeballSomeErrors')), // Just eyeball some errors
	output(choosen(U.BadValues, 1000),	named(o+'_tc_SomeErrorValues')));  // See my error field values

EXPORT proc_generate_report (boolean submitTheStats = true) := function
        orbitStats        := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o);;
        disp_orbit_report := output(orbitStats,all,named('tc_OrbitReport'));
        submitStats       := Scrubs.OrbitProfileStats(o,'ScrubsAlerts',orbitStats,v_tc,m,CustomTag:='').SubmitStats;

        return SEQUENTIAL(
                        gen_hyg_report,
                        disp_scrubs_report,		
                        disp_orbit_report,
                        if(submitTheStats,submitStats)

        );
END;
