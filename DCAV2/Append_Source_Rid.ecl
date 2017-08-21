import ut;

export Append_Source_Rid	(

	 dataset(Layouts.Base.companies			)	pInputFile							
	,dataset(Layouts.Base.companies			)	pBaseFile			= Files().base.companies.qa	
	
) := function

	dBaseFile := if(_Flags.KeepHistory ,pBaseFile	,dataset([],Layouts.Base.companies));

	pInputFile_dis	:= distribute(pInputFile, hash(rawfields.enterprise_num, file_type));
	pBaseFile_dis		:= distribute(dBaseFile,  hash(rawfields.enterprise_num, file_type));
	
	Layouts.Base.companies getSrcRid (pInputFile_dis l, pBaseFile_dis r) := transform
		self.src_rid	:= r.src_rid;		
		self 					:= l;
	end;
	
	//*** this join assigns the Src_rids for the older records.
	dBase_with_rids := join(pInputFile_dis, pBaseFile_dis, 
												  left.rawfields.enterprise_num = right.rawfields.enterprise_num and
													left.file_type								= right.file_type,
													getSrcRid (left,right),
													left outer,
													keep(1),
													local);
	
	//*** assign rid's for the newer records.
	ut.MAC_Append_Rcid (dBase_with_rids, src_rid, dBase_out);

	return dBase_out;

end;