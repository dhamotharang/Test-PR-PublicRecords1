import faa, ut, BIPV2;

f := faa.file_aircraft_registration_bldg; 

  Layout_Searchfile := RECORD
	  unsigned6 aircraft_id;
		faa.layout_aircraft_registration_out_slim;
		BIPV2.IDlayouts.l_xlink_ids;
	END;
	
ut.MAC_Sequence_Records_NewRec(f,Layout_Searchfile,aircraft_id,outf);

// persistent record id 

  Layout_Searchfile_out := RECORD
  unsigned6 aircraft_id;
	faa.layout_aircraft_registration_out_Persistent_ID;
	BIPV2.IDlayouts.l_xlink_ids;
	END;
	
outf_dedup:= dedup(sort(distribute(project(outf, transform(Layout_Searchfile_out, 
self.name:= trim(left.name,left,right),self.persistent_record_id := 0,self:= left)), 
						hash(n_number,serial_number, mfr_mdl_code, eng_mfr_mdl, year_mfr, type_registrant,name,
								street,street2,city,state,zip_code,region,orig_county,country,last_action_date,cert_issue_date,certification,
								type_aircraft,type_engine,status_code,mode_s_code,fract_owner,aircraft_mfr_name,model_name)),
								n_number,serial_number, mfr_mdl_code, eng_mfr_mdl, year_mfr, type_registrant,name,
								street,street2,city,state,zip_code,region,orig_county,country,last_action_date,cert_issue_date,certification,
								type_aircraft,type_engine,status_code,mode_s_code,fract_owner,aircraft_mfr_name,model_name,
								-date_last_seen,-UltWeight,-OrgWeight,-SELEWeight,-ProxWeight,-POWWeight,-EmpWeight,-DotWeight,local),
								except aircraft_id, date_first_seen, date_last_seen,lot,current_flag,UltID,OrgID,SELEID,ProxID,POWID,EmpID,DotID,
								UltWeight,OrgWeight,SELEWeight,ProxWeight,POWWeight,EmpWeight,DotWeight,UltScore,OrgScore,SELEScore,ProxScore,POWScore,EmpScore,DotScore,local); 
																								
out_pID := project( outf_dedup , transform(Layout_Searchfile_out, 
 self. persistent_record_id := hash64(trim(left.n_number,left,right)+
  trim(left.serial_number,left,right)+
  trim(left.mfr_mdl_code,left,right)+
  trim(left.eng_mfr_mdl,left,right)+
  trim(left.year_mfr,left,right)+
  trim(left.type_registrant,left,right)+
  trim(left.name,left,right)+
  trim(left.street,left,right)+
  trim(left.street2,left,right)+
  trim(left.city,left,right)+
 trim(left.state,left,right)+
 trim( left.zip_code,left,right)+
  trim(left.region,left,right)+
  trim(left.orig_county,left,right)+
  trim(left.country,left,right)+
  trim(left.last_action_date,left,right)+
  trim(left.cert_issue_date,left,right)+
  trim(left.certification,left,right)+
  trim(left.type_aircraft,left,right)+
  trim(left.type_engine,left,right)+
  trim(left.status_code,left,right)+
  trim(left.mode_s_code,left,right)+
  trim(left.fract_owner,left,right)+
  trim(left.aircraft_mfr_name,left,right)+
  trim(left.model_name,left,right)); 
	
	self := left)); 
	
export searchfile_Linkids := out_pID;