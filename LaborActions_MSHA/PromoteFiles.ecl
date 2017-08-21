import lib_fileservices,_control,lib_stringlib,versioncontrol;

export PromoteFiles(string pversion = '') := module

	export fPromote_Sprayed2Using :=	function

		promote_sprayed2using := 	sequential(
																	 Promote(,'accident').Input.sprayed2using
																	,Promote(,'contractor').Input.sprayed2using
																	,Promote(,'contractor_cy_employment').Input.sprayed2using
																	,Promote(,'contractor_qt_employment').Input.sprayed2using
																	,Promote(,'controller_hist').Input.sprayed2using
																	,Promote(,'inspection').Input.sprayed2using
																	,Promote(,'mine').Input.sprayed2using
																	,Promote(,'operator_cy_employment').Input.sprayed2using
																	,Promote(,'operator_hist').Input.sprayed2using
																	,Promote(,'operator_qt_employment').Input.sprayed2using
																	,Promote(,'violation').Input.sprayed2using
																);
		return promote_sprayed2using;
	end; //end fPromote_Sprayed2Using
	
	export fPromote_Using2Used :=	function

		promote_using2used := 	sequential(
																	 Promote(,'accident').Input.Using2Used
																	,Promote(,'contractor').Input.Using2Used
																	,Promote(,'contractor_cy_employment').Input.Using2Used
																	,Promote(,'contractor_qt_employment').Input.Using2Used
																	,Promote(,'controller_hist').Input.Using2Used
																	,Promote(,'inspection').Input.Using2Used
																	,Promote(,'mine').Input.Using2Used
																	,Promote(,'operator_cy_employment').Input.Using2Used
																	,Promote(,'operator_hist').Input.Using2Used
																	,Promote(,'operator_qt_employment').Input.Using2Used
																	,Promote(,'violation').Input.Using2Used
																);
		return promote_using2used;
	end; //end fPromote_Using2Used

	export fPromote_New2Built :=	function

		promote_new2built := 	sequential(
																	 Promote(pversion,'base_accident').New2Built
																	,Promote(pversion,'base_contractor').New2Built
																	,Promote(pversion,'base_events').New2Built
																	,Promote(pversion,'base_mine').New2Built
																	,Promote(pversion,'base_operator').New2Built
																);
		return promote_new2built;
	end; //end fPromote_New2Built

	export fPromote_Built2QA :=	function

		promote_built2qa := 	sequential(
																	 Promote(pversion,'base_accident').Built2QA
																	,Promote(pversion,'base_contractor').Built2QA
																	,Promote(pversion,'base_events').Built2QA
																	,Promote(pversion,'base_mine').Built2QA
																	,Promote(pversion,'base_operator').Built2QA
																);
		return promote_built2qa;
	end;  //end fPromote_Built2QA
	
end; //end PromoteFiles