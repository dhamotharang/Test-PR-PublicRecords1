import WsWorkunits,STD,ut;
EXPORT Diff_Wuid_Archive_Queries(
   string pWuid1
  ,string pWuid2
  ,string pFilter = ''
) :=
function

  ds_old := WsWorkunits.get_Archive_Query(pWuid1);
  ds_new := WsWorkunits.get_Archive_Query(pWuid2);

  ds_find_diffs := join(ds_old  ,ds_new  ,std.str.touppercase(left.modulename) = std.str.touppercase(right.modulename) and std.str.touppercase(left.attributename) = std.str.touppercase(right.attributename) ,transform(
    {string modulename,string attributename ,dataset(recordof(ut.fStringDiff('',''))) diffs }
    ,self.diffs := ut.fStringDiff(trim(left.code) ,trim(right.code))
    ,self       := left
  ));

  ds_old_only := join(ds_old  ,ds_new  ,std.str.touppercase(left.modulename) = std.str.touppercase(right.modulename) and std.str.touppercase(left.attributename) = std.str.touppercase(right.attributename)  ,transform(
    recordof(left)
    ,self       := left
  ),left only);

  ds_new_only := join(ds_old  ,ds_new  ,std.str.touppercase(left.modulename) = std.str.touppercase(right.modulename) and std.str.touppercase(left.attributename) = std.str.touppercase(right.attributename) ,transform(
    recordof(right)
    ,self       := right
  ),right only);

  ds_only_att_names := project(ds_find_diffs (exists(diffs),~regexfind('std',modulename,nocase),trim(pFilter) = '' or regexfind(pFilter,modulename + attributename,nocase)) ,transform({string modulename,string attributename},self := left));
   
  outputs := parallel(
     output('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWuid1 + '">' + pWuid1 + '</a>'  ,named('Wuid1__html'))
    ,output('<a href="/esp/files/stub.htm?Widget=WUDetailsWidget&Wuid=' + pWuid2 + '">' + pWuid2 + '</a>'  ,named('Wuid2__html'))
    ,output(sort(ds_only_att_names  ,std.str.tolowercase(modulename),std.str.tolowercase(attributename))                                                 ,named('Changed_Attributes'     ) ,all)
    ,output(sort(ds_find_diffs(exists(diffs),~regexfind('std',modulename,nocase),trim(pFilter) = '' or regexfind(pFilter,modulename + attributename,nocase)),std.str.tolowercase(modulename),std.str.tolowercase(attributename))  ,named('Code_Differences'       ) ,all)

    ,output(sort(ds_old_only  ,std.str.tolowercase(modulename),std.str.tolowercase(attributename))                                                                                                                                ,named('Atts_Only_In_Old_Wuid'  ) ,all)
    ,output(sort(ds_new_only  ,std.str.tolowercase(modulename),std.str.tolowercase(attributename))                                                                                                                                ,named('Atts_Only_In_New_Wuid'  ) ,all)

    ,output(sort(ds_find_diffs(exists(diffs),regexfind('std',modulename,nocase))  ,std.str.tolowercase(modulename),std.str.tolowercase(attributename))                                                                            ,named('Std_Library_Differences') ,all)

  );

  return outputs;
end;