import instantid_logs, header;

export mac_InstantID_Logs_ADL_Append(input_file, rdate = '', result_file) := macro

/* Input InfutorCID Base Layout and Date for restricting records

ORIGINAL REQUEST
	JTROST: request to see what lift we could get from the InstantID logs to enhance the ADL rate on the Infutor caller-id file
	LSIMMONS: Taking the last 2 years of InstantID requests and running the Name/City/State records against the 
	input criteria from InstantID matching on Name/Phone to see if we can get additional lift on an ADL append.
	
	1- Filter the Instant ID records with Name City St
	2- Compare those to the Infutor CID file by name and phone
	3- Run stats on the results for records with an ADL in InstantID and no ADL in InfutorCID 
	W20090527-161656  Prod */
///////////////////////////////////////////////////////////////////////////////////////////////

#uniquename(dinstantid_log)
#uniquename(fInfutorCID)
#uniquename(JnTrInstantID_Logs)
#uniquename(jnInstantID_Logs)
#uniquename(neustar)

%dinstantid_log% := distribute(InstantID_Logs.File_InstantID_Logs_Base
										    (p_city_name <> '' and st <> '' and fname <> '' and lname <> '' and  did > 0 and phone <> '' and (rdate < date_last_seen or rdate < date_first_seen)), hash(fname,lname,phone));

%fInfutorCID% := distribute(input_file(did = 0 and (phone <> '' and fname <> '' and lname <> '')), hash(fname,lname,phone));

recordof(input_file) %JnTrInstantID_Logs%(input_file l, InstantID_Logs.Layout_InstantID_Logs_Base r) := transform
	self.did_instantID := if(rdate <= r.date_last_seen , r.did, 0);
  self := l;
end;

/* Join to InstantID Logs to retrieve DID by name and phone */
result_file := join(%fInfutorCID%, %dinstantid_log%, 
											left.fname = right.fname and left.lname = right.lname and left.phone = right.phone, 
											%JnTrInstantID_Logs%(left, right), left outer, local) 
							 + input_file(did > 0 or phone = '' or fname = '' or lname = '');

endmacro;