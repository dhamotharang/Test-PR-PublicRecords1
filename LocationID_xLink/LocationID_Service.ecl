/*--SOAP--
<message name="LocationID_Header_Service">
<part name="AddressLine1" type="xsd:string"/>
<part name="AddressLine2" type="xsd:string"/>
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
<p>if Address1 and Address2 are provided then other parameters will be ignored.</p>
<p>Input fields are cleaned according to the standard hygiene requirements of this file.</p>
<p>The more data input the better; but unless one of the following field combinations are present the UBER key will be used:-</p>
<p>v_city_name:st:prim_range:prim_name</p>
<p>zip5:prim_range:prim_name</p>
<p>By default all records of all clusters where the CLUSTER matches the field will be returned. To force a single record to match use MatchAllInOneRecord. To only return matching records use RecordsOnly.</p>
*/
EXPORT LocationID_Service := MACRO
  IMPORT SALT37,LocationId_xLink,Address;
	
	 STRING line1                          := ''    : STORED('AddressLine1', FORMAT(SEQUENCE(1)));
	 STRING linelast                       := ''    : STORED('AddressLine2', FORMAT(SEQUENCE(2)));
  UNSIGNED Input_UniqueID               := 0     : STORED('UniqueID', FORMAT(SEQUENCE(3)));
  UNSIGNED InputMaxIds0                 := 0     : STORED('MaxIds', FORMAT(SEQUENCE(4)));
  UNSIGNED Input_MaxIds                 := IF(InputMaxIds0=0,50,InputMaxIds0);
  UNSIGNED Input_LeadThreshold          := 0     : STORED('LeadThreshold', FORMAT(SEQUENCE(5)));
  SALT37.StrType User_prim_range        := ''    : STORED('prim_range', FORMAT(SEQUENCE(6)));
  SALT37.StrType User_predir            := ''    : STORED('predir', FORMAT(SEQUENCE(7)));
  SALT37.StrType User_prim_name         := ''    : STORED('prim_name', FORMAT(SEQUENCE(8)));
  SALT37.StrType User_addr_suffix       := ''    : STORED('addr_suffix', FORMAT(SEQUENCE(9)));
  SALT37.StrType User_postdir           := ''    : STORED('postdir', FORMAT(SEQUENCE(10)));
  SALT37.StrType User_unit_desig        := ''    : STORED('unit_desig', FORMAT(SEQUENCE(11)));
  SALT37.StrType User_sec_range         := ''    : STORED('sec_range', FORMAT(SEQUENCE(12)));
  SALT37.StrType User_v_city_name       := ''    : STORED('v_city_name', FORMAT(SEQUENCE(13)));
  SALT37.StrType User_st                := ''    : STORED('st', FORMAT(SEQUENCE(14)));
  SALT37.StrType User_zip5              := ''    : STORED('zip5', FORMAT(SEQUENCE(15)));
  BOOLEAN FullMatch                     := FALSE : STORED('MatchAllInOneRecord', FORMAT(SEQUENCE(16)));
  BOOLEAN RecordsOnly                   := FALSE : STORED('RecordsOnly', FORMAT(SEQUENCE(17)));
  SALT37.StrType Input_SortBy           := ''    : STORED('SortBy', FORMAT(SEQUENCE(18)));
  UNSIGNED e_LocId                      := 0     : STORED('LocId', FORMAT(SEQUENCE(19)));
  UNSIGNED e_rid                        := 0     : STORED('rid', FORMAT(SEQUENCE(20)));

	 clean_address := Address.CleanAddress182(line1, linelast);

  SALT37.StrType Input_prim_range  := if(line1!='',Address.CleanFields(clean_address).prim_range, User_prim_range);
  SALT37.StrType Input_predir      := if(line1!='',Address.CleanFields(clean_address).predir, User_predir);
  SALT37.StrType Input_prim_name   := if(line1!='',Address.CleanFields(clean_address).prim_name, User_prim_name);	
  SALT37.StrType Input_addr_suffix := if(line1!='',Address.CleanFields(clean_address).addr_suffix, User_addr_suffix);
  SALT37.StrType Input_postdir     := if(line1!='',Address.CleanFields(clean_address).postdir, User_postdir);
  SALT37.StrType Input_unit_desig  := if(line1!='',Address.CleanFields(clean_address).unit_desig, User_unit_desig);
  SALT37.StrType Input_sec_range   := if(line1!='',Address.CleanFields(clean_address).sec_range, User_sec_range);
  SALT37.StrType Input_v_city_name := if(line1!='',Address.CleanFields(clean_address).v_city_name, User_v_city_name);
  SALT37.StrType Input_st          := if(line1!='',Address.CleanFields(clean_address).st, User_st);
  SALT37.StrType Input_zip5        := if(line1!='',Address.CleanFields(clean_address).zip, User_zip5);
	
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