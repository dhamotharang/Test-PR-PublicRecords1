import Accuity;
EXPORT Files := MODULE

export	PEPentity	:=	dataset('~thor::in::accuity::pep::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	USPentity	:=	dataset('~thor::in::accuity::usp::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
	// due diligence
export	EULentity	:=	dataset('~thor::in::accuity::eul::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EUAentity	:=	dataset('~thor::in::accuity::eua::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EDCentity	:=	dataset('~thor::in::accuity::edc::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EDEentity	:=	dataset('~thor::in::accuity::ede::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EDAentity	:=	dataset('~thor::in::accuity::eda::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	ESAentity	:=	dataset('~thor::in::accuity::esa::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EDIentity	:=	dataset('~thor::in::accuity::edi::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));
export	EUKentity	:=	dataset('~thor::in::accuity::euk::entity', Accuity.Layouts.input.rEntity, XML('gwl/entities/entity'));


export	groups  :=	dataset('~thor::in::accuity::pep::group', Accuity.Layouts.input.rGroups, XML('xml/groups/group'));
export	PEPsrccode	:=	dataset('~thor::in::accuity::pep::srccode', Accuity.Layouts.input.rSrccode, XML('xml/source-code-maps/source-code-map'));
export	USPsrccode	:=	dataset('~thor::in::accuity::usp::srccode', Accuity.Layouts.input.rSrccode, XML('xml/source-code-maps/source-code-map'));


END;