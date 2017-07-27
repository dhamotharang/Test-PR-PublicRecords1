valid_chars := ' !"#$%&`()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_\'abcdefghijklmnopqrstuvwxyz{|}~';

assessors_layout := record
string1610 str;
end;

f1 := dataset('~thor_dell400_2::out::avm_assessor_1', assessors_layout, flat);
f2 := dataset('~thor_dell400_2::out::avm_assessor_2', assessors_layout, flat);
f3 := dataset('~thor_dell400_2::out::avm_assessor_3', assessors_layout, flat);
f4 := dataset('~thor_dell400_2::out::avm_assessor_4', assessors_layout, flat);

count(f1);
count(f2);
count(f3);
count(f4);


ffilt1 := f1(length(stringlib.StringFilterOut(str, valid_chars)) > 0);
count(ffilt1);
output(ffilt1);

ffilt2 := f2(length(stringlib.StringFilterOut(str, valid_chars)) > 0);
count(ffilt2);
output(ffilt2);

ffilt3 := f3(length(stringlib.StringFilterOut(str, valid_chars)) > 0);
count(ffilt3);
output(ffilt3);

ffilt4 := f4(length(stringlib.StringFilterOut(str, valid_chars)) > 0);
count(ffilt4);
output(ffilt4);

layout_bad_chars := record
string badchars;
end;

fbad1 := project(ffilt1,
                transform(layout_bad_chars,
			           self.badchars := stringlib.StringFilterOut(left.str, valid_chars)));
output(choosen(fbad1, 500));

fbad2 := project(ffilt2,
                transform(layout_bad_chars,
			           self.badchars := stringlib.StringFilterOut(left.str, valid_chars)));
output(choosen(fbad2, 500));

fbad3 := project(ffilt3,
                transform(layout_bad_chars,
			           self.badchars := stringlib.StringFilterOut(left.str, valid_chars)));
output(choosen(fbad3, 500));

fbad4 := project(ffilt4,
                transform(layout_bad_chars,
			           self.badchars := stringlib.StringFilterOut(left.str, valid_chars)));
output(choosen(fbad4, 500));
