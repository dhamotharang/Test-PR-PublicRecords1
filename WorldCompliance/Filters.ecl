/*

These are the various filters used to paritition the files

*/
EXPORT Filters := MODULE

export fAdverseMedia 						:= ['Adverse Media','Investigation'];
export fEnforcement 						:= ['Enforcement','Excluded Party','End-Use Controls'];

export fEdd 										:= ['Associated Entity','Company of Interest', 'Influential Person', 'SOE', 'PEP'];
//Bug: 149009 - WCo: Add new records to WorldCompliance - Expanded Due Diligence file
export fEdd1 										:= ['SOE', 'PEP']; //Production
//export fEdd1a									:= ['Enforcement']; //Test

//Bug: 196854 - WCo - Bridger: Change to logic for WorldCompliance Expanded Due Diligence
export fEdd2 										:= ['Associated Entity'];

export fEddBackup 							:= ['Associated Entity','Company of Interest','End-Use Controls',      
														'Excluded Party',
														'Influential Person'];
       //     'Investigation'];
export fStateOwned 							:= ['SOE'];
export fPep 										:= ['PEP','Associated Entity','Company of Interest','Influential Person','Shareholder'];

export usaCountries 						:= ['United States','Puerto Rico','Guam','United States Minor Outlying Islands','Virgin Islands, U.S.',
														'American Samoa'];

export fSanctions 							:= ['Sanction List'];

				//BD-108 - Addition of Associated Entity into the Sanctions and Enforement xml file - 3/19/2018
export fSanctionsAndEnforcement := ['Sanction List','Enforcement','Excluded Party','End-Use Controls','Associated Entity'];

export fFull 										:= ['Adverse Media','Investigation','SOE','PEP','Associated Entity','Company of Interest','Influential Person',
														'Shareholder','Sanction List','End-Use Controls','Enforcement','Excluded Party'];

export fRegistrations 					:= ['Registrations', 'High Risk'];

END;