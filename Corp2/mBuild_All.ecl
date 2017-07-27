export mBuild_All :=
module

	export build_bases			:= mBuild_BaseFiles.Build_All;
	export build_roxie_keys		:= mBuild_Roxie_Keys.Build_All;
	export promote2QA			:= Promote_Built_To_QA;
	
	export All := 
	sequential(
		
		 build_bases		
		,build_roxie_keys
		,promote2QA
		
	) : success(Send_Email.Roxie.QA), failure(Send_Email.BuildFailure);

end;