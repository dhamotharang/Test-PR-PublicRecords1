export TargetGroup
 :=
  module
	export	string				Thor_Dell400			:=	'thor_dell400';			// Currently 32-bit only
	export	string				Thor_200				:=	'thor_200';				// Currently 32-bit only, 64-bit capable
	export	string				Thor_Dell400_2			:=	'thor_dell400_2';		// Replaced by Thor400_84 on 2008.04.07
	export	string				Thor400_84				:=	'thor400_84';			// New, as of 2008.04.07, replacing thor_dell400_2

	export	string				Production_Watch_Thor	:=	'production_watch_thor';
	export	string				HThor					:=	'eclagent';

	export	set of string		All_400					:=	[Thor_Dell400,Thor400_84];
	export	string				ADL_400					:=	Thor400_84;
	export	string				BDL_400					:=	Thor_Dell400;

	// 32-bit clusters
	export	set of string		All_400_32bit			:=	All_400;
	export	string				ADL_400_32bit			:=	ADL_400;
	export	string				BDL_400_32bit			:=	BDL_400;

	// 64-bit clusters
	export	set of string		All_400_64bit			:=	All_400_32bit;
	export	string				ADL_400_64bit			:=	ADL_400_32bit;
	export	string				BDL_400_64bit			:=	BDL_400_32bit;
  end
 ;
