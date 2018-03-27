//*******************************************************************************************
//  I think this will have to be a second file to go with the proc_build_huntingfishing_keys
//*******************************************************************************************
import ut, emerges;
	  

Layout_Searchfile := RECORD
	unsigned6 rid;
	emerges.layout_hunters_out;
END;

EXPORT file_huntfish_SearchAutokey(DATASET(Layout_Searchfile) indataset) := FUNCTION

			dist_dataset := distribute(indataset,hash(rid));

			Autokey_layout:= emerges.Layout.hunt_fish_out;

			// First normalize for residence & mailing address
			Autokey_layout_w_extra_city_field:=record
				Autokey_layout;
				string25 p_city_name;
			end;

			Autokey_layout_w_extra_city_field get_addrs(dist_dataset l,unsigned1 C):=transform
				self.prim_range  := if(C=1,l.prim_range,l.mail_prim_range);
				self.predir      := if(C=1,l.predir,l.mail_predir);
				self.prim_name   := if(C=1,l.prim_name,l.mail_prim_name);
				self.suffix      := if(C=1,l.suffix,l.mail_addr_suffix);
				self.postdir     := if(C=1,l.postdir,l.mail_postdir);
				self.unit_desig  := if(C=1,l.unit_desig,l.mail_unit_desig);
				self.sec_range   := if(C=1,l.sec_range,l.mail_sec_range);
				self.p_city_name := if(C=1,l.p_city_name,l.mail_p_city_name);
				self.city_name   := if(C=1,l.city_name,l.mail_v_city_name);
				self.st          := if(C=1,l.st,l.mail_st);
				self.zip         := if(C=1,l.zip,l.mail_ace_zip);
				self.zip4        := if(C=1,l.zip4,l.mail_zip4);
				self.county      := if(C=1,l.county,l.mail_fipscounty);
				// On the second time when the mail address is being used, 
				// null out the ssn field so that duplicate autokey ssn records do not get created.
				self.best_ssn    := if(C=1,l.best_ssn,'');
				self.did         := (unsigned6)l.did_out;
				self:=l;
			end;

			// Normalize once for residence and mailing address (if present)
			norm_file_addrs := normalize(dist_dataset,if(left.mail_prim_name='',1,2),
																		get_addrs(left,counter));

			dedup_file_addrs := dedup(sort(norm_file_addrs,did,record),record);

			// Normalize again for p/v city name
			Autokey_layout get_cities(dedup_file_addrs l,unsigned1 C):=transform
				self.city_name := if(C=1,l.p_city_name,l.city_name);
				// On the second time when the city_name (aka v_city_name) is being used, 
				// null out the ssn field so that duplicate autokey ssn records do not get created.
				self.best_ssn  := if(C=1,l.best_ssn,'');
				self:= l;
			end;

			norm_file_cities := normalize(dedup_file_addrs,if(left.p_city_name=left.city_name or 
																												left.city_name='',1,2),
																		get_cities(left,counter));

			dedup_file_cities := dedup(sort(norm_file_cities,did,record),record); 

			// Normalize a third time for homestate (residence address state) not = 
			// source_state (license state)
			Autokey_layout state_xform(dedup_file_cities l,unsigned1 C):=transform
				self.prim_range  := if(C=1,l.prim_range,'');
				self.predir      := if(C=1,l.predir,'');
				self.prim_name   := if(C=1,l.prim_name,'');
				self.suffix      := if(C=1,l.suffix,'');
				self.postdir     := if(C=1,l.postdir,'');
				self.unit_desig  := if(C=1,l.unit_desig,'');
				self.sec_range   := if(C=1,l.sec_range,'');
				self.city_name   := if(C=1,l.city_name,'');
				self.st          := if(C=1,l.st,l.source_state);
				self.zip         := if(C=1,l.zip,'');
				self.zip4        := if(C=1,l.zip4,'');
				self.county      := if(C=1,l.county,'');
				// On the second time when source_state (aka license_state) is being used, 
				// null out the ssn field so that duplicate autokey ssn records do not get created.
				self.best_ssn   := if(C=1,l.best_ssn,'');
				self:= l;
			end;

			norm_file_states := normalize(dedup_file_cities,if(left.homestate=left.source_state or
																												 left.source_state='',1,2),
																		state_xform(left,counter));

			dedup_file_states := dedup(sort(norm_file_states,did,record),record); 

			RETURN dedup_file_states;

END;
