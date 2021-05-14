/*--SOAP--
<message name="Diff_Wuid_Archive_Queries_Service">
<part name="pWuid1"   type="xsd:string"/>
<part name="pWuid2" type="xsd:string"/>
<part name="pFilter" type="xsd:string"/>
</message>
*/
EXPORT Diff_Wuid_Archive_Queries_Service := 
MACRO


  // IMPORT Workman,WsWorkunits,STD,ut;
  IMPORT Workman;

  string pWuid1   := ''        : stored('pWuid1'  ) ;
  string pWuid2   := ''        : stored('pWuid2'  ) ;
  string pFilter  := ''        : stored('pFilter' ) ;

  #workunit('name'  ,'Workman.Diff_Wuid_Archive_Queries_Service');

  Workman.Diff_Wuid_Archive_Queries(pWuid1  ,pWuid2 ,pFilter);

ENDMACRO;