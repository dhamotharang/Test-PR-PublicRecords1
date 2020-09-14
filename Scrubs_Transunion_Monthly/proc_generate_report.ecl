IMPORT SALT32,Scrubs,Data_Services,TransunionCred;
IMPORT Scrubs_Transunion_Monthly as S;
F := S.In_File: independent;		  // input file
o := 'Scrubs_Transunion_Monthly';		// orbit profile name
m := 'Transunion';

loc := data_services.Data_location.Prefix('PersonHeader');
v_tn := regexfind('w20.*-',nothor(fileservices.SuperFileContents(TransunionCred.Superfile_list.base))[1].name,0)[2..9];


N := S.Scrubs.FromNone(F);
U := S.Scrubs.FromExpanded(N.ExpandedInFile);
h := S.hygiene(F);											
y := h.Summary('SummaryReport');
p := h.allprofiles;

gen_hyg_report := sequential(
	OUTPUT(y,NAMED('SummaryReport_'+o),ALL),
	OUTPUT(p,NAMED('AllProfiles_'+o)  ,ALL));

disp_scrubs_report := sequential(
	output(        U.SummaryStats    ,	named(o+'_tn_ErrorSummary')),      // Show errors by field and type
	output(choosen(U.AllErrors, 1000),	named(o+'_tn_EyeballSomeErrors')), // Just eyeball some errors
	output(choosen(U.BadValues, 1000),	named(o+'_tn_SomeErrorValues')));  // See my error field values

EXPORT proc_generate_report (boolean submitTheStats = true) := function
        orbitStats        := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o);;
        disp_orbit_report := output(orbitStats,all,named('tn_OrbitReport'));
        submitStats       := Scrubs.OrbitProfileStats(o,'ScrubsAlerts',orbitStats,v_tn,m,CustomTag:='').SubmitStats;

        return SEQUENTIAL(
                        gen_hyg_report,
                        disp_scrubs_report,		
                        disp_orbit_report,
                        if(submitTheStats,submitStats)

        );
END;
