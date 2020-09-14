/*--SOAP--
<message name="get_Wuid_Query_Attributes_Service">
<part name="pWuid"   type="xsd:string"/>
<part name="pFilter" type="xsd:string"/>
</message>
*/
EXPORT get_Wuid_Query_Attributes_Service := 
MACRO


  // IMPORT Workman,WsWorkunits,STD,ut;
  IMPORT Workman;

  string pWuid    := ''        : stored('pWuid'   ) ;
  string pFilter  := ''        : stored('pFilter' ) ;

  #workunit('name'  ,'Workman.get_Wuid_Query_Attributes_Service');

  Workman.get_Wuid_Query_Attributes(pWuid ,pFilter);

ENDMACRO;