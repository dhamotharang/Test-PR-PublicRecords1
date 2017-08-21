import Crim_Common, CRIM, Address, lib_stringlib;

ds_def := crim.File_OH_Summit_CuyahogaFalls.defendant(def_id<>'DefendantID');

d := distribute(ds_def, hash32(def_id));

Crim_Common.Layout_In_Court_Offender tOHOffend(d input) := Transform
	clean_def_name				      := stringlib.stringfilter(stringlib.stringtouppercase(input.def_name),'ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	self.process_date			      := Crim_Common.Version_Development;
	self.offender_key			      := Function_Offender_Key_Generator('4C',trim(input.case_num),trim(stringlib.stringfindreplace(input.file_dt,'/','')));
	self.vendor 				        := '4C';
	self.state_origin 		      := 'OH';
	self.data_type				      := '2';
	self.source_file			      := '(CP)OHSUMMITCUYAHOGA';
	self.case_number			      := input.case_num;
	self.case_court				      := input.jurisdiction;
	self.case_name				      := '';
	self.case_type				      := input.case_num[5];
	self.case_type_desc			    := '';
	self.case_filing_dt			    := if(Function_ParseDate(input.file_dt,'MM/DD/YYYY')[1..2] between '19' and '20',
								                    Function_ParseDate(input.file_dt,'MM/DD/YYYY'),'' );
	self.pty_nm					        := trim(input.def_name, right, left);
	self.pty_nm_fmt				      := 'L';
	self.orig_lname				      := '';
	self.orig_fname				      := '';    
	self.orig_mname				      := '';
	self.orig_name_suffix		    := '';
	self.pty_typ				        := '0';
	self.nitro_flag				      := '';
	self.orig_ssn				        := '';
	self.dle_num				        := '';
	self.fbi_num				        := '';
	self.doc_num				        := '';
	self.ins_num				        := '';
	self.id_num					        := '';
	self.dl_num					        := input.license_num;
	self.dl_state				        := input.LIC_ST_CD;
	self.citizenship			      := '';
	self.dob					          := if(Function_ParseDate(input.dob,'MM/DD/YYYY')[1..8] >= '19000101' and 
	                                 ((integer)stringlib.GetDateYYYYMMDD()[1..4])-((integer)Function_ParseDate(input.dob,'MM/DD/YYYY')[1..4])>=18,
									                  Function_ParseDate(input.dob,'MM/DD/YYYY'),'');
	self.dob_alias				      := '';
	self.place_of_birth			    := '';
	self.street_address_1		    := if(regexfind('C/O', input.street), '',      
								                 if(regexfind('[0-9]', input.city), input.city, trim(regexreplace('UNKNOWN|'+'LKA|'+'[-|\\*|"|.\\\\]',input.street, ''), left, right)));
	self.street_address_2		    := '';
	self.street_address_3		    := if(regexfind('C/O', input.street) or regexfind('[0-9]', input.city), '',trim(regexreplace('\\?', stringlib.stringtouppercase(input.city), ''),left,right));
	self.street_address_4		    := if (regexfind('C/O', input.street), '',
								                 if(length(input.state)>2 and regexfind('[A-Za-z]', input.state) or length(input.state) = 2 and stringlib.stringtouppercase(input.state) 
								                 in ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN','TX','UT','VT','VI','VA','WA','WV','WI','WY','AE','AA','AE','AE','AE','AP'], stringlib.stringtouppercase(trim(input.state,left,right)),''));
	self.street_address_5		    := if (regexfind('C/O', input.street), '',
								                 if((length(trim(input.zip,left,right)) = 5 or length(trim(input.zip,left,right)) = 9) and
									               regexfind('[1-9]', input.zip), trim(regexreplace('[\\*|"|.\\\\]', input.zip,''),left,right),''));
	self.race					          := '';
	self.race_desc				      := '';
	self.sex					          := '';
	self.hair_color				      := '';
	self.hair_color_desc		    := '';
	self.eye_color				      := '';
	self.eye_color_desc			    := '';
	self.skin_color				      := '';
	self.skin_color_desc		    := '';
	self.height					        := '';
	self.weight					        := '';
	self.party_status			      := '';
	self.party_status_desc		  := '';
	self.prim_range 			      := ''; 
	self.predir 				        := '';					   
	self.prim_name 				      := '';
	self.addr_suffix 			      := '';
	self.postdir 				        := '';
	self.unit_desig 			      := '';
	self.sec_range 				      := '';
	self.p_city_name 			      := '';
	self.v_city_name 			      := '';
	self.state 					        := '';
	self.zip5 					        := '';
	self.zip4 					        := '';
	self.cart 					        := '';
	self.cr_sort_sz 			      := '';
	self.lot 					          := '';
	self.lot_order 				      := '';
	self.dpbc 					        := '';
	self.chk_digit 				      := '';
	self.rec_type 				      := '';
	self.ace_fips_st			      := '';
	self.ace_fips_county		    := '';
	self.geo_lat 				        := '';
	self.geo_long 				      := '';
	self.msa 					          := '';
	self.geo_blk 				        := '';
	self.geo_match 				      := '';
	self.err_stat 				      := '';
	self.title 					        := '';
	self.fname 					        := '';
	self.mname 					        := '';
	self.lname 					        := '';
	self.name_suffix 			      := '';
	self.cleaning_score 		    := ''; 

end;

pOHOffend := project(d, tOHOffend(left));

Crim.Crim_clean(pOHOffend,cleanOHOffend);

fOHOffend := dedup(sort(distribute(cleanOHOffend,hash(offender_key)),
				offender_key,case_court,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local),
					offender_key,pty_nm,pty_nm_fmt,pty_typ,dob,street_address_1,local,left)
					: PERSIST('~thor_dell400::persist::Crim_OH_Summit_CuyahogaFalls_Offender');

export Map_OH_Summit_Cty_CuyahogaFalls_City_Offender := fOHOffend;