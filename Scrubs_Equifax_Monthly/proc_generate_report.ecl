IMPORT SALT32,Scrubs,Data_Services;
IMPORT Scrubs_Equifax_Monthly as S;
F := S.In_File: independent;		  // input file
o := 'Scrubs_Equifax_Monthly';		// orbit profile name
m := 'Equifax';
z := '\''+o+'\'';

loc := data_services.Data_location.Prefix('PersonHeader');
v_eq:= regexfind('_20.*',nothor(fileservices.SuperFileContents(loc+
                          nothor(fileservices.SuperFileContents(loc+ 'thor_data400::in::hdr_raw'))[1].name))[1].name,0)[2..];

N := S.Scrubs.FromNone(F);
U := S.Scrubs.FromExpanded(N.ExpandedInFile);
h := S.hygiene(F);											
y := h.Summary('SummaryReport');
p := h.allprofiles;

gen_hyg_report := sequential(
	OUTPUT(y,NAMED('SummaryReport_'+o),ALL),
	OUTPUT(p,NAMED('AllProfiles_'+o)  ,ALL));

disp_scrubs_report := sequential(
	output(        U.SummaryStats    ,	named(o+'_eq_ErrorSummary')),      // Show errors by field and type
	output(choosen(U.AllErrors, 1000),	named(o+'_eq_EyeballSomeErrors')), // Just eyeball some errors
	output(choosen(U.BadValues, 1000),	named(o+'_eq_SomeErrorValues')));  // See my error field values

EXPORT proc_generate_report (boolean submitTheStats = true) := function
        orbitStats        := U.OrbitStats() : persist('~persist::_scrubs_rpt::'+o);;
        disp_orbit_report := output(orbitStats,all,named('eq_OrbitReport'));
        submitStats       := Scrubs.OrbitProfileStats(#expand(z),'ScrubsAlerts',orbitStats,v_eq,m,CustomTag:='').SubmitStats;

        return SEQUENTIAL(
                        gen_hyg_report,
                        disp_scrubs_report,		
                        disp_orbit_report,
                        if(submitTheStats,submitStats)

        );
END;
