
import Inquiry_AccLogs;

EXPORT Boca_Shell_College_Attendance( grouped dataset(risk_indicators.layout_boca_shell) input_clam, boolean isFCRA ) := function

with_college_attendance := project(input_clam,
	transform(risk_indicators.layout_boca_shell,
		college_land_use_codes := [ '1111', '9103', '9204', '0118', '0656', '0680', '0119', '9203'];
		addr_history_college_evidence := left.address_history_summary.address_history_advo_college_hit or 
																		 left.address_verification.input_address_information.Standardized_land_use_code in college_land_use_codes or
																		 left.address_verification.address_history_1.Standardized_land_use_code in college_land_use_codes or
																		 left.address_verification.address_history_2.Standardized_land_use_code in college_land_use_codes;
																		 							 
		self.address_history_summary.address_history_college_evidence := addr_history_college_evidence;
		
		inquiry_hit := exists(choosen(Inquiry_AccLogs.Key_Inquiry_DID(keyed(left.did=s_did) and
						(unsigned)search_info.datetime[1..6] < left.historydate 
						and bus_intel.industry='STUDENT LOANS'), 1));
		
		student_loan_inquiry := if(isFCRA, false, inquiry_hit);  // only ping inquiries for non-fcra
	
	
		self.attended_college := 
													map(
													left.did=0 => false,
													left.email_summary.email_domain_EDU_ct > 0 => true,	
													left.professional_license.plCategory in ['3','4','5'] => true,
													left.student.file_type in ['A','H','C','O'] => true,
													left.student.file_type='M' and (left.student.college_code<>'' or left.student.college_tier<>'' or left.student.college_major<>'') => true,
													left.student.file_type='' and (left.student.college_code<>'' or left.student.college_tier<>'' or left.student.college_major<>'' or
																												 left.student.class<>'' or left.student.income_level_code<>'') => true,										 
													addr_history_college_evidence => true,		
													student_loan_inquiry => true,
													false);
		self := left));	

return with_college_attendance;

end;
