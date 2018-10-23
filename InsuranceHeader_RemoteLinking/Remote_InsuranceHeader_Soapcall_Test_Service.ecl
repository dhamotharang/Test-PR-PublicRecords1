/*--SOAP--
<message name="Remote_InsuranceHeader_Soapcall_Test_Service">
  <part name="Roxie_IP" type="xsd:string"/>
  <part name="Input_Data" type="tns:XmlDataSet" cols="200" rows="100" />
</message>
*/
 
/*--INFO-- Match together two records using the provided fields*/

EXPORT Remote_InsuranceHeader_Soapcall_Test_Service := MACRO
  IMPORT SALT37,InsuranceHeader_RemoteLinking;
  #CONSTANT('Superfile_Name','');
  Roxie_IP := InsuranceHeader_RemoteLinking.Constants.HEADER_SERVICE_ROXIE_IP : STORED('Roxie_IP',FORMAT(SEQUENCE(1)));
  Input_Data := DATASET([], InsuranceHeader_RemoteLinking.Layouts.ServiceInputLayout_Batch) : STORED('Input_Data',FORMAT(SEQUENCE(2)));
  out_rec := RECORD
    STRING50 IPAddress;
    STRING20 Enviroment;
    BOOLEAN  checkpassed;
  END;
  user_info := DATASET([{Roxie_IP,STD.Str.ToUpperCase(_Control.ThisEnvironment.RoxieEnv),STD.Str.ToUpperCase(_Control.ThisEnvironment.RoxieEnv) = 'PROD'}],out_rec);
  OUTPUT(user_info,NAMED('User_Info'));
  InsuranceHeader_RemoteLinking.fn_RemoteLinking_Soapcall_Batch(Input_Data,Roxie_IP);
ENDMACRO; 