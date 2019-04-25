import RiskWise,scoring_project_pip,Scoring_Project_Macros,Scoring_Project_DailyTracking, sghatti,Gateway, ut;

yesterday := ut.date_math(ut.getdate, -1);
// yesterday := '20170322';
	output(yesterday);

qa_ddt_ds := Scoring_Project_DailyTracking.DDT_GetDeployedDatasets('Q', 'B', '', '');

filter := ['BN','B'];
header_check := qa_ddt_ds(cluster not in filter);


layout := record
string datasetname;
string envment;
string cluster;
string buildversion;
string releasedate;
end;

date_form(string rel_date) := function
		a := Stringlib.StringFind(rel_date, '/', 1);
		b := Stringlib.StringFind(rel_date, '/', 2);
		c := b + 4;
		mo := intformat((integer)rel_date[1..(a-1)], 2, 1);
		dom := intformat((integer)rel_date[(a+1)..(b-1)], 2, 1);
		yr := intformat((integer)rel_date[(b+1)..c], 4, 1);
	return yr + mo + dom;
end;
layout trans(header_check le) := transform
self.datasetname := le.datasetname;
self.envment := if(le.envment = 'Q', 'Cert', le.envment);
self.cluster := le.cluster;
self.buildversion := le.buildversion;
self.releasedate := date_form(le.releasedate);
self := [];
end;

get_header_dt := project(header_check, trans(left));

	output(get_header_dt);
headersort := sort(get_header_dt, -releasedate, datasetname);
	output(headersort, all);

get_yesterday_dt := headersort(releasedate = yesterday);
	output(get_yesterday_dt, all);


// string build_v := (string)headersort[1].buildversion;
// output(build_v);
			