import lib_stringlib;
/////////////////////////////////////////////////////////////////////////////////////
// helper routine to parse the xml that returns from the cleaners
export string parse_xml(string xml_token,string payload) := function
integer startoffset := stringlib.StringFind(payload,'<'+xml_token+'>',1);
integer endoffset := stringlib.StringFind(payload,'</'+xml_token+'>',1);

return(payload[startoffset+ length('<'+xml_token+'>') .. endoffset-1 ]);
end;




