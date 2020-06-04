export Layout_FraudPoint := RECORD
	string20 dataset_name;
  string20 model_name;
	string30 acctNo;
	string20 fname;
	string20 lname;
	string5  zip;
	string9  ssn;
	string10 hphone;

	string3   score;
	string5   hri;
	string150 hri_desc;
	string5		hri2;
	string150 hri2_desc;
	string5   hri3;
	string150 hri3_desc;
	string5   hri4;
	string150 hri4_desc;
	string5   hri5;
	string150 hri5_desc;
	string5   hri6;
	string150 hri6_desc;
	
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;

END;