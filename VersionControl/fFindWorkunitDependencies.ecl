import lib_WORKUNITSERVICES;

export fFindWorkunitDependencies(

	 const varstring pWuid1
	,const varstring pWuid2

) :=
function
// find persists written for both

	dWuid1files := lib_WORKUNITSERVICES.WorkunitServices.WorkunitFilesWritten(pWuid1);
	dWuid2files := lib_WORKUNITSERVICES.WorkunitServices.WorkunitFilesWritten(pWuid2);
	
	dWuid1Persists := dWuid1files(regexfind('persist::',name,nocase));
	dWuid2Persists := dWuid2files(regexfind('persist::',name,nocase));
	
	dWuid1Slim := table(dWuid1Persists,	{string name := stringlib.stringtouppercase(name)});
	dWuid2Slim := table(dWuid2Persists,	{string name := stringlib.stringtouppercase(name)});
	
	dOverlap := join(
		 dWuid1Slim
		,dWuid2Slim
		,left.name = right.name
		,transform({string name}
				,self.name := left.name;
		)
	);
	
	return dOverlap;

end;