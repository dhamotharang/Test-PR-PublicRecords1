import Enclarity,Enclarity_Facility_Sanctions,Data_Services,doxie;

d1:=Enclarity.Files(,true).individual_base.qa;
d2:=Enclarity.Files(,true).facility_base.qa;
d3:=Enclarity.Files(,true).associate_base.qa;
// as of 20160630 - no longer receiving Ingenix data - turning off the call to the Ingenix in files
// d4:=Ingenix_NatlProf.File_EnclaritySanctionGap;
d4:=Enclarity_Facility_Sanctions.Files(,true).facility_sanctions_base.qa;
r:={unsigned6 pid, string38 group_key:=''};
d := dedup(
						project(d1,r)
					+ project(d2,r)
					+ project(d3,r)
					+ project(d4,r)
				,pid,group_key,all);

i:=index(d,{pid},{group_key}
		,Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_PID_' + doxie.Version_SuperKey);

EXPORT Key_pid_gk := i;