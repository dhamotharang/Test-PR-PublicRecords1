import HealthCareProvider;
export mac_append_provider_data  (Infile,Input_LNPID,
																	Input_PRIM_RANGE = '',Input_PRIM_NAME = '',Input_SEC_RANGE = '',Input_V_CITY_Name = '',Input_ST = '',Input_ZIP = '',
																	Input_LIC_STATE = '',Input_LIC_NBR = '',
																	Input_DEA_NUMBER = '',Input_NPI_NUMBER = '',Outfile) := MACRO
			
#UNIQUENAME(hasUniqueId)
ut.hasField(infile, UniqueId, %hasUniqueId%);

#uniquename(layout_seq)
%layout_seq% := record
	#IF (~%hasUniqueID%) unsigned8 uniqueID; #END	
	recordof(infile);
end;

#uniquename(AssignSeq)
%layout_seq% %AssignSeq%(infile l, unsigned4 cnt) := transform
	self.uniqueID := #IF (%hasUniqueID%) l.uniqueID; #ELSE cnt; #END
	self := l;
end;

#uniquename(infile_seq_1)
%infile_seq_1% := project(infile, %AssignSeq%(left, counter));
#uniquename(infile_seq)
%infile_seq% := %infile_seq_1%; //if(%asIndex%, distribute(%infile_seq_1%, uniqueId), %infile_seq_1%);

#uniquename(into)
HealthCareProvider.Layouts.Best_Data_Input %into%(%infile_seq% le) := TRANSFORM
  SELF.UniqueId := le.uniqueId;
	#IF ( #TEXT(Input_LNPID) <> '' )
    SELF.LNPID := (TYPEOF(SELF.LNPID))le.Input_LNPID;
  #ELSE
    SELF.LNPID := (TYPEOF(SELF.LNPID))'';
  #END
  #IF ( #TEXT(Input_PRIM_RANGE) <> '' )
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))le.Input_PRIM_RANGE;
  #ELSE
    SELF.PRIM_RANGE := (TYPEOF(SELF.PRIM_RANGE))'';
  #END
  #IF ( #TEXT(Input_PRIM_NAME) <> '' )
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))le.Input_PRIM_NAME;
  #ELSE
    SELF.PRIM_NAME := (TYPEOF(SELF.PRIM_NAME))'';
  #END
  #IF ( #TEXT(Input_SEC_RANGE) <> '' )
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))le.Input_SEC_RANGE;
  #ELSE
    SELF.SEC_RANGE := (TYPEOF(SELF.SEC_RANGE))'';
  #END
  #IF ( #TEXT(Input_V_CITY_NAME) <> '' )
    SELF.CITY := (TYPEOF(SELF.CITY))le.Input_V_CITY_NAME;
  #ELSE
    SELF.CITY := (TYPEOF(SELF.CITY))'';
  #END
  #IF ( #TEXT(Input_ST) <> '' )
    SELF.ST := (TYPEOF(SELF.ST))le.Input_ST;
  #ELSE
    SELF.ST := (TYPEOF(SELF.ST))'';
  #END
  #IF ( #TEXT(Input_ZIP) <> '' )
    SELF.ZIP := (TYPEOF(SELF.ZIP))le.Input_ZIP;
  #ELSE
    SELF.ZIP := (TYPEOF(SELF.ZIP))'';
  #END
  #IF ( #TEXT(Input_LIC_STATE) <> '' )
    SELF.PROV_LIC_STATE := (TYPEOF(SELF.PROV_LIC_STATE))le.Input_LIC_STATE;
  #ELSE
    SELF.PROV_LIC_STATE := (TYPEOF(SELF.PROV_LIC_STATE))'';
  #END
  #IF ( #TEXT(Input_LIC_NBR) <> '' )
    SELF.PROV_LIC_NBR := (TYPEOF(SELF.PROV_LIC_NBR))le.Input_LIC_NBR;
  #ELSE
    SELF.PROV_LIC_NBR := (TYPEOF(SELF.PROV_LIC_NBR))'';
  #END
  #IF ( #TEXT(Input_DEA_NUMBER) <> '' )
    SELF.PROV_DEA_NUMBER := (TYPEOF(SELF.PROV_DEA_NUMBER))le.Input_DEA_NUMBER;
  #ELSE
    SELF.PROV_DEA_NUMBER := (TYPEOF(SELF.PROV_DEA_NUMBER))'';
  #END
  #IF ( #TEXT(Input_NPI_NUMBER) <> '' )
    SELF.PROV_NPI_NUMBER := (TYPEOF(SELF.PROV_NPI_NUMBER))le.Input_NPI_NUMBER;
  #ELSE
    SELF.PROV_NPI_NUMBER := (TYPEOF(SELF.PROV_NPI_NUMBER))'';
  #END
	SELF := [];
END;

#uniquename(pr)
%pr% := project(%infile_seq%,%into%(left)); // Into roxie input format

