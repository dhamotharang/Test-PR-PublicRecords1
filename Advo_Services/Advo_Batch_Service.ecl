/*--SOAP--
<message name="Advo_Batch_Service">
  <part name="DPPAPurpose" type="xsd:byte"/>
  <part name="GLBPurpose" type="xsd:byte"/>
  <part name="DoBadSecRange" type="xsd:boolean"/>
  <part name="IncludeAllSecRanges" type="xsd:boolean"/>
  <part name="batch_in" type="tns:XmlDataSet" cols="70" rows="25"/>
</message>
*/
export Advo_Batch_Service() := macro
  
  // Set Boolean values:
  //
  // do_bad_sec_range--when set to true, will find matching records for house
  // addresses that have a sec_range by mistake (in the input).
  BOOLEAN do_bad_sec_range := FALSE : STORED('DoBadSecRange');
  
  // include_all_sec_ranges--when set for true, will find all matching units (and
  // their metadata) for a particular building address when no sec_range is provided.
  BOOLEAN include_all_sec_ranges := FALSE : STORED('IncludeAllSecRanges');
  
  // Layout of input data
  in_layout := Advo_Services.Advo_Batch_Service_Layouts.Batch_In;
  
  // Grab input data from SOAP variable
  dataset(in_layout) indata := dataset([],in_layout) : stored('batch_in');
  
  // Retrieve and output records
  results := Advo_Services.Advo_Batch_Service_Records(indata, do_bad_sec_range, include_all_sec_ranges);
  output(results, named('Results'));

endmacro;
