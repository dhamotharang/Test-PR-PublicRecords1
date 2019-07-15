// Boca Prod = 'boca-prod-thor'
EXPORT EmailNotificationsToDelete(string envname) := function
	ds := dedup(sort(thorbackup.GetDeleteFilesFromDB(,envname
																										,
																										,
																										,
																										,'0')(size > thorbackup.Constants.deletethresholdsize and ~(regexfind('keydiff',filename) or excludeme = 1)),emailid),emailid);
	
	return apply(
							ds,
								fileservices.sendemail(thorbackup.constants.adminemailsfordeletion + if (emailid <> 'NA',','+emailid,''),
			'IMPORTANT** '+owner+' **Delete Files on Prod Thor',
			if (emailid <> 'NA',
			'You have files that are over 100 GB and not part of superfile.',
			'Admins - email id is missing for '+ owner + ' please inform RPT to add the users email. If the user is no more with company please check with managers to decide if the file(s) can be deleted.') 
			+ '\n\n\nPlease visit http://uspr-dops.risk.regn.net/thorfilelist.aspx and check all the files that can been deleted'
			,,,'BocaRoxiePackageTeam@lexisnexis.com')
			);
end;