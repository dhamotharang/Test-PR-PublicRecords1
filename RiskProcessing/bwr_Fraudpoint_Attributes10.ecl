#workunit('name','Fraudpoint Attributes');
#option ('hthorMemoryLimit', 1000)
#option ('linkCountedRows', false)

IMPORT Models, iESP, Risk_Indicators, RiskWise, UT;
/* ********************************************************************
 *                               OPTIONS                              *
 **********************************************************************
 * recordsToRun: Number of records to run through the service. Set to *
 *    0 to run all.                                                   *
 * threads: Number of parallel threads to run. Set to 1 - 30.         *
 * roxieIP: IP Address of the non-FCRA roxie.                         *
 **********************************************************************/
recordsToRun := 0;
eyeball := 50;

threads := 25;

roxieIP := RiskWise.shortcuts.prod_batch_neutral; // Production
// roxieIP := RiskWise.shortcuts.staging_neutral_roxieIP; // Staging/Cert

inputFile := '~jpyon::in::sprint_867_input_f_s_in';
outputFile := '~jpyon::out::alerus_1031_newfile_fp_attr2';

/* **************************************
 *         MAIN SCRIPT CODE             *
 ****************************************/
prii_layout := RECORD
     string ACCOUNT;
     string FirstName;
     string MiddleName;
     string LastName;
     string StreetAddress;
     string CITY;
     string STATE;
     string ZIP;
     string HomePhone;
     string SSN;
     string DateOfBirth;
     string WorkPhone;
     string INCOME;
     string DLNumber;
     string DLState;
     string BALANCE;
     string CHARGEOFFD;
     string FORMERName;
     string EMAIL;
     string EmployerName;
     integer HistoryDateYYYYMM;
end;

f := IF(recordsToRun <= 0, DATASET(inputFile, prii_layout, csv(quote('"'))),
                            CHOOSEN(DATASET(inputFile, prii_layout,CSV(QUOTE('"'))), recordsToRun));

output(CHOOSEN(f, eyeball), named('sample_original_input'));


Layout_Attributes_In := RECORD
	string name;
END;

layout_soap := record
	STRING AccountNumber;
	STRING FirstName;
	STRING MiddleName;
	STRING LastName;
	STRING NameSuffix;
	STRING StreetAddress;
	STRING City;
	STRING State;
	STRING Zip;
	STRING Country;
	STRING SSN;
	STRING DateOfBirth;
	STRING Age;
	STRING DLNumber;
	STRING DLState;
	STRING Email;
	STRING IPAddress;
	STRING HomePhone;
	STRING WorkPhone;
	STRING EmployerName;
	STRING FormerName;
	INTEGER GLBPurpose;
	INTEGER DPPAPurpose;
	string DataRestrictionMask;		
	integer HistoryDateYYYYMM;
	dataset(Models.Layout_Score_Chooser) scores;
	dataset(Risk_Indicators.Layout_Gateways_In) gateways;
	dataset(Layout_Attributes_In) RequestedAttributeGroups;
end;

params := dataset([], models.Layout_Parameters);

layout_old_acct := RECORD
	STRING old_account_number;
	layout_soap;
END;


layout_old_acct into_fdInput(f le, INTEGER c) := TRANSFORM
	SELF.old_account_number := le.account;
	SELF.Accountnumber := (STRING)c;	
	SELF.DPPAPurpose := 3;
	SELF.GLBPurpose := 1;

	self.HistoryDateYYYYMM:= le.historydateyyyymm;
	self.DataRestrictionMask := '000000000000';  // to allow use of both Equifax and Experian, this is the default value for all legacy scoring products

	SELF.RequestedAttributeGroups := dataset([{'Version1'}], layout_attributes_in);
//	self.scores := dataset([{'Models.RVTelecom_Service', fcraroxieIP,params}], models.Layout_Score_Chooser); 
	//self.gateways := dataset([{'neutralroxie', 'http://roxiethorvip.hpcc.risk.regn.net:9856'}], risk_indicators.Layout_Gateways_In);
	SELF := le;
	self := [];
