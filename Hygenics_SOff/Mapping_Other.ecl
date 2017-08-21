
ds_other := hygenics_soff.file_in_so_other;

	other_layout := record
		string recordid;
		string statecode;
		string intnet_email_address_1;
	end;
	
	other_layout slimRec(ds_other l):= transform
		self.intnet_email_address_1 := l.emailaddress;
		self 						:= l;
	end;

other_file := project(ds_other, slimRec(left));

export Mapping_Other := other_file;