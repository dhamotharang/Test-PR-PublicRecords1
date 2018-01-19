/*
	Note:  	This repository entry is intended to be checked-in in each environment's
			repository but not migrated.  While they should remain in sync across
			environments with regards to the actual exported attributes contained
			herein, the values are should remain specific to that environment.
*/
import lib_thorlib;
import ^ as root;
export ThisEnvironment
 :=
  module
	// root.environment value comes from eclcc server config setup done by SC ops
	// -Denvironment='Prod_Thor'
	// https://jira.rsi.lexisnexis.com/browse/DOPS-460
	export	string	Name			:=	#IFDEFINED(root.environment, 'Prod_Thor');
	export	string	ESP_IPAddress	:=	_Control.IPAddress.Prod_thor_ESP;
	export	string	Dali_IPAddress	:=	lib_thorlib.thorlib.daliservers();	//_Control.IPAddress.Dataland_Dali;
	export	string	Thor_Version	:=	'648_08';
	export	string	RoxieEnv		:=	thorlib.getenv('Environment','');
	export	boolean	IsPlatformThor		:= true;
	export	string	ThisDaliIp		:= Dali_IPAddress[..length(trim(Dali_IPAddress))-5]:independent;
  end
 ;