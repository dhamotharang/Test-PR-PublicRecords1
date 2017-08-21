
export Proc_Promote_Input(string version) :=  parallel(

sequential( // accident
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::accident',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::accident',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::accident'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::accident');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::accident');),																		 
		
sequential( // accidentabstract
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::accidentabstract',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::accidentabstract',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::accidentabstract'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::accidentabstract');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::accidentabstract');),																		 
		
sequential( // accidentinjury
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::accidentinjury',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::accidentinjury',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::accidentinjury'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::accidentinjury');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::accidentinjury');),																		 

sequential( // gendutystd
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::gendutystd',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::gendutystd',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::gendutystd'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::gendutystd');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::gendutystd');),																		 

					
sequential( // inspection
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::inspection',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::inspection',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::inspection'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::inspection');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::inspection');),																		 
					
sequential( // optionalinfo
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::optionalinfo',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::optionalinfo',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::optionalinfo'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::optionalinfo');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::optionalinfo');),																		 
					
sequential( // relatedactivity
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::relatedactivity',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::relatedactivity',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::relatedactivity'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::relatedactivity');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::relatedactivity');),																		 
					
sequential( // strategiccodes
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::strategiccodes',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::strategiccodes',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::strategiccodes'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::strategiccodes');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::strategiccodes');),																		 
					
sequential( // violation
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::violation',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::violation',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::violation'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::violation');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::violation');),																		 
					
sequential( // violationevent
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::delete::violationevent',true);             
 FileServices.PromoteSuperFileList([OSHAIR.cluster + 'in::OSHAIR::used::violationevent',
  															    OSHAIR.cluster + 'in::OSHAIR::delete::violationevent'],
																		OSHAIR.cluster + 'in::oshair::' + version + '::violationevent');
 FileServices.ClearSuperFile(OSHAIR.cluster + 'in::OSHAIR::sprayed::violationevent');)																		 
	
);