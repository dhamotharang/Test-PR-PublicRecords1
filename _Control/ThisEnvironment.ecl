/*
	Note:  	This repository entry is intended to be checked-in in each environment's
			repository but not migrated.  While they should remain in sync across
			environments with regards to the actual exported attributes contained
			herein, the values are should remain specific to that environment.
*/
import lib_thorlib;
export ThisEnvironment
 :=
  module
	// export	string	Name			:=	'QA_Roxie';
	export	string	Name			:=	'Prod_Thor';
	export	string	ESP_IPAddress	:=	_Control.IPAddress.Dataland_ESP;
	export	string	Dali_IPAddress	:=	lib_thorlib.thorlib.daliservers();	//_Control.IPAddress.Dataland_Dali;
	export	string	Thor_Version	:=	'648_01';
	export	string	RoxieEnv		:=	thorlib.getenv('Environment','');
	export	boolean	IsPlatformThor		:= false;
  end
 ;