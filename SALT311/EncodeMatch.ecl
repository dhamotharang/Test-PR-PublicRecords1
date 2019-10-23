EXPORT EncodeMatch(INTEGER match_code, StrType field_name,Str2Type mapName(StrType name)) := TRIM(MAP(
    //If the SALT match code is one side null then the out string is blank
    match_code = MatchCode.OneComponentNull OR match_code = MatchCode.OneSideNull => '',
    //If the SALT match code shows exact then the out string is just the field_name
    match_code = MatchCode.ExactMatch => ','+mapName(field_name),
    //Otherwise it is 'field_name:match_code'
    ','+mapName(field_name)+':'+MatchCode.Expand(match_code)
));