end;
fdInput := project(f, into_fdInput(left, counter));
output(CHOOSEN(fdInput, eyeball), named('Sample_FD_Input'));


dist_dataset := DISTRIBUTE(PROJECT(fdInput,TRANSFORM(layout_soap,SELF := LEFT)), RANDOM());


Layout_Attribute := RECORD, maxlength(10000)
	DATASET(Models.Layout_Parameters) Attribute;
END;
Layout_AttributeGroup := RECORD, maxlength(70000)
	string name;
	string index;
	DATASET(Layout_Attribute) Attributes;
END;
Layout_FDAttributesOut := RECORD, maxlength(100000)
	string30 accountnumber;
	//Risk_Indicators.Layout_Input input;
	DATASET(Layout_AttributeGroup) AttributeGroup;
	string errorcode;
END;


Layout_FDAttributesOut myFail(dist_dataset le) := TRANSFORM
	SELF.errorcode := FAILCODE + FAILMESSAGE;
	SELF := le;
	SELF := [];
END;


resu := SOAPCALL(dist_dataset, roxieIP,
				'Models.FraudAdvisor_Service', {dist_dataset}, 
				DATASET(Layout_FDAttributesOut),
        RETRY(5), TIMEOUT(500), LITERAL,
        XPATH('Models.FraudAdvisor_ServiceResponse/Results/Result/Dataset[@name=\'Results2\']/Row'),
				PARALLEL(threads), onFail(myFail(LEFT)));
				
