IMPORT SANCTN, Address, lib_stringlib,ut, Prof_License_Mari, std;

export clean_incident(string filedate) := function

// Get the two datasets
SANCTN_incident      := SANCTN.file_in_incident;
SANCTN_incident_text := SANCTN.file_in_incident_varying;
// Get the current 2-digit year
integer current_yy := (integer)(stringlib.GetDateYYYYMMDD()[3..4]);

layout_combined := RECORD
   SANCTN.layout_SANCTN_incident_in;
   string255 incident_text;   
end;

layout_combined  incident_combined(SANCTN_incident L, SANCTN_incident_text R) := TRANSFORM
   self.incident_text   := R.INCIDENT_TEXT;
   self.ORDER_NUMBER    := R.ORDER_NUMBER;
   self := L;
end;

j_incident := JOIN(SANCTN_incident
                  ,SANCTN_incident_text
									,left.BATCH_NUMBER    = right.BATCH_NUMBER
									AND left.INCIDENT_NUMBER = right.INCIDENT_NUMBER
									,incident_combined(left,right)
									,LEFT OUTER
									,LOCAL);

//Remove nonprintable characters
else_filter_find := '[Ã¢]';
//else_filter_find := '[^[:print:]]';
else_filter := '[^[:print:]]';

SANCTN.layout_SANCTN_incident_clean clean_SANCTN_incident(j_incident input) := TRANSFORM
  
   self.incident_date_clean	:= if(input.INCIDENT_DATE = '', '',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(input.INCIDENT_DATE,left,right)));
	 self.fcr_date_clean			:= if(input.FCR_DATE= '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(input.FCR_DATE,left,right)));
	
	//Remove nonprintable characters
	 self.incident_text       := IF(regexfind(else_filter_find,input.incident_text) = false,input.incident_text,
		                            regexreplace(else_filter,input.incident_text,'',NOCASE));
	
	  self.cln_modified_date   := if(input.MODIFIED_DATE = '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(input.MODIFIED_DATE,left,right)));
	 self.cln_load_date			 	 := if(input.LOAD_DATE = '','',Prof_License_Mari.DateCleaner.ToYYYYMMDD(trim(input.LOAD_DATE,left,right)));

   self                     := input;
   self:=[];
   
end;

clean_data := sort(PROJECT(j_incident, clean_SANCTN_incident(LEFT)),batch_number,incident_number, order_number);

clean_data_suppress := clean_data ((trim(batch_number,left,right)+trim(incident_number,left,right) not in SANCTN.SuppressBatchIncident));

output('Incident data: ' + count(clean_data));

clean_data_deduped := output(dedup(clean_data_suppress,all),,SANCTN.cluster_name +'out::SANCTN::'+filedate+'::incident_cleaned');

//Clear the history of the incident clean and party clean superfiles since it is full file replacement
add_super := sequential(STD.File.StartSuperFileTransaction()
                        ,STD.File.ClearSuperFile(SANCTN.cluster_name + 'out::sanctn::incident_cleaned',true)
                        ,STD.File.AddSuperFile(SANCTN.cluster_name + 'out::sanctn::incident_cleaned', SANCTN.cluster_name + 'out::sanctn::' + filedate + '::incident_cleaned')
												,STD.File.FinishSuperFileTransaction());

return sequential(clean_data_deduped, add_super);

end;