/*--SOAP--
<message name="LocationID_Header_Service">
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
<part name="SortBy" type="xsd:string"/>
<part name="MatchAllInOneRecord" type="xsd:boolean"/>
<part name="RecordsOnly" type="xsd:boolean"/>
<part name="MaxIds" type="xsd:integer"/>
<part name="LeadThreshold" type="xsd:integer"/>
<part name="UniqueID" type="xsd:integer"/>
</message>
*/
 
/*--INFO-- Find those entities having records matching the input criteria.
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>v_city_name:st:prim_range:prim_name</p>
<p>zip5:prim_range:prim_name</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT LocationID_Header_Service := MACRO
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
  BOOLEAN FullMatch := FALSE : STORED('MatchAllInOneRecord', FORMAT(SEQUENCE(14)));
  BOOLEAN RecordsOnly := FALSE: STORED('RecordsOnly', FORMAT(SEQUENCE(15)));
  SALT37.StrType Input_SortBy := '' : STORED('SortBy', FORMAT(SEQUENCE(16)));
  UNSIGNED e_LocId := 0 : STORED('LocId', FORMAT(SEQUENCE(17)));
  UNSIGNED e_rid := 0 : STORED('rid', FORMAT(SEQUENCE(18)));
 
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
  ,RecordsOnly,FullMatch,e_rid,e_LocId}],LocationId_xLink.Process_LocationID_Layouts.InputLayout);
 
  pm := LocationId_xLink.MEOW_LocationID(Input_Data); // This module performs regular xLocId functions
  ds := pm.Data_;
  FieldNumber(SALT37.StrType fn) := CASE(fn,'prim_range' => 1,'predir' => 2,'prim_name' => 3,'addr_suffix' => 4,'postdir' => 5,'unit_desig' => 6,'sec_range' => 7,'v_city_name' => 8,'st' => 9,'zip5' => 10,11);
  result := CHOOSE(FieldNumber(Input_SortBy),SORT(ds,-weight,LocId,prim_range,RECORD),SORT(ds,-weight,LocId,predir,RECORD),SORT(ds,-weight,LocId,prim_name,RECORD),SORT(ds,-weight,LocId,addr_suffix,RECORD),SORT(ds,-weight,LocId,postdir,RECORD),SORT(ds,-weight,LocId,unit_desig,RECORD),SORT(ds,-weight,LocId,sec_range,RECORD),SORT(ds,-weight,LocId,v_city_name,RECORD),SORT(ds,-weight,LocId,st,RECORD),SORT(ds,-weight,LocId,zip5,RECORD),SORT(ds,-weight,LocId,RECORD));
  OUTPUT(result,NAMED('Header_Data'));
ENDMACRO;
