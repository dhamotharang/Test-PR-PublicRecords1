import Mdr, ut;
export Update_Base(
   string 								jobid,
	 string									pversion,
	 boolean                pFileUseOtherEnvironment
) :=
function
fmtsin := [ 	'%m/%d/%y-%I:%M %p',		'%m/%d/%Y %I:%M:%S %p',
					'%m/%d/%y-',		'%m/%d/%y -',	'%m//%d/%y-',
					'%m/%d-%y-',		'%m/%d/%Y %I:%M',	'%m/%d/%Y -%I:%M',
					'%m/%d/%Y %H:%M'];
fmtout:='%Y%m%d';

response := dataset(Filenames().in_response + '::' + jobid + '_fixed', layouts.response_input_fixed, thor);
request := dataset(Filenames().in_request + '::' + jobid + '_fixed', layouts.request_input_fixed, thor);

base := join(request,
						 response,
						 left.acctno = right.acctno and
						 left.jobid =  right.jobid,
						 transform(Layouts.Base, 
							self.response_customer_client_code := right.customer_client_code,
							self.response_date_submitted:= right.date_submitted,
							self.response_date_submitted_reformat:=  if(length(trim(right.date_submitted,left, right)) = 8,		
																																  ut.ConvertDate(trim(right.date_submitted,left, right),'%m%d%Y'),
																																	ut.ConvertDate(trim('0' +right.date_submitted,left, right),'%m%d%Y')),
							self.response_Account_number :=  right.Account_number,
							self.response_SSN :=  right.SSN,
							self.response_company_phone1 :=  right.company_phone1,
							self.response_company_phone2 :=  right.company_phone2,
							self.response_phone_1_status :=  right.phone_1_status,
							self.response_phone1_notes :=  right.phone1_notes,
							self.response_phone1_notes_date :=  ut.ConvertDateMultiple(right.phone1_notes, fmtsin, fmtout),
							self.response_phone_2_status :=  right.phone_2_status,
							self.response_phone2_notes:=  right.phone2_notes,
							self.response_phone2_notes_date :=  ut.ConvertDateMultiple(right.phone2_notes, fmtsin, fmtout),
							self.did := (unsigned) left.did,
							self.bdid := (unsigned) left.bdid,
							self.acctno := (unsigned) left.acctno,
							self.dt_vendor_first_reported :=  (unsigned)pversion,
							self.dt_vendor_last_reported :=  (unsigned)pversion,
							self.jobid := (unsigned)left.jobid,
							self.response_file_name := right.filename,
							self.response_InputFileNamestring := '',
						  self := left))(source<>'IB');

addGlobalSID := mdr.macGetGlobalSID(base, 'PSS', 'source', 'global_sid'); //DF-26599: Populate Global_SID

	return addGlobalSID;

end;