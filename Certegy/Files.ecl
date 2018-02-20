import data_services;

export Files := module
	export certegy_in	:=dataset(data_services.foreign_prod+'thor_data400::in::certegy::dl',Certegy.layouts.certegy_DL_monthly,flat);
	export cplicense_in	:=dataset(data_services.foreign_prod+'thor_data400::in::choicepoint::license',Certegy.layouts.cp_DL_in,csv(separator('|'),maxlength(8192)));
	export certegy_base	:=dataset(data_services.foreign_prod+'thor_data400::base::certegy',Certegy.layouts.base,flat);
end;