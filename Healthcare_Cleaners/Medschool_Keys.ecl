import doxie, tools,healthcare_cleaners,mprd;
export Medschool_Keys(

	 string		pversion							= ''
	,boolean pUseProd = false

) :=
module

export medschool_Base				                := Medschool_Files(pversion,pUseProd).medschool_file;
export medschool_Base_msidk	                := medschool_Base(msid <>0);
export non_medschool_Base				              := Medschool_Files(pversion,pUseProd).non_medschool_file;
export non_medschool_Base_msidk	              := non_medschool_Base(msid <>0);
 
export medschool_wordlist_Base				        := Medschool_Files(pversion,pUseProd).medschool_wordlist_file;
export medschool_wordlist_Base_wordk	        := medschool_wordlist_Base(words<> '');
export non_medschool_wordlist_Base				    := Medschool_Files(pversion,pUseProd).non_medschool_wordlist_file;
export non_medschool_wordlist_Base_wordk	    := non_medschool_wordlist_Base(words<> '');

tools.mac_FilesIndex('medschool_Base		,{msid}	  ,{medschool_Base_msidk}'	,Medschool_KeyNames(pversion,pUseProd).medschool_msid_key			,medschool_msid_key);
tools.mac_FilesIndex('medschool_wordlist_Base		,{words}	  ,{medschool_wordlist_Base_wordk}'	,Medschool_KeyNames(pversion,pUseProd).medschool_wordlist_word_key,medschool_wordlist_word_key);
tools.mac_FilesIndex('non_medschool_Base		,{msid}	  ,{non_medschool_base_msidk}'	,Medschool_KeyNames(pversion,pUseProd).non_medschool_msid_key			,non_medschool_msid_key);
tools.mac_FilesIndex('non_medschool_wordlist_Base		,{words}	  ,{non_medschool_wordlist_Base_wordk}'	,Healthcare_Cleaners.Medschool_KeyNames(pversion,pUseProd).non_medschool_wordlist_word_key,non_medschool_wordlist_word_key);

end;

