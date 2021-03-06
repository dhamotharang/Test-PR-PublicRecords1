/*--SOAP--
<message name="FocusSearchService">
  <part name="FocusSearch" type="xsd:string" rows="7" cols="40" />
	<part name="FocusDocIDs" type="tns:XmlDataSet" cols="70" rows="25"/>
		
	<part name="MaxResults" type="xsd:unsignedInt"/>
  <part name="MaxResultsThisTime" type="xsd:unsignedInt"/>
  <part name="SkipRecords" type="xsd:unsignedInt"/>
	<part name="SSNMask" type="xsd:string"/>
	<part name="ApplicationType"     	type="xsd:string"/>
  
	<part name="DPPAPurpose" type="xsd:byte"/>
 </message>
*/
/*--USES-- Text_Search.search_form_xslt
*/

/*--INFO-- Text Search.
*/
import doxie, Text_Search, DEA;
export FocusSearchService := MACRO

		// boolean-specific parameters
		//'Richard and Anderson' 
    doxie.MAC_Header_Field_Declare()	
		STRING srchString :='': STORED('FocusSearch');
		in_keys := dataset([], Text_Search.Layout_ExternalKey) :
                     stored('FocusDocIDs',few);
										 
		unsigned8 MaxDocs := MaxResults_val;
		
		// boolean search
		con := DEA.Constants('');
		STRING stem		:= con.stem;
		STRING srcType:= con.srcType;
		STRING qual		:= con.qual;
	
	 info := Text_Search.FileName_Info_Instance(stem, srcType, qual);
	 s := Text_Search.Focus_Search_Module(info, srchString,false,,,MaxDocs,,,in_keys);

  		ans := s.ExtKeyanswers;
   		errCode := s.error_code;
   		errMsg := s.error_msg;
   		noErr := errCode = 0;
   		IF(~noErr, ut.outputMessage(errCode, errMsg));
   		
   		// deakeys := JOIN(ans, DEA.Key_Boolean_Map
   								// ,LEFT.docref.src=RIGHT.src and 
   								// LEFT.docref.doc = RIGHT.doc
   								// and RIGHT.dea_registration_number <> '',
     							// TRANSFORM(DEAV2_services.assorted_layouts.layout_search_IDs,SELF :=RIGHT),
									// LIMIT(ut.limits.default, skip)
   								// );
			deakeys := PROJECT( ans, TRANSFORM(DEAV2_services.assorted_layouts.layout_search_IDs,
			                                   self.dea_registration_number:=left.ExternalKey) );
									
			reg_nums := DEDUP(deakeys,dea_registration_number,all);

   		payload := DEAV2_services.DEAV2_Search_recs(reg_nums,,application_type_value);
			Text_Search.MAC_Append_ExternalKey(payload, payload2, l.dea_registration_number);
  
   		dea_results := SORT(payload2,dea_registration_number);

   		doxie.MAC_Marshall_Results_NoCount(dea_results,results_paged,,Outputcount);
			
   		IF(noErr,Outputcount);
   		IF(noErr, OUTPUT(results_paged,NAMED('Results')));

				

ENDMACRO;
