//prep the three base files and merge them into 1.
//project aircraft into common layout

layout_common_aircraft_airman_cert tPreProcess(faa.searchFile_bid l) :=
	transform
	 	self.source_type:='AR';
		self.street1:=l.street;
		self.orig_fname:='';
		self.orig_lname:=''; 
		self.orig_rec_type:='';
		self.record_type:='';
		self.letter_code:='';
		self.med_class:='';
		self.med_date:='';
		self.med_exp_date:='';
		self.unique_id:='';
		self.letter:='';
		self.cer_type:='';
		self.cer_type_mapped:='';
		self.cer_level:='';
		self.cer_level_mapped:='';
		self.cer_exp_date:='';
		self.ratings:='';
		self.suffix:='';
		self.county_name:='';
		self.zip4:='';
		self.did_out:=(UNSIGNED8)l.did_out;
		self.bdid_out:=(UNSIGNED8)l.bdid_out;
		self.aircraft_id := l.aircraft_id;
		self:=l;
	end;
aircraft_ds := project(faa.searchFile_bid, tPreProcess(left));



 //project airman into common layout
 
layout_common_aircraft_airman_cert tPreProcess1(faa.file_airmen_data_bldg l) :=
	transform
		self.source_type:='AM';
		self.did_out:=(UNSIGNED8)l.did_out;
		self.bdid_out:=0;
		self.name:='';
		self.n_number:='';
		self.serial_number:='';
		self.mfr_mdl_code:='';
		self.eng_mfr_mdl:='';
		self.year_mfr:='';
		self.type_registrant:='';
		self.last_action_date:='';
		self.cert_issue_date:='';
		self.certification:='';
		self.type_aircraft:='';
		self.type_engine:='';
		self.status_code:='';
		self.mode_s_code:='';
		self.fract_owner:='';
		self.aircraft_mfr_name:='';
		self.model_name:='';
		self.compname:='';
		self.letter:='';
		self.cer_type:='';
		self.cer_type_mapped:='';
		self.cer_level:='';
		self.cer_level_mapped:='';
		self.cer_exp_date:='';
		self.ratings:='';				
		self.orig_county:='';
		self.aircraft_id := 0;
		self:=l;
	end;
	
airmen_ds := project(faa.file_airmen_data_bldg, tPreProcess1(left));


concat := aircraft_ds + airmen_ds;

export file_faa_autokey_bid:=concat;