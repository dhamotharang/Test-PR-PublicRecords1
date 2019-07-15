import mdr;
dlatest_iteration := files().base.built;
//filter for contact recs
dfilt := dlatest_iteration(
			lname != ''
	and fname != ''
);
dproj := project(dfilt	,transform(
	{dlatest_iteration.proxid	,string41 contact}
	,self.contact := trim(stringlib.stringcleanspaces(left.fname + ' ' + left.lname),left,right)
	,self					:= left
));
EXPORT file_contact := dedup(sort(distribute(dproj	,proxid),proxid,contact,local),proxid,contact,local);
