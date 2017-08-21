
ds_charge := hygenics_soff.file_in_so_charge;

	charge_layout := record
		string recordid;
		string statecode;
		string police_agency;
	end;
	
	charge_layout slimRec(ds_charge l):= transform
		self.police_agency 	:= l.ArrestingAgency;
		self 				:= l;
	end;

charge_file := project(ds_charge, slimRec(left)):persist('~thor_200::persist::soff_charge');;

export Mapping_Charge := charge_file;