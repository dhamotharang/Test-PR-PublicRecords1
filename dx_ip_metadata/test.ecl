import $, std;
output($.functions.hex4format('0'));
output($.functions.hex4format(''));
beg_hextets       := Std.Str.SplitWords('0:0:0:0:1:0:0:0',':');
output(beg_hextets[1]);
