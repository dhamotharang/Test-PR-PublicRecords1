export macBuild_State(

	 pState
	,pOutputDataset
) :=
macro
	//could add spray in here too
	//standardize, did, and output sprayed file
	#uniquename(clean_file)
	#uniquename(Append_Best_Data)

					%clean_file%				:= MartindaleHubble_Append.fStandardizeFiles(	MartindaleHubble_Append.Files('').input.pState.sprayed);
					%Append_Best_Data%	:= MartindaleHubble_Append.fAppendIDS(				%clean_file%																					);
	export	pOutputDataset			:= MartindaleHubble_Append.fTransform2Output(	%Append_Best_Data%																		); 
	
endmacro;