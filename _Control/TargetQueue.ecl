export TargetQueue
 :=
  module
	export	string				Thor400_92				:=	'thor400_92';				// Currently 32-bit only
	export	string				Thor_200				:=	'thor400_30';	// Deprecating 200 hence switching the value to 400_30
	export	string				Thor_Dell400_2			:=	'thor_dell400_2';		// Replaced by Thor400_84 on 2008.04.07
	export	string				Thor400_84				:=	'thor400_84';			// New, as of 2008.04.07, replacing thor_dell400_2
	export	string				Thor400_20				:=	'thor400_20';

	export	string				Production_Watch_Thor	:=	'production_watch_thor';
	export	string				HThor					:=	'hthor';

	export	set of string		All_400			  :=	[Thor400_92,Thor400_84];
	export	string        ADL_2_400       :=	Thor400_20;   /*Gong Base File Build*/
	export	string				ADL_400					:=	Thor400_20;   /*Gong History Key Build job*/
  export	string				BDL_400					:=	Thor400_20;   /*Gong Weekly Key Build job*/

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
