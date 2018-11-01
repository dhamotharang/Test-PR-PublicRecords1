export Layout_FraudPoint := RECORD
	string20 dataset_name;
	string30 acctNo;
	string20 fname;
	string20 lname;
	string5  zip;
	string9  ssn;
	string10 hphone;

	string3   score;
	string2   hri;
	string100 hri_desc;
	string2		hri2;
	string100 hri2_desc;
	string2   hri3;
	string100 hri3_desc;
	string2   hri4;
	string100 hri4_desc;
	string2   hri5;
	string100 hri5_desc;
	string2   hri6;
	string100 hri6_desc;
	
	string3   score_2;
	string2   hri_2;
	string100 hri_desc_2;
	string2		hri2_2;
	string100 hri2_desc_2;
	string2   hri3_2;
	string100 hri3_desc_2;
	string2   hri4_2;
	string100 hri4_desc_2;
	string2   hri5_2;
	string100 hri5_desc_2;
	string2   hri6_2;
	string100 hri6_desc_2;
	
	string1 StolenIdentityIndex;
	string1 SyntheticIdentityIndex;
	string1 ManipulatedIdentityIndex;
	string1 VulnerableVictimIndex;
	string1 FriendlyFraudIndex;
	string1 SuspiciousActivityIndex;

END;