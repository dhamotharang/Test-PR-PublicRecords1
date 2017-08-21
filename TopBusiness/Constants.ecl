export Constants := module

	export Segment_Types := module
		export UNTRUSTED           :=  1;
		export INCOMPLETE          :=  2;
		export TRIPLE_CORE         :=  3;
		export DOUBLE_CORE         :=  4;
		export DOUBLE_TRUSTED      :=  5;
		export ESTABLISHED_EDA     :=  6;
		export ESTABLISHED_TRUSTED :=  7;
		export EMERGING_EDA        :=  8;
		export EMERGING_TRUSTED    :=  9;
		export HISTORICAL          := 10;
		export NONUPDATING         := 11;
		export DEAD                := 12;
	end;

	export SET_CORE_SEGMENTS :=  [
		Segment_Types.EMERGING_EDA,
		Segment_Types.EMERGING_TRUSTED,
		Segment_Types.ESTABLISHED_EDA,
		Segment_Types.ESTABLISHED_TRUSTED,
		Segment_Types.DOUBLE_TRUSTED,
		Segment_Types.DOUBLE_CORE,
		Segment_Types.TRIPLE_CORE];
	
	export Company_Name_Types := module
		export unsigned1 UNKNOWN    := 0;
		export unsigned1 LEGAL      := 1;
		export unsigned2 FICTITIOUS := 2;
	end;
	
	export Address_Types := module
		export unsigned1 UNKNOWN  := 0;
		export unsigned1 MAILING  := 1;
		export unsigned1 PROPERTY := 2;
		export unsigned1 BUSINESS := 3;
		export unsigned1 REGAGENT := 4;
	end;
	
	export Phone_Types := module
		export unsigned1 UNKNOWN := 0;
		export unsigned1 PHONE   := 1;
		export unsigned1 FAX     := 2;
	end;
	
	export Contact_Name_Types := module
		export string5 OWNER := 'Owner';
	end;
	
	export MatchCodes := module
		export unsigned4 NAME_ADDR             := 1 <<  0; //         1
		export unsigned4 NAME_PHONE            := 1 <<  1; //         2
		export unsigned4 LIEN_CREDITOR         := 1 <<  2; //         4
		export unsigned4 FEIN_ADDR_PHONE       := 1 <<  3; //         8
		export unsigned4 DUNS_NAME             := 1 <<  4; //        16
		export unsigned4 EXPERIAN_ADDR_PHONE   := 1 <<  5; //        32
		export unsigned4 PHONE7_ADDR_CLOSENAME := 1 <<  6; //        64
		export unsigned4 REZADDR_PHONE         := 1 <<  7; //       128
		export unsigned4 NAME_FEIN             := 1 <<  8; //       256
		export unsigned4 INCORP                := 1 <<  9; //       512
		export unsigned4 NAME_URL              := 1 << 10; //      1024
		export unsigned4 FEIN_ADDR_DUNS        := 1 << 11; //      2048
		export unsigned4 EXPERIAN_ADDR         := 1 << 12; //      4096
		export unsigned4 EXPERIAN_CLOSENAME    := 1 << 13; //      8192
		export unsigned4 UCCLIEN_ADDR          := 1 << 14; //     16384
		export unsigned4 UCCLIEN_NAME          := 1 << 15; //     32768
		export unsigned4 SOURCEPARTY           := 1 << 16; //     65536
		export unsigned4 ADDR_INITSS           := 1 << 17; //    131072
		export unsigned4 FEIN_ADDR_NAMESUBSTR  := 1 << 18; //    262144
		export unsigned4 MVR_SELECTNAME        := 1 << 19; //    524288
		export unsigned4 UCCLIEN_CREDITOR_SELECTNAME_NOADDR := 1 << 20; // 1048576
		export unsigned4 TFPHONE_NAME_ZIP      := 1 << 21; //   2097152
		export unsigned4 NAME_ZIP_NPANXX       := 1 << 22; //   4194304
		export unsigned4 ZOOM_NAME             := 1 << 23; //   8388608
		export unsigned4 TFPHONE_NAME_CITY_STATE := 1 << 24; //16777216
		export unsigned4 SOURCEDOCID_CLOSENAME := 1 << 25; //  33554432
		export unsigned4 SOURCEDOCID_ADDRESS   := 1 << 26; //  67108864
		export unsigned4 PRIMRANGE_ZIP_NAME    := 1 << 27; // 134217728
		export unsigned4 ZIP_PHONE_CLOSE_PR_NAME := 1 << 28; // 268435456
		export unsigned4 ZIP_PHONE_NAME_BLANK_CN := 1 << 29; // 536870912
		export unsigned4 STATE_NAME_PR_PN      := 1 << 30; // 1073741824
		export unsigned4 DUNS_ADDR_PHONE       := 1 << 31; // 2147483648
	end;

	export ItemTypes := module
		export unsigned2 NAME := 1;
		export unsigned2 ADDRESS := 2;
		export unsigned2 PHONE := 3;
		export unsigned2 URL := 4;
		export unsigned2 SIC := 5;
		export unsigned2 NAIC := 6;
		export unsigned2 LIEN_ACTIVE := 7;
		export unsigned2 LIEN_TERMINATED := 8;
		export unsigned2 AIRCRAFT_CURRENT := 9;
		export unsigned2 AIRCRAFT_PRIOR := 10;
		export unsigned2 ABSTRACT := 11;
		export unsigned2 CORPINFO := 12;
		export unsigned2 MARK := 13;
		export unsigned2 BANKRUPTCY_DEBTOR := 14;
		export unsigned2 BANKRUPTCY_ATTORNEY := 15;
		// export unsigned2 CONTACT := 16;
		export unsigned2 EXECUTIVE := 17;
		export unsigned2 ASSOCIATEDBUSINESS := 18;
		export unsigned2 PARENTBUSINESS := 19;
		export unsigned2 INDUSTRYDESC := 20;
		export unsigned2 BUSINESSDESC := 21;
		export unsigned2 FINANCE      := 22;
		export unsigned2 WATERCRAFT_PRIOR := 23;
		export unsigned2 WATERCRAFT_CURRENT := 24;
		export unsigned2 UCC_DEBTOR_ACTIVE := 25;
		export unsigned2 UCC_SECURED_ACTIVE := 26;
		export unsigned2 UCC_DEBTOR_TERMINATED := 27;
		export unsigned2 UCC_SECURED_TERMINATED := 28;
		export unsigned2 LICENSE := 29;		
		export unsigned2 CONTACT_PRIOR := 30;
		export unsigned2 CONTACT_CURRENT := 31;
		export unsigned2 PROPERTY_PRIOR := 32;
		export unsigned2 PROPERTY_CURRENT := 33;
		export unsigned2 FORECLOSURENOD := 34;
		export unsigned2 MVR_PRIOR := 35;
		export unsigned2 MVR_CURRENT := 36;
		export unsigned2 BANKRUPTCY_TRUSTEE := 37;
	end;
	
   export string1 CURRENT    := 'C';
   export string1 PRIOR      := 'P';
	 export string1 ACTIVE     := 'A';
	 export string1 TERMINATED := 'T';
	 
export layout_corpStatus := record
			string2 StateAbbrev;
			string20 Code; 
			string50 CodeDescrpt;
			string15 LNNormalizedStatus;
end;