output(CHOOSEN(resu, eyeball), named('Sample_Result'));


			
fd_attributes_norm := RECORD
	//string20 AccountNumber;
	string30 AccountNumber;
	
	string8 SSNFirstSeen;
	string8 DateLastSeen;
	string1 isRecentUpdate;
	string2 NumSources;
	string1 isPhoneFullNameMatch;
	string1 isPhoneLastNameMatch;
	string3 inferredAge;// new
	string1 isSSNInvalid;
	string1 isPhoneInvalid;
	string1 isAddrInvalid;
	string1 isDLInvalid;
	string1 isNoVer;
	
	// SSN Attributes
	string1 isDeceased;
	string8 DeceasedDate;
	string1 isSSNValid;
	string1 isRecentIssue;
	string8 LowIssueDate;
	string8 HighIssueDate;
	string2 IssueState;
	string1 isNonUS;
	string1 isIssued3;
	string1 isIssuedAge5;
	string3 ssnCode;// new
	
	// Evidence of Compromised Identity
	string1 isSSNNotFound;
	string1 isFoundOther;
	string1 isIssuedPrior;
	string1 isPhoneOther;
	string2 SSNPerID;
	string2 AddrPerID;
	string2 PhonePerID;
	string2 IDPerSSN;
	string2 AddrPerSSN;
	string2 IDPerAddr;
	string2 SSNPerAddr;
	string2 PhonePerAddr;
	string2 IDPerPhone;
	string2 SSNPerID6;
	string2 AddrPerID6;
	string2 PhonePerID6;
	string2 IDPerSSN6;
	string2 AddrPerSSN6;
	string2 IDPerAddr6;
	string2 SSNPerAddr6;
	string2 PhonePerAddr6;
	string2 IDPerPhone6;
	
	// Identity Change Information
	string2 LastPerSSN;
	string2 LastPerID;
	string6 DateLastNameChange;
	string20 NewLastName;
	string2 LastNames30;
	string2 LastNames90;
	string2 LastNames180;
	string2 LastNames12;
	string2 LastNames24;
	string2 LastNames36;
	string2 LastNames60;
	string2 IDPerSFDUAddr;
	string2 SSNPerSFDUAddr;

	// Characteristics of Input Address
	string65 IAAddress;
	string25 IACity;
	string2 IAState;
	string5 IAZip;
	string4 IAZip4;
	string6 IADateFirstReported;
	string6 IADateLastReported;
	string3 IALenOfRes;
	string1 IADwellType;
	string1 IAisNotPrimaryRes;
	string1 IAPhoneListed;
	string10 IAPhoneNumber;
	string10 IAMED_HHINC;// new
	string10 IAMED_HVAL;// new
	string3 IAMURDERS;// new
	string3 IACARTHEFT;// new
	string3 IABURGLARY;// new
	string3 IATOTCRIME;// new
	
	// Characteristics of Current Address (most recently reported)
	string65 CAAddress;
	string25 CACity;
	string2 CAState;
	string5 CAZip;
	string4 CAZip4;
	string6 CADateFirstReported;
	string6 CADateLastReported;
	string3 CALenOfRes;
	string1 CADwellType;
	string1 CAisNotPrimaryRes;
	string1 CAPhoneListed;
	string10 CAPhoneNumber;
	string10 CAMED_HHINC;// new
	string10 CAMED_HVAL;// new
	string3 CAMURDERS;// new
	string3 CACARTHEFT;// new
	string3 CABURGLARY;// new
	string3 CATOTCRIME;// new
	
	// Characteristics of Previous Address (next most recently reported)
	string65 PAAddress;
	string25 PACity;
	string2 PAState;
	string5 PAZip;
	string4 PAZip4;
	string6 PADateFirstReported;
	string6 PADateLastReported;
	string3 PALenOfRes;
	string1 PADwellType;
	string1 PAisNotPrimaryRes;
	string1 PAPhoneListed;
	string10 PAPhoneNumber;
	string10 PAMED_HHINC;// new
	string10 PAMED_HVAL;// new
	string3 PAMURDERS;// new
	string3 PACARTHEFT;// new
	string3 PABURGLARY;// new
	string3 PATOTCRIME;// new
	
	// Differences between Input Address and Current Address
	string1 isInputCurrMatch;
	string4 DistInputCurr;
	string1 isDiffState;
	string10 IncomeDiff;// new
	string10 HomeValueDiff;// new
	string3 CrimeDiff;// new
	string2 EcoTrajectory;
	
	// Differences between Current Address and Previous Address
	string1 isInputPrevMatch;
	string4 DistCurrPrev;
	string1 isDiffState2;
	string10 IncomeDiff2;// new
	string10 HomeValueDiff2;// new
	string3 CrimeDiff2;// new
	string2 EcoTrajectory2;
	
	// Transient Person Attributes
	string1 mobility_indicator;
	string1 statusAddr;
	string1 statusAddr2;
	string1 statusAddr3;
	string6 PADateFirstReported2;
	string6 NPADateFirstReported;
	string2 addrChanges30;
	string2 addrChanges90;
	string2 addrChanges180;
	string2 addrChanges12;
	string2 addrChanges24;
	string2 addrChanges36;
	string2 addrChanges60;
	
	// Derogatory Public Records
//	string2 felonies;
//	string8 date_last_conviction;
//	string2 felonies30;
//	string2 felonies90;
//	string2 felonies180;
//	string2 felonies12;
//	string2 felonies24;
//	string2 felonies36;
//	string2 felonies60;
	
	// new section
//	string2 arrests;
//	string8 date_last_arrest;
//	string2 arrests30;
//	string2 arrests90;
//	string2 arrests180;
//	string2 arrests12;
//	string2 arrests24;
//	string2 arrests36;
//	string2 arrests60;
	
	// Higher Risk Address and Phone Attributes
	string1 isAddrHighRisk;
	string1 isPhoneHighRisk;
	string30 hriskcmpy;// new
	string6 sic;// new
	string1 isAddrPrison;
	string1 isZipPOBox;
	string1 isZipCorpMil;
	string1 phoneStatus;
	string1 isPhonePager;
	string1 isPhoneMobile;
	string1 isPhoneZipMismatch;
	string4 phoneAddrDist;
	// new section
	string1 hphonetypeflag;
	string2 hphonesrvcflag;
	string1 areacodesplit;
	string3 altareacode;
	string1 addrval;
	string5 invalidaddr;
		
	// Higher Risk Internet Connection Attributes
	string1 IPinvalid;
	string1 IPNonUS;
	string2 IPState;
	string2 IPCountry;
	string1 IPContinent;
	
	// string3 RV_score;
	// string3 RV_reason;
	// string3 RV_reason2;
	// string3 RV_reason3;
	// string3 RV_reason4;
	
	string6 history_date;
	
	string10 errorcode;
