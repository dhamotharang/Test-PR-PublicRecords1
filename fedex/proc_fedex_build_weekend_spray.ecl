#workunit('name', 'FEDEX-NOHIT Spray-Only');

import _control;

export	proc_fedex_build_weekend_spray(string	version_date) :=
function	
	spray_file	:=	fedex.Spray_Prep_Fedex(version_date);
										
	return sequential(spray_file);
end;