#uniquename(best_data)
%best_data% := HealthCareProvider.ExtractBestData (%pr%);

#uniquename(layout_result)
%layout_result% := record
		recordof(infile);
		UNSIGNED8 PREFIX_LexID;
		STRING1	  Header_Entity_Type;
		STRING9	  Header_SSN;
		STRING9	  Header_Consumer_SSN;
		UNSIGNED4 Header_DateOfBirth;
		UNSIGNED4 Header_Consumer_DateOfBirth;
		STRING25  Header_LicenseNumber;
		STRING25  Header_CleanedLicenseNumber;
		STRING2	  Header_LicenseState;
		STRING60  Header_LicenseType;
		STRING60  Header_LicenseStatus;
		UNSIGNED4 Header_DateLicenseExpired; 
		STRING1	  Header_DeathIndicator;
		UNSIGNED4 Header_DateOfDeath;
		UNSIGNED4 Header_BillingTaxID;
		STRING10  Header_Phone;
		STRING10  Header_Fax;
		STRING6	  Header_UPIN;
		STRING10  Header_NPINUMBER;
		UNSIGNED4	Header_DateNPIDeactivated;
		STRING1	  Header_DEABusinessActivityIndicator;		
		STRING10  Header_DEANumber;
		UNSIGNED4 Header_DateDEAExpired;
		BOOLEAN	  Header_isStateSanction;
		BOOLEAN	  Header_isOfficeOfInspectorGeneralSanction;
		BOOLEAN	  Header_isOfficeOfPersonalManagementSanction;
		STRING10  Header_Taxonomy;
		STRING50  Header_TaxonomyDescription;		
		STRING3	  Header_SpecialityCode;	
		STRING1	  Header_ProviderStatus;
		UNSIGNED4 Header_LicenseCount;
		UNSIGNED4 Header_LicenseStateCount;
		UNSIGNED4 Header_ActiveLicenseCount;
		UNSIGNED4 Header_InactiveLicenseCount;
		UNSIGNED4 Header_RevokedLicenseCount;
		UNSIGNED4 Header_DEACount;
		UNSIGNED4 Header_ActiveDEACount;
		UNSIGNED4 Header_ExpiredDEACount;
		UNSIGNED4 Header_DeactivedNPICount;		
		STRING10  Header_PracticePrimaryRange;
		STRING2   Header_PracticePreDirection;
		STRING28  Header_PracticePrimaryName;
		STRING4   Header_PracticeAddressSuffix;
		STRING2   Header_PracticePostDirection;
		STRING10  Header_PracticeUnitDesignation;
		STRING8   Header_PracticeSecondaryRange;
		STRING25  Header_PracticeCityName_Vanity;
		STRING2   Header_PracticeState;
		STRING5   Header_PracticeZip5;
		UNSIGNED4 Header_PracticeAddressLastVerified;
		UNSIGNED4 Client_DateLicenseExpired;
		STRING60  Client_LicenseType;		
		STRING60  Client_LicenseStatus;		
		UNSIGNED4 Client_DateNPIDeactivated;
		STRING1	  Client_NPIFlag;
		UNSIGNED4 Client_DateDEAExpired;		
		STRING1	  Client_DEAFlag;		
		STRING40	Group_Key;
		STRING1		Practice_Address_Flag;
end;

