/*--SOAP--
<message name="Remote_InsuranceHeader_Service_Dempsey">
  <part name="Input_Data" type="tns:XmlDataSet" cols="200" rows="100" />
</message>
*/
 
/*--INFO-- Match together two records using the provided fields*/
EXPORT Remote_InsuranceHeader_Service_Dempsey := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  #CONSTANT('Superfile_Name','');
  Input_Data := DATASET([], InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch) : STORED('Input_Data',FORMAT(SEQUENCE(1)));
  OUTPUT(InsuranceHeader_RemoteLinking.fn_RemoteLinking(Input_Data));
ENDMACRO;
