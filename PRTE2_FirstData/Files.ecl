import prte2_dlv2, std;

EXPORT Files := module

	export input_file := prte2_dlv2.Files.dl2_base(length(trim(dl_number)) > 1);

//Pulling records from PRTE2_DLV2 base file to create FirstData dataset	
	layouts.base		xform_data(input_file L) := transform
	self.PROCESS_DATE								:= (string)STD.Date.Today();
	self.FILEDATE										:= ' ';
	self.RECORD_TYPE								:= 'D';
  self.ACTION_CODE								:= 'I';
	v_dl_seq := (string)L.dl_seq;
  self.CONS_ID										:= if(length(trim(v_dl_seq)) = 9,v_dl_seq, (string)intformat(l.dl_seq,9,1)); 
  self.DL_STATE										:= L.orig_state;
  self.DL_ID											:= L.dl_number;
  self.FIRST_SEEN_DATE_TRUE				:= (string)L.dt_first_seen + '01';
  self.LAST_SEEN_DATE							:= (string)STD.Date.Today();
  self.DISPUTE_STATUS							:= '';
  self.LEX_ID											:= (string)L.did;
	END;
	
	export base 						:= project(input_file, xform_data(left));
	
	export drvrlicense			:= project(base(lex_id <> ''), transform(prte2_firstdata.Layouts.key_license, 
																																	self.lex_id := (unsigned6)left.lex_id; 
																																	self.date_first_seen := left.first_seen_date_true;
																																	self.date_last_seen  := left.last_seen_date;
																																	self := left)); 
	
	export keyfile_did 			:= project(base(lex_id <> ''), transform(prte2_firstdata.Layouts.key_did, 
																																		self.lex_id := (unsigned6)left.lex_id; 
																																		self.date_first_seen := left.first_seen_date_true;
																																		self.date_last_seen  := left.last_seen_date;
																																		self := left)); 
	
end;