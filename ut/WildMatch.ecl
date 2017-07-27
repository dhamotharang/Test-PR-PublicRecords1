star_cnt(string s) := MAP( stringlib.stringfind(s,'*',4)<>0 => 4,
							stringlib.stringfind(s,'*',3)<>0 => 3,
							stringlib.stringfind(s,'*',2)<>0 => 2,
							stringlib.stringfind(s,'*',1)<>0 => 1,
                            0 );

ext_star(string s, integer1 n) :=
    MAP( n = 0 => s[1..stringlib.stringfind(s,'*',1)-1],
         n = 1 and star_cnt(s) = 1 =>s[stringlib.stringfind(s,'*',1)+1..length(s)],
         n = 1 => s[stringlib.stringfind(s,'*',1)+1..stringlib.stringfind(s,'*',2)-1],
         '' );

export WildMatch(string src,string to_find) := MAP(
star_cnt(to_find)=0 => stringlib.stringfind(src,to_find,1) <> 0,
star_cnt(to_find)=1 =>
                  MAP ( length(trim(to_find))-1>length(trim(src)) => false,
						stringlib.stringfind(to_find,'*',1) = 1 => stringlib.stringfind(src,ext_star(to_find,1),1) = length(trim(src))-length(trim(to_find))+2,
                        stringlib.stringfind(to_find,'*',1) = length(trim(to_find)) => stringlib.stringfind(src,ext_star(to_find,0),1) = 1,
                        stringlib.stringfind(src,ext_star(to_find,0),1) > 0 and
                            stringlib.stringfind(src,ext_star(to_find,0),1) < stringlib.stringfind(src,ext_star(to_find,1),1)
					   ),
					   false						  );