import Enclarity,Data_Services,doxie;

d1:=Enclarity.Files(,true).individual_base.qa;
d2:=Enclarity.Files(,true).facility_base.qa;
d3:=Enclarity.Files(,true).associate_base.qa;
d4:=Ingenix_NatlProf.File_EnclaritySanctionGap;
r:={unsigned6 pid, string38 group_key:=''};
d := dedup(
						project(d1,r)
					+ project(d2,r)
					+ project(d3,r)
					+ project(d4,transform(r,self.pid:=(Unsigned6)left.sanc_id,self:=left))
				,pid,group_key,all);

i:=index(d,{pid},{group_key}
		,Data_Services.Data_Location.Prefix('Provider')+'thor_data400::key::ingenix_PID_' + doxie.Version_SuperKey);

EXPORT Key_pid_gk := i;