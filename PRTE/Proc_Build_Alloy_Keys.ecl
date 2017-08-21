//Build prte key(s) for Alloy Student List
IMPORT AlloyMedia_student_list;

EXPORT Proc_Build_Alloy_Keys(STRING version) := FUNCTION

arecord_alloymedia:= RECORD
  unsigned8 did;
	AlloyMedia_student_list.layouts.Layout_base AND NOT DID;
  unsigned8 __internal_fpos__;
 END;
 prte_alloymedia:=buildindex(index(dataset([],arecord_alloymedia),{did},{dataset([],arecord_alloymedia)},'keyname'),
	 													 '~prte::key::alloymedia_student_list::'+version+'::did',update);
 prte_fcra_alloymedia:=buildindex(index(dataset([],arecord_alloymedia),{did},{dataset([],arecord_alloymedia)},'keyname'),
	 													 '~prte::key::fcra::alloymedia_student_list::'+version+'::did',update);

 RETURN PARALLEL(prte_alloymedia,prte_fcra_alloymedia);

END;