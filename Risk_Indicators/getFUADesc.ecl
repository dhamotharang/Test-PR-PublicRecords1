export getFUADesc(string1 s) := CASE(s,	
	'A' => 'Follow your internal policy regarding potential matches to OFAC database information',
	'B' => 'Verify name with Social (via SSN card, DL if applicable, paycheck stub, or other Government Issued ID)',
	'C' => 'Verify name with Address (via DL, utility bill, Directory Assistance, paycheck stub, or other Government Issued ID)',
	'D' => 'Verify phone (Directory Assistance, utility bill)',
	'E' => 'Follow your internal policy regarding potential matches to non-OFAC global watchlists',
	'F' => 'Ask customer for a utility bill or other documentation showing a physical address location',
	'G' => 'ITINs are not to be used for ID purposes.  Please consult your organization\'s policy',
	'');