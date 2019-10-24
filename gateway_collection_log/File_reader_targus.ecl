﻿import $, targus, STD;

EXPORT File_reader_targus := module 
  
  EXPORT decodeFile(dataset($.layouts.raw_xml_in) infile) := FUNCTION
    infile_decoded := PROJECT(infile, // first row is header, discard it
                              TRANSFORM(gateway_collection_log.Layouts.decoded_xml_in, 
															SELF.seq := COUNTER;
															SELF.request_data := STD.Str.DecodeBase64(Left.request_data);
															SELF.response_data := STD.Str.DecodeBase64(Left.response_data);
															SELF := left
															));
    // output(infile_decoded,{(string)request_data,(string)response_data});
    RETURN infile_decoded;
  END;

  EXPORT formatRequest(dataset($.layouts.decoded_xml_in) infile) := FUNCTION
    layout_request := RECORD
	    targus.Layout_Targus_in request {XPATH('TargusComprehensiveRequest')};
    END;
    recs := project(infile, 
		                TRANSFORM(targus.layout_targus_in, 
										SELF.User.QueryId := (STRING) LEFT.seq;
										SELF := FROMXML(layout_request, '<Row>' + left.request_data + '</Row>').request)
                   );
		RETURN recs;
  END;

  EXPORT formatResponse(dataset($.layouts.decoded_xml_in) infile) := FUNCTION
    layout_response := RECORD
	    // recordof(targus.Layout_Targus_out.response) response {XPATH('TargusComprehensiveResponse')};
			recordof(targus.Layout_Targus_out) response {XPATH('TargusComprehensiveResponseEx')};
    END;
    recs := project(infile,
		                TRANSFORM(targus.Layout_Targus_out,       
															SELF.Response.Header.QueryId := (STRING) LEFT.seq;
															SELF := FROMXML(layout_response, '<Row>' + left.response_data + '</Row>').response;
															SELF := []; 
		               ));
    RETURN recs;
  END;

end;
