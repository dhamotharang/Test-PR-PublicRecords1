export fn_create_skey(string p1, string p2):= function

s1 := fileservices.createsuperfile(p1+'::built::'+p2);
s2 := fileservices.createsuperfile(p1+'::qa::'+p2);
s3 := fileservices.createsuperfile(p1+'::father::'+p2);
s4 := fileservices.createsuperfile(p1+'::grandfather::'+p2);
s5 := fileservices.createsuperfile(p1+'::delete::'+p2);

do_it := parallel(s1,s2,s3,s4,s5);

return do_it;

end;
