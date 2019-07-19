
import Inquiry_AccLogs, risk_indicators, doxie, Suppress, riskwise;

EXPORT Boca_Shell_College_Attendance( grouped dataset(risk_indicators.layout_boca_shell) input_clam, boolean isFCRA, doxie.IDataAccess mod_access  = doxie.IDataAccess) := function

layout_temp_CCPA := RECORD
	integer8 did; // CCPA changes
    unsigned4 global_sid; // CCPA changes
	risk_indicators.layout_boca_shell;
END;

with_college_attendance := project(input_clam,
	transform(layout_temp_CCPA,
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
		self.did := left.did;
        self.global_sid := 0;
		self := left));	
    
layout_temp_CCPA College_Attendance_CCPA(with_college_attendance le, Inquiry_AccLogs.Key_Inquiry_DID ri) := transform
                self.global_sid := ri.ccpa.global_sid;
				self := le;
end;

college_attendance_join :=  join(with_college_attendance, Inquiry_AccLogs.Key_Inquiry_DID,
												 keyed(right.s_did=left.did),
												 College_Attendance_CCPA(left,right), 
                                                 left outer,
												 atmost(right.s_did=left.did, riskwise.max_atmost));

suppressed_college_attendance := Suppress.MAC_SuppressSource(college_attendance_join, mod_access);

formatted_college_attendance := PROJECT(suppressed_college_attendance, TRANSFORM(risk_indicators.layout_boca_shell,
                                                  SELF := LEFT));
																								
return formatted_college_attendance;

end;
