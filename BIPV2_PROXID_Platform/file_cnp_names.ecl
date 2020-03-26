dlatest_iteration := files().base.built;
dfilt := dlatest_iteration(
      cnp_name != ''
);
dproj := project(dfilt	,transform({dlatest_iteration.rcid	,string250 cnp_name_raw},self.cnp_name_raw := left.cnp_name,self := left));

EXPORT file_cnp_names := dproj;//table(dproj,{rcid,cnp_name},rcid,cnp_name,merge);
