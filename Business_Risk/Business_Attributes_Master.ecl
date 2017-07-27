IMPORT Risk_Indicators, ut, Models;

EXPORT Business_Attributes_Master(Risk_Indicators.Layout_Boca_Shell clam) := MODULE
 /* *************************************
	*    Shared Intermediate Variables    *
	*************************************** */
	SHARED sysdate := IF(clam.historydate <> 999999, (INTEGER)((STRING)clam.historydate[1..6]), (INTEGER)(ut.GetDate[1..6]));
	
	SHARED reported_age := TRUNCATE(((sysdate - Models.Common.SAS_Date((STRING)clam.reported_dob)) / 365.25));
	
	SHARED applicant_age := MAP(
																(INTEGER)clam.shell_input.age > 0	=> (INTEGER)clam.shell_input.age,
																(INTEGER)clam.inferred_age > 0		=> (INTEGER)clam.inferred_age,
																reported_age > 0									=> reported_age,
																																		 -1
															);
	

 /* *************************************
	*   Chase Representative Attributes   *
	*************************************** */
	EXPORT STRING1 Rep_Lien_Unrel_Lvl := MAP(
																							clam.bjl.liens_historical_unreleased_count = 0 AND clam.bjl.liens_recent_unreleased_count = 0				=> '0',
																							(clam.bjl.liens_historical_unreleased_count = 0 AND clam.bjl.liens_recent_unreleased_count = 1) OR
																							(clam.bjl.liens_historical_unreleased_count = 1 AND clam.bjl.liens_recent_unreleased_count = 0)			=> '1',
																							clam.bjl.liens_historical_unreleased_count = 2 AND clam.bjl.liens_recent_unreleased_count = 0				=> '2',
																							clam.bjl.liens_historical_unreleased_count > 2 AND clam.bjl.liens_recent_unreleased_count = 0				=> '3',
																							(clam.bjl.liens_historical_unreleased_count > 0 AND clam.bjl.liens_recent_unreleased_count = 1) OR
																							(clam.bjl.liens_historical_unreleased_count = 0 AND clam.bjl.liens_recent_unreleased_count > 1)			=> '4',
																																																																										 '5'
																					); // 0-5
	
	EXPORT STRING1 Rep_Prop_Owner := MAP(
																				clam.address_verification.owned.property_total > 0									=> '2',
																				clam.address_verification.input_address_information.naprop = 4 AND 
																				clam.address_verification.sold.property_total = 0 AND
																				clam.address_verification.ambiguous.property_total = 0							=> '2',
																				clam.address_verification.sold.property_total > 0 OR
																				clam.address_verification.ambiguous.property_total > 0							=> '1',
																																																							 '0'
																			); // 0-2
	
	EXPORT STRING2 Rep_Prof_License_Category := MAP(
																										~clam.professional_license.professional_license_flag		=> '-1',
																										(INTEGER)clam.professional_license.plcategory < 3				=> '0',
																																																							 clam.professional_license.plcategory
																									); // (-1)-5
	
	EXPORT STRING1 Rep_Accident_Count := (STRING)MIN(clam.accident_data.acc.num_accidents, 3); // 0-3
	
	EXPORT STRING1 Rep_Paydayloan_Flag := IF(clam.impulse.count > 0, '1', '0'); // Boolean (0-1)
	
	EXPORT STRING2 Rep_Age_Lvl := MAP(
																			applicant_age = -1		=> '46',
																			applicant_age <= 18		=> '18',
																			applicant_age <= 25		=> '25',
																			applicant_age <= 35		=> '35',
																			applicant_age <= 45		=> '45',
																															 '46'
																		); // 18, 25, 35, 45, 46
	
	EXPORT STRING1 Rep_Bankruptcy_Count := (STRING)MIN(clam.bjl.filing_count, 3); // 0-3
	
	EXPORT STRING1 Rep_Ssns_Per_Adl := (STRING)MIN(clam.velocity_counters.ssns_per_adl, 4); // 0-4
	
	EXPORT STRING1 Rep_Past_Arrest := IF(clam.bjl.arrests_count > 0, '1', '0'); // Boolean (0-1)
	
	EXPORT STRING3 Rep_Add1_Lres_Lvl := MAP(
																						clam.lres <= 0		=> '0',
																						clam.lres <= 12		=> '12',
																						clam.lres <= 24		=> '24',
																						clam.lres <= 48		=> '48',
																						clam.lres <= 72		=> '72',
																						clam.lres <= 96		=> '96',
																						clam.lres <= 192	=> '192',
																																 '193'
																					); // 0, 12, 24, 48, 72, 96, 192, 193
	
	EXPORT STRING1 Rep_Criminal_Assoc_Lvl := MAP(
																								clam.relatives.criminal_relative_within25miles = 0			=> '0',
																								clam.relatives.criminal_relative_within25miles = 1			=> '1',
																								clam.relatives.criminal_relative_within25miles IN [2,3]	=> '3',
																																																					 '4'
																							); // 0, 1, 3, 4
	
	EXPORT STRING1 Rep_Felony_Count := (STRING)MIN(clam.bjl.felony_count, 2); // 0-2
END;