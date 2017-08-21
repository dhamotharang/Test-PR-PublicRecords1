EXPORT files := module

EXPORT Experian_IN := DATASET(constants.In_Experian, Layouts.In_Layout, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), maxlength(1950),QUOTE('"')));

Export Prep := project(Experian_IN,
   Transform(Layouts.Base,
   Self:=Left;
   self := []; 
   ));
	 
EXPORT Base := DATASET(constants.Base_Experian, Layouts.Base, FLAT );

Export CRDB :=project(Base,Layouts.Experian_CRDB_Base);

END;