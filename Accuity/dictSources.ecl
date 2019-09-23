entity1		:=	dataset('~thor_data400::in::accuity::gwl::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
acc := entity1(type not in ['1','2']);
EXPORT dictSources := DICTIONARY($.dsSources(acc), {code => source_name});