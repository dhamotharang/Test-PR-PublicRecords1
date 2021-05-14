import WsWorkunits,STD,ut;
EXPORT get_Wuid_Query_Attributes(
   string pWuid
  ,string pFilter = ''
) :=
function

  ds_atts := WsWorkunits.get_Archive_Query(pWuid);

  ds_only_att_names := project(ds_atts (trim(pFilter) = '' or regexfind(pFilter,modulename + attributename,nocase)) ,transform({string modulename,string attributename},self := left));
   
  outputs := parallel(
     output('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWuid + '">' + pWuid + '</a>'                               ,named('Wuid__html'          )      )
    ,output(sort(ds_only_att_names  ,std.str.tolowercase(modulename),std.str.tolowercase(attributename))                              ,named('Attribute_Names'     ) ,all )
    ,output(sort(ds_atts(~regexfind('std',modulename,nocase),trim(pFilter) = '' or regexfind(pFilter,modulename + attributename,nocase)),std.str.tolowercase(modulename),std.str.tolowercase(attributename))   ,named('Attributes_Code'     ) ,all )
    ,output(sort(ds_atts( regexfind('std',modulename,nocase)                                                                           ),std.str.tolowercase(modulename),std.str.tolowercase(attributename))   ,named('Std_Library_Code'    ) ,all )

  );

  return outputs;
end;