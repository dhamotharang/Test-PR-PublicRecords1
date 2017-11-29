/*
	Note:  	This repository entry is intended to be sandboxed by each user
			to allow each user to have values specific to that user.
*/
export MyInfo
 :=
  module
	export	string	UserID				:=	'p_svc_person_header';
	export	string	Password			:=	'p@ssword';
  export  string  UserID_prod   :=  'p_svc_person_header';
  export  string  Password_prod :=  '';
	export	string	Name				:=	'p_svc_person_header';
	export	string	EmailAddressNormal	:=	'gabriel.marcan@lexisnexisrisk.com';
	export	string	EmailAddressNotify	:=	'gabriel.marcan@lexisnexisrisk.com';
  end
 ;
