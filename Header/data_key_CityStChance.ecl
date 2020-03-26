// copied from Address\Key_CityStChance.ecl, but returns dataset instead of INDEX

/*
ONE PART KEY 
Record Count: 42,691  

The idea of this key is to be able to make a reasonable guess at STATE, given the CITY
So, I am going to find the valid STATE occurences for each CITY, and I am going to 
count the zips to give me an idea of the strength of the association.

Keyed field {city_name}
Payload - st, percent_chance (that the city belongs to the state, computed by zip count)

*/

//*** First, get the correct header records
import header;
h := 
header.File_Headers;

hz4 := h(zip4 <> '', zip <> '', st <> '', city_name <> '');

prec := {h.zip, h.st, h.city_name};

hp := 
project(
	hz4,
	prec
);
	
	
//*** Distribute by City and State, then dedup by City and State and Zip (to allow for count of zips)	
hpd :=
dedup(
	sort(
		distribute(
			hp, 
			hash(city_name, st)
		),
		city_name, st, zip, 
		local
	),
	city_name, st, zip,
	local
);


//*** Count the zips that occur in each City/State
cnt_rec := record
	hpd.city_name;
	hpd.st;
	count_zips := count(group);
end;

t := table(hpd, cnt_rec, city_name, st, local);


//*** Add the % chance that a certain state is correct (by zip count)
cnt_rec_city_only := record
	t.city_name;
	count_zips := sum(group, t.count_zips);
end;

t_city_only := table(t, cnt_rec_city_only, city_name);

jrec := record
	t;
	unsigned2 percent_chance;
end;

j :=
join(
	t,
	t_city_only,
	left.city_name = right.city_name,
	transform(
		jrec,
		self.percent_chance := (unsigned2)((left.count_zips/right.count_zips) * 100),
		self := left
	),
	lookup,
	left outer
);


//*** Define the index
// i := 
// index(
// 	j,
// 	{city_name},
// 	{st, percent_chance},
// 	//'~thor_data400::cemtemp::city_name.st'
// 	ut.Data_Location.Person_header+'thor_data400::key::hdr_city_name.st.percent_chance_' + doxie.Version_SuperKey);

export data_Key_CityStChance := j;