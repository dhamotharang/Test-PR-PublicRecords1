
import header,codes,did_add,didville,ut,header_slimsort,watchdog,doxie_files,roxiekeybuild,Risk_Indicators,doxie, death_master,Scrubs_Risk_Indicators;

export proc_RiskIndicator_buildkey(string filedate) := function
  #uniquename(version_date)
  %version_date% := filedate;
//Non-FCRA Key build

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_SSN_Table_v4,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4', 
										  '~thor_data400::key::death_master::@version@::ssn_table_v4',a1, '2')
											

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_SSN_Table_v4_filtered,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4_filtered', 
										  '~thor_data400::key::death_master::@version@::ssn_table_v4_filtered', a2, '2')
	
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_Address_Table_v4,
										  '~thor_data400::key::death_master::'+%version_date%+'::address_table_v4', 
										  '~thor_data400::key::death_master::@version@::address_table_v4',a3, '2')


RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_ADL_Risk_Table_v4,
										  '~thor_data400::key::death_master::'+%version_date%+'::adl_risk_table_v4', 
										  '~thor_data400::key::death_master::@version@::adl_risk_table_v4', a4, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_correlation_ssn_name,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_name', 
										  '~thor_data400::key::death_master::@version@::ssn_name',a9, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_correlation_ssn_addr,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_addr', 
										  '~thor_data400::key::death_master::@version@::ssn_addr',a10, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_correlation_addr_name,
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_name', 
										  '~thor_data400::key::death_master::@version@::addr_name',a11, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_correlation_phone_addr,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr', 
										  '~thor_data400::key::death_master::@version@::phone_addr',a12, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_correlation_phone_lname,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname', 
										  '~thor_data400::key::death_master::@version@::phone_lname',a13, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_SSN_Table_v4_2,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4_2', 
										  '~thor_data400::key::death_master::@version@::ssn_table_v4_2',a14, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_Suspicious_Identities,
										  '~thor_data400::key::death_master::'+%version_date%+'::suspicious_identities', 
										  '~thor_data400::key::death_master::@version@::suspicious_identities',a15, '2')
											
// start of 10 new keys for shell 5.3
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_ssn_name_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_name_summary', 
										  '~thor_data400::key::death_master::@version@::ssn_name_summary',a16, '2')

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_ssn_addr_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_addr_summary', 
										  '~thor_data400::key::death_master::@version@::ssn_addr_summary',a17, '2')
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_ssn_dob_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_dob_summary', 
										  '~thor_data400::key::death_master::@version@::ssn_dob_summary',a18, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_ssn_phone_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_phone_summary', 
										  '~thor_data400::key::death_master::@version@::ssn_phone_summary',a19, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_phone_dob_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_dob_summary', 
										  '~thor_data400::key::death_master::@version@::phone_dob_summary',a20, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_addr_name_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_name_summary', 
										  '~thor_data400::key::death_master::@version@::addr_name_summary',a21, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_addr_dob_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_dob_summary', 
										  '~thor_data400::key::death_master::@version@::addr_dob_summary',a22, '2')	
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_name_dob_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::name_dob_summary', 
										  '~thor_data400::key::death_master::@version@::name_dob_summary',a23, '2')	
											
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_phone_addr_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr_summary', 
										  '~thor_data400::key::death_master::@version@::phone_addr_summary',a24, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_phone_lname_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname_summary', 
										  '~thor_data400::key::death_master::@version@::phone_lname_summary',a25, '2')												


RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_phone_addr_header_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr_header_summary', 
										  '~thor_data400::key::death_master::@version@::phone_addr_header_summary',a26, '2')	

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Correlation_Risk.key_phone_lname_header_summary,
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname_header_summary', 
										  '~thor_data400::key::death_master::@version@::phone_lname_header_summary',a27, '2')	
											
											

//FCRA Key build

RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_SSN_Table_v4_filtered,
										  '~thor_data400::key::death_master::fcra::'+%version_date%+'::ssn_table_v4_filtered', 
										  '~thor_data400::key::death_master::fcra::@version@::ssn_table_v4_filtered', a5, '2')
RoxieKeyBuild.MAC_SK_BuildProcess_Local(Risk_Indicators.Key_FCRA_ADL_Risk_Table_v4_Filtered,
										  '~thor_data400::key::death_master::fcra::'+%version_date%+'::adl_risk_table_v4_filtered', 
										  '~thor_data400::key::death_master::fcra::@version@::adl_risk_table_v4_filtered', a7, '2');
											
											
