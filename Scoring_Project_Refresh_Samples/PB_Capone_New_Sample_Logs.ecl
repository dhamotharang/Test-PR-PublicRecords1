IMPORT Risk_Reporting, RiskWise, Score_Logs, STD, UT, Scoring_Project_Macros, Scoring_Project_Refresh_Samples, zz_Koubsky_SALT, SALT23;


Output_structure := record
	Scoring_Project_Macros.Regression.global_layout;
	Scoring_Project_Macros.Regression.pii_layout;
	Scoring_Project_Macros.Regression.runtime_layout;
end;
	

oldsample := '~scoring_project::in::Profile_Booster_Capone_20160912';
dsoldsample := DATASET(oldsample, Output_structure, thor );
output(dsoldsample, named('dsoldsample'));

Output_structure trans_old(dsoldsample le):= transform
self.firstname := le.firstname + ' '+le.middlename + ' ' + le.lastname ;
self.middlename := '';
self.lastname := '';
self := le;
self := [];
end;

ds_change_old:= project(dsoldsample, trans_old(left));

output(ds_change_old, named('ds_change_old'));
count(ds_change_old);




ds_in := '~bbraaten::uacs_sbita_lexis_nexis_tpb_part00.csv';



layout := record
string mess;
string company;
string street_addr;
string addr_2;
string city_name;
string st;
string z5;
string zip4;
string IDK;
end;

// ds := DATASET(ds_in, layout, CSV(HEADING(single), QUOTE('"')) );
ds := DATASET(ds_in, layout, CSV );

output(ds, named('ds'));

// name := ds(REGEXFIND('([a-zA-Z]+)', mess));

strip_punctuation(STRING cn) := FUNCTION
						STRING punct := '1234567890';
					RETURN STD.Str.FilterOut(cn,punct);
		END; 


newlayout := record
string name_full;
string company;
string street_addr;
// string addr_2;
string city_name;
string st;
string z5;
string zip4;
end;

Output_structure trans(ds le):= transform
self.firstname := strip_punctuation(le.mess);
self.streetaddress := le.street_addr + ' ' +le.addr_2;
self.city := le.city_name;
self.state := le.st;
self.zip := le.z5+le.zip4;
self.company := le.company;
self := le;
self := [];
end;

ds_new := project(ds, trans(left));

output(ds_new, named('ds_new'));
count(ds_new);

filteredzip := ds_new(REGEXFIND('(^[0-9]{5}$)|(^[0-9]{5}-?[0-9]{4}$)', zip));


goodinfo := filteredzip( firstname <> '' and streetaddress != '' and city != '' and state != '' and zip != '' );										
output(goodinfo, named('goodinfo'));
count(goodinfo);

DedupedData := dedup(goodinfo, firstname, zip, all); //sorted by ssn since all blank ssn's have been removed;
output(DedupedData, named('DedupedData'));

count(DedupedData);

// new_sample := choosen(DedupedData, 25000);
ut.MAC_Pick_Random(DedupedData,new_sample,10000);   //grabs 5000 of new deduped rocrods;

output(new_sample, named('new_sample'));
count(new_sample);


dsremove_one := ds_change_old(perm_flag <> 1) ;
dsremove_two := dsremove_one(perm_flag <> 2);
output(dsremove_two, named('dsremove_two'));
count(dsremove_two);

max_account := max(ds_change_old, accountnumber);

Output_structure Trans_input(dsremove_two le, integer c) := transform
// self.Date_added := (Integer)ut.getdate;
self.Perm_Flag := If(c <=5000, 0 , if(c>5000 and c <= 10000, 1, if(c>10000 and C <= 15000, 2 , if(c >15000 and c <= 20000, 3, 4))));  
// self.AccountNumber := c;
self.Customer := 'Capital One';
self.Source_Info := 'ProfileBooster_Batch_Logs';
self := le;
end;

ds_clean_old := project(dsremove_two, Trans_input(left, counter));




output(choosen(ds_clean_old, all), named('ds_clean_old'));
count(ds_clean_old);


Output_structure Trans_input_new(new_sample le, integer c) := transform
self.Date_added := (Integer)ut.getdate;
self.Perm_Flag := If(c <=5000, 4 , if(c>5000 and c <= 10000, 5, 9));
self.AccountNumber := max_account+c;
self.Customer := 'Capital One';
self.Source_Info := 'ProfileBooster_Batch_Logs';
self.historydateyyyymm := 999999;
self.history_date	 := 999999;
self := le;
end;

ds_clean_new := project(new_sample, Trans_input_new(left, counter));

output(choosen(ds_clean_new, all), named('ds_clean_new'));
count(ds_clean_new);

full_file := ds_clean_old+ ds_clean_new;


Sorted_Sample := Sort(full_file, perm_flag, date_added);


fileout := '~scoring_project::in::Profile_Booster_Capone_20180226';
OUTPUT(Sorted_Sample,,fileout, thor, overwrite);


final_salt := choosen(Sorted_Sample, 25000);

zz_Koubsky_SALT.mac_profile(final_salt); 

EXPORT PB_Capone_New_Sample_Logs := 'todo';