outfile := join (%infile_seq%,%best_data%,left.uniqueid = right.uniqueid,transform(%layout_result%, 
		SELF.PREFIX_LexID													:=	RIGHT.HDR_DID;
		SELF.Header_Entity_Type										:=	RIGHT.HDR_ENTITY_TYPE;
		SELF.Header_SSN														:=	RIGHT.HDR_SSN;
		SELF.Header_Consumer_SSN									:=	RIGHT.HDR_CNSMR_SSN;
		SELF.Header_DateOfBirth										:=	RIGHT.HDR_DOB;
		SELF.Header_Consumer_DateOfBirth					:=	RIGHT.HDR_CNSMR_DOB;
		SELF.Header_LicenseNumber									:=	RIGHT.HDR_LIC_NBR;
		SELF.Header_CleanedLicenseNumber					:=	RIGHT.HDR_C_LIC_NBR;
		SELF.Header_LicenseState									:=	RIGHT.HDR_LIC_STATE;
		SELF.Header_LicenseType										:=	RIGHT.HDR_LIC_TYPE;
		SELF.Header_LicenseStatus									:=	RIGHT.HDR_LIC_STATUS;
		SELF.Header_DateLicenseExpired						:= 	RIGHT.HDR_DT_LIC_EXPIRATION; 
		SELF.Header_DeathIndicator								:=	RIGHT.HDR_DEATH_IND;
		SELF.Header_DateOfDeath										:=	RIGHT.HDR_DOD;
		SELF.Header_BillingTaxID									:=	RIGHT.HDR_BILLING_TAX_ID;
		SELF.Header_Phone													:=	RIGHT.HDR_PHONE;
		SELF.Header_Fax														:=	RIGHT.HDR_FAX;
		SELF.Header_UPIN													:=	RIGHT.HDR_UPIN;
		SELF.Header_NPINUMBER											:=	RIGHT.HDR_NPI_NUMBER;
		SELF.Header_DateNPIDeactivated						:=	RIGHT.HDR_DT_NPI_DEACTIVATED;
		SELF.Header_DEABusinessActivityIndicator	:=	RIGHT.HDR_DEA_BUS_ACT_IND;		
		SELF.Header_DEANumber											:=	RIGHT.HDR_DEA_NUMBER;
		SELF.Header_DateDEAExpired								:=	RIGHT.HDR_DT_DEA_EXPIRATION;
		SELF.Header_isStateSanction								:=	RIGHT.HDR_IS_STATE_SANCTION;
		SELF.Header_isOfficeOfInspectorGeneralSanction	:=		RIGHT.HDR_IS_OIG_SANCTION;
		SELF.Header_isOfficeOfPersonalManagementSanction:=	RIGHT.HDR_IS_OPM_SANCTION;
		SELF.Header_Taxonomy											:=	RIGHT.HDR_TAXONOMY;
		SELF.Header_TaxonomyDescription						:=	RIGHT.HDR_TAXONOMY_Desc;		
		SELF.Header_SpecialityCode								:=	RIGHT.HDR_SPECIALITY_CODE;	
		SELF.Header_ProviderStatus								:=	RIGHT.HDR_PROVIDER_STATUS;
		SELF.Header_LicenseCount									:=	RIGHT.HDR_LIC_CNT;
		SELF.Header_LicenseStateCount							:=	RIGHT.HDR_LIC_ST_CNT;
		SELF.Header_ActiveLicenseCount						:=	RIGHT.HDR_ACTIVE_LIC_CNT;
		SELF.Header_InactiveLicenseCount					:=	RIGHT.HDR_INACTIVE_LIC_CNT;
		SELF.Header_RevokedLicenseCount						:=	RIGHT.HDR_REVOKED_LIC_CNT;
		SELF.Header_DEACount											:=	RIGHT.HDR_DEA_CNT;
		SELF.Header_ActiveDEACount								:=	RIGHT.HDR_DEA_ACTIVE_CNT;
		SELF.Header_ExpiredDEACount								:=	RIGHT.HDR_DEA_EXPIRED_CNT;
		SELF.Header_DeactivedNPICount							:=	RIGHT.HDR_NPI_DEACT_CNT;		
		SELF.Header_PracticePrimaryRange					:=	RIGHT.HDR_PRAC_PRIM_RANGE;
		SELF.Header_PracticePreDirection					:=	RIGHT.HDR_PRAC_PREDIR;
		SELF.Header_PracticePrimaryName						:=	RIGHT.HDR_PRAC_PRIM_NAME;
		SELF.Header_PracticeAddressSuffix					:=	RIGHT.HDR_PRAC_ADDR_SUFFIX;
		SELF.Header_PracticePostDirection					:=	RIGHT.HDR_PRAC_POSTDIR;
		SELF.Header_PracticeUnitDesignation				:=	RIGHT.HDR_PRAC_UNIT_DESIG;
		SELF.Header_PracticeSecondaryRange				:=	RIGHT.HDR_PRAC_SEC_RANGE;
		SELF.Header_PracticeCityName_Vanity				:=	RIGHT.HDR_PRAC_CITY_NAME;
		SELF.Header_PracticeState									:=	RIGHT.HDR_PRAC_ST;
		SELF.Header_PracticeZip5									:=	RIGHT.HDR_PRAC_ZIP;
		SELF.Header_PracticeAddressLastVerified		:=	RIGHT.HDR_PRAC_ADDR_LAST_VERIFIED;
		SELF.Client_DateLicenseExpired						:=	RIGHT.PROV_DT_LIC_EXPIRED;
		SELF.Client_LicenseType										:=	RIGHT.PROV_LIC_TYPE;		
		SELF.Client_LicenseStatus									:=	RIGHT.PROV_LIC_STATUS;		
		SELF.Client_DateNPIDeactivated						:=	RIGHT.PROV_DT_NPI_DEACTIVATED;
		SELF.Client_NPIFlag												:=	RIGHT.PROV_NPI_FLAG;
		SELF.Client_DateDEAExpired								:=	RIGHT.PROV_DT_DEA_EXPIRATION;		
		SELF.Client_DEAFlag												:=	RIGHT.PROV_DEA_FLAG;		
		SELF.Group_Key														:=	RIGHT.Group_Key;
		SELF.Practice_Address_Flag								:=	RIGHT.Practice_Address_Flag;
		SELF := LEFT;),HASH);
ENDMACRO;																			
