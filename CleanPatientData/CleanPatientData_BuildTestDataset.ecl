Input_Record := RECORD
		STRING50   PatientKey;
		STRING12   PatientNumber;
		STRING2    PatientSequenceNumber;
		STRING2    PatientSecurityCode;
		STRING2    PatientRelation;
		STRING9    PatientSocialSecurityNumber;
		STRING30   PatientFirstName;
		STRING1    PatientMiddleName;
		STRING36   PatientLastName;
		STRING36   PatientAddressLine1;
		STRING36   PatientAddressLine2;
		STRING24   PatientCityName;
		STRING2    PatientState;
		STRING5    PatientZip5;
		STRING30   PatientCounty;
		STRING2    PatientCountry;
		STRING8    PatientDateOfBirth;
		STRING1    PatientGender;
		STRING8    PatientDeathOfDeath;
		STRING8    InsuredEligibleEffectiveDate;
		STRING8    InsuredEligibleExpirationDate;
		STRING6    InsuredEligibleCoverageType;
		STRING4    InsuredEligibleStatus;
		STRING50   PrimaryMemberKey;
		STRING9    PrimaryInsuredSocialSecurityNumber;
		STRING12   PrimaryInsuredNumber;
		STRING12   PrimaryInsuredPolicyNumber;
		STRING15   PrimaryInsuredGroupNumber;
		STRING11   PrimaryInsuredDivisionNumber;
		STRING8    PatientLatestUpdateDate;
		STRING50   UserDefinedField01;
		STRING50   UserDefinedField02;
		STRING50   UserDefinedField03;
		STRING50   UserDefinedField04;
		STRING50   UserDefinedField05;
		STRING50   UserDefinedField06;
		STRING50   UserDefinedField07;
		STRING50   UserDefinedField08;
		STRING50   UserDefinedField09;
		STRING50   UserDefinedField10;
END;

ds := DATASET
    (
        [
            {'57925','00040183101','','','18','000401831','RAPHAEL','','LABENS','6413 KING LAWRENCE ROAD','','RALEIGH','NC','27607','NC183','','19760308','M','','20120816','20130715','SNGL','T','57925','000401831','57925','163830','008312','008312A','','','','','','','','','','',''}
        ],
        Input_Record
    );

OUTPUT(ds,,'~qa::cleanpatientdata::cleanpatientdata::input',OVERWRITE);