EXPORT Corp_Active_ds := sort(dedup(dataset([
{'IL','12','AB INITIO',' '},
{'GA','12','ABANDONED','Inactive'},//'Expired
{'RI','','ABANDONED','Inactive'},//'Expired
{'TX','13','ABANDONED','Inactive'},//'Expired
{'AK','26','ACCEPTANCE INACTIVE','Inactive'},//'
{'MO','26','ACCEPTANCE INACTIVE','Inactive'},
{'MS','26','ACCEPTANCE INACTIVE','Inactive'},
{'NH','26','ACCEPTANCE INACTIVE','Inactive'},
{'AL','X','ACTIVE','Active'},
{'AL','','ACTIVE','Active'},
{'AZ','1','ACTIVE','Active'},
{'AZ','','ACTIVE','Active'},
{'CA','1','ACTIVE','Active'},
{'CA','A','ACTIVE','Active'},
{'CT','AC','ACTIVE','Active'},
{'DC','AC','ACTIVE','Active'},
{'FL','A','ACTIVE','Active'},
{'HI','NO CODE -Description from Raw File','ACTIVE','Active'},
{'IA','A','ACTIVE','Active'},
{'IN','1','ACTIVE','Active'},
{'KY','A','ACTIVE','Active'},
{'LA','A','ACTIVE','Active'},
{'MA','ACTIVEFL','ACTIVE','Active'},
{'MA','Y','ACTIVE','Active'},
{'MD','A','ACTIVE','Active'},
{'MI','0','ACTIVE','Active'},
{'MI','\"0,A\"','ACTIVE','Active'},
{'MI','A','ACTIVE','Active'},
{'MI','CC','ACTIVE','Active'},
{'MI','','ACTIVE','Active'},
{'MN','AN','ACTIVE','Active'},
{'MN','BT','ACTIVE','Active'},
{'MN','DC','ACTIVE','Active'},
{'MN','FC','ACTIVE','Active'},
{'MN','FLP','ACTIVE','Active'},
{'MN','LP ','ACTIVE','Active'},
{'MN','MLP','ACTIVE','Active'},
{'MN','NLP','ACTIVE','Active'},
{'MN','NP','ACTIVE','Active'},
{'MN','RLP','ACTIVE','Active'},
{'MN','RN','ACTIVE','Active'},
{'MN','TM','ACTIVE','Active'},
{'MN','','ACTIVE','Active'},
{'MO','2','ACTIVE','Active'},
{'MS','2','ACTIVE','Active'},
{'MT','A','ACTIVE','Active'},
{'MT','ACT','ACTIVE','Active'},
{'ND','A','ACTIVE','Active'},
{'NE','A','ACTIVE','Active'},
{'NH','2','ACTIVE','Active'},
{'NJ','ACT','ACTIVE','Active'},
{'NV','NO CODE -Description from Raw File','ACTIVE','Active'},
{'NY','','ACTIVE','Active'},
{'OR ','NO CODE -Description from Raw File','ACTIVE','Active'},
{'PA','3','ACTIVE','Active'},
{'RI','','ACTIVE','Active'},
{'SD','','ACTIVE','Active'},
{'TN','0','ACTIVE','Active'},
{'TN','','ACTIVE','Active'},
{'TX','11','ACTIVE','Active'},
{'UT','A','ACTIVE','Active'},
{'UT','','ACTIVE','Active'},
{'VA','0','ACTIVE','Active'},
{'VT','A','ACTIVE','Active'},
{'WA','A','ACTIVE','Active'},
{'WV','1','ACTIVE','Active'},
{'WV','18','ACTIVE','Active'},
{'WV','23','ACTIVE','Active'},
{'WV','24','ACTIVE','Active'},
{'WV','26','ACTIVE','Active'},
{'WV','','ACTIVE','Active'},
{'WY','1','ACTIVE','Active'},
{'WY','','ACTIVE','Active'},
{'TN','','ACTIVE - DISSOLVED','<null>'},//,'seems contadictory
{'AK','28','ACTIVE - FOREIGN NAME','Active'},//'Foreign Name - non AK co
{'AK','3','ACTIVE - GOOD STANDING','Active'},//'
{'AK','46','ACTIVE - NON COMPLIANT','Active'},//,'
{'AK','2','ACTIVE - REGISTRATION','Active'},//'
{'AK','1','ACTIVE - RESERVED NAME','Active'},//'
{'TN','','ACTIVE - SUSPENDED','<null> '},//'
{'KS','AA','ACTIVE AND IN GOOD STANDING','Active'},//'
{'ND','A','ACTIVE AND IN GOOD STANDING','Active'},
{'WA','A','ACTIVE AND IN GOOD STANDING','Active'},
{'NM','AC','ACTIVE CORPORATION','Active'},
{'GA','39','ACTIVE NAME RESERVATION','Active'},//'are these 2 separate statuses? 
{'GA','3','ACTIVE/COMPLIANCE','Active'},//'
{'GA','32','ACTIVE/NONCOMPLIANCE','Active'},//'
{'GA','33','ACTIVE/OWES CURRENT YEAR','Active'},//'Owes state $
{'IA','R','ACTIVE/REGISTERED AGENT RESIGNED','Active'},//'Flag the Reg Agent as old/former? 
{'UT','','ACTIVE-ADMINISTRATIVE','Active'},//'
{'UT','','ACTIVE-APPLICATION APPROVED (FOR REINSTATEMENT)','Active'},//'
{'UT','','ACTIVE-APPLICATION APPROVED (LICENSURE)','Active'},//'
{'UT','','ACTIVE-APPLICATION SUBMITTED (LICENSURE)','Active'},//'
{'UT','','ACTIVE-EXPIRATION OF BOND','Active'},//'
{'UT','','ACTIVE-EXPIRED LICENSE RENEWAL','Active'},//'renewal/lapse?
{'UT','','ACTIVE-GOOD STANDING','Active'},//'
{'UT','','ACTIVE-LICENSE ISSUANCE','Active'},//'
{'UT','','ACTIVE-LICENSE RENEWAL','Active'},//'renewal/lapse?
{'PA','2','ACTIVE-NAME IS AVAILABLE','<null>'},//'
{'UT','','ACTIVE-RENEWAL OF LICENSE','Active'},//'renewal/lapse?
{'AZ','9','AD-DISSOLVED - BAD CHECK','Inactive'},//'
{'AZ','14','AD-DISSOLVED - CORP LIFE EXPIRED','Inactive'},//'
{'AZ','12','AD-DISSOLVED - FILE CERT/DISCLOSURE','Inactive'},//'
{'AZ','13','AD-DISSOLVED - OTHER','Inactive'},//'
{'AZ','8','AD-DISSOLVED-FILE ANNUAL REPORT','Inactive'},//'
{'AZ','18','AD-DISSOLVED-INCOMPLETE DISSOLUTION/WITHDRAWAL','Inactive'},//'
{'AZ','10','AD-DISSOLVED-MAINTAIN STAT AGENT','Inactive'},//'
{'AZ','11','AD-DISSOLVED-PUB/FILE AFFIDAVIT','Inactive'},//'
{'AZ','16','AD-DISSOLVED-UNDELIVERABLE ADDRESS','Inactive'},//'
{'HI','NO CODE -Description from Raw File','ADM. TERMINATED','Inactive'},//'
{'NH','36','ADMIN DISS LLP-CC-NP','Inactive'},//'
{'MO','31','ADMIN DISS/CANCEL/OTHER','Inactive'},//'
{'NH','37','ADMIN DISSOLUTION','Inactive'},//'
{'NH','36','ADMIN DISSOLUTION LLP-CC','Inactive'},//'
{'TN','6','ADMIN DISSOLVED','Inactive'},//'
{'MO','30','ADMIN DISSOLVED NONPROFIT','Inactive'},//'
{'MO','29','ADMIN DISSOLVED PROFIT','Inactive'},//'
{'TN','5','ADMIN REVOKED','Inactive'},//'
{'ID','O','ADMIN TERMINATED','Inactive'},//'
{'GA','41','ADMIN. DISSOLVED','Inactive'},//'
{'NH','34','ADMIN. SUSPENSION','Inactive'},//'
{'UT','','ADMINISTRATIVE HOLD-GOOD STANDING','Pending'},//'
{'UT','','ADMINISTRATIVE HOLD-INCOMPLETE APPLICATION','Pending'},//'
{'AZ','7','ADMINISTRATIVELY CANCELLED','Inactive'},//'
{'ID','J','ADMINISTRATIVELY CANCELLED','Inactive'},//'
{'AR','22','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'CO','','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'ID','A','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'IN','2','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'ME','ADI','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'NC','8','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'WI','ADS','ADMINISTRATIVELY DISSOLVED','Inactive'},//'
{'CO','','ADMINISTRATIVELY DISSOLVED - NAME NOT AVAIL','Inactive'},//'
{'AZ','20','ADMINISTRATIVELY FROZEN','Pending'},//'
{'ID','B','ADMINISTRATIVELY REVOKED','Inactive'},//'
{'AR','23','ADMINISTRATIVELY WITHDRAWN','Inactive'},//'?
{'IL','1','AGENT RESIGNATION','<null> '},//'Flag the Reg Agent as old/former
{'IL','5','AGENT VACATED','<null> '},//'Flag the Reg Agent as old/former
{'SD','AA','AMENDED CERTIFICATE OF AUTHORITY','<null> '},//'"""Amending"" should count as a ""pulse"" for the co being alive?"
{'SD','AM','AMENDMENT','<null> '},//'
{'SD','AR','ANNUAL REPORT','Active'},//'
{'KS','DZ','ANNUAL REPORT NOT RECEIVED - STATUS UNAVAILABLE','<null> '},//'
{'UT','','APPLICATION CANCELLED-ADMINISTRATIVE','Inactive'},//'
{'NC','23','APPLIED TO WITHDRAW','Pending'},//'
{'DC','OK','APPROVED','Active'},//'
{'SC','DIS','ARTICLES OF DISSOLUTION','Inactive'},//'
{'SD','AC','ARTICLES OF INCORPORATION','Active'},//'
{'SD','AO','ARTICLES OF ORGANIZATION','Active'},//'
{'TX','22','ASSUMED NAME ENTITY','<null> '},//'DBA/FBN
{'ME','SUR','AUTHORITY SURRENDERED','Inactive'},//'
{'AZ','15','AUTHORITY SUSPENDED BY COURT ORDER','Inactive'},//'
{'NC','5','AUTO DISSOLVE','Inactive'},//'
{'GA','34','AUTOMATED ADMINISTRATIVE','<null> '},//'
{'AZ','6','BAD CHECK','<null> '},//'Bad Check to state!!
{'IL','3','BANKRUPCY','Inactive'},//'potential bktcy!!
{'IL','13','BANKRUPCY','Inactive'},//'Bankrupcy poss
{'AZ','B','BANKRUPTCY','Inactive'},//'Bankruptcy!
{'RI','','BANKRUPTCY','Inactive'},//'Bankruptcy!
{'WV','18','BANKRUPTCY','Inactive'},//'Bankruptcy!
{'WV','','BANKRUPTCY','Inactive'},//'Bankruptcy!
{'NM','BK','BANKRUPTCY-RECEIVERSHIP','Inactive'},//'Bankruptcy!
{'NM','BT','BUSINESS TRANSACTED','Active'},//'??
{'OR','','BUSSTAT','<null> '},//'
{'VA','19','CANC (AUTO-FEE) LLC/LP/BT-FEES NOT PAID','Inactive'},//'Late/No payment 
{'VA','8','CANC INVOL','Inactive'},//'
{'VA','76','CANC(AUTO R/A) LLC/LP/BT-FAILED MAINTAIN R/A','Inactive'},//'
{'VA','15','CANC(VOLUNTARY) (LLC/LP/BT)','Inactive'},//'
{'VA','17','CANC/DOM (CORP)','Inactive'},//'Domestic Corporation
{'VA','25','CANC/DOM (LLC)','Inactive'},//'Domestic LLC
{'AK','41','CANCELED','Inactive'},//'
{'AK','47','CANCELED TRADEMARK','Inactive'},//'"Is this a situation of over-packed ""status"" field? If so - <null> it"
{'VA','44','CANCELED-CNVRSION','Inactive'},//'
{'ID','H','CANCELLATION','Inactive'},//'
{'MT','CAN','CANCELLATION','Inactive'},//'
{'NM','CA','CANCELLATION','Inactive'},//'
{'SD','CL','CANCELLATION','Inactive'},//'
{'NM','CR','CANCELLATION OF REGISTRATION','Inactive'},//'
{'AL','C','CANCELLED','Inactive'},//'
{'AR','16','CANCELLED','Inactive'},//'
{'CA','3','CANCELLED','Inactive'},//'
{'CA','C','CANCELLED','Inactive'},//'
{'CT','CN','CANCELLED','Inactive'},
{'DC','CAN','CANCELLED','Inactive'},
{'GA','8','CANCELLED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','CANCELLED','Inactive'},//'
{'IN','4','CANCELLED','Inactive'},//'
{'MD','T','CANCELLED','Inactive'},//'
{'ME','CAN','CANCELLED','Inactive'},//'
{'MS','40','CANCELLED','Inactive'},//'
{'MT','C','CANCELLED','Inactive'},//'
{'NC','3','CANCELLED','Inactive'},//'
{'NJ','CAN','CANCELLED','Inactive'},//'
{'OK','19','CANCELLED','Inactive'},//'
{'PA','8','CANCELLED','Inactive'},//'
{'RI','','CANCELLED','Inactive'},//'
{'TN','9','CANCELLED','Inactive'},//'
{'TX','16','CANCELLED','Inactive'},//'
{'UT','','CANCELLED','Inactive'},//'
{'NV','NO CODE -Description from Raw File','CANCELLED','Inactive'},//'
{'OH','H','CANCELLED BUT NAME RESERVED','<null> '},//'?
{'OH','C','CANCELLED NAME NOT RESERVED','Inactive'},//'
{'UT','','CANCELLED-ADMINISTRATIVE','Inactive'},//'
{'UT','','CANCELLED-AMENDED','Inactive'},//'
{'UT','','CANCELLED-BY USER REQUEST','Inactive'},//'
{'UT','','CANCELLED-CANCELED','Inactive'},//'
{'UT','','CANCELLED-CREATION OF A DIFFERENT ENTITY','Inactive'},//'Merged??
{'UT','','CANCELLED-DISSOLVED','Inactive'},//'
{'UT','','CANCELLED-ENTITY TYPE CHANGE','<null> '},//'
{'UT','','CANCELLED-EXPIRATION OF NON-RENEWABLE APPR. LIC.','Inactive'},//'
{'UT','','CANCELLED-INVOL. CANC. / NO RENEWAL','Inactive'},
{'UT','','CANCELLED-REQUESTED CANCELLED STATUS','Inactive'},
{'UT','','CANCELLED-VOLUNTARILY WITHDRAWN','Inactive'},
{'SD','CA','CERTIFICATE OF AUTHORITY','Active'},
{'WI','RCA','CERTIFICATE OF AUTHORITY REVOKED','Active'},
{'WI','CAN','CERTIFICATE OF CANCELLATION','Inactive'},
{'TN','C','CLEARED BY REVENUE','Pending'},
{'KS','CO','CLOSED BY COURT ORDER','Inactive'},
{'KS','CC','CLOSED BY ORDER OF BANK COMMISSIONER','Inactive'},
{'CA','F','CONDITIONALLY DISSOLVED (NO TAX CLEARANCE)','Inactive'},
{'CA','F','CONDITIONALLY DISSOLVED (NO TAX CLEARANCE)','Inactive'},
{'KS','JC','CONSENT TO JURSDICTION/STATUS NOT REQUIRED','<null> '},
{'MS','27','CONSOKIDATED INACTIVE','Inactive'},
{'AZ','Y','CONSOLID. WITH OTHER CORPORATION','Merged'},//'Merged!!
{'AR','15','CONSOLIDATED','Merged'},//'??
{'CT','CS','CONSOLIDATED','Merged'},//'??
{'DC','CO','CONSOLIDATED','Merged'},//'??
{'GA','35','CONSOLIDATED','Merged'},//'??
{'MD','C','CONSOLIDATED','Merged'},//'??
{'ME','CON','CONSOLIDATED','Merged'},//'??
{'NC','21','CONSOLIDATED','Merged'},//'??
{'NM','CO','CONSOLIDATED','Merged'},//'??
{'OK','11','CONSOLIDATED','Merged'},//'??
{'RI','','CONSOLIDATED','Merged'},//'??
{'TX','15','CONSOLIDATED','Merged'},//'??
{'WI','CNS','CONSOLIDATED - NON-SURVIVOR','Inactive'},//'??
{'WI','CNS','CONSOLIDATED -- NON-SURVIVOR','Inactive'},//'??
{'AK','27','CONSOLIDATED INACTIVE','Inactive'},//'??
{'MO','27','CONSOLIDATED INACTIVE','Inactive'},//'??
{'NH','27','CONSOLIDATED INACTIVE','Inactive'},//'??
{'ND','C','CONSOLIDATED WITH ANOTHER ORGANIZATION','Merged'},//'??
{'ID','L','CONSOLIDATION','Merged'},//'??
{'UT','14','CONSOLIDATION','Merged'},//'??
{'VA','98','CONV FOREIGN/DOMESTIC','Active'},//'
{'VA','22','CONV NATL BANK','Active'},//'
{'IL','10','CONVERSION','Active'},//'
{'ME','COV','CONVERSION','Active'},//'
{'MT','CNV','CONVERSION','Active'},//'
{'RI','','CONVERSION','Active'},//'
{'ND','CV','CONVERSION TO ALTERNATE CORP TYPE','Active'},//'
{'NV','NO CODE -Description from Raw File','CONVERT OUT','<null> '},//'??
{'AK','9','CONVERTED','Active'},//'
{'AR','14','CONVERTED','Active'},//'
{'CO','','CONVERTED','Active'},//'
{'CT','CV','CONVERTED','Active'},//'
{'GA','48','CONVERTED','Active'},//'
{'HI','NO CODE -Description from Raw File','CONVERTED','Active'},//'
{'ID','K','CONVERTED','Active'},//'
{'KS','CV','CONVERTED','Active'},//'
{'MO','9','CONVERTED','Active'},//'
{'MS','9','CONVERTED','Active'},//'
{'NC','9','CONVERTED','Active'},//'
{'NH','9','CONVERTED','Active'},//'
{'OK','10','CONVERTED','Active'},//'
{'TX','14','CONVERTED','Active'},//'
{'VA','46','CONVERTED','Active'},//'
{'VA','45','CONVERTED ADM','Active'},//'
{'CA','0','CONVERTED OUT','Active'},//'
{'CA','O','CONVERTED OUT','Active'},//'
{'KS','CN','CONVERTED TO NATIONAL/FEDERAL','Active'},//'
{'AZ','H','CORPORATE LIFE EXPIRED','Inactive'},//'
{'KS','AA','CORPORATION IS ACTIVE AND IN GOOD STANDING','Active'},//'
{'KS','DD','CORPORATION IS DELINQUENT','Pending'},//'Deliquent - Risk?! 
{'KS','PP','CORPORATION IS PENDING','Pending'},//'
{'KS','RP','CORPORATION IS REINSTATING','Pending'},//'
{'NM','TC','CORPORATION TAX CLEARANCE','<null> '},//'
{'PA','9','COUNTY ORPHAN','<null> '},//'
{'NC','16','COURT ORDERED DISSOLUTION','Inactive'},//'
{'NH','33','CREATION INACTIVE','Inactive'},//'
{'KY','C','CROSS REFERENCE','<null> '},//'Interesting - linkage? 
{'ID','C','CURRENT','Active'},//'
{'NC','2','CURRENT-ACTIVE','Active'},//'
{'LA','A','CURRENTLY ACTIVE IN SECRETARY OF STATE RECORDS','Active'},
{'LA','I','CURRENTLY INACTIVE IN SECRETARY OF STATE RECORDS','Inactive'},
{'IA','D','DEAD/INACTIVE','Inactive'},
{'IA','D','DEAD/INACTIVE; ACTIVE','<null> '},//'???
{'IA','D','DEAD/INACTIVE; ANNUAL/BIENNIAL REPORT NOT FILED','Inactive'},//'
{'IA','D','DEAD/INACTIVE; CONSOLIDATION','Inactive'},
{'IA','D','DEAD/INACTIVE; DISSOLUTION','Inactive'},
{'IA','D','DEAD/INACTIVE; EXPIRED','Inactive'},//'Expired
{'IA','D','DEAD/INACTIVE; MERGED','Inactive'},//'Merger
{'IA','D','DEAD/INACTIVE; NO REGISTERED AGENT ON FILE','Inactive'},//'
{'IA','D','DEAD/INACTIVE; OTHER','Inactive'},//'
{'IA','D','DEAD/INACTIVE; REVOKED','Inactive'},//'
{'UT','','DECEASED-FAILURE TO FILE RENEWAL','Inactive'},//'
{'UT','','DECLINED','Inactive'},//'
{'NV','NO CODE -Description from Raw File','DEFAULT','<null> '},//'
{'MT','DED','DELAYED EFFECTIVE DATE','Pending'},//'
{'AZ','N','DELETE NO-RECORD TO REFERENCE','Inactive'},//'
{'AR','20','DELETED','Inactive'},//'
{'CA','8','DELETED','Inactive'},//'
{'IL','D','DELETED','Inactive'},//'
{'OK','14','DELETED','Inactive'},//'
{'TX','20','DELETED','Inactive'},//'
{'CO','','DELINQUENT','Delinquent'},//'
{'IL','2','DELINQUENT','Delinquent'},//'
{'TX','5','DELINQUENT','Delinquent'},//'
{'UT','18','DELINQUENT','Delinquent'},//'
{'UT','','DELINQUENT','Delinquent'},//'
{'WI','DLQ','DELINQUENT','Delinquent'},//'
{'WI','LQ','DELINQUENT','Delinquent'},//'
{'AZ','W','DELINQUENT - OTHER','Delinquent'},//'
{'AZ','L','DELINQUENT AMENDMENT PUBLICATION','Delinquent'},//'
{'AZ','20','DELINQUENT ANNUAL REPORT','Delinquent'},//'
{'AZ','I','DELINQUENT ANNUAL REPORT','Delinquent'},//'
{'AZ','C','DELINQUENT BAD CHECK','Delinquent'},//'Bad Check to state!!
{'AZ','Q','DELINQUENT CORP LIFE EXPIRED','Inactive'},//'
{'AZ','P','DELINQUENT DISCLOSURE','Delinquent'},//'
{'AZ','U','DELINQUENT INCOMPLETE DISSOLUTION/WITHDRAWAL','Delinquent'},//'
{'AZ','O','DELINQUENT MERGER PUBLICATION','Delinquent'},//'
{'AZ','K','DELINQUENT PUBLICATION','Delinquent'},//'
{'AZ','J','DELINQUENT STATUTORY AGENT','Delinquent'},//'
{'AZ','D','DELINQUENT UNDELIVERABLE ADDRESS','Delinquent'},//'Bad Addr filed with state
{'UT','','DELINQUENT-ADMINISTRATIVE','Delinquent'},//'
{'UT','','DELINQUENT-ANNUAL REPORT','Delinquent'},//'
{'UT','','DELINQUENT-FAILURE TO FILE RENEWAL','Delinquent'},//'
 {'CO','','\"DESIGN, PRODUCTION AND SALES OF VINTAGE-INSPIRED CHILDREN\'S\"','<null> '},//'
{'CT','D','DISABLED','<null> '},//'I wonder if this relates to the data Shellnut's getting
{'GA','4','DISAPPROVED FILING','<null> '},//'
{'CA','B','DISHONORED CHECK','<null> '},//'Bad check to state!!
{'GA','36','DISS./CANCEL/TERMINAT','Inactive'},//'
{'MT','DSC','DISSOCIATION','Active'},//'Note - these usually REMOVE a MEMBER from an LLC!
{'MT','DSM','DISSOCIATION OF MEMBER','Active'},//'Note - these usually REMOVE a MEMBER from an LLC!
{'MT','DIS','DISSOLUTION','Inactive'},//'
{'SC','','DISSOLUTION','Inactive'},//'
{'SD','DS','DISSOLUTION','Inactive'},//'
{'WV','19','DISSOLUTION BY COURT ORDER','Inactive'},//'
{'WV','','DISSOLUTION BY COURT ORDER','Inactive'},//'
{'NM','DH','DISSOLUTION HEARING','Inactive'},//'
{'AZ','22','DISSOLVE IN PROGRESS','Inactive'},//'
{'AK','2','DISSOLVED','Inactive'},//'
{'AK','3','DISSOLVED','Inactive'},//'
{'AK','8','DISSOLVED','Inactive'},//'
{'AK','11','DISSOLVED','Inactive'},//'
{'AK','24','DISSOLVED','Inactive'},//'
{'AK','27','DISSOLVED','Inactive'},//'
{'AK','29','DISSOLVED','Inactive'},//'
{'AK','30','DISSOLVED','Inactive'},//'
{'AK','41','DISSOLVED','Inactive'},//'
{'AK','44','DISSOLVED','Inactive'},//'
{'AK','45','DISSOLVED','Inactive'},//'
{'AK','46','DISSOLVED','Inactive'},//'
{'AL','D','DISSOLVED','Inactive'},//'
{'AR','7','DISSOLVED','Inactive'},//'
{'CA','6','DISSOLVED','Inactive'},//'
{'CA','D','DISSOLVED','Inactive'},//'
{'CT','D','DISSOLVED','Inactive'},//'
{'DC','DS','DISSOLVED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','DISSOLVED','Inactive'},//'
{'ID','D','DISSOLVED','Inactive'},//'
{'IL','8','DISSOLVED','Inactive'},//'Co dissolved - defunct
{'KS','LY','DISSOLVED','Inactive'},//'
{'MD','D','DISSOLVED','Inactive'},//'
{'ME','DIS','DISSOLVED','Inactive'},//'
{'MO','8','DISSOLVED','Inactive'},//'
{'MS','8','DISSOLVED','Inactive'},//'
{'NC','14','DISSOLVED','Inactive'},//'
{'NH','8','DISSOLVED','Inactive'},//'
{'NJ','DIS','DISSOLVED','Inactive'},//'
{'NV  ','NO CODE -Description from Raw File','DISSOLVED','Inactive'},//'
{'OK','4','DISSOLVED','Inactive'},//'
{'RI','','DISSOLVED','Inactive'},//'
{'SC','DIS','DISSOLVED','Inactive'},//'
{'TN','1','DISSOLVED','Inactive'},//'
{'UT','21','DISSOLVED','Inactive'},//'
{'WI','DIS','DISSOLVED','Inactive'},//'
{'WI','DS','DISSOLVED','Inactive'},//'
{'WV','7','DISSOLVED','Inactive'},//'
{'WV','','DISSOLVED','Inactive'},//'

{'CO','','DISSOLVED (TERM EXPIRED)','Inactive'},//'
{'NJ','DBB','DISSOLVED BEFORE COMMENCING BUSINESS','Inactive'},//'
{'MO','32','DISSOLVED NONPROFIT','Inactive'},//'
{'NJ','DPP','DISSOLVED PENDING DISSOLUTION','Inactive'},//'
{'NJ','DWA','DISSOLVED WITHOUT ASSETS','Inactive'},//'
{'WI','DNP','\"DISSOLVED, NAME PROTECTED\"','Inactive'},//'
{'WI','NP','\"DISSOLVED, NAME PROTECTED\"','Inactive'},//'
{'VA','14','DISSOLVING','Inactive'},//'
{'GA','11','DO NOT USE  Disapproved','Inactive'},//'
{'SD','DT','DOMESTIC BUSINESS DECLARATION OF TRUST','Active'},//'
{'AZ','T','DOMESTICATED SEE COMMENTS','Active'},//'
{'CO','NO CODE -Description from Raw File','EFFECTIVE','Active'},//'
{'CO','NO CODE -Description from Raw File','EFFECTIVENESS PREVENTED','<null> '},//'
{'GA','6','ELECTION TO LLC/LP','Active'},//'LLC or LP!!
{'SC','ELE-CORP','ELEEMOSYNARY INCORPORATION','<null> '},//'NPO or church
{'UT','','EMERITUS LICENSE-CANCELED','<null> '},//'
{'UT','','EMERITUS LICENSE-VOLUNTARILY DISSOLVED','<null> '},//'
{'TX','15','ENTITY DELETED','Inactive'},//'
{'TX','14','ENTITY INACTIVE','Inactive'},//'
{'MT','ERR','ERROR CORRECTION','<null> '},//'
{'ME','EXC','EXCUSED','<null> '},//'
{'NM','EX','EXEMPT','<null> '},//'
{'NM','EE','EXISTENCE EXPIRED AUTOMATICALLY','Inactive'},//'
{'ID','Y','EXISTING','Active'},//'
{'CO','NO CODE -Description from Raw File','EXISTS','Active'},//'
{'WV','26','EXPIRATION OF TERM','Inactive'},//'
{'AR','11','EXPIRED','Inactive'},//'
{'CO','NO CODE -Description from Raw File','EXPIRED','Inactive'},//'
{'CT','EX','EXPIRED','Inactive'},//'
{'DC','EXP','EXPIRED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','EXPIRED','Inactive'},//'
{'ID','E','EXPIRED','Inactive'},//'
{'IL','6','EXPIRED','Inactive'},//'
{'IL','11','EXPIRED','Inactive'},//'
{'KS','EV','EXPIRED','Inactive'},//'
{'ME','EXP','EXPIRED','Inactive'},//'
{'MI','O','EXPIRED','Inactive'},//'
{'MT','EXP','EXPIRED','Inactive'},//'
{'NC','20','EXPIRED','Inactive'},//'
{'ND','E','EXPIRED','Inactive'},//'
{'NH','38','EXPIRED','Inactive'},//'
{'OK','7','EXPIRED','Inactive'},//'
{'PA','41','EXPIRED','Inactive'},//'
{'RI','','EXPIRED','Inactive'},//'
{'SC','EXP','EXPIRED','Inactive'},//'
{'SD','EX','EXPIRED','Inactive'},//'
{'TX','6','EXPIRED','Inactive'},//'
{'TX','11','EXPIRED','Inactive'},//'
{'TX','12','EXPIRED','Inactive'},//'
{'UT','','EXPIRED','Inactive'},//'
{'NV','NO CODE -Description from Raw File','EXPIRED','Inactive'},//'
{'AK','42','EXPIRED - FOREIGN NAME','Inactive'},//'Foreign Name (out of state co)
{'AK','43','EXPIRED - REGISTRATION','Inactive'},//'Biz reg - or name reg?
{'AK','44','EXPIRED - RESERVED NAME','Inactive'},//'Biz reg - or name reg?
{'KS','ES','EXPIRED CHARITABLE ORGANIZATION -- FAILED TO REFILE         ','Inactive'},//'
{'WI','EXP','EXPIRED FOREIGN REGISTERED NAME','Inactive'},//'
{'MS','43','EXPIRED NAME','<null> '},//'
{'GA','47','EXPIRED NAME RESERVATION','<null> '},//'
{'KS','EN','EXPIRED NAME RESERVATION','<null> '},//'
{'CT','ER','EXPIRED RESERVATION','Inactive'},//'
{'CT','RS','EXPIRED RESERVATION','Inactive'},//'
{'UT','','EXPIRED-ADMIN. ACTIVATION (SEE COMMENTS)','Inactive'},//'
{'UT','','EXPIRED-ADMINISTRATIVE','Inactive'},//'
{'UT','','EXPIRED-AMENDED','Inactive'},//'
{'UT','','EXPIRED-ANNUAL REPORT','Inactive'},//'
{'UT','','EXPIRED-APPLICATION RE-SUBMITTED (FOR LICENSURE)','Inactive'},//'
{'UT','','EXPIRED-APPLICATION SUBMITTED (FOR LICENSURE)','Inactive'},//'
{'UT','','EXPIRED-BCI CHECK APPROVED','Inactive'},//'
{'UT','','EXPIRED-BUSINESS SOLD','Inactive'},//'
{'UT','','EXPIRED-BY USER REQUEST','Inactive'},//'
{'KS','EX','EXPIRED-CAN NOT ACCEPT AN ANNUAL REPORT','Inactive'},//'
{'UT','','EXPIRED-CANCELED','Inactive'},//'
{'UT','','EXPIRED-CONSOLIDATED','Inactive'},//'
{'UT','','EXPIRED-CONVERSION','Inactive'},//'
{'UT','','EXPIRED-CREATION OF A DIFFERENT ENTITY','Inactive'},//'
{'UT','','EXPIRED-DEATH OF LICENSEE','Inactive'},//'
{'UT','','EXPIRED-DELINQUENT','Inactive'},//'
{'UT','','EXPIRED-DISSOLVED','Inactive'},//'
{'UT','','EXPIRED-DOMESTICATION','Inactive'},//'
{'UT','','EXPIRED-ENTITY TYPE CHANGE','Inactive'},//'
{'UT','','EXPIRED-EXPIRATION OF BOND','Inactive'},//'
{'UT','','EXPIRED-EXPIRATION OF NON-RENEWABLE APPR. LIC.','Inactive'},//'
{'UT','','EXPIRED-EXPIRED (AT DATA CONVERSION)','Inactive'},//'
{'UT','','EXPIRED-EXPIRED LICENSE RENEWAL','Inactive'},//'
{'UT','','EXPIRED-FAILURE TO FILE RENEWAL','Inactive'},//'
{'UT','','EXPIRED-FAILURE TO PAY MONIES DUE','Inactive'},//'
{'UT','','EXPIRED-FAILURE TO PAY RENEWAL FEES','Inactive'},//'
{'UT','','EXPIRED-FAILURE TO PAY TAXES','Inactive'},//'
{'UT','','EXPIRED-INCOMPLETE APPLICATION','Inactive'},//'
{'UT','','EXPIRED-INCOMPLETE RENEWAL FORM','Inactive'},//'
{'UT','','EXPIRED-INSURANCE CANCELLED (LICENSURE)','Inactive'},//'
{'UT','','EXPIRED-INVOL. CANC. / NO RENEWAL','Inactive'},//'
{'UT','','EXPIRED-INVOL. DISS / NO RENEWAL','Inactive'},//'
{'UT','','EXPIRED-LICENSE RENEWAL','Inactive'},//'
{'UT','','EXPIRED-LICENSE TRANSFERRED','Inactive'},//'
{'UT','','EXPIRED-MAINTAIN REGISTERED AGENT','Inactive'},//'
{'UT','','EXPIRED-MERGED','Inactive'},//'
{'UT','','EXPIRED-NO REGISTERED AGENT','Inactive'},//'
{'UT','','EXPIRED-NON RENEWAL','Inactive'},//'
{'UT','','EXPIRED-NOT ASSOCIATED WITH COMPANY','Inactive'},//'
{'UT','','EXPIRED-OWNER EXPIRED','Inactive'},//'
{'UT','','EXPIRED-REQUESTED CANCELLED STATUS','Inactive'},//'
{'UT','','EXPIRED-REQUESTED INACTIVE STATUS','Inactive'},//'
{'UT','','EXPIRED-RETURNED CHECK (APPLICATION)','Inactive'},//'
{'UT','','EXPIRED-REVOKED','Inactive'},//'
{'UT','','EXPIRED-REVOKED / NO RENEWAL','Inactive'},//'
{'UT','','EXPIRED-UPGRADE EXPIRATION','Inactive'},//'
{'UT','','EXPIRED-VOLUNTARILY DISSOLVED','Inactive'},//'
{'UT','','EXPIRED-VOLUNTARILY WITHDRAWN','Inactive'},//'
{'UT','','EXPIRED-VOLUNTARY - DISCIPLINARY','Inactive'},//'
{'UT','','EXPIRED-WITHDRAWL OF APPLICATION','Inactive'},//'
{'NJ','EXP','EXPUNGED','Inactive'},//'
{'NJ','XPG','EXPUNGED','Inactive'},//'
{'NJ','XNP','EXPUNGED (NON-PROFIT)','Inactive'},//'
{'NJ','XPG','EXPUNGED (SAME AS EXP)','Inactive'},//'
{'NJ','XFR','EXPUNGED FOREIGN','Inactive'},//'
{'ID','T','EXTENDED','<null> '},//'
{'SD','FQ','FARM QUALIFICATION','<null> '},//'
{'SD','FR','FARM REPORT','<null> '},//'
{'IL','7','FAS DELINQUENT','Delinquent'},//'
{'VA','1','FEE DELINQUENT','Delinquent'},//'
{'VA','2','FEE DELINQUENT FOLLOWING REINSTATEMENT','Delinquent'},//'
{'IL','3','FEIN DELINQUENT','Delinquent'},//'
{'IL','4','FEIN DELINQUENT','Delinquent'},//'
{'MO','35','FICTITIOUS ACTIVE','Active'},//'FBN?
{'MO','36','FICTITIOUS EXPIRED','Inactive'},//'FBN?
{'SD','FU','FIDUCIARY','<null> '},//'
{'ME','FIE','FILED IN ERROR','<null> '},//'
{'WI','FDE','\"FILED, DELAYED EFFECTIVE\"','Pending'},//' investigate it from spreadsheet.
{'KS','EE','FILING RESCINDED','<null> '},//'
{'GA','2','FLAWED/DEFICIENT','Pending'},//'
{'SC','','FOR PROFIT BUSINESS','<null> '},//'doesn't look like a status 
{'CA','7','FORFEITED','Inactive'},//'
{'CT','FF','FORFEITED','Inactive'},//'
{'ID','F','FORFEITED','Inactive'},//'
{'MD','F','FORFEITED','Inactive'},//'
{'MO','7','FORFEITED','Inactive'},//'
{'MS','7','FORFEITED','Inactive'},//'
{'MT','FOR','FORFEITED','Inactive'},//'
{'NH','7','FORFEITED','Inactive'},//'
{'NM','FF','FORFEITED','Inactive'},//'
{'RI','','FORFEITED','Inactive'},//'
{'KS','FQ','FORFEITED - BY ORDER OF BANK COMMISSION','Inactive'},//'Risk?! 
{'KS','FS','FORFEITED - FAILED TO CORRECT AND RETURN A/R','Inactive'},//'
{'KS','FU','FORFEITED - FAILED TO DESIGNATE A NEW RESIDENT AGENT','Inactive'},//'
{'KS','FR','FORFEITED - FAILED TO TIMELY FILE A/R','Inactive'},//'
{'KS','FI','FORFEITED - INSUFFICIENT FUNDS','Inactive'},//'Risk?! 
{'KS','FP','FORFEITED - PURSUANT TO STATE BOARD','Inactive'},//'
{'TX','6','FORFEITED EXISTENCE','Inactive'},//'
{'TX','4','FORFEITED RIGHTS','Inactive'},//'
{'KS','FT','FORFEITED-BY COURT ORDER','Inactive'},//'
{'SC','FOR','FORFEITURE','Inactive'},//'
{'SC','','FORFEITURE','Inactive'},//'
{'MD','P','FORFEITURE PENDING','Pending'},//'
{'SD','GP','GENERAL PARTNERSHIP','Active'},//'status?
{'KS','EG','GENERAL PARTNERSHIP EXPIRED','Inactive'},//'Expired
{'KS','GR','GENERAL PARTNERSHIP REGISTERED','Active'},//'Partnership?
{'AR','1','GOOD STANDING','Active'},//'
{'CO','NO CODE -Description from Raw File','GOOD STANDING','Active'},//'
{'ID','G','GOOD STANDING','Active'},//'
{'IL','0','GOOD STANDING','Active'},//'
{'ME','VGS','GOOD STANDING','Active'},//'
{'MO','3','GOOD STANDING','Active'},//'
{'MS','3','GOOD STANDING','Active'},//'
{'MT','GDS','GOOD STANDING','Active'},//'
{'NH','3','GOOD STANDING','Active'},//'
{'SC','GDS','GOOD STANDING','Active'},//'
{'SC','','GOOD STANDING','Active'},//'
{'SC','GDS','GOOD STANDING CERTIFICATE','Active'},//'
{'ID','Z','HISTORICAL','Inactive'},//'
{'KY','H','HISTORICAL COMPANIES','Inactive'},//'
{'UT','','HOME STATE','<null> '},//'
{'OK','16','IMPENDING OUSTER','Pending'},//'
{'WI','IBS','IN BAD STANDING','Inactive'},//'
{'OK','1','IN EXISTENCE','Active'},//'
{'TX','1','IN EXISTENCE','Active'},//'
{'OH','A','IN GOOD STANDING','Active'},//'
{'AK','5','IN PROCESS','Pending'},//'
{'MO','5','IN PROCESS','Pending'},//'
{'MS','5','IN PROCESS','Pending'},//'
{'NH','5','IN PROCESS','Pending'},//'
{'WI','COM','\"IN PROCESS, NOT YET FILED\"','Pending'},
{'KS','EG','GENERAL PARTNERSHIP EXPIRED','Inactive'},//'Expired
{'KS','GR','GENERAL PARTNERSHIP REGISTERED','Active'},//'Partnership?
{'AR','1','GOOD STANDING','Active'},//'
{'CO','NO CODE -Description from Raw File','GOOD STANDING','Active'},//'
{'ID','G','GOOD STANDING','Active'},//'
{'IL','0','GOOD STANDING','Active'},//'
{'ME','VGS','GOOD STANDING','Active'},//'
{'MO','3','GOOD STANDING','Active'},//'
{'MS','3','GOOD STANDING','Active'},//'
{'MT','GDS','GOOD STANDING','Active'},//'
{'NH','3','GOOD STANDING','Active'},//'
{'SC','GDS','GOOD STANDING','Active'},//'
{'SC','','GOOD STANDING','Active'},//'
{'SC','GDS','GOOD STANDING CERTIFICATE','Active'},//'
{'ID','Z','HISTORICAL','Inactive'},//'
{'KY','H','HISTORICAL COMPANIES','Inactive'},//'
{'UT','','HOME STATE','<null> '},//'
{'OK','16','IMPENDING OUSTER','Pending'},//'
{'WI','IBS','IN BAD STANDING','Inactive'},//'
{'OK','1','IN EXISTENCE','Active'},//'
{'TX','1','IN EXISTENCE','Active'},//'
{'OH','A','IN GOOD STANDING','Active'},//'
{'AK','5','IN PROCESS','Pending'},//'
{'MO','5','IN PROCESS','Pending'},//'
{'MS','5','IN PROCESS','Pending'},//'
{'NH','5','IN PROCESS','Pending'},//'
{'WI','COM','\"IN PROCESS, NOT YET FILED\"','Pending'},//'
{'ND','R','IN RECEIVERSHIP','Inactive'},//'
{'TX','1','IN USE','<null> '},//'assuming a name reservation 
{'CA','9','INACTIVE','Inactive'},//'
{'FL','I','INACTIVE','Inactive'},//'
{'GA','42','INACTIVE','Inactive'},//'
{'IN','3','INACTIVE','Inactive'},//'
{'KY','I','INACTIVE','Inactive'},//'
{'LA','I','INACTIVE','Inactive'},//'
{'MA','N','INACTIVE','Inactive'},//'
{'MD','N','INACTIVE','Inactive'},//'
{'MI','1','INACTIVE','Inactive'},//'
{'MI','1','INACTIVE','Inactive'},//'
{'MI','\"1,O\"','INACTIVE','Inactive'},//'
{'MI','CC','INACTIVE','Inactive'},//'
{'MI','CD','INACTIVE','Inactive'},//'
{'MI','FN','INACTIVE','Inactive'},//'
{'MI','O','INACTIVE','Inactive'},//'
{'MN','ANI','INACTIVE','Inactive'},//'
{'MN','BTI','INACTIVE','Inactive'},//'
{'MN','DCI','INACTIVE','Inactive'},//'
{'MN','FCI','INACTIVE','Inactive'},//'
{'MN','FLI','INACTIVE','Inactive'},//'
{'MN','I','INACTIVE','Inactive'},//'
{'MN','LPI','INACTIVE','Inactive'},//'
{'MN','MLI','INACTIVE','Inactive'},//'
{'MN','NLI','INACTIVE','Inactive'},//'
{'MN','NPI','INACTIVE','Inactive'},//'
{'MN','RLI','INACTIVE','Inactive'},//'
{'MN','RNI','INACTIVE','Inactive'},//'
{'MN','TMI','INACTIVE','Inactive'},//'
{'MO','4','INACTIVE','Inactive'},//'
{'MS','4','INACTIVE','Inactive'},//'
{'ND','I','INACTIVE','Inactive'},//'
{'NE','I','INACTIVE','Inactive'},//'
{'NH','4','INACTIVE','Inactive'},//'
{'NY','','INACTIVE','Inactive'},//'
{'OK','20','INACTIVE','Inactive'},//'
{'OR ','NO CODE -Description from Raw File','INACTIVE','Inactive'},//'
{'PA','31','INACTIVE','Inactive'},//'
{'TX','3','INACTIVE','Inactive'},//'
{'TX','23','INACTIVE','Inactive'},//'
{'TX','','INACTIVE','Inactive'},//'
{'UT','I','INACTIVE','Inactive'},//'
{'VT','I','INACTIVE','Inactive'},//'
{'WA','T','INACTIVE','Inactive'},//'
{'WV','','INACTIVE','Inactive'},//'
{'WY','2','INACTIVE','Inactive'},//'
{'WY','','INACTIVE - ADMINISTRATIVELY DISSOLVED (NO AGENT)','Inactive'},//'
{'WY','','INACTIVE - ADMINISTRATIVELY DISSOLVED (OTHER)','Inactive'},//'
{'WY','','INACTIVE - ADMINISTRATIVELY DISSOLVED (TAX)','Inactive'},//'
{'TN','','INACTIVE - BANK','Inactive'},//'
{'TN','','INACTIVE - CANCELLED','Inactive'},//'
{'WY','','INACTIVE - CANCELLED','Inactive'},//'
{'MI','1','INACTIVE - CERTIFICATE OF CONVERSION','Inactive'},//'
{'MI','\"1,CV\"','INACTIVE - CERTIFICATE OF CONVERSION','Inactive'},//'
{'MI','CV','INACTIVE - CERTIFICATE OF CONVERSION','Inactive'},//'
{'MI','1','INACTIVE - CERTIFICATE OF WITHDRAWAL','Inactive'},//'
{'MI','\"1,CW\"','INACTIVE - CERTIFICATE OF WITHDRAWAL','Inactive'},//'
{'MI','CW','INACTIVE - CERTIFICATE OF WITHDRAWAL','Inactive'},//'
{'MI','CM','INACTIVE - CONSENT OF MEMBERS','Inactive'},//'
{'WY','','INACTIVE - CONSOLIDATED','Inactive'},//'
{'TN','','INACTIVE - CONVERTED','Inactive'},//'
{'WY','','INACTIVE - CONVERTED','Inactive'},//'
{'MI','1','INACTIVE - COURT ORDER','Inactive'},//'
{'MI','\"1,CO\"','INACTIVE - COURT ORDER','Inactive'},//'
{'MI','CO','INACTIVE - COURT ORDER','Inactive'},//'
{'WY','','INACTIVE - DISSOLVED','Inactive'},//'
{'TN','','INACTIVE - DISSOLVED (ADMINISTRATIVE)','Inactive'},//'
{'TN','','INACTIVE - DISSOLVED (JUDICIAL)','Inactive'},//'
{'TN','','INACTIVE - DISSOLVED (NO AGENT)','Inactive'},//'
{'TN','','INACTIVE - EXPIRED','Inactive'},//'
{'WY','','INACTIVE - EXPIRED','Inactive'},//'
{'TX','','INACTIVE - if inactive date field filled and valid','Inactive'},//'
{'MI','AR','INACTIVE - MCLA 450.4106','Inactive'},//'
{'MI','1','INACTIVE - MCLA 450.5104(4)','Inactive'},//'
{'MI','\"1,DC\"','INACTIVE - MCLA 450.5104(4)','Inactive'},//'
{'MI','DC','INACTIVE - MCLA 450.5104(4)','Inactive'},//'
{'TN','','INACTIVE - MERGED','Merged'},//'
{'WY','','INACTIVE - MERGED','Merged'},//'
{'MI','1','INACTIVE - MERGER','Merged'},//'
{'MI','\"1,ME\"','INACTIVE - MERGER','Merged'},//'
{'MI','ME','INACTIVE - MERGER','Merged'},//'
{'MI','1','INACTIVE - OTHER','Inactive'},//'
{'MI','\"1,OT\"','INACTIVE - OTHER','Inactive'},//'
{'MI','OT','INACTIVE - OTHER','Inactive'},//'
{'MI','1','INACTIVE - RESCINDED','Inactive'},//'
{'MI','RE','INACTIVE - RESCINDED','Inactive'},//'
{'TN','','INACTIVE - REVOKED (ADMINISTRATIVE)','Inactive'},//'
{'TN','E','INACTIVE - REVOKED (LABOR & WORKFORCE DEPT)','Inactive'},//'
{'TN','','INACTIVE - REVOKED (LABOR & WORKFORCE DEPT)','Inactive'},//'
{'WY','','INACTIVE - REVOKED (NO AGENT)','Inactive'},//'
{'TN','','INACTIVE - REVOKED (REVENUE)','Inactive'},//'
{'WY','','INACTIVE - REVOKED (TAX)','Inactive'},//'
{'MI','SE','INACTIVE - SPECIFIED EVENT','Inactive'},//'
{'MI','1','INACTIVE - TERM EXPIRATION','Inactive'},//'
{'MI','\"1,TE\"','INACTIVE - TERM EXPIRATION','Inactive'},//'
{'MI','TE','INACTIVE - TERM EXPRIATION','Inactive'},//'
{'MI','TM','INACTIVE - TERM OF MEMBERS','Inactive'},//'
{'TN','','INACTIVE - TERMINATED','Inactive'},//'
{'WY','','INACTIVE - TRANSFER','Inactive'},//'
{'WY','','INACTIVE - WITHDRAW/DISSOLVE/CANCEL','Inactive'},//'
{'WY','','INACTIVE - WITHDRAWAL','Inactive'},//'
{'TN','','INACTIVE - WITHDRAWN','Inactive'},//'
{'IA','D','INACTIVE (DEAD)','Inactive'},//'
{'NY','','INACTIVE / Depends on Certificate Code','Inactive'},//'
{'GA','37','INACTIVE LIMITED PARTNERS','Inactive'},//'
{'WA','T','INACTIVE OR DISSOLVED','Inactive'},//'
{'WV','14','INACTIVE/DECREE OF COURT','Inactive'},//'
{'WV','','INACTIVE/DECREE OF COURT','Inactive'},//'
{'WV','15','INACTIVE/MERGER','Inactive'},//'
{'WV','','INACTIVE/MERGER','Inactive'},//'
{'WV','16','INACTIVE/NAME CHANGE','Inactive'},//'
{'WV','','INACTIVE/NAME CHANGE','Inactive'},//'
{'UT','','INACTIVE-ADMINISTRATIVE','Inactive'},//'
{'UT','','INACTIVE-INCOMPLETE APPLICATION','Inactive'},//'
{'ME','DEA','INACTIVE-UNKNOWN REASON','Inactive'},//'
{'UT','','INACTIVE-WITHDRAWL OF APPLICATION','Inactive'},//'
{'KS','IF','INCOMPLETE FILING -- NEVER ACTIVATED','Inactive'},//'
{'MD','I','INCORPORATED','Active'},//'Incorporation
{'MD','X','INCORPORATED PRIOR TO 12/27/1977','<null> '},//'state of MD got a new system in 1977 =)
{'WI','INC','INCORPORATED/QUALIFIED','Active'},//'status?  
{'WI','NC','INCORPORATED/QUALIFIED','Active'},//'
{'ME','INF','INFORMATIONAL STATUS','<null> '},//'
{'SC','INT','INTENT','Pending'},//'
{'SC','INT','INTENT','Pending'},//'
{'MS','35','INTENT DISSOLVE:RA/T/AR','Pending'},//'
{'AK','40','INTENT TO DISSOLVE','Pending'},//'
{'IL','2','INTENT TO DISSOLVE','Pending'},//'
{'TN','I','INTENT TO DISSOLVE','Pending'},//'
{'MS','30','INTENT TO DISSOLVE - AR','Pending'},//'
{'MS','31','INTENT TO DISSOLVE - RA','Pending'},//'
{'MS','29','INTENT TO DISSOLVE - TAX','Pending'},//'
{'MT','IVD','INTENT TO DISSOLVE INVOLUNTARILY','Pending'},//'
{'MT','INT','INTENT TO DISSOLVE VOLUNTARILY','Pending'},//'
{'MS','34','INTENT TO DISSOLVE: AR/T','Pending'},//'
{'MS','33','INTENT TO DISSOLVE: RA/AR','Pending'},//'
{'MS','32','INTENT TO DISSOLVE: RA/T','Pending'},//'
{'MT','IVR','INTENT TO REVOKE CERT OF AUTHORITY','Pending'},//'
{'HI','NO CODE -Description from Raw File','INV. CANCELLED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','INV. DISSOLVED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','INV. REVOKED','Inactive'},//'
{'VA','8','INVCAN/COURT','Inactive'},//'
{'VA','16','INVDISS/COURT','Inactive'},//'
{'TX','8','INVOLUNTARILY DISSOLVED','Inactive'},//'
{'WI','IDS','INVOLUNTARILY DISSOLVED','Inactive'},//'
{'ND','I','INVOLUNTARILY DISSOLVED OR TERMINATED','Inactive'},//'
{'NM','IS','INVOLUNTARILY STRICKEN','Inactive'},//'
{'IL','9','INVOLUNTARY DISSOLUTION','Inactive'},//'Invol dissolut?
{'IL','12','INVOLUNTARY DISSOLUTION','Inactive'},//'
{'MT','INV','INVOLUNTARY DISSOLUTION','Inactive'},//'
{'GA','10','INVOLUNTARY DISSOLUTON 5','Inactive'},//'
{'AK','30','INVOLUNTARY DISSOLVED','Inactive'},//'
{'VA','9','INVTERM/COURT','Inactive'},//'
{'GA','49','JUDICIAL DISSOLUTION','Inactive'},//'
{'NC','19','JUDICIAL DISSOLUTION','Inactive'},//'
{'TN','8','JUDICIAL DISSOLVED','Inactive'},//'
{'AR','9','JUDICIALLY DISSOLVED','Inactive'},//'
{'CO','','JUDICIALLY DISSOLVED','Inactive'},//'
{'IN','9','JUDICIALLY DISSOLVED','Inactive'},//'
{'OK','5','JUDICIALLY DISSOLVED','Inactive'},//'
{'TX','9','JUDICIALLY DISSOLVED','Inactive'},//'
{'KY','K','KENTUCKY GOV. FAST TRACK FILING - NOT YET APPROVED','Pending'},//'
{'NM','LF','LATE-FILER','<null> '},//'
{'TX','18','LAW REPEALED','<null> '},//'
{'SD','LT','LETTER','<null> '},//'
{'SC','LLC','LIMITED LIABILITY CORPORATION','Active'},//'these are not statuses - rather incorp types
{'SC','','LIMITED PARTNERSHIP','Active'},//'these are not statuses - rather incorp types
{'SC','LP','LIMITED PARTNERSHIP','Active'},//'these are not statuses - rather incorp types
{'SD','LP','LIMITED PARTNERSHIP','Active'},//'these are not statuses - rather incorp types
{'SC','','LLP','Active'},//'these are not statuses - rather incorp types
{'ID','S','LLP REVOKED','Inactive'},//'
{'GA','13','MANUAL ADMINISTRATIVE DIS','Inactive'},//'
{'PA','39','MERGE','Merged'},//'
{'AK','24','MERGED','Merged'},//'
{'AL','M','MERGED','Merged'},//'Merged!!
{'AR','13','MERGED','Merged'},//'Merged!!
{'CO','NO CODE -Description from Raw File','MERGED','Merged'},//'Merged!!
{'CT','M','MERGED','Merged'},//'Merged!!
{'DC','MG','MERGED','Merged'},//'Merged!!
{'GA','38','MERGED','Merged'},//'Merged!!
{'HI','NO CODE -Description from Raw File','MERGED','Merged'},//'Merged!!
{'IL','9','MERGED','Merged'},//'Merged! 
{'IL','10','MERGED','Merged'},//'Merged! 
{'IN','8','MERGED','Merged'},//'Merged?! 
{'MD','M','MERGED','Merged'},//'Merged! 
{'ME','MER','MERGED','Merged'},//'
{'MO','24','MERGED','Merged'},//'
{'MS','24','MERGED','Merged'},//'
{'NC','24','MERGED','Merged'},//'
{'NH','24','MERGED','Merged'},//'
{'NJ','MRG','MERGED','Merged'},//'
{'OK','9','MERGED','Merged'},//'
{'PA','33','MERGED','Merged'},//'
{'TN','4','MERGED','Merged'},//'
{'TX','13','MERGED','Merged'},//'
{'VA','20','MERGED','Merged'},//'
{'VA','21','MERGED - DELINQUENT','Merged'},//'
{'WI','MGD','MERGED - NON-SURVIVOR','Inactive'},//'
{'WI','MGD','MERGED -- NON-SURVIVOR','Inactive'},//'
{'SD','MD','MERGED (OUT OF EXISTENCE)','Inactive'},//'
{'RI','','MERGED INTO AN ENTITY OF RECORD','Inactive'},//'
{'CA','C','MERGED OUT','Inactive'},//'Merged!!
{'CA','M','MERGED OUT','Inactive'},//'Merged!!
{'ID','X','MERGED OUT','Inactive'},//'
{'KS','MX','MERGED OUT OF EXISTENCE','Inactive'},//'Merged! 
{'MT','MRN','MERGED OUT TO UNQUALIFIED CORP/CO','Inactive'},//'
{'AZ','A','MERGED WITH OTHER CORPORATION','Inactive'},//'Merged!!
{'NM','MG','MERGED-OUT','Inactive'},//'
{'SC','MER','MERGER','Merged'},//'
{'SC','','MERGER','Merged'},//'
{'WV','1','MERGER','Merged'},//'
{'WV','10','MERGER','Merged'},//'
{'WV','','MERGER','Merged'},//'
{'SD','ME','MERGER (SURVIVOR)','Merged'},//'
{'WI','GD','MERGER-NON-SURVIVOR','Inactive'},//'
{'SD','MS','MISCELLANEOUS','<null> '},//'
{'NC','22','MULTIPLE','<null> '},//'
{'MS','42','NAME CHANGE','Active'},//'Name v Incorp?
{'SD','NC','NAME CHANGE','Active'},//'
{'WV','22','NAME CHANGE','Active'},//'
{'WI','CNF','NAME CONFLICT','<null> '},//'
{'WI','CMC','NAME CONSENT REQUIRED','<null> '},//'
{'WI','RGL','\"NAME REGISTERED, LONG-TERM\"','<null> '},//'
{'RI','','NAME REGISTRATION','<null> '},//'
{'SC','REG','NAME REGISTRATION','<null> '},//'
{'KS','NN','NAME RESERVATION','<null> '},//'
{'RI','','NAME RESERVATION','<null> '},//'
{'GA','45','NAME RESERVATION - 90 DAY','<null> '},//'
{'PA','32','NAME RESERVATION EXPIRATION','<null> '},//'
{'GA','44','NAME RESERVATION REJECTED','<null> '},//'
{'WI','RLT','\"NAME RESERVED, LONG-TERM\"','<null> '},//'
{'WI','PND','\"NAME RESERVED, NOT YET FILED\"','<null> '},//'
{'WI','RES','\"NAME RESERVED, SHORT-TERM\"','<null> '},//'
{'KY','N','NEW COMPANY - NOT YET VERIFIED ','Pending'},//'
{'NM','NC','NEW CORPORATION','Active'},//'
{'SC','NAG','NO AGENT','<null> '},//'
{'IL','5','NO BIENNUAL REPORT FILED','<null> '},//'
{'PA','37','NON QUALIFIED','<null> '},//'
{'IL','8','NON-COMPLIANCE','<null> '},//'
{'CO','NO CODE -Description from Raw File','NONCOMPLIANT','<null> '},//'
{'NM','NF','NON-FILER','<null> '},//'
{'LA','P','NON-LOUISIANA CORPORATION HAS A PENDING WITHDRAWAL','Pending'},//'
{'AK','25','NON-QUALIFIED','<null> '},//'
{'MO','25','NON-QUALIFIED','<null> '},//'
{'MS','25','NON-QUALIFIED','<null> '},//'
{'NH','25','NON-QUALIFIED','<null> '},//'
{'GA','46','NON-QUALIFYING','<null> '},//'
{'SC','','NOT ABLE TO MAINTAIN REGISTERED AGENT','<null> '},//'
{'AR','5','NOT CURRENT','Inactive'},//'
{'IL','2','NOT IN GOOD STANDING','Inactive'},//'
{'ME','NGS','NOT IN GOOD STANDING','Inactive'},//'
{'ND','N','NOT IN GOOD STANDING','Inactive'},//'
{'NH','28','NOT IN GOOD STANDING','Inactive'},//'
{'OH','D','NOT IN GOOD STANDING','Inactive'},//'
{'RI','','NULL','<null> '},//'
{'NH','31','OBJECTION','<null> '},//'
{'DC','OA','OLD ACT','<null> '},//'
{'MO','28','ORDERED DISSOLVED','Inactive'},//'
{'WI','ORG','ORGANIZED','Active'},//'
{'OK','18','OTC SUSPENSION','Pending'},//'
{'OK','21','OUSTED','Inactive'},//'
{'NH','39','PARENT/OWNER DISSOLVED','Inactive'},//'
{'OK','15','PAST DUE REPORT','Pending'},//'
{'AR','24','PENDING','Pending'},//'
{'DC','PD','PENDING','Pending'},//'
{'GA','5','PENDING','Pending'},//'
{'ID','P','PENDING','Pending'},//'
{'NH','30','PENDING','Pending'},//'
{'CA','P','PENDING CANCELLATION','Pending'},//'
{'KY','X','PENDING DISSOLUTION','Pending'},//'
{'MT','PEX','PENDING EXPIRATION','Pending'},//'
{'MT','PGS','PENDING GOOD STANDING','Pending'},//'
{'MT','PRN','PENDING RENEWAL','Pending'},//'
{'NV','NO CODE -Description from Raw File','PERMANENTLY REVOKED','Inactive'},//'
{'AL','P','PREVIOUS NAME','<null> '},//'PKA!!
{'TX','2','PRIOR','<null> '},//'
{'NM','AP','PROCESS OF APPEAL','Pending'},//'
{'ME','QUA','QUALIFIED (FORMERLY REGISTERED)','Active'},//'
{'OK','3','RA NOTICE SENT','Active'},//'
{'TX','3','RA NOTICE SENT','Active'},//'
{'KY','F','REAL NAME OF FOREIGN ORG. WHICH FILED UNDER A FICTITIOUS NAME','Active'},//'FBN/Foreign 
{'PA','5','RECEIVED','Pending'},//'
{'RI','','RECEIVERSHIP','Inactive'},//'
{'WI','DEL','RECORD DELETED','Inactive'},//'
{'CT','RD','REDOMESTICATED','Active'},//'
{'KS','BN','REDOMESTICATED IN','Active'},//'
{'KS','BO','REDOMESTICATED OUT','Active'},//'
{'ME','RDM','REDOMESTICATION','Active'},//'
{'SC','REG','REGISTER NAME','Active'},//'
{'CT','RG','REGISTERED','Active'},//'
{'KS','BR','REGISTERED','Active'},//'
{'MT','RGT','REGISTERED','Active'},//'
{'NJ','REGISTER','REGISTERED','Active'},//'
{'NJ','RST','REGISTERED','Active'},//'
{'TX','5','REGISTERED','Active'},//'
{'WI','RG','REGISTERED','Active'},//'
{'WI','RGD','REGISTERED','Active'},//'
{'CO','NO CODE -Description from Raw File','REGISTERED AGENT RESIGNED','<null> '},//'
{'IL','12','REGISTERED NAME CANCELLATION','<null> '},//'
{'IL','10','REGISTERED NAME EXPIRATION','<null> '},//'Note the date - that name may be avail to other entities in that state
{'SC','','REGISTRATION','Active'},//'
{'SD','RP','REGISTRATION FOR LIMITED PARTNERSHIP','Active'},//'
{'SD','RG','REGISTRATION OF NAME','Active'},//'
{'SD','RR','REGISTRATION RENEWAL','Active'},//'
{'IL','1','REINSTATED','Active'},//'
{'AZ','R','REINSTATEMENT','Active'},//'
{'SC','REI','REINSTATEMENT','Active'},//'
{'SC','','REINSTATEMENT','Active'},//'
{'NM','RI','RE-INSTATEMENT','Active'},//'
{'SD','RI','RE-INSTATEMENT','Active'},//'
{'DC','RJ','REJECTED','Pending'},//'
{'PA','36','REJECTED','Pending'},//'
{'ME','TAO','REMOVED - ADMINISTRATIVE ORDER','Inactive'},//'
{'ME','TCO','REMOVED - COURT ORDER','Inactive'},//'
{'ME','TIF','REMOVED - INSUFFICIENT FUNDS','Inactive'},//'
{'CT','RN','RENUNCIATED','Inactive'},//'
{'ME','RNN','RENUNCIATION OF LIMITED LIABILITY PARTNERSHIP','Inactive'},//'
{'TX','2','REPORT DUE','Pending'},//'
{'OK','2','REPORT NOTICE SENT','Pending'},//'
{'MT','RSV','RESERVATION','Pending'},//'
{'SC','RES','RESERVATION','Pending'},//'
{'SC','','RESERVATION','Pending'},//'
{'SC','RES - CO','RESERVATION FOR CORPORATION','Pending'},//'
{'SC','RES - EL','RESERVATION FOR ELEEMOSYNARY','Pending'},//'
{'SD','RS','RESERVATION OF NAME','Pending'},//'
{'SC','RES','RESERVE NAME','Pending'},//'
{'TX','4','RESERVED','Pending'},//'
{'CT','RC','RESERVED CANCELED','Inactive'},//'
{'MO','1','RESERVED NAME','Pending'},//'
{'MS','1','RESERVED NAME','Pending'},//'
{'NC','1','RESERVED NAME','Pending'},//'
{'NH','1','RESERVED NAME','Pending'},//'
{'PA','1','RESERVED NAME','Pending'},//'
{'PA','35','RESERVED NAME (BLANK)','Pending'},//'
{'SC','NAG','RESIGNATION OF AGENT','<null> '},//'
{'SD','RA','RESIGNATION OF AGENT','<null> '},//'
{'SD','SA','RESTATED ARTICLES','Active'},//'
{'WI','GS','RESTORED TO GOOD STANDING','Active'},//'
{'WI','IGS','RESTORED TO GOOD STANDING','Active'},//'
{'ND','M','RETIRED BY MERGER','Inactive'},//'
{'NM','RR','RETURNED REPORT','<null> '},//'
{'TN','7','REVENUE REVOKED','Inactive'},//'
{'RI','','REVIVAL','Active'},//'
{'MD','R','REVIVED','Active'},//'
{'MT','REV','REVIVED','Active'},//'
{'VA','30','REVKD-AUTO AR/$ CORP-NO REPORT AND/OR FEES','Inactive'},//'
{'MT','RVK','REVOCATION','Inactive'},//'
{'SD','RV','REVOCATION','Inactive'},//'
{'RI','','REVOCATION NOTICE','Pending'},//'
{'SD','DR','REVOCATION OF DISSOLUTION','<null> '},//'
{'KS','SR','REVOCATION OF SERVICE AGENT','<null> '},//'
{'WV','1','REVOCATION-FAILURE TO FILE A/R','Inactive'},//'"May be ""pending"". "
{'WV','23','REVOCATION-FAILURE TO FILE A/R','Inactive'},//'
{'WV','','REVOCATION-FAILURE TO FILE A/R','Inactive'},//'
{'AK','29','REVOKED','Inactive'},//'
{'AL','R','REVOKED','Inactive'},//'
{'AR','10','REVOKED','Inactive'},//'
{'CO','','REVOKED','Inactive'},//'
{'CT','RV','REVOKED','Inactive'},//'
{'DC','RV','REVOKED','Inactive'},//'
{'GA','30','REVOKED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','REVOKED','Inactive'},//'
{'ID','R','REVOKED','Inactive'},//'
{'IL','7','REVOKED','Inactive'},//'
{'IN','6','REVOKED','Inactive'},//'
{'ME','REV','REVOKED','Inactive'},//'
{'MS','41','REVOKED','Inactive'},//'
{'NC','13','REVOKED','Inactive'},//'
{'NM','RV','REVOKED','Inactive'},//'
{'NV','NO CODE -Description from Raw File','REVOKED','Inactive'},//'
{'PA','30','REVOKED','Inactive'},//'
{'TX','9','REVOKED','Inactive'},//'
{'TX','10','REVOKED','Inactive'},//'
{'WV','12','REVOKED','Inactive'},//'
{'WV','','REVOKED','Inactive'},//'
{'AZ','19','REVOKED - INCOMPLETE DISSOLUTION/WITHDRAWAL','Inactive'},//'
{'AZ','17','REVOKED - UNDELIVERABLE ADDRESS','Inactive'},//'
{'NM','RF','REVOKED AND BEYOND APPEAL PERIOD','Inactive'},//'
{'RI','','REVOKED AUTHORITY','Inactive'},//'
{'RI','','REVOKED ENTITY','Inactive'},//'
{'NJ','DRV','REVOKED FOR NON-PAYMENT OF ANNUAL REPORTS','Inactive'},//'
{'VA','31','REVOKED-AUTO RA CORP-FAILURE TO MAINTAIN R/A','Inactive'},//'
{'AZ','2','REVOKED-BAD CHECK','Inactive'},//'Bad Check to state!!
{'AZ','1','REVOKED-FILE ANNUAL REPORT','Inactive'},//'
{'AZ','5','REVOKED-FILE CERT./DISCLOSURE','Inactive'},//'
{'AZ','3','REVOKED-MAINTAIN STATUTORY AGENT','Inactive'},//'
{'AZ','6','REVOKED-OTHER','Inactive'},//'
{'AZ','4','REVOKED-PUBLISH & FILE AFFIDAVIT','Inactive'},//'
{'CO','','SEE ATTACHED STATEMENT','<null> '},//'
{'GA','9','SEE NOTEPAD','<null> '},//'
{'KS','SA','SERVICE AGENT/STATUS NOT REQUIRED','<null> '},//'
{'KS','SA','SERVICE AGENT/STATUS NOT REQUIRED','<null> '},//'
{'AZ','S','SET-ASIDE','<null> '},//'
{'SD','SH','SHARE DESIGNATION','<null> '},//'
{'KS','CS','SO CANCELLED','<null> '},//'Canceled? 
{'IL','13','SPECIAL ACT CORPORATION','Active'},//'
{'IL','13','SPECIAL ACT CORPORATION','Active'},//'
{'CA','E','STATE TO FEDERAL BANK CONVERSION','Active'},//'
{'SD','SC','STATEMENT OF CHANGE AGENT/ADDRESS','Active'},//'
{'NM','SD','STATEMENT OF INTENT TO DISSOLVE','Pending'},//'
{'KS','AI','STATUS PENDING EXAMINATION OF A/R','Pending'},//'
{'KS','DI','STATUS PENDING EXAMINATION OF A/R','Pending'},//'
{'AR','26','STATUTORILY DISSOLVED','Inactive'},//'
{'AR','19','STRICKEN','<null> '},//'
{'TX','16','STRICKEN','<null> '},//'
{'TX','19','STRICKEN','<null> '},//'
{'CA','4','SURRENDERED','<null> '},//'
{'VA','18','SURRENDERED (CORP)','Inactive'},//'
{'VA','26','SURRENDERED (LLC)','Inactive'},//'
{'MT','MRF','SURVIVOR; CORP/CO BELOW MERGED OUT','Inactive'},//'
{'MT','MRT','SURVIVOR; MERGED WITH UNQUALIFIED CORP/CO','Active'},//'
{'CA','2','SUSPENDED','Inactive'},//'
{'IL','14','SUSPENDED','Inactive'},//'
{'IL','14','SUSPENDED','Inactive'},//'
{'ME','SUS','SUSPENDED','Inactive'},//'
{'NC','10','SUSPENDED','Inactive'},//'
{'NE','S','SUSPENDED','Inactive'},//'
{'MT','SSP','SUSPENSION','Inactive'},//'
{'NM','SU','SUSPENSION','Inactive'},//'
{'SD','TX','TAX NOTICE (OLD LLC\'S)','<null> '},//'
{'CA','5','TERM EXPIRED','Inactive'},//'
{'VA','9','TERM INVOL','Inactive'},//'
{'VA','10','TERM(AUTO AR/$) CORP-NO REPORT AND/OR FEES','Inactive'},//'
{'VA','11','TERM(AUTO R/A) CORP-FAILURE TO MAINTAIN R/A','Inactive'},//'
{'VA','12','TERM(EXPIRED) CORP-DATE OF DURATION EXPIRED','Inactive'},//'
{'VA','13','TERM(VOLUNTARY) (CORP)','Inactive'},//'
{'MO','33','TERM/CANCEL','Inactive'},//'
{'DC','TERM','TERMINATED','Inactive'},//'
{'HI','NO CODE -Description from Raw File','TERMINATED','Inactive'},//'
{'OK','22','TERMINATED','Inactive'},//'
{'TN','2','TERMINATED','Inactive'},//'
{'TX','8','TERMINATED','Inactive'},//'
{'TX','17','TERMINATED','Inactive'},//'
{'VT','T','TERMINATED','Inactive'},//'
{'NV','NO CODE -Description from Raw File','TERMINATED','Inactive'},//'
{'WI','TER','TERMINATED FGN REGISTERED NAME','Inactive'},//'
{'WI','TER','TERMINATED FOREIGN REGISTERED NAME','Inactive'},//'
{'NM','CV','THE CORPORATION/ORGANIZATION STATUS IS NOT KNOWN','<null> '},//'nice? 
{'NC','17','TO FED BANK','<null> '},//'
{'NC','18','TO FOREIGN INS','<null> '},//'
{'NH','35','TRANSACTION INACTIVE','<null> '},//'
{'AR','21','TRANSFERRED','Active'},//'
{'OK','23','TRANSFERRED','Active'},//'
{'TX','21','TRUST CORPORATION','<null> '},//'
{'IL','4','UNACCEPTABLE PAYMENT','<null> '},//'potential risk
{'IL','4','UNACCEPTABLE PAYMENT','<null> '},//'potential risk
{'DC','UK','UNKNOWN','<null> '},//'
{'UT','U','UNKNOWN','<null> '},//'
{'AR','17','USED','<null> '},//'
{'GA','7','VOID','Inactive'},//'
{'VA','99','VOID','Inactive'},//'
{'MS','36','VOID - AFF/VOID','Inactive'},//'
{'MS','37','VOID - CHAR/VOID/FEE','Inactive'},//'
{'MS','38','VOID - FAILURE TO FILE','Inactive'},//'
{'MS','39','VOID - FALSIFIED DOCUMENT','Inactive'},//'
{'NC','15','VOL SURRENDER','Inactive'},//'
{'OK','12','VOL. CANCELLED','Inactive'},//'
{'CO','NO CODE -Description from Raw File','VOLUNTARILY','<null> '},//'
{'AK','8','VOLUNTARILY DISSOLVED','Inactive'},//'
{'CO','','VOLUNTARILY DISSOLVED','Inactive'},//'
{'IN','5','VOLUNTARILY DISSOLVED','Inactive'},//'
{'TX','7','VOLUNTARILY DISSOLVED','Inactive'},//'
{'WV','1','VOLUNTARILY DISSOLVED','Inactive'},//'
{'WV','17','VOLUNTARILY DISSOLVED','Inactive'},//'
{'WV','23','VOLUNTARILY DISSOLVED','Inactive'},//'
{'WV','','VOLUNTARILY DISSOLVED','Inactive'},//'
{'ND','V','VOLUNTARILY TERMINATED','Inactive'},//'
{'IL','3','VOLUNTARY CANCELLATION','Inactive'},//'
{'WV','21','VOLUNTARY CANCELLATION-LLC','Inactive'},//'
{'WV','26','VOLUNTARY CANCELLATION-LLC','Inactive'},//'
{'NM','DV','VOLUNTARY DISSOLUTION','Inactive'},//'
{'MO','34','VOLUNTARY DISSOLVED','Inactive'},//'
{'WV','24','VOLUNTARY TERMINATION','Inactive'},//'
{'WV','26','VOLUNTARY TERMINATION','Inactive'},//'
{'WV','','VOLUNTARY TERMINATION','Inactive'},//'
{'WV','1','VOLUNTARY WITHDRAWAL','Inactive'},//'
{'WV','23','VOLUNTARY WITHDRAWAL','Inactive'},//'
{'WV','25','VOLUNTARY WITHDRAWAL','Inactive'},//'
{'WV','','VOLUNTARY WITHDRAWAL','Inactive'},//'
{'DC','WD','WITHDRAWAL','Inactive'},//'
{'DC','WDRL','WITHDRAWAL','Inactive'},//'
{'SD','WD','WITHDRAWAL','Inactive'},//'
{'WI','TD','WITHDRAWAL','Inactive'},//'
{'WI','WTD','WITHDRAWAL','Inactive'},//'
{'UT','58','WITHDRAWAL COMPLETE','Inactive'},//'
{'AK','45','WITHDRAWN','Inactive'},//'
{'AL','W','WITHDRAWN','Inactive'},//'
{'AR','12','WITHDRAWN','Inactive'},//'
{'CO','NO CODE -Description from Raw File','WITHDRAWN','Inactive'},//'
{'CT','WD','WITHDRAWN','Inactive'},//'
{'GA','31','WITHDRAWN','Inactive'},//'
{'HI','NO CODE -Description from Raw File','WITHDRAWN','Inactive'},//'
{'ID','W','WITHDRAWN','Inactive'},//'
{'IL','6','WITHDRAWN','Inactive'},//'
{'IN','7','WITHDRAWN','Inactive'},//'
{'KS','WZ','WITHDRAWN','Inactive'},//'
{'MS','28','WITHDRAWN','Inactive'},//'
{'MT','WDR','WITHDRAWN','Inactive'},//'
{'NC','12','WITHDRAWN','Inactive'},//'
{'NH','29','WITHDRAWN','Inactive'},//'
{'NJ','WTH','WITHDRAWN','Inactive'},//'
{'NM','WD','WITHDRAWN','Inactive'},//'
{'OK','8','WITHDRAWN','Inactive'},//'
{'PA','34','WITHDRAWN','Inactive'},//'
{'PA','40','WITHDRAWN','Inactive'},//'
{'RI','','WITHDRAWN','Inactive'},//'
{'TN','3','WITHDRAWN','Inactive'},//'
{'TX','7','WITHDRAWN','Inactive'},//'
{'TX','12','WITHDRAWN','Inactive'},//'
{'UT','','WITHDRAWN-','Inactive'},//'
{'NV','NO CODE -Description from Raw File','WITHDRAWN','Inactive'},//'
{'AK','11','WITHDRAWN BY MERGER','Merged'},//'
{'MO','11','WITHDRAWN BY MERGER','Merged'},//'
{'MS','11','WITHDRAWN BY MERGER','Merged'},//'
{'NC','11','WITHDRAWN BY MERGER','Merged'},//'
{'NH','11','WITHDRAWN BY MERGER','Merged'},//'
{'VA','40','WITHDRAWN(VOL) (CORP)','Inactive'},//'
{'GA','43','WITHDRAWN/MERGED','Merged'},//'
{'UT','','WITHDRAWN-LICENSE ISSUANCE','Inactive'},//'
{'VA','43','WTHDRWN-CNVRSION','<null> '},//'
{'VA','42','WTHDRWN-MERGER','Merged'},//'
{'CO','','Y','<null> '},//'
{'AK','','','<null> '},//'
{'AL','','','<null> '},//'
{'AR','','','<null> '},//'
{'AZ','21','','<null> '},//'
{'AZ','','','<null> '},//'
{'CA','','','<null> '},//'
{'CO','NO CODE -Description from Raw File','','<null> '},//'
{'CO','','','<null> '},//'
{'CT','','','<null> '},//'
{'DC','2000','','<null> '},//'
{'DC','#500 200','','<null> '},//'
{'DC','#910 200','','<null> '},//'
{'DC','#930 200','','<null> '},//'
{'DC','20016 AC','','<null> '},//'
{'DC','CAN','','<null> '},//'
{'DC','DBU','','<null> '},//'
{'DC','DLC','','<null> '},//'
{'DC','DLP','','<null> '},//'
{'DC','DNP','','<null> '},//'
{'DC','DPR','','<null> '},//'
{'DC','FBU','','<null> '},//'
{'DC','FLC','','<null> '},//'
{'DC','FLP','','<null> '},//'
{'DC','FNP','','<null> '},//'
{'DC','FPR','','<null> '},//'
{'DC','MD','','<null> '},//'
{'DC','MG','','<null> '},//'
{'DC','STATUS','','<null> '},//'
{'DC','STE. #78','','<null> '},//'
{'DC','STE.#217','','<null> '},//'
{'DC','SUITE 12','','<null> '},//'
{'DC','SUITE 40','','<null> '},//'
{'DC','SUITE 44','','<null> '},//'
{'DC','SUITE 60','','<null> '},//'
{'DC','W.TOWER','','<null> '},//'
{'DC','','','<null> '},//'
{'IA','','','<null> '},//'
{'ID','-','','<null> '},//'
{'ID','_','','<null> '},//'
{'ID','','','<null> '},//'
{'IL','','','<null> '},//'
{'IN','46','','<null> '},//'
{'IN','IN','','<null> '},//'
{'IN','','','<null> '},//'
{'KS','LG','','<null> '},//'
{'KS','','','<null> '},//'
{'KY','1','','<null> '},//'
{'KY','G','','<null> '},//'
{'KY','S','','<null> '},//'
{'KY','V','','<null> '},//'
{'KY','','','<null> '},//'
{'LA','','','<null> '},//'
{'MA','12','','<null> '},//'
{'MA','4303974','','<null> '},//'
{'MA','8202007','','<null> '},//'
{'MA','9091994','','<null> '},//'
{'MA','9132009','','<null> '},//'
{'MA','12301963','','<null> '},//'
{'MA','','','<null> '},//'
{'MD','','','<null> '},//'
{'ME','RIV','','<null> '},//'
{'ME','','','<null> '},//'
{'MI','A','','<null> '},//'
{'MI','AR','','<null> '},//'
{'MI','CD','','<null> '},//'
{'MI','CM','','<null> '},//'
{'MI','CO','','<null> '},//'
{'MI','CV','','<null> '},//'
{'MI','CW','','<null> '},//'
{'MI','DC','','<null> '},//'
{'MI','ME','','<null> '},//'
{'MI','OT','','<null> '},//'
{'MI','RE','','<null> '},//'
{'MI','SE','','<null> '},//'
{'MI','TE','','<null> '},//'
{'MI','TM','','<null> '},//'
{'MI','','','<null> '},//'
{'MN','','','<null> '},//'
{'MO','1','','<null> '},//'
{'MO','2','','<null> '},//'
{'MO','3','','<null> '},//'
{'MO','4','','<null> '},//'
{'MO','5','','<null> '},//'
{'MO','7','','<null> '},//'
{'MO','8','','<null> '},//'
{'MO','9','','<null> '},//'
{'MO','11','','<null> '},//'
{'MO','24','','<null> '},//'
{'MO','25','','<null> '},//'
{'MO','26','','<null> '},//'
{'MO','27','','<null> '},//'
{'MO','28','','<null> '},//'
{'MO','29','','<null> '},//'
{'MO','30','','<null> '},//'
{'MO','31','','<null> '},//'
{'MO','32','','<null> '},//'
{'MO','33','','<null> '},//'
{'MO','34','','<null> '},//'
{'MO','35','','<null> '},//'
{'MS','43','','<null> '},//'
{'MS','','','<null> '},//'
{'NC','','','<null> '},//'
{'ND','C','','<null> '},//'
{'ND','M','','<null> '},//'
{'ND','N','','<null> '},//'
{'ND','T','','<null> '},//'
{'ND','','','<null> '},//'
{'NE','','','<null> '},//'
{'NH','','','<null> '},//'
{'NJ','DIS','','<null> '},//'
{'NJ','DPP','','<null> '},//'
{'NJ','DWA','','<null> '},//'
{'NJ','MRG','','<null> '},//'
{'NJ','WTD','','<null> '},//'
{'NJ','XNP','','<null> '},//'
{'NJ','XPG','','<null> '},//'
{'NJ','','','<null> '},//'
{'NY','','','<null> '},//'
{'OH','','','<null> '},//'
{'OK','','','<null> '},//'
{'RI','','','<null> '},//'
{'SC','0','','<null> '},//'
{'SC','1','','<null> '},//'
{'SC','2','','<null> '},//'
{'SC','INT','','<null> '},//'
{'SC','','','<null> '},//'
{'SD','AS','','<null> '},//'
{'SD','AT','','<null> '},//'
{'SD','','','<null> '},//'
{'TN','A','','<null> '},//'
{'TN','L','','<null> '},//'
{'TN','','','<null> '},//'
{'TX','TE','','<null> '},//'
{'TX','','','<null> '},//'
{'VA','60','','<null> '},//'
{'VA','','','<null> '},//'
{'VT','','','<null> '},//'
{'WI','CA','','<null> '},//'
{'WI','IS','','<null> '},//'
{'WI','','','<null> '},//'
{'WV','','','<null> '},//'
{'WY','','','<null> '}//'
], layout_corpStatus),all, record),StateAbbrev,CodeDescrpt);

	 export layout_executives := record
			TopBusiness.Layout_Contacts.linked.position_title;
			unsigned1 order;
	 end;
	 
	 export layout_positionTitle := record
	    string position;
			string normalizedTitle; 
			string normalizedTitle2;
			//string50 normalizedTitle3;
	 end;
	 export layout_executiveOrdering := record
			string position_title;
			integer order;
			boolean IsExecutive;
	 end;
	 

