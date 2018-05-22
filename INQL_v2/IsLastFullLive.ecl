import did_add;

EXPORT IsLastFullLive(boolean isFCRA = false) := FUNCTION

 HistoryKeyVersion := did_add.get_EnvVariable('inquiry_build_version','http://roxiethor.sc.seisint.com:9856'); //prod
 FullBase := INQL_v2.Filenames(,isFCRA,false).INQL_Base.built;

 f(string v) := stringlib.stringfind(v, '::', 5)+2;
 LF := fileservices.superfilecontents(FullBase)[1].name;
 return LF[f(LF)..] = HistoryKeyVersion;

END;