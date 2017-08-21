import Crim_Common;

export Version
 :=
  module

	export	Development		:=	'20130305';
	export	Production		:=	'20130201a';

	export	CrimOffender	:=	Crim_Common.Version_Development;
	export	Court_Offenses	:=	CrimOffender;

	export	DOC_Offenses	:=	CrimOffender;
	export	DOC_Punishment	:=	DOC_Offenses;

	export	SexPred			:=	'20130208';

  end
 ;