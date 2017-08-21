import Crim_Common;

export Version
 :=
  module

	export	Development		:=	Crim_Common.Version_Development;
	export	Production		:=	Crim_Common.Version_Production;

	export	CrimOffender	:=	Crim_Common.Version_Development;
	export	Court_Offenses:=	CrimOffender;

	export	DOC_Offenses	:=	CrimOffender;
	export	DOC_Punishment:=	DOC_Offenses;

	export	SexPred				:=	'20130412a';

  end
 ;
 



