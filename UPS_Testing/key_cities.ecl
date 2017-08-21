import header,ut;

hfh := header.File_Headers;
h_rec := {hfh.prim_range, hfh.prim_name, hfh.city_name, hfh.st, hfh.zip, hfh.zip4};
// h := dedup(project(hfh(st = 'FL'), h_rec), all) : persist('cemtemp::header::FL');
h := hfh;

isacity(string st, string city) :=
	ZIPLIB.CityToZip5(st, city) <> '';

actual_cities := 
dedup(
	h,
	city_name,
	st,
	all
)(isacity(st, city_name));

// output(actual_cities, named('actual_cities'));

questionable := 
join(
	h,
	actual_cities,
	left.city_name = right.city_name and
	left.st = right.st,
	transform(
		h_rec,
		self := left
	),
	left only,
	lookup
);

actual := 
join(
	h,
	actual_cities,
	left.city_name = right.city_name and
	left.st = right.st,
	transform(
		h_rec,
		self := left
	),
	lookup
);

// output(questionable, named('questionable'));

ad := distribute(actual			 (city_name <> '', prim_range <> '', prim_name <> '', st <> '', zip <> ''), hash(prim_range, prim_name, st, zip));
qd := distribute(questionable(city_name <> '', prim_range <> '', prim_name <> '', st <> '', zip <> ''), hash(prim_range, prim_name, st, zip));
// output(qd, named('qd'));
// output(qd(zip4 <> ''), named('qd_zip4'));
// output(qd, named('qd'));

// output(h);
// count(h);

j_rec := {string25 good_city_name, string25 bad_city_name, string2 st, unsigned4 occurences};
j := 
join(
	ad,//(zip4 <> ''),
	qd(zip4 = ''),
	left.prim_range = right.prim_range and
	left.prim_name = right.prim_name and
	left.st = right.st and
	left.zip = right.zip and
	left.city_name <> right.city_name,
	transform(
		j_rec,
		self.good_city_name := left.city_name,
		self.bad_city_name 	:= right.city_name,
		self.st := left.st,
		self.occurences := 1
	),
	local
);

r := 
rollup(
	sort(distribute(j(good_city_name <> '', bad_city_name <> ''), hash(good_city_name, bad_city_name)), good_city_name, bad_city_name, local),
	left.good_city_name = right.good_city_name and
	left.bad_city_name = right.bad_city_name,
	transform(
		j_rec,
		self.occurences := left.occurences + right.occurences,
		self := left
	),
	local
);

p_rec := {j_rec, boolean StringContains, unsigned4 StringSimilar};

p := 
project(
	r,
	transform(
		p_rec,
		self.StringContains := 
			stringlib.StringContains(left.good_city_name, left.bad_city_name, true) or
			stringlib.StringContains(left.bad_city_name, left.good_city_name, true),
		self.StringSimilar := 
			ut.StringSimilar100(left.good_city_name, left.bad_city_name),
		self := left
	)
);

p_sort := sort(distribute(p, hash(bad_city_name)), bad_city_name, -StringContains, StringSimilar, local) : persist('cemtemp::p_sort');
p_dedu := dedup(p_sort, bad_city_name, local);


myindex := 
index(
	p_dedu,
	{bad_city_name, st},
	{good_city_name, StringContains, StringSimilar, occurences},
	'~thor_data400::cemtemp::key::bad_city_name',
	DISTRIBUTED
);

export key_cities := myindex;

/*
buildindex(myindex, overwrite);


output(p_sort, named('p_sort'));
output(choosen(p_dedu, 1000), named('p_dedu'));

set_interesting := ['DELRAY', 'POMPANO', 'LAUDERDALE'];

// output(p_sort,,'~thor_data400::cemtemp::j',overwrite);
// output(choosen(p_sort, 1000), named('j_choosen'));
output(enth(p_dedu, 1000), named('j_enth'));
output(choosen(p_dedu(bad_city_name in set_interesting), 1000), named('j_interesting'));
// output(choosen(actual_cities(city_name in set_interesting), 1000), named('actual_interesting'));
// output(choosen(questionable(city_name in set_interesting), 1000), named('questionable_interesting'));

*/