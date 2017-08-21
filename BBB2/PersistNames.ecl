import tools;
export PersistNames := 
module

//naming convention:  <cluster>::persist::<module>::<attribute>
	shared persistroot		:= thor_cluster + 'persist::' + dataset_name;


	export BDIDMember		  := persistroot + '::BDID_Member';
	export CleanMember		:= persistroot + '::Clean_Member';
	export BDIDNonMember	:= persistroot + '::BDID_Non_Member';
	export CleanNonMember	:= persistroot + '::Clean_Non_Member';
	export AsBusHeader		:= persistroot + '::BBB_As_Business_Header';
	export AsBusLinking		:= persistroot + '::BBB_As_Business_Linking';
	
	export dAll_persistnames := 
	DATASET([
	
		  (BDIDMember)
		 ,(CleanMember)
		 ,(BDIDNonMember)
		 ,(CleanNonMember)
		 ,(AsBusHeader)
		 ,(AsBusLinking)
	
	], tools.Layout_Names);

end;