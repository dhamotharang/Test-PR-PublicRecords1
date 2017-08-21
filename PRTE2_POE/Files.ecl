Import POE,mdr,Prte2;
EXPORT files := module

EXPORT POE_IN := DATASET(constants.In_POE, Layouts.POE_Base, CSV(HEADING(1), SEPARATOR('\t'), TERMINATOR(['\n','\r\n']), QUOTE('"')));
EXPORT POE_base := DATASET(constants.Base_POE, Layouts.Base, FLAT );
	 
shared dkeybuild		:= project(POE_Base, transform(layouts.keybuild, self.subject_ssn := if(mdr.sourceTools.sourceIsUtility(left.source), 0, left.subject_ssn),self := left));

shared POE_append := POE.Append_Supp(dkeybuild);
Export DS_Did:=POE_append(Did>0);

Export ds_source_hierarchy:=Poe.File_Source_Hierarchy;

END;