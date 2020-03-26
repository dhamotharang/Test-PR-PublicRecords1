/*--SOAP--
<message name="MEOW_LocationID_Service">
<part name="prim_range" type="xsd:string"/>
<part name="predir" type="xsd:string"/>
<part name="prim_name_derived" type="xsd:string"/>
<part name="addr_suffix_derived" type="xsd:string"/>
<part name="postdir" type="xsd:string"/>
<part name="err_stat" type="xsd:string"/>
<part name="unit_desig" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="v_city_name" type="xsd:string"/>
<part name="st" type="xsd:string"/>
<part name="zip5" type="xsd:string"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Attempt to resolve or find LocIds.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>v_city_name:st:prim_range:prim_name_derived</p>
<p>zip5:prim_range:prim_name_derived</p>
*/
EXPORT MEOW_LocationID_Service := MACRO
  IMPORT SALT37,LocationId_xLink;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT37.StrType Input_prim_range := '' : STORED('prim_range', FORMAT(SEQUENCE(4)));
  SALT37.StrType Input_predir := '' : STORED('predir', FORMAT(SEQUENCE(5)));
  SALT37.StrType Input_prim_name_derived := '' : STORED('prim_name_derived', FORMAT(SEQUENCE(6)));
  SALT37.StrType Input_addr_suffix_derived := '' : STORED('addr_suffix_derived', FORMAT(SEQUENCE(7)));
  SALT37.StrType Input_postdir := '' : STORED('postdir', FORMAT(SEQUENCE(8)));
  SALT37.StrType Input_err_stat := '' : STORED('err_stat', FORMAT(SEQUENCE(9)));
  SALT37.StrType Input_unit_desig := '' : STORED('unit_desig', FORMAT(SEQUENCE(10)));
  SALT37.StrType Input_sec_range := '' : STORED('sec_range', FORMAT(SEQUENCE(11)));
  SALT37.StrType Input_v_city_name := '' : STORED('v_city_name', FORMAT(SEQUENCE(12)));
  SALT37.StrType Input_st := '' : STORED('st', FORMAT(SEQUENCE(13)));
  SALT37.StrType Input_zip5 := '' : STORED('zip5', FORMAT(SEQUENCE(14)));
  UNSIGNED e_LocId := 0 : STORED('LocId', FORMAT(SEQUENCE(15)));
  UNSIGNED e_rid := 0 : STORED('rid', FORMAT(SEQUENCE(16)));
 
  Template := DATASET([],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.predir))Input_predir
  ,(TYPEOF(Template.prim_name_derived))Input_prim_name_derived
  ,(TYPEOF(Template.addr_suffix_derived))Input_addr_suffix_derived
  ,(TYPEOF(Template.postdir))Input_postdir
  ,(TYPEOF(Template.err_stat))Input_err_stat
  ,(TYPEOF(Template.unit_desig))Input_unit_desig
  ,(TYPEOF(Template.sec_range))LocationId_xLink.Fields.Make_sec_range((SALT37.StrType)Input_sec_range)
  ,(TYPEOF(Template.v_city_name))Input_v_city_name
  ,(TYPEOF(Template.st))Input_st
  ,(TYPEOF(Template.zip5))Input_zip5
  ,false,false,0,0}],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
 
  pm := LocationId_xLink.MEOW_LocationID(Input_Data); // This module performs regular xLocId functions
  OUTPUT(pm.Raw_Results,NAMED('Results'));
ENDMACRO;
