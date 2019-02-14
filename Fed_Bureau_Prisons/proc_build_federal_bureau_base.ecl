//
import STD, nid;

EXPORT proc_build_federal_bureau_base (string version):= function

  dedup_def := dedup(sort(file_in_defendant_federal_raw,record),record);
	dedup_off := dedup(sort(file_in_offense_federal_raw,record),record);
	dedup_sent := dedup(sort(file_in_sentence_federal_raw,record),record); 

  join_def_off := join(dedup_def,dedup_off,
                       left.recordid = right.recordid, left outer);
						
  join_def_off_sent := join(join_def_off,dedup_sent,
                      left.recordid = right.recordid, left outer);									

  layout_federal_bureau_base   tr_offender_key(join_def_off_sent l) := TRANSFORM
	
	name := STD.Str.FindReplace(l.name, '\\U0027', '\'' );
	lastName := STD.Str.FindReplace(l.lastname, '\\U0027', '\'' );
	firstName := STD.Str.FindReplace(l.firstname, '\\U0027', '\'' );
	middleName := STD.Str.FindReplace(l.middlename, '\\U0027', '\'' );
	suffix := STD.Str.FindReplace(l.suffix, '\\U0027', '\'' ); 	
	
	src := 'XX'; // mdr.sourceTools.src_fed
		
  offender_key := (String)hash64(name + l.InmateNumber);  //Do not include DOB, gender and race in off key. 
	                                                        //Since if in future fill rates increase in these three fields, 
																													//then same person will have more than one off key. 
																													//We try to avoid this.
  
  persistent_record_id := src + (String)hash64(name + l.InmateNumber + l.Gender + l.race 
	                                                 + l.OffenseDesc + l.disposition); 	//Used same fields in upsert logic. Need to keep OffenseDesc 
																									                                    //as part of upsert logic. If not then in future multiple offenses 
																																											//can overlay and result will be one offense.

	self.offender_key := offender_key;
	self.persistent_record_id := persistent_record_id;
	self.src := src;
	self.process_date := (String8)Std.Date.Today();
	self.date_first_seen := '0';  //Blank dates are acceptable since raw data does not 
  self.date_last_seen := '0';   //present any supporting evidence of first and last seen dates
  self.date_vendor_first_reported := version;                       
  self.date_vendor_last_reported := version;
	self.Record_Upload_Date := l.RecordUploadDate;
	self.category := l.RecordType;
	self.source := l.SourceName;
	self.orig_name := name;
	self.orig_lastName := lastname;
	self.orig_firstName := firstname;
	self.orig_middleName := middlename;
	self.orig_suffix := suffix; 
	self.DOB := l.DOB;
	self.sex := l.Gender;
	self.race := l.Race;
	self.age := l.age;	
	self.Registery_Number := l.InmateNumber;  
	self.Defendant_Status := l.DefendantStatus;	
	self.offense_description := l.OffenseDesc; 
	self.disposition := l.disposition;
	self.Scheduled_Release_Date := l.ScheduledReleaseDate;
	self := [];
	end;

 
	//set up ingest file attibutes
  todays_processed_file := dedup(sort(project(join_def_off_sent,tr_offender_key(left)),record),record); 	
	current_base := file_federal_bureau_base;
	
	//Ingest todays_processed_file into current_base to get new_base
	base_with_tag := Fed_Bureau_Prisons.Ingest(false,,current_base,todays_processed_file);
	
	new_base :=  base_with_tag.AllRecords;	
	
  add_rec_type	:= Project(new_base, TRANSFORM(Fed_Bureau_Prisons.layout_federal_bureau_base, 
																										      self.rec_type := left.__Tpe;
																													self.history_flag := if(left.__Tpe=Ingest().RecordType.Old,'H','');
																													self := left;
																													self:= [];));	

  // clean names
  nid.mac_cleanfullnames(add_rec_type, cleanfullnames, orig_name, useV2:=true); 
 
  layout_federal_bureau_base   tr_map_clean_names(cleanfullnames l) := TRANSFORM	
  self.nametype := l.nametype;
	self.nid := l.nid; 
	self.title := l.cln_title;
	self.fname := l.cln_fname;
	self.mname := l.cln_mname;
	self.lname := l.cln_lname;
	self.suffix := l.cln_suffix;
	self.name_ind := l.name_ind;
	self := l;
	end; 
	
	map_clean_names := project(cleanfullnames,tr_map_clean_names(left));

	//Need to output new base before base_with_tag.Dostats can be called.
  build_base := output(map_clean_names,,'~thor_data400::base::federal_bureau_of_prisons_'+version+'_'+thorlib.wuid(), __compressed__); 

  return sequential(build_base,
	                  base_with_tag.Dostats										
				           );		
									 
end;
 
 

	

				
		 												 