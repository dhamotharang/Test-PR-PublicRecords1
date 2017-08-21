import ut,data_services;
export File_Iverification := module

export layout:= record
unsigned6 did; //DID derived from original DID or from spouse or household relationship
string10 phone;
unsigned6 orig_did; //Did from original record in Gong or Phonesplus
unsigned6 hhid;
unsigned1 file_source := 0; //1 Â– Gong, 2 - Phonesplus Above, 3 - Phonesplus Below
unsigned6 rec_type := 0; //Bit map: 1 Â– Individual, 2 Â– Spouse, 3 - Household
unsigned6 dt_first_seen := 0;
unsigned6 dt_last_seen := 0;
unsigned6 iver_indicator:= 0; // Bit map: 1 Â– Did-Phone match current irec,
															//          2 Â– Did-phone match historical irec 
															//          3 Â– Hhid-Phone match current irec 
															//          4 - Hhid-Phone match historical irec 
unsigned6 iver_dt_first_seen := 0; //Date first seen in irecord: YYYYMMDD date when there is a match to irecord and 0 when there is no match
unsigned6 iver_dt_last_seen := 0;  //Date last seen in irecord:
unsigned6 dt_first_ver := 0; //Date when the record was first processed for a match
unsigned6 dt_last_ver := 0;  //Date when the record was last processed for a match
boolean current_rec := false; //Indicates if the record is current or historical
end;

export name := data_services.data_location.Prefix('')+ 'thor_data400::base::iverification';

export Base:=  dataset(name, layout, thor);
end;