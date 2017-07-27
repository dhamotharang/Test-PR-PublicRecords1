/*--SOAP--
<message name="AddressCorrection_BatchService">	
	<part name="DPPAPurpose"          type="xsd:byte"/>
	<part name="GLBPurpose"           type="xsd:byte"/>
	<part name="ApplicationType"     	type="xsd:string"/>
	<part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>					
</message>
*/
import AutoStandardI;
export AddressCorrection_BatchService() := MACRO
  // used by AddrBest.BestAddr_common()
  #stored('MaxRecordsToReturn',1000)
	inputData := DATASET([], PhilipMorris.Layouts_Batch.InAddrRecord) : stored('batch_in', few);
	appType := AutoStandardI.InterfaceTranslator.application_type_val.val(project(AutoStandardI.GlobalModule(),AutoStandardI.InterfaceTranslator.application_type_val.params));

	OUTPUT(PhilipMorris.AddressCorrection_BatchService_Records(inputData,appType), NAMED('Results') );		
	
ENDMACRO;
// AddressCorrection_BatchService()
/* Expected XML Format
<dataset>
  <row>
    <AcctNo></AcctNo>
    <Name_Prefix></Name_Prefix>
    <Name_First></Name_First>
    <Name_Middle></Name_Middle>
    <Name_Last></Name_Last>
    <Name_Suffix></Name_Suffix>
    <DOB></DOB>
    <PhoneNo></PhoneNo>
    <Addr1_Prim_Range></Addr1_Prim_Range>
    <Addr1_PreDir></Addr1_PreDir>
    <Addr1_Prim_Name></Addr1_Prim_Name>
    <Addr1_Suffix></Addr1_Suffix>
    <Addr1_PostDir></Addr1_PostDir>
    <Addr1_Unit_Desig></Addr1_Unit_Desig>
    <Addr1_Sec_Range></Addr1_Sec_Range>
    <Addr1_City></Addr1_City>
    <Addr1_State></Addr1_State>
    <Addr1_Zip5></Addr1_Zip5>
    <Addr1_Zip4></Addr1_Zip4>
    <Addr2_Prim_Range></Addr2_Prim_Range>
    <Addr2_PreDir></Addr2_PreDir>
    <Addr2_Prim_Name></Addr2_Prim_Name>
    <Addr2_Suffix></Addr2_Suffix>
    <Addr2_PostDir></Addr2_PostDir>
    <Addr2_Unit_Desig></Addr2_Unit_Desig>
    <Addr2_Sec_Range></Addr2_Sec_Range>
    <Addr2_City></Addr2_City>
    <Addr2_State></Addr2_State>
    <Addr2_Zip5></Addr2_Zip5>
    <Addr2_Zip4></Addr2_Zip4>
    <Addr3_Prim_Range></Addr3_Prim_Range>
    <Addr3_PreDir></Addr3_PreDir>
    <Addr3_Prim_Name></Addr3_Prim_Name>
    <Addr3_Suffix></Addr3_Suffix>
    <Addr3_PostDir></Addr3_PostDir>
    <Addr3_Unit_Desig></Addr3_Unit_Desig>
    <Addr3_Sec_Range></Addr3_Sec_Range>
    <Addr3_City></Addr3_City>
    <Addr3_State></Addr3_State>
    <Addr3_Zip5></Addr3_Zip5>
    <Addr3_Zip4></Addr3_Zip4>
  </row>
</dataset>
*/