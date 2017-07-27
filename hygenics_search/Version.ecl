import Crim_Common;

export Version
 :=
  module

	export	Development		:=	'20120305d';
	export	Production		:=	'20111104';

	export	CrimOffender	:=	Crim_Common.Version_Development;
	export	Court_Offenses	:=	CrimOffender;

	export	DOC_Offenses	:=	CrimOffender;
	export	DOC_Punishment	:=	DOC_Offenses;

	export	SexPred			:=	'20110909a';

  end
 ;