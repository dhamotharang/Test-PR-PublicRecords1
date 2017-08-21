/*--SOAP--
<message name="xLNPID_FragHunter_Service">
<part name="CNAME" type="xsd:string"/>
<part name="CNP_NAME" type="xsd:string"/>
<part name="CNP_NUMBER" type="xsd:string"/>
<part name="CNP_STORE_NUMBER" type="xsd:string"/>
<part name="CNP_BTYPE" type="xsd:string"/>
<part name="CNP_LOWV" type="xsd:string"/>
<part name="PRIM_RANGE" type="xsd:string"/>
<part name="PRIM_NAME" type="xsd:string"/>
<part name="SEC_RANGE" type="xsd:string"/>
<part name="V_CITY_NAME" type="xsd:string"/>
<part name="ST" type="xsd:string"/>
<part name="ZIP" type="xsd:string"/>
<part name="TAX_ID" type="xsd:string"/>
<part name="FEIN" type="xsd:string"/>
<part name="PHONE" type="xsd:string"/>
<part name="FAX" type="xsd:string"/>
<part name="LIC_STATE" type="xsd:string"/>
<part name="C_LIC_NBR" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="CLIA_NUMBER" type="xsd:string"/>
<part name="MEDICARE_FACILITY_NUMBER" type="xsd:string"/>
<part name="MEDICAID_NUMBER" type="xsd:string"/>
<part name="NCPDP_NUMBER" type="xsd:string"/>
<part name="TAXONOMY" type="xsd:string"/>
<part name="TAXONOMY_CODE" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="FAC_NAME" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRES" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Return all available data for LNPID with similar fields to the one provided</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>CNP_NAME:ZIP
</p><p>CNP_NAME
</p><p>CNP_NAME:ST
</p><p>PRIM_NAME:PRIM_RANGE:ZIP
</p><p>PRIM_NAME:ZIP
</p><p>PRIM_NAME:V_CITY_NAME:ST
</p><p>PHONE
</p><p>FAX
</p><p>C_LIC_NBR
</p><p>VENDOR_ID
</p><p>TAX_ID
</p><p>FEIN
</p><p>DEA_NUMBER
</p><p>NPI_NUMBER
</p><p>NPI_NUMBER
</p><p>CLIA_NUMBER
</p><p>MEDICARE_FACILITY_NUMBER
</p><p>MEDICAID_NUMBER
</p><p>NCPDP_NUMBER
</p><p>BDID
</p>*/
EXPORT xLNPID_FragHunter_Service := MACRO
  IMPORT SALT29,PRTE_Health_Facility_Services;
  SALT29.StrType Input_CNAME := '' : STORED('CNAME');
  SALT29.StrType Input_CNP_NAME := '' : STORED('CNP_NAME');
  SALT29.StrType Input_CNP_NUMBER := '' : STORED('CNP_NUMBER');
  SALT29.StrType Input_CNP_STORE_NUMBER := '' : STORED('CNP_STORE_NUMBER');
  SALT29.StrType Input_CNP_BTYPE := '' : STORED('CNP_BTYPE');
  SALT29.StrType Input_CNP_LOWV := '' : STORED('CNP_LOWV');
  SALT29.StrType Input_PRIM_RANGE := '' : STORED('PRIM_RANGE');
  SALT29.StrType Input_PRIM_NAME := '' : STORED('PRIM_NAME');
  SALT29.StrType Input_SEC_RANGE := '' : STORED('SEC_RANGE');
  SALT29.StrType Input_V_CITY_NAME := '' : STORED('V_CITY_NAME');
  SALT29.StrType Input_ST := '' : STORED('ST');
  SALT29.StrType Input_ZIP := '' : STORED('ZIP');
  SALT29.StrType Input_TAX_ID := '' : STORED('TAX_ID');
  SALT29.StrType Input_FEIN := '' : STORED('FEIN');
  SALT29.StrType Input_PHONE := '' : STORED('PHONE');
  SALT29.StrType Input_FAX := '' : STORED('FAX');
  SALT29.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT29.StrType Input_C_LIC_NBR := '' : STORED('C_LIC_NBR');
  SALT29.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT29.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT29.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT29.StrType Input_CLIA_NUMBER := '' : STORED('CLIA_NUMBER');
  SALT29.StrType Input_MEDICARE_FACILITY_NUMBER := '' : STORED('MEDICARE_FACILITY_NUMBER');
  SALT29.StrType Input_MEDICAID_NUMBER := '' : STORED('MEDICAID_NUMBER');
  SALT29.StrType Input_NCPDP_NUMBER := '' : STORED('NCPDP_NUMBER');
  SALT29.StrType Input_TAXONOMY := '' : STORED('TAXONOMY');
  SALT29.StrType Input_TAXONOMY_CODE := '' : STORED('TAXONOMY_CODE');
  SALT29.StrType Input_BDID := '' : STORED('BDID');
  SALT29.StrType Input_SRC := '' : STORED('SRC');
  SALT29.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  SALT29.StrType Input_FAC_NAME := '' : STORED('FAC_NAME');
  SALT29.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT29.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT29.StrType Input_ADDRES := '' : STORED('ADDRES');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold');
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
  Template := DATASET([],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.CNAME))PRTE_Health_Facility_Services.Fields.Make_CNAME((SALT29.StrType)Input_CNAME)
  ,(TYPEOF(Template.CNP_NAME))PRTE_Health_Facility_Services.Fields.Make_CNP_NAME((SALT29.StrType)Input_CNP_NAME)
  ,(TYPEOF(Template.CNP_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CNP_NUMBER((SALT29.StrType)Input_CNP_NUMBER)
  ,(TYPEOF(Template.CNP_STORE_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CNP_STORE_NUMBER((SALT29.StrType)Input_CNP_STORE_NUMBER)
  ,(TYPEOF(Template.CNP_BTYPE))PRTE_Health_Facility_Services.Fields.Make_CNP_BTYPE((SALT29.StrType)Input_CNP_BTYPE)
  ,(TYPEOF(Template.CNP_LOWV))PRTE_Health_Facility_Services.Fields.Make_CNP_LOWV((SALT29.StrType)Input_CNP_LOWV)
  ,(TYPEOF(Template.PRIM_RANGE))Input_PRIM_RANGE
  ,(TYPEOF(Template.PRIM_NAME))Input_PRIM_NAME
  ,(TYPEOF(Template.SEC_RANGE))Input_SEC_RANGE
  ,(TYPEOF(Template.V_CITY_NAME))Input_V_CITY_NAME
  ,(TYPEOF(Template.ST))Input_ST
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.TAX_ID))Input_TAX_ID
  ,(TYPEOF(Template.FEIN))Input_FEIN
  ,(TYPEOF(Template.PHONE))PRTE_Health_Facility_Services.Fields.Make_PHONE((SALT29.StrType)Input_PHONE)
  ,(TYPEOF(Template.FAX))PRTE_Health_Facility_Services.Fields.Make_FAX((SALT29.StrType)Input_FAX)
  ,(TYPEOF(Template.LIC_STATE))PRTE_Health_Facility_Services.Fields.Make_LIC_STATE((SALT29.StrType)Input_LIC_STATE)
  ,(TYPEOF(Template.C_LIC_NBR))PRTE_Health_Facility_Services.Fields.Make_C_LIC_NBR((SALT29.StrType)Input_C_LIC_NBR)
  ,(TYPEOF(Template.DEA_NUMBER))PRTE_Health_Facility_Services.Fields.Make_DEA_NUMBER((SALT29.StrType)Input_DEA_NUMBER)
  ,(TYPEOF(Template.VENDOR_ID))PRTE_Health_Facility_Services.Fields.Make_VENDOR_ID((SALT29.StrType)Input_VENDOR_ID)
  ,(TYPEOF(Template.NPI_NUMBER))PRTE_Health_Facility_Services.Fields.Make_NPI_NUMBER((SALT29.StrType)Input_NPI_NUMBER)
  ,(TYPEOF(Template.CLIA_NUMBER))PRTE_Health_Facility_Services.Fields.Make_CLIA_NUMBER((SALT29.StrType)Input_CLIA_NUMBER)
  ,(TYPEOF(Template.MEDICARE_FACILITY_NUMBER))PRTE_Health_Facility_Services.Fields.Make_MEDICARE_FACILITY_NUMBER((SALT29.StrType)Input_MEDICARE_FACILITY_NUMBER)
  ,(TYPEOF(Template.MEDICAID_NUMBER))PRTE_Health_Facility_Services.Fields.Make_MEDICAID_NUMBER((SALT29.StrType)Input_MEDICAID_NUMBER)
  ,(TYPEOF(Template.NCPDP_NUMBER))PRTE_Health_Facility_Services.Fields.Make_NCPDP_NUMBER((SALT29.StrType)Input_NCPDP_NUMBER)
  ,(TYPEOF(Template.TAXONOMY))PRTE_Health_Facility_Services.Fields.Make_TAXONOMY((SALT29.StrType)Input_TAXONOMY)
  ,(TYPEOF(Template.TAXONOMY_CODE))PRTE_Health_Facility_Services.Fields.Make_TAXONOMY_CODE((SALT29.StrType)Input_TAXONOMY_CODE)
  ,(TYPEOF(Template.BDID))PRTE_Health_Facility_Services.Fields.Make_BDID((SALT29.StrType)Input_BDID)
  ,(TYPEOF(Template.SRC))PRTE_Health_Facility_Services.Fields.Make_SRC((SALT29.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))PRTE_Health_Facility_Services.Fields.Make_SOURCE_RID((SALT29.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.FAC_NAME))PRTE_Health_Facility_Services.Fields.Make_FAC_NAME((SALT29.StrType)Input_FAC_NAME)
  ,(TYPEOF(Template.ADDR1))PRTE_Health_Facility_Services.Fields.Make_ADDR1((SALT29.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))PRTE_Health_Facility_Services.Fields.Make_LOCALE((SALT29.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRES))PRTE_Health_Facility_Services.Fields.Make_ADDRES((SALT29.StrType)Input_ADDRES)
  ,false,false,e_LNPID}],PRTE_Health_Facility_Services.Process_xLNPID_Layouts.InputLayout);
  pm := PRTE_Health_Facility_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,LNPID);
  odm := PRTE_Health_Facility_Services.MEOW_xLNPID(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
