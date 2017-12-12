import ut;
export PersistNames(

	boolean	pUseOtherEnvironment	= false

) := 
INLINE module

	shared persistroot		:= constants(pUseOtherEnvironment).persistTemplate;

	export AsBusinessContact		:= persistroot + 'YellowPages_As_Business_Contact';
	export AsBusinessHeader			:= persistroot + 'YellowPages_As_Business_Header'	;
	export YellowPagesBaseGong	:= persistroot + 'YellowPages_Base_Gong'					;
	export YellowPagesBaseYP		:= persistroot + 'YellowPages_Base_YP'						;
	export Cleaned_Input_AID		:= persistroot + 'CleanedInputAID'								;
	export FileKeybuild					:= persistroot + 'File_Keybuild'									;

	
	export dAll_persistnames := 
	DATASET([
		  (AsBusinessContact	)
		 ,(AsBusinessHeader		)
		 ,(YellowPagesBaseGong)
		 ,(YellowPagesBaseYP	)
		 ,(Cleaned_Input_AID	)
		 ,(FileKeybuild				)

	], ut.Layout_Names);

end;