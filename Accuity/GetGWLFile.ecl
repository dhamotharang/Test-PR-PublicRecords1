IMPORT Worldcheck_Bridger, Std;
EXPORT GetGWLFile := FUNCTION

	input := DISTRIBUTE(Accuity.Reformat.outputs.GWL, (integer)id);

	entity1		:=	dataset('~thor_data400::in::accuity::gwl::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
	acc := entity1(type not in ['1','2']);

	crit := DISTRIBUTE(Accuity.GetSourceCriteria(acc), id);

	withCrit := JOIN(input, crit, (integer)left.id=right.id, 
							TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
								self.search_criteria := (string)right.criteria;
								words := Std.Str.WordCount(left.accuitydatasource);
								code := (integer)Std.Str.GetNthWord(left.accuitydatasource, words);
								self.comments := 'Source: ' + TRIM($.dictSources[code].source_name) + 
																		IF(TRIM(left.comments)='', '',
																		' | ' + TRIM(left.comments));
								self := left;), left outer, local);

	return withCrit;


END;