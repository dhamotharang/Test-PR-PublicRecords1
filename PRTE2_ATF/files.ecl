IMPORT PRTE2_ATF, ATF, PRTE_CSV, MDR;

EXPORT files := MODULE

	//need to change once Data Insight creates new combined CSV file
	EXPORT ATF_Firearms_in		:= 	DATASET(PRTE2_ATF.Constants.IN_ATF,PRTE2_ATF.layouts.lAtf_Firearms_in,
																		CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));																									
//Base output files
	EXPORT Base_out	:= DATASET(PRTE2_ATF.Constants.BASE_ATF, PRTE2_ATF.Layouts.base_ext,flat);
	
//Slim layout, no BIP
	EXPORT SearchFile := project(Base_out, TRANSFORM(PRTE2_ATF.Layouts.SearchFile and not [persistent_record_id, lf], self.ATF_id := left.persistent_record_id, self.did := (UNSIGNED6)left.did_out, self	:= left));

//Temp Autokey file
	PRTE2_ATF.Layouts.tempAutokey xform(SearchFile l) := TRANSFORM
		self.did_out6 := (unsigned6) l.did_out;
		self.ATF_id := l.ATF_id;
		self.bdid6 := (unsigned6) L.bdid;
		self := l;
	END;
	
	EXPORT ATF_firearms_autokey := project(SearchFile, xform(left));

	EXPORT ATF_header := project(Base_out, layouts.Base);

END;