//Move Non-FCRA Key build				

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_table_v4',
									 '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4', b1, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_table_v4_filtered',
									 '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4_filtered', b2, '2')
  
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::address_table_v4',
									 '~thor_data400::key::death_master::'+%version_date%+'::address_table_v4', b3, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::adl_risk_table_v4', 
									 '~thor_data400::key::death_master::'+%version_date%+'::adl_risk_table_v4', b4, '2')					 

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_name', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_name',b9, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_addr', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_addr',b10, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::addr_name', 
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_name',b11, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_addr', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr',b12, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_lname', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname',b13, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_table_v4_2', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_table_v4_2',b14, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::suspicious_identities', 
										  '~thor_data400::key::death_master::'+%version_date%+'::suspicious_identities',b15, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_name_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_name_summary',b16, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_addr_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_addr_summary',b17, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_dob_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_dob_summary',b18, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::ssn_phone_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::ssn_phone_summary',b19, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_dob_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_dob_summary',b20, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::addr_name_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_name_summary',b21, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::addr_dob_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::addr_dob_summary',b22, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::name_dob_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::name_dob_summary',b23, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_addr_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr_summary',b24, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_lname_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname_summary',b25, '2')

RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_addr_header_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_addr_header_summary',b26, '2')
											
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::@version@::phone_lname_header_summary', 
										  '~thor_data400::key::death_master::'+%version_date%+'::phone_lname_header_summary',b27, '2')
											
											
	
//Move FCRA Key build
		
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::fcra::@version@::ssn_table_v4_filtered',
									 '~thor_data400::key::death_master::fcra::'+%version_date%+'::ssn_table_v4_filtered', b5, '2')
RoxieKeyBuild.MAC_SK_Move_To_Built_v2('~thor_data400::key::death_master::fcra::@version@::adl_risk_table_v4_filtered', 
									'~thor_data400::key::death_master::fcra::'+%version_date%+'::adl_risk_table_v4_filtered', b7, '2');	

									
full1 := 	sequential(	parallel(a1,a2,a3,a4,a5,a7,a9,a10,a11,a12,a13,a14,a15,a16,a17,a18,a19,a20,a21,a22,a23,a24,a25,a26,a27),
					  					parallel(b1,b2,b3,b4,b5,b7,b9,b10,b11,b12,b13,b14,b15,b16,b17,b18,b19,b20,b21,b22,b23,b24,b25,b26,b27)
										);					

	///////////////////////// Move Non-FCRA KEYS /////////////////////////
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_table_v4', 'Q', move1, 2);
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_table_v4_filtered', 'Q', move2, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::address_table_v4', 'Q', move3, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::adl_risk_table_v4', 'Q', move4, 2);
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_name', 'Q',move9, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_addr', 'Q',move10, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::addr_name', 'Q',move11, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_addr', 'Q',move12, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_lname', 'Q',move13, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_table_v4_2', 'Q',move14, 2)
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::suspicious_identities', 'Q',move15, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_name_summary', 'Q',move16, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_addr_summary', 'Q',move17, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_dob_summary', 'Q',move18, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::ssn_phone_summary', 'Q',move19, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_dob_summary', 'Q',move20, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::addr_name_summary', 'Q',move21, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::addr_dob_summary', 'Q',move22, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::name_dob_summary', 'Q',move23, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_addr_summary', 'Q',move24, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_lname_summary', 'Q',move25, 2)	
	
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_addr_header_summary', 'Q',move26, 2)
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::@version@::phone_lname_header_summary', 'Q',move27, 2)

  
	///////////////////////// Move FCRA KEYS /////////////////////////
	RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::fcra::@version@::ssn_table_v4_filtered', 'Q', move5, 2);
  RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::death_master::fcra::@version@::adl_risk_table_v4_filtered', 'Q', move7, 2);

	move_qa	:=	parallel(move1,move2,move3,move4,move5,move7,move9,move10,move11,move12,move13,move14,move15,move16,move17,move18,move19,move20,move21,move22,move23,move24,move25,move26,move27);
                       
//// Please do not add automatic update of DOPS or Orbit in this build.  

return sequential(full1,move_qa,Scrubs_Risk_Indicators.fn_GenerateStats(filedate),Scrubs_Risk_Indicators.fn_RunScrubs(filedate,''));
END;				
									