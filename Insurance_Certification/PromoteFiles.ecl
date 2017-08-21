import lib_fileservices,_control,lib_stringlib,versioncontrol;

export PromoteFiles(string pversion = '') := module

  /* Sprayed to Using */	
	export fPromote_Sprayed2Using :=	function
		promote_sprayed2using := 	sequential( Promote(,'certification').Input.sprayed2using
																	       ,Promote(,'policy').Input.sprayed2using );
		return promote_sprayed2using;
	end;  
	
  /*Using to Used */	
	export fPromote_Using2Used :=	function
		promote_using2used := 	sequential( Promote(,'certification').Input.Using2Used
																	     ,Promote(,'policy').Input.Using2Used );
		return promote_using2used;
	end; 

  /* New to Built */	
	export fPromote_New2Built :=	function
		promote_new2built := 	sequential( Promote(pversion,'certification').New2Built
																	   ,Promote(pversion,'policy').New2Built );
		return promote_new2built;
	end;  
	
	/* Built to QA */
	export fPromote_Built2QA :=	function
		promote_built2qa := 	sequential( Promote(pversion,'certification').Built2QA
																	   ,Promote(pversion,'policy').Built2QA );
		return promote_built2qa;
	end;   
	
end;  