END;


get_group(recordof(Layout_FDAttributesOut) groups, string name_i) := function
	groupi := groups.attributegroup(name=name_i);
	return groupi;
end;


get_attribute(dataset(Layout_AttributeGroup) groupi, integer i) := function
	attr := groupi.attributes[i];
	return attr;	
end;

fd_attributes_norm normit(resu L, fdInput R) := transform
	self.AccountNumber := r.old_account_number;
		
	// version1 output
	v := get_group(l, 'Version1');
	v1 := get_attribute(v, 1);
	v2 := get_attribute(v, 2);
	v3 := get_attribute(v, 3);
	v4 := get_attribute(v, 4);
	v5 := get_attribute(v, 5);
	v6 := get_attribute(v, 6);
	v7 := get_attribute(v, 7);
	v8 := get_attribute(v, 8);
	v9 := get_attribute(v, 9);
	v10 := get_attribute(v, 10);
	v11 := get_attribute(v, 11);
	v12 := get_attribute(v, 12);
	v13 := get_attribute(v, 13);
	v14 := get_attribute(v, 14);
	v15 := get_attribute(v, 15);
	v16 := get_attribute(v, 16);
	v17 := get_attribute(v, 17);
	v18 := get_attribute(v, 18);
	v19 := get_attribute(v, 19);
	v20 := get_attribute(v, 20);
	v21 := get_attribute(v, 21);
	v22 := get_attribute(v, 22);
	v23 := get_attribute(v, 23);
	v24 := get_attribute(v, 24);
	v25 := get_attribute(v, 25);
	v26 := get_attribute(v, 26);
	v27 := get_attribute(v, 27);
	v28 := get_attribute(v, 28);
	v29 := get_attribute(v, 29);
	v30 := get_attribute(v, 30);
	v31 := get_attribute(v, 31);
	v32 := get_attribute(v, 32);
	v33 := get_attribute(v, 33);
	v34 := get_attribute(v, 34);
	v35 := get_attribute(v, 35);
	v36 := get_attribute(v, 36);
	v37 := get_attribute(v, 37);
	v38 := get_attribute(v, 38);
	v39 := get_attribute(v, 39);
	v40 := get_attribute(v, 40);
	v41 := get_attribute(v, 41);
	v42 := get_attribute(v, 42);
	v43 := get_attribute(v, 43);
	v44 := get_attribute(v, 44);
	v45 := get_attribute(v, 45);
	v46 := get_attribute(v, 46);
	v47 := get_attribute(v, 47);
	v48 := get_attribute(v, 48);
	v49 := get_attribute(v, 49);
	v50 := get_attribute(v, 50);
	v51 := get_attribute(v, 51);
	v52 := get_attribute(v, 52);
	v53 := get_attribute(v, 53);
	v54 := get_attribute(v, 54);
	v55 := get_attribute(v, 55);
	v56 := get_attribute(v, 56);
	v57 := get_attribute(v, 57);
	v58 := get_attribute(v, 58);
	v59 := get_attribute(v, 59);
	v60 := get_attribute(v, 60);
	v61 := get_attribute(v, 61);
	v62 := get_attribute(v, 62);
	v63 := get_attribute(v, 63);
	v64 := get_attribute(v, 64);
	v65 := get_attribute(v, 65);
	v66 := get_attribute(v, 66);
	v67 := get_attribute(v, 67);
	v68 := get_attribute(v, 68);
	v69 := get_attribute(v, 69);
	v70 := get_attribute(v, 70);
	v71 := get_attribute(v, 71);
	v72 := get_attribute(v, 72);
	v73 := get_attribute(v, 73);
	v74 := get_attribute(v, 74);
	v75 := get_attribute(v, 75);
	v76 := get_attribute(v, 76);
	v77 := get_attribute(v, 77);
	v78 := get_attribute(v, 78);
	v79 := get_attribute(v, 79);
	v80 := get_attribute(v, 80);
	v81 := get_attribute(v, 81);
	v82 := get_attribute(v, 82);
	v83 := get_attribute(v, 83);
	v84 := get_attribute(v, 84);
	v85 := get_attribute(v, 85);
	v86 := get_attribute(v, 86);
	v87 := get_attribute(v, 87);
	v88 := get_attribute(v, 88);
	v89 := get_attribute(v, 89);
	v90 := get_attribute(v, 90);
	v91 := get_attribute(v, 91);
	v92 := get_attribute(v, 92);
	v93 := get_attribute(v, 93);
	v94 := get_attribute(v, 94);
	v95 := get_attribute(v, 95);
	v96 := get_attribute(v, 96);
	v97 := get_attribute(v, 97);
	v98 := get_attribute(v, 98);
	v99 := get_attribute(v, 99);
	v100 := get_attribute(v, 100);
	v101 := get_attribute(v, 101);
	v102 := get_attribute(v, 102);
	v103 := get_attribute(v, 103);
	v104 := get_attribute(v, 104);
	v105 := get_attribute(v, 105);
	v106 := get_attribute(v, 106);
	v107 := get_attribute(v, 107);
	v108 := get_attribute(v, 108);
	v109 := get_attribute(v, 109);
	v110 := get_attribute(v, 110);
	v111 := get_attribute(v, 111);
	v112 := get_attribute(v, 112);
	v113 := get_attribute(v, 113);
	v114 := get_attribute(v, 114);
	v115 := get_attribute(v, 115);
	v116 := get_attribute(v, 116);
	v117 := get_attribute(v, 117);
	v118 := get_attribute(v, 118);
	v119 := get_attribute(v, 119);
	v120 := get_attribute(v, 120);
	v121 := get_attribute(v, 121);
	v122 := get_attribute(v, 122);
	v123 := get_attribute(v, 123);
	v124 := get_attribute(v, 124);
	v125 := get_attribute(v, 125);
	v126 := get_attribute(v, 126);
	v127 := get_attribute(v, 127);
	v128 := get_attribute(v, 128);
	v129 := get_attribute(v, 129);
	v130 := get_attribute(v, 130);
	v131 := get_attribute(v, 131);
	v132 := get_attribute(v, 132);
	v133 := get_attribute(v, 133);
	v134 := get_attribute(v, 134);
	v135 := get_attribute(v, 135);
	v136 := get_attribute(v, 136);
	v137 := get_attribute(v, 137);
	v138 := get_attribute(v, 138);
	v139 := get_attribute(v, 139);
	v140 := get_attribute(v, 140);
	v141 := get_attribute(v, 141);
	v142 := get_attribute(v, 142);
	v143 := get_attribute(v, 143);
	v144 := get_attribute(v, 144);
	v145 := get_attribute(v, 145);
	v146 := get_attribute(v, 146);
	v147 := get_attribute(v, 147);
	v148 := get_attribute(v, 148);
	v149 := get_attribute(v, 149);
	v150 := get_attribute(v, 150);
	v151 := get_attribute(v, 151);
	v152 := get_attribute(v, 152);
	v153 := get_attribute(v, 153);
	v154 := get_attribute(v, 154);
	v155 := get_attribute(v, 155);
	v156 := get_attribute(v, 156);
	v157 := get_attribute(v, 157);
	v158 := get_attribute(v, 158);
	v159 := get_attribute(v, 159);
	v160 := get_attribute(v, 160);
	v161 := get_attribute(v, 161);
	v162 := get_attribute(v, 162);
	// v163 := get_attribute(v, 163);
	// v164 := get_attribute(v, 164);
	// v165 := get_attribute(v, 165);
	// v166 := get_attribute(v, 166);
	// v167 := get_attribute(v, 167);
	// v168 := get_attribute(v, 168);
	// v169 := get_attribute(v, 169);
	// v170 := get_attribute(v, 170);
	// v171 := get_attribute(v, 171);
	// v172 := get_attribute(v, 172);
	// v173 := get_attribute(v, 173);
	// v174 := get_attribute(v, 174);
	// v175 := get_attribute(v, 175);
	// v176 := get_attribute(v, 176);
	// v177 := get_attribute(v, 177);
	// v178 := get_attribute(v, 178);
	// v179 := get_attribute(v, 179);
	// v180 := get_attribute(v, 180);
	
	self.SSNFirstSeen := v1.attribute[1].value;
	self.DateLastSeen := v2.attribute[1].value;
	self.isRecentUpdate := v3.attribute[1].value;
	self.NumSources := v4.attribute[1].value;
	self.isPhoneFullNameMatch := v5.attribute[1].value;
	self.isPhoneLastNameMatch := v6.attribute[1].value;
	self.inferredAge := v7.attribute[1].value;// new
	self.isSSNInvalid := v8.attribute[1].value;
	self.isPhoneInvalid := v9.attribute[1].value;
	self.isAddrInvalid := v10.attribute[1].value;
	self.isDLInvalid := v11.attribute[1].value;
	self.isNoVer := v12.attribute[1].value;
	
	// SSN Attributes
	self.isDeceased := v13.attribute[1].value;
	self.DeceasedDate := v14.attribute[1].value;
	self.isSSNValid := v15.attribute[1].value;
	self.isRecentIssue := v16.attribute[1].value;
	self.LowIssueDate := v17.attribute[1].value;
	self.HighIssueDate := v18.attribute[1].value;
	self.IssueState := v19.attribute[1].value;
	self.isNonUS := v20.attribute[1].value;
	self.isIssued3 := v21.attribute[1].value;
	self.isIssuedAge5 := v22.attribute[1].value;
	self.ssnCode := v23.attribute[1].value;// new
	
	// Evidence of Compromised Identity
	self.isSSNNotFound := v24.attribute[1].value;
	self.isFoundOther := v25.attribute[1].value;
	self.isIssuedPrior := v26.attribute[1].value;
	self.isPhoneOther := v27.attribute[1].value;
	self.SSNPerID := v28.attribute[1].value;
	self.AddrPerID := v29.attribute[1].value;
	self.PhonePerID := v30.attribute[1].value;
	self.IDPerSSN := v31.attribute[1].value;
	self.AddrPerSSN := v32.attribute[1].value;
	self.IDPerAddr := v33.attribute[1].value;
	self.SSNPerAddr := v34.attribute[1].value;
	self.PhonePerAddr := v35.attribute[1].value;
	self.IDPerPhone := v36.attribute[1].value;
	self.SSNPerID6 := v37.attribute[1].value;
	self.AddrPerID6 := v38.attribute[1].value;
	self.PhonePerID6 := v39.attribute[1].value;
	self.IDPerSSN6 := v40.attribute[1].value;
	self.AddrPerSSN6 := v41.attribute[1].value;
	self.IDPerAddr6 := v42.attribute[1].value;
	self.SSNPerAddr6 := v43.attribute[1].value;
	self.PhonePerAddr6 := v44.attribute[1].value;
	self.IDPerPhone6 := v45.attribute[1].value;
	
	// Identity Change Information
	self.LastPerSSN := v46.attribute[1].value;
	self.LastPerID := v47.attribute[1].value;
	self.DateLastNameChange := v48.attribute[1].value;
	self.NewLastName := v49.attribute[1].value;
	self.LastNames30 := v50.attribute[1].value;
	self.LastNames90 := v51.attribute[1].value;
	self.LastNames180 := v52.attribute[1].value;
	self.LastNames12 := v53.attribute[1].value;
	self.LastNames24 := v54.attribute[1].value;
	self.LastNames36 := v55.attribute[1].value;
	self.LastNames60 := v56.attribute[1].value;
	self.IDPerSFDUAddr := v57.attribute[1].value;
	self.SSNPerSFDUAddr := v58.attribute[1].value;

	// Characteristics of Input Address
	self.IAAddress := v59.attribute[1].value;
	self.IACity := v60.attribute[1].value;
	self.IAState := v61.attribute[1].value;
	self.IAZip := v62.attribute[1].value;
	self.IAZip4 := v63.attribute[1].value;
	self.IADateFirstReported := v64.attribute[1].value;
	self.IADateLastReported := v65.attribute[1].value;
	self.IALenOfRes := v66.attribute[1].value;
	self.IADwellType := v67.attribute[1].value;
	self.IAisNotPrimaryRes := v68.attribute[1].value;
	self.IAPhoneListed := v69.attribute[1].value;
	self.IAPhoneNumber := v70.attribute[1].value;
	self.IAMED_HHINC := v71.attribute[1].value;// new
	self.IAMED_HVAL := v72.attribute[1].value;// new
	self.IAMURDERS := v73.attribute[1].value;// new
	self.IACARTHEFT := v74.attribute[1].value;// new
	self.IABURGLARY := v75.attribute[1].value;// new
	self.IATOTCRIME := v76.attribute[1].value;// new
	
	// Characteristics of Current Address (most recently reported)
	self.CAAddress := v77.attribute[1].value;
	self.CACity := v78.attribute[1].value;
	self.CAState := v79.attribute[1].value;
	self.CAZip := v80.attribute[1].value;
	self.CAZip4 := v81.attribute[1].value;
	self.CADateFirstReported := v82.attribute[1].value;
	self.CADateLastReported := v83.attribute[1].value;
	self.CALenOfRes := v84.attribute[1].value;
	self.CADwellType := v85.attribute[1].value;
	self.CAisNotPrimaryRes := v86.attribute[1].value;
	self.CAPhoneListed := v87.attribute[1].value;
	self.CAPhoneNumber := v88.attribute[1].value;
	self.CAMED_HHINC := v89.attribute[1].value;// new
	self.CAMED_HVAL := v90.attribute[1].value;// new
	self.CAMURDERS := v91.attribute[1].value;// new
	self.CACARTHEFT := v92.attribute[1].value;// new
	self.CABURGLARY := v93.attribute[1].value;// new
	self.CATOTCRIME := v94.attribute[1].value;// new
	
	// Characteristics of Previous Address (next most recently reported)
	self.PAAddress := v95.attribute[1].value;
	self.PACity := v96.attribute[1].value;
	self.PAState := v97.attribute[1].value;
	self.PAZip := v98.attribute[1].value;
	self.PAZip4 := v99.attribute[1].value;
	self.PADateFirstReported := v100.attribute[1].value;
	self.PADateLastReported := v101.attribute[1].value;
	self.PALenOfRes := v102.attribute[1].value;
	self.PADwellType := v103.attribute[1].value;
	self.PAisNotPrimaryRes := v104.attribute[1].value;
	self.PAPhoneListed := v105.attribute[1].value;
	self.PAPhoneNumber := v106.attribute[1].value;
	self.PAMED_HHINC := v107.attribute[1].value;// new
	self.PAMED_HVAL := v108.attribute[1].value;// new
	self.PAMURDERS := v109.attribute[1].value;// new
	self.PACARTHEFT := v110.attribute[1].value;// new
	self.PABURGLARY := v111.attribute[1].value;// new
	self.PATOTCRIME := v112.attribute[1].value;// new
	
	// Differences between Input Address and Current Address
	self.isInputCurrMatch := v113.attribute[1].value;
	self.DistInputCurr := v114.attribute[1].value;
	self.isDiffState := v115.attribute[1].value;
	self.IncomeDiff := v116.attribute[1].value;// new
	self.HomeValueDiff := v117.attribute[1].value;// new
	self.CrimeDiff := v118.attribute[1].value;// new
	self.EcoTrajectory := v119.attribute[1].value;
	
	// Differences between Current Address and Previous Address
	self.isInputPrevMatch := v120.attribute[1].value;
	self.DistCurrPrev := v121.attribute[1].value;
	self.isDiffState2 := v122.attribute[1].value;
	self.IncomeDiff2 := v123.attribute[1].value;// new
	self.HomeValueDiff2 := v124.attribute[1].value;// new
	self.CrimeDiff2 := v125.attribute[1].value;// new
	self.EcoTrajectory2 := v126.attribute[1].value;
	
	// Transient Person Attributes
	self.mobility_indicator := v127.attribute[1].value;
	self.statusAddr := v128.attribute[1].value;
	self.statusAddr2 := v129.attribute[1].value;
	self.statusAddr3 := v130.attribute[1].value;
	self.PADateFirstReported2 := v131.attribute[1].value;
	self.NPADateFirstReported := v132.attribute[1].value;
	self.addrChanges30 := v133.attribute[1].value;
	self.addrChanges90 := v134.attribute[1].value;
	self.addrChanges180 := v135.attribute[1].value;
	self.addrChanges12 := v136.attribute[1].value;
	self.addrChanges24 := v137.attribute[1].value;
	self.addrChanges36 := v138.attribute[1].value;
	self.addrChanges60 := v139.attribute[1].value;
	
	// Derogatory Public Records
