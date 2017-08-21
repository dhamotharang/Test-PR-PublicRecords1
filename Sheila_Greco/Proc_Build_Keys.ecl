import doxie, Tools;
export Proc_Build_Keys(

	 string													pversion

) :=
module

  knames := keynames(pversion);
		
	export BuildLinkids 					:= tools.macf_WriteIndex('Sheila_Greco.Key_LinkIds.key ,knames.linkids.logical');
	
  export full_build :=
	sequential(
		 parallel(
			  BuildLinkids 											
		 )
		,Promote(pversion).buildfiles.New2Built
	);
		
	export All :=
	if(tools.fun_IsValidVersion(pversion)
		,full_build
		,output('No Valid version parameter passed, skipping Sheila_Greco.Proc_Build_Keys atribute')
	);
end;
