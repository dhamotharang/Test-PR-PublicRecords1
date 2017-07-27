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
<part name="LIC_STATE" type="xsd:string"/>
<part name="C_LIC_NBR" type="xsd:string"/>
<part name="DEA_NUMBER" type="xsd:string"/>
<part name="VENDOR_ID" type="xsd:string"/>
<part name="NPI_NUMBER" type="xsd:string"/>
<part name="CLIA_NUMBER" type="xsd:string"/>
<part name="MEDICARE_FACILITY_NUMBER" type="xsd:string"/>
<part name="BDID" type="xsd:string"/>
<part name="SRC" type="xsd:string"/>
<part name="SOURCE_RID" type="xsd:string"/>
<part name="ADDR1" type="xsd:string"/>
<part name="LOCALE" type="xsd:string"/>
<part name="ADDRESS" type="xsd:string"/>
<part name="LNPID" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
/*--INFO-- Return all available data for LNPID with similar fields to the one provided</p><p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>CNP_NAME:ZIP
</p><p>CNP_NAME:ST
</p><p>CNP_NAME
</p><p>PRIM_NAME:PRIM_RANGE:ZIP
</p><p>PRIM_NAME:ZIP
</p><p>PRIM_NAME:V_CITY_NAME:ST
</p><p>PHONE
</p><p>C_LIC_NBR:LIC_STATE
</p><p>VENDOR_ID
</p><p>TAX_ID
</p><p>FEIN
</p><p>DEA_NUMBER
</p><p>NPI_NUMBER
</p><p>BDID
</p>*/
EXPORT xLNPID_FragHunter_Service := MACRO
  IMPORT SALT29,Health_Facility_Services;
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
  SALT29.StrType Input_LIC_STATE := '' : STORED('LIC_STATE');
  SALT29.StrType Input_C_LIC_NBR := '' : STORED('C_LIC_NBR');
  SALT29.StrType Input_DEA_NUMBER := '' : STORED('DEA_NUMBER');
  SALT29.StrType Input_VENDOR_ID := '' : STORED('VENDOR_ID');
  SALT29.StrType Input_NPI_NUMBER := '' : STORED('NPI_NUMBER');
  SALT29.StrType Input_CLIA_NUMBER := '' : STORED('CLIA_NUMBER');
  SALT29.StrType Input_MEDICARE_FACILITY_NUMBER := '' : STORED('MEDICARE_FACILITY_NUMBER');
  SALT29.StrType Input_BDID := '' : STORED('BDID');
  SALT29.StrType Input_SRC := '' : STORED('SRC');
  SALT29.StrType Input_SOURCE_RID := '' : STORED('SOURCE_RID');
  SALT29.StrType Input_ADDR1 := '' : STORED('ADDR1');
  SALT29.StrType Input_LOCALE := '' : STORED('LOCALE');
  SALT29.StrType Input_ADDRESS := '' : STORED('ADDRESS');
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID');
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds');
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED e_LNPID := 0 : STORED('LNPID');
  Template := DATASET([],Health_Facility_Services.Process_xLNPID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds
  ,(TYPEOF(Template.CNAME))Health_Facility_Services.Fields.Make_CNAME((SALT29.StrType)Input_CNAME)
  ,(TYPEOF(Template.CNP_NAME))Health_Facility_Services.Fields.Make_CNP_NAME((SALT29.StrType)Input_CNP_NAME)
  ,(TYPEOF(Template.CNP_NUMBER))Health_Facility_Services.Fields.Make_CNP_NUMBER((SALT29.StrType)Input_CNP_NUMBER)
  ,(TYPEOF(Template.CNP_STORE_NUMBER))Health_Facility_Services.Fields.Make_CNP_STORE_NUMBER((SALT29.StrType)Input_CNP_STORE_NUMBER)
  ,(TYPEOF(Template.CNP_BTYPE))Health_Facility_Services.Fields.Make_CNP_BTYPE((SALT29.StrType)Input_CNP_BTYPE)
  ,(TYPEOF(Template.CNP_LOWV))Health_Facility_Services.Fields.Make_CNP_LOWV((SALT29.StrType)Input_CNP_LOWV)
  ,(TYPEOF(Template.PRIM_RANGE))Health_Facility_Services.Fields.Make_PRIM_RANGE((SALT29.StrType)Input_PRIM_RANGE)
  ,(TYPEOF(Template.PRIM_NAME))Input_PRIM_NAME
  ,(TYPEOF(Template.SEC_RANGE))Input_SEC_RANGE
  ,(TYPEOF(Template.V_CITY_NAME))Input_V_CITY_NAME
  ,(TYPEOF(Template.ST))Input_ST
  ,(TYPEOF(Template.ZIP))Input_ZIP
  ,(TYPEOF(Template.TAX_ID))Input_TAX_ID
  ,(TYPEOF(Template.FEIN))Input_FEIN
  ,(TYPEOF(Template.PHONE))Health_Facility_Services.Fields.Make_PHONE((SALT29.StrType)Input_PHONE)
  ,(TYPEOF(Template.LIC_STATE))Health_Facility_Services.Fields.Make_LIC_STATE((SALT29.StrType)Input_LIC_STATE)
  ,(TYPEOF(Template.C_LIC_NBR))Health_Facility_Services.Fields.Make_C_LIC_NBR((SALT29.StrType)Input_C_LIC_NBR)
  ,(TYPEOF(Template.DEA_NUMBER))Health_Facility_Services.Fields.Make_DEA_NUMBER((SALT29.StrType)Input_DEA_NUMBER)
  ,(TYPEOF(Template.VENDOR_ID))Health_Facility_Services.Fields.Make_VENDOR_ID((SALT29.StrType)Input_VENDOR_ID)
  ,(TYPEOF(Template.NPI_NUMBER))Health_Facility_Services.Fields.Make_NPI_NUMBER((SALT29.StrType)Input_NPI_NUMBER)
  ,(TYPEOF(Template.CLIA_NUMBER))Health_Facility_Services.Fields.Make_CLIA_NUMBER((SALT29.StrType)Input_CLIA_NUMBER)
  ,(TYPEOF(Template.MEDICARE_FACILITY_NUMBER))Health_Facility_Services.Fields.Make_MEDICARE_FACILITY_NUMBER((SALT29.StrType)Input_MEDICARE_FACILITY_NUMBER)
  ,(TYPEOF(Template.BDID))Health_Facility_Services.Fields.Make_BDID((SALT29.StrType)Input_BDID)
  ,(TYPEOF(Template.SRC))Health_Facility_Services.Fields.Make_SRC((SALT29.StrType)Input_SRC)
  ,(TYPEOF(Template.SOURCE_RID))Health_Facility_Services.Fields.Make_SOURCE_RID((SALT29.StrType)Input_SOURCE_RID)
  ,(TYPEOF(Template.ADDR1))Health_Facility_Services.Fields.Make_ADDR1((SALT29.StrType)Input_ADDR1)
  ,(TYPEOF(Template.LOCALE))Health_Facility_Services.Fields.Make_LOCALE((SALT29.StrType)Input_LOCALE)
  ,(TYPEOF(Template.ADDRESS))Health_Facility_Services.Fields.Make_ADDRESS((SALT29.StrType)Input_ADDRESS)
  ,false,false,e_LNPID}],Health_Facility_Services.Process_xLNPID_Layouts.InputLayout);
  pm := Health_Facility_Services.MEOW_xLNPID(Input_Data); // This module performs regular xLNPID functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,LNPID);
  odm := Health_Facility_Services.MEOW_xLNPID(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
