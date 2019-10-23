IMPORT SALT39,Scrubs, ut;
IMPORT Scrubs_HeaderSlimSortSrc_Monthly as S;

F := S.In_File: independent;		  // input file
o := 'Scrubs_HeaderSlimSortSrc_Monthly';		// orbit profile name
m := 'HeaderSlimSortSrc';

ver := ut.GetDate : INDEPENDENT;

N := S.Scrubs.FromNone(F);
U := S.Scrubs.FromExpanded(N.ExpandedInFile);
h := S.hygiene(F);											
y := h.Summary('SummaryReport');
p := h.allprofiles;

gen_hyg_report := sequential(
	OUTPUT(y,NAMED('SummaryReport_'+o),ALL),
	OUTPUT(p,NAMED('AllProfiles_'+o)  ,ALL));

disp_scrubs_report := sequential(
	output(        U.SummaryStats    ,	named(o+'_ErrorSummary')),      // Show errors by field and type
	output(choosen(U.AllErrors, 1000),	named(o+'_EyeballSomeErrors')), // Just eyeball some errors
	output(choosen(U.BadValues, 1000),	named(o+'_SomeErrorValues')));  // See my error field values

EXPORT proc_generate_report (boolean submitTheStats = true) := FUNCTION
        orbitStats        := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o);;
        disp_orbit_report := output(orbitStats,all,named('OrbitReport'));
        submitStats       := Scrubs.OrbitProfileStats(o,'ScrubsAlerts',orbitStats,ver,m,CustomTag:='').SubmitStats;

        return SEQUENTIAL(
                        gen_hyg_report,
                        disp_scrubs_report,		
                        disp_orbit_report,
                        if(submitTheStats,submitStats)

        );
END;