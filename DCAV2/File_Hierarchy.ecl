EXPORT File_Hierarchy(

	 dataset(Layouts.Base.Companies	)	pBaseFile			= Files().base.companies.built			
	,string														pPersistname	= persistnames().FileHierarchy

) :=
function

	dout := project(pBaseFile(record_type in [Utilities.RecordType.Updated,Utilities.RecordType.New]), transform(layouts.temporary.hierarchy
			,self.root	:= intformat((unsigned)left.rawfields.root,9,1)
			,self.sub		:= intformat((unsigned)left.rawfields.sub	,4,1)
			,self 			:= left.rawfields
			,self 			:= left)) 
	: persist(pPersistname);
	
	return dout;

end;