//	self.felonies := v140.attribute[1].value;
//	self.date_last_conviction := v141.attribute[1].value;
//	self.felonies30 := v142.attribute[1].value;
//	self.felonies90 := v143.attribute[1].value;
//	self.felonies180 := v144.attribute[1].value;
//	self.felonies12 := v145.attribute[1].value;
//	self.felonies24 := v146.attribute[1].value;
//	self.felonies36 := v147.attribute[1].value;
//	self.felonies60 := v148.attribute[1].value;
	
	// new section
//	self.arrests := v149.attribute[1].value;
//	self.date_last_arrest := v150.attribute[1].value;
//	self.arrests30 := v151.attribute[1].value;
//	self.arrests90 := v152.attribute[1].value;
//	self.arrests180 := v153.attribute[1].value;
//	self.arrests12 := v154.attribute[1].value;
//	self.arrests24 := v155.attribute[1].value;
//	self.arrests36 := v156.attribute[1].value;
//	self.arrests60 := v157.attribute[1].value;
	
	// Higher Risk Address and Phone Attributes
		self.isAddrHighRisk := v140.attribute[1].value;
	self.isPhoneHighRisk := v141.attribute[1].value;
	self.hriskcmpy := v142.attribute[1].value;// new
	self.sic := v143.attribute[1].value;// new
	self.isAddrPrison := v144.attribute[1].value;
	self.isZipPOBox := v145.attribute[1].value;
	self.isZipCorpMil := v146.attribute[1].value;
	self.phoneStatus := v147.attribute[1].value;
	self.isPhonePager := v148.attribute[1].value;
	self.isPhoneMobile := v149.attribute[1].value;
	self.isPhoneZipMismatch := v150.attribute[1].value;
	self.phoneAddrDist := v151.attribute[1].value;
	// new section
	self.hphonetypeflag := v152.attribute[1].value;
	self.hphonesrvcflag := v153.attribute[1].value;
	self.areacodesplit := v154.attribute[1].value;
	self.altareacode := v155.attribute[1].value;
	self.addrval := v156.attribute[1].value;
	self.invalidaddr := v157.attribute[1].value;
	
	// Higher Risk Internet Connection Attributes
	self.IPinvalid := v158.attribute[1].value;
	self.IPNonUS := v159.attribute[1].value;
	self.IPState := v160.attribute[1].value;
	self.IPCountry := v161.attribute[1].value;
	self.IPContinent := v162.attribute[1].value;
	
	
	// self.rv_score := l.models[1].scores[1].i;
	// self.rv_reason := l.models[1].scores[1].reason_codes[1].reason_code;
	// self.rv_reason2 := l.models[1].scores[1].reason_codes[2].reason_code;
	// self.rv_reason3 := l.models[1].scores[1].reason_codes[3].reason_code;
	// self.rv_reason4 := l.models[1].scores[1].reason_codes[4].reason_code;
	
	self.history_date := (string)r.HistoryDateYYYYMM;
	
	self := l;
	self := [];
end;
normed := JOIN(resu, fdInput,LEFT.accountnumber=RIGHT.accountnumber, normit(LEFT,RIGHT));

output(CHOOSEN(normed, eyeball), NAMED('Sample_Normalized'));

output(normed,, outputFile, CSV(heading(single), quote('"')), overwrite);