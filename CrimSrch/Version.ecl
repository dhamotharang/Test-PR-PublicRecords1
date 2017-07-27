import Crim_Common;

export Version
 :=
  module

	export	Development		:=	'20050825';
	export	Production		:=	'20050822';

	export	CrimOffender	:=	Crim_Common.Version_Production;
	export	Court_Offenses	:=	CrimOffender;

	export	DOC_Offenses	:=	CrimOffender;
	export	DOC_Punishment	:=	DOC_Offenses;

	export	SexPred			:=	'20050616_redid';

  end
 ;