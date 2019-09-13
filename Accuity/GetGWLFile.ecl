IMPORT Worldcheck_Bridger;
EXPORT GetGWLFile := FUNCTION

	input := DISTRIBUTE(Accuity.Reformat.outputs.GWL, (integer)id);

	entity1		:=	dataset('~thor_data400::in::accuity::gwl::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
	acc := entity1(type not in ['1','2']);

	crit := DISTRIBUTE(Accuity.GetSourceCriteria(acc), id);

	withCrit := JOIN(input, crit, (integer)left.id=right.id, 
							TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
								self.search_criteria := (string)right.criteria;
								self := left;), left outer, local);

	return withCrit;


END;