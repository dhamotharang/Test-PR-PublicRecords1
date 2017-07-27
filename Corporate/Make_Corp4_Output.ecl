#workunit('name', 'Corporate Output Files Creation ' + corporate.Corp4_Build_Date);

state_list := ['AK','AZ','CA','CO','CT','FL','ID','IN','KS','KY',
               'LA','MA','MN','MS','NV','NY','OH','OR','RI','SD',
               'VA','ND','NE','NM','WI',
               // New States for December 2002
               'IL','IA','MI','OK','WA',
				// New states added for jan 2003
				'TN', 'UT',
				// NEW STATES ADDED FEB 2003
				'AR', 'MD', 'MO', 'PA', 'WY',
				// new states added april 2003
				'TX',
                // new states added may 2003
                'MT',
				// new states added june 2003
				'VT',
				// new states added july 2003
				'NH', 'NC',
				// new states added august 2003
				'ME' ];

// Output Corporate File
Corporate.Layout_Corporate_Out FormatCorpOutput(Corporate.Layout_Corporate_Base L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, INTFORMAT(L.bdid, 12, 1), '');
SELF := L;
END;

Corporate_Out := PROJECT(Corporate.File_Corp4_Base(state_origin in state_list), FormatCorpOutput(LEFT));

OUTPUT(Corporate_Out,,'OUT::Corp4_' + Corporate.Corp4_build_Date, OVERWRITE);

// Output Corporate Contacts File
Corporate.Layout_Corp_Contacts_Out FormatCorpContactsOutput(Corporate.Layout_Corp_Contacts_DID L) := TRANSFORM
SELF.bdid := IF(L.bdid <> 0, INTFORMAT(L.bdid, 12, 1), '');
SELF.did := IF(L.did <> 0, INTFORMAT(L.did, 12, 1), '');
SELF.preGLB_did := IF(L.did <> 0, INTFORMAT(L.did, 12, 1), '');
SELF := L;
END;

Corp_Contacts_Out := PROJECT(Corporate.File_Corp4_Contacts_Base_DID(state_origin in state_list), FormatCorpContactsOutput(LEFT));


OUTPUT(Corp_Contacts_Out,,'OUT::Corp4_Contacts_DID_' +Corporate.Corp4_build_Date, OVERWRITE);