import mdr;
dlatest_iteration := files().base.built;
//filter for contact recs
dfilt := dlatest_iteration(
			mailing_prim_name   != ''
	and mailing_v_city_name != ''
	and mailing_st          != ''
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	            ,dlatest_iteration.mailing_prim_name
  ,dlatest_iteration.mailing_v_city_name,dlatest_iteration.mailing_st}
	,self					:= left
));
EXPORT file_mailing_address := dedup(sort(distribute(dproj	,proxid),whole record,local),whole record,local);
