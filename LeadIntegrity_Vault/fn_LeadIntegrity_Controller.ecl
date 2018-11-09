#workunit('name', 'LeadIntegrity Service Test');
// #workunit('cluster', 'hthor');

IMPORT LeadIntegrity_Vault; 
IMPORT LeadIntegrity_Vault_Layout; 
IMPORT _Control, STD;

EXPORT fn_LeadIntegrity_Controller(STRING8 date_in = '', STRING part_nbr) := FUNCTION

failuresubject := 'Lead Integrity Input file validation failed for '+ TRIM(date_in) + '-' + TRIM(part_nbr);
failurebody := 'Lead Integrity Input file validation failed for '+ TRIM(date_in) + '-' + TRIM(part_nbr) +'\n\n'+
          'The workunit is '+WORKUNIT;

inputFileName := LeadIntegrity_Vault.Constants.MMPrefix + TRIM(date_in) + '_' + TRIM(part_nbr) + '_of_15';  
outputFileName := LeadIntegrity_Vault.Constants.ARPrefix + TRIM(date_in) + '::lead_integrity_attrib::p' + TRIM(part_nbr); 

LeadIntegrity_Vault.fn_LeadIntegrity_Service(TRIM(date_in), TRIM(part_nbr), inputFileName, outputFileName)
		: SUCCESS(fileservices.SendEMail(Constants.TeamEmailList, 'LeadIntegrity Attributes Build on Boca Prod Completed For Part Number: ' + TRIM(part_nbr) +  
							' And For the Build Period: ' + TRIM(date_in), 'The Work Unit is: ' + workunit)),
	    FAILURE(fileservices.SendEMail(Constants.TeamEmailList, 'LeadIntegrity Attributes Build on Boca Prod Failed For Part Number: ' + TRIM(part_nbr) +  
							' And For the Build Period: ' + TRIM(date_in), 'The Work Unit is: ' + workunit + '\n' + FAILMESSAGE));

RETURN (outputFileName);
END;