export executiveOrder := dataset([
{'CHIEF EXECUTIVE OFFICER',1,True},
{'CHIEF OPERATING OFFICER',2,True},
{'CHIEF FINANCIAL OFFICER',3,True},
{'CHIEF TECHNOLOGY OFFICER',4,True},
{'CHIEF INFORMATION OFFICER',5,True},
{'CHIEF OFFICER - MARKETING',6,True},
{'CHIEF OFFICER - SALES',7,True},
{'CHIEF CUSTOMER OFFICER',8,True},
{'CHIEF OFFICER - HUMAN RESOURCES',9,True},
{'CHIEF PHARMACIST',10,True},
{'CHAIR',11,True},
{'OWNER',12,True},
{'TREASURER',13,True},
{'BOARD MEMBER',14,True},
{'GENERAL COUNSEL',15,True},
{'SR VICE PRESIDENT',16,True},
{'SR VICE PRESIDENT - HUMAN RESOURCES',17,True},
{'VICE CHAIR',18,True},
{'PRESIDENT',19,True},
{'EXECUTIVE VICE PRESIDENT',20,True},
{'VICE PRESIDENT',21,True},
{'EXECUTIVE - FINANCE',22,True},
{'EXECUTIVE VICE PRESIDENT - SALES',23,True},
{'EXECUTIVE -MARKETING',24,True},
{'EXECUTIVE - HUMAN RESOURCE',25,True},
{'EXECUTIVE',26,True},
{'SECRETARY',27,True},
{'ATTORNEY',28,True},
{'ACCOUNTANT',29,True},
{'FOUNDER',30,True},
{'DIRECTOR',31,True},
{'AGENT',32,True},
{'AUTHORIZED REPRESENTATIVE',33,True},
{'GENERAL MANAGER',34,True},
{'IT',35,false},
{'INCORPORATOR',36,True},
{'PROJECT MANAGER',37,false},
{'MANAGER',38,false},
{'SELF EMPLOYED',39,True},
{'PARTNER',40,True},
{'PRINCIPAL',41,True},
{'MEMBER',42,True},
{'SHAREHOLDER',43,false},
{'DEVELOPER',44,false},
{'HUMAN RESOURCE MANAGER',45,false},
{'ACCOUNT MANAGER',46,false},
{'ASSISTANT',47,false},
{'ADMINISTRATOR',48,false},
{'ASSOCIATE',49,false},
{'CONTACT',50,false},
{'OFFICER',51,True},
{'SPOKESPERSON',52,false},
{'BRANCH MANAGER',53,false},
{'CONTROLLER',54,True},
{'PHYSICIAN',55,false},
{'MEDICAL DIRECTOR',56,false},
{'PHARMACIST',57,false},
{'NURSE',58,false},
{'PHARMACY TECHNICIAN',59,false},
{'MEDICAL ASSISTANT',60,false},
{'ANALYST',61,false},
{'CONSULTANT',62,false},
{'CONTRACTOR',63,false},
{'RESEARCH',64,false},
{'SALES',65,false},
{'CUSTOMER SERVICE REPRESENTATIVE',66,false},
{'EDITOR IN CHIEF',67,false},
{'EDITOR',68,false},
{'ENGINEER',69,false},
{'SUPERINTENDENT',70,false},
{'PLANT MANAGER',71,false},
{'COMMISSIONER',72,false},
{'DESIGNER',73,false},
{'JUDGE',74,false},
{'LOBBYIST',75,false},
{'GOVERNOR',76,false},
{'MAYOR',77,false},
{'POLICE CHIEF',78,false},
{'FIRE CHIEF',79,false},
{'CAPTAIN',80,false},
{'COMMANDER',81,false},
{'COMMITTEE MEMBER',82,false},
{'LIEUTENANT',83,false},
{'PUBLISHER',84,false},
{'PURCHASING',85,false},
{'SHERIFF',86,false},
{'TEACHER',87,false},
{'BOOKKEEPER',88,false},
{'CHEF',89,false},
{'INSTRUCTOR',90,false},
{'LIBRARIAN',91,false},
{'MACHINIST',92,false},
{'MAINTENANCE',93,false},
{'STUDENT',94,false},
{'REAL ESTATE AGENT',95,false},
{'REAL ESTATE BROKER',96,false},
{'REPORTER',97,false},
{'DRIVER',98,false},
{'COACH',99,false},
{'LABORER',100,false},
{'PHOTOGRAPHER',101,false},
{'PHYSICIAN ASSISTANT',102,false},
{'PROFESSOR',103,false},
{'RELIGIOUS LEADER',104,false},
{'RETIRED',105,false},
{'SERGEANT',106,false},
{'TRUSTEE',107,false},
{'WRITER',108,false}
], layout_executiveOrdering);

end;
