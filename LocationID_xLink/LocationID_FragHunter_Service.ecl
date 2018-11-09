/*--SOAP--
<message name="LocationID_FragHunter_Service">
<part name="prim_range" type="xsd:string"/>
<part name="predir" type="xsd:string"/>
<part name="prim_name" type="xsd:string"/>
<part name="addr_suffix" type="xsd:string"/>
<part name="postdir" type="xsd:string"/>
<part name="unit_desig" type="xsd:string"/>
<part name="sec_range" type="xsd:string"/>
<part name="v_city_name" type="xsd:string"/>
<part name="st" type="xsd:string"/>
<part name="zip5" type="xsd:string"/>
<part name="LocId" type="unsignedInt"/>
<part name="rid" type="unsignedInt"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Return all available data for LocId with similar fields to the one provided</p>
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>v_city_name:st:prim_range:prim_name</p>
<p>zip5:prim_range:prim_name</p>
*/
EXPORT LocationID_FragHunter_Service := MACRO
  IMPORT SALT37,LocationId_xLink;
  UNSIGNED Input_UniqueID := 0 : STORED('UniqueID', FORMAT(SEQUENCE(1)));
  UNSIGNED InputMaxIds0 := 0 : STORED('MaxIds', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_MaxIds := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold := 0 : STORED('LeadThreshold', FORMAT(SEQUENCE(3)));
  SALT37.StrType Input_prim_range := '' : STORED('prim_range', FORMAT(SEQUENCE(4)));
  SALT37.StrType Input_predir := '' : STORED('predir', FORMAT(SEQUENCE(5)));
  SALT37.StrType Input_prim_name := '' : STORED('prim_name', FORMAT(SEQUENCE(6)));
  SALT37.StrType Input_addr_suffix := '' : STORED('addr_suffix', FORMAT(SEQUENCE(7)));
  SALT37.StrType Input_postdir := '' : STORED('postdir', FORMAT(SEQUENCE(8)));
  SALT37.StrType Input_unit_desig := '' : STORED('unit_desig', FORMAT(SEQUENCE(9)));
  SALT37.StrType Input_sec_range := '' : STORED('sec_range', FORMAT(SEQUENCE(10)));
  SALT37.StrType Input_v_city_name := '' : STORED('v_city_name', FORMAT(SEQUENCE(11)));
  SALT37.StrType Input_st := '' : STORED('st', FORMAT(SEQUENCE(12)));
  SALT37.StrType Input_zip5 := '' : STORED('zip5', FORMAT(SEQUENCE(13)));
  UNSIGNED e_LocId := 0 : STORED('LocId', FORMAT(SEQUENCE(14)));
  UNSIGNED e_rid := 0 : STORED('rid', FORMAT(SEQUENCE(15)));
 
  Template := DATASET([],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
  Input_Data := DATASET([{(TYPEOF(Template.UniqueID))Input_UniqueID,Input_MaxIds,Input_LeadThreshold
  ,(TYPEOF(Template.prim_range))Input_prim_range
  ,(TYPEOF(Template.predir))Input_predir
  ,(TYPEOF(Template.prim_name))Input_prim_name
  ,(TYPEOF(Template.addr_suffix))Input_addr_suffix
  ,(TYPEOF(Template.postdir))Input_postdir
  ,(TYPEOF(Template.unit_desig))Input_unit_desig
  ,(TYPEOF(Template.sec_range))Input_sec_range
  ,(TYPEOF(Template.v_city_name))Input_v_city_name
  ,(TYPEOF(Template.st))Input_st
  ,(TYPEOF(Template.zip5))Input_zip5
  ,false,false,e_rid,e_LocId}],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
 
  pm := LocationId_xLink.MEOW_LocationID(Input_Data); // This module performs regular xLocId functions
  ds := pm.DataToSearch;
  fids := SET(pm.Uid_Results,LocId);
  odm := LocationId_xLink.MEOW_LocationID(ds,true,fids);
  OUTPUT(odm.Raw_Results,NAMED('PossibleFragments'));
  OUTPUT(odm.Raw_Data,NAMED('FragmentData'));
  OUTPUT(pm.Raw_Data,NAMED('OriginalData'));
ENDMACRO;
