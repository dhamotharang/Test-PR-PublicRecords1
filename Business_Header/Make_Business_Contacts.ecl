IMPORT ut, DID_Add, Header, header_slimsort, watchdog, business_regression;

#workunit ('name', 'Build Business_Contacts');

layout_ssn_assign := RECORD
	UNSIGNED6 uid;
	UNSIGNED8 did;
	QSTRING9  ssn;
END;

layout_ssn_assign SlimForSSN(Business_Header.Layout_Business_Contacts_Temp l) := TRANSFORM
	SELF.ssn := IF(l.ssn = 0, '', INTFORMAT(l.ssn, 9, 1));
	SELF := l;
END;

Contacts_DID := PROJECT(Business_Header.BC_Scored(did != 0), SlimForSSN(LEFT));

// Append SSN by DID to Contacts
DID_Add.MAC_Add_SSN_By_DID(Contacts_DID, did, ssn, Business_Contacts_SSN_Append) 

Business_Contacts_SSN_Append_Dist := DISTRIBUTE(Business_Contacts_SSN_Append, HASH(uid));
Business_Contacts_BDID_Dist := DISTRIBUTE(Business_Header.BC_Scored, HASH(uid));

Business_Header.Layout_Business_Contact_Full AssignSSNs(Business_Header.Layout_Business_Contacts_Temp l, layout_ssn_assign r) := TRANSFORM
	SELF.ssn := IF(r.ssn != '', (UNSIGNED6) r.ssn, l.ssn);
	SELF := l;
END;

Business_Contacts := JOIN(Business_Contacts_BDID_Dist,
                          Business_Contacts_SSN_Append_Dist,
                          LEFT.uid = RIGHT.uid,
                          AssignSSNs(LEFT, RIGHT),
                          LEFT OUTER, LOCAL);
               
ut.MAC_SF_BuildProcess(Business_Contacts,'BASE::Business_Contacts',o_contacts)

o_stats := Business_Header.BC_Stats;

o_reg := business_regression.Proc_BC_Regression_Test;


dothis := OUTPUT('MAKE SURE THESE TWO FILES HAVE THE SAME NUMBER OF RECORDS, PLEASE!');

export Make_Business_Contacts := SEQUENTIAL(o_contacts, o_stats
,dothis);
