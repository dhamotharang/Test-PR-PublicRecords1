import gong;

export _fn_newphone_verification(string8 new_date) := function

dHistory := distribute(gong.File_History(phone10 <> '' and regexfind('[1-9]', phone10[1..3]) and length(trim(phone10, left,right)) = 10), hash(phone10));

newHistory := table(dHistory, {phone10, dt := max(group,dt_first_seen), ct := count(group)}, phone10)(ct = 1 and dt = new_date);

Set_phone10:=set(choosen(newHistory, 500), phone10);

samples := sort(gong_v2.File_GongMaster(phone10 in Set_phone10), phone10);

return output(samples, named('New_Phones_Samples'), all);
end;