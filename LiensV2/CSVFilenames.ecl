export CSVFilenames(integer cnt = 0) :=
module
	//////////////////////////////////////////////////////////////////
	// -- Declaration of Value Types
	//////////////////////////////////////////////////////////////////
	
	
	export DisJmtsupdate	:= '~thor_data400::in::liensv2::cgl::DisJmts' ;
	export FSTLienupdate	:= '~thor_data400::in::liensv2::cgl::FSTLien' ;
	export FSTrlesupdate	:= '~thor_data400::in::liensv2::cgl::FSTrles' ;
	export SatJmtsupdate	:= '~thor_data400::in::liensv2::cgl::SatJmts' ;
	export SubJmtsupdate	:= '~thor_data400::in::liensv2::cgl::SubJmts' ;
  export VacJmtsupdate	:= '~thor_data400::in::liensv2::cgl::VacJmts' ;
	export judgmtsupdate	:= '~thor_data400::in::liensv2::cgl::judgmts' ;
	export MAChildSupport	:= '~thor_data400::in::liensv2::ma::childsupportlien';
	export MAWelfLien	  	:= '~thor_data400::in::liensv2::ma::welflien';
	export MAWrit	      	:= '~thor_data400::in::liensv2::ma::writs';
	export MAWritName   	:= '~thor_data400::in::liensv2::ma::writsname';
	
	
	shared layout_superfiles := 
	record
		string superfile;
	end;

/*	export input_superfiles := DATASET([(federalupdate),
	                                    (ServAbsupdate),
										(BusDtorupdate),
										(BusSecpupdate),
										(okclienupdate),
										(filingsupdate),
										(PerDtorupdate),
										(PerSecpupdate),
										(chgfilgupdate),
										(judgmtsupdate)] , layout_superfiles);
*/

end;


