import doxie,doxie_build,ut, data_services;

f := doxie_build.File_VehicleContacts_KeyBuilding(company_name<>'');


cleanco := TRIM(TRIM(StringLib.StringFilter(datalib.CompanyClean(f.company_name)[1..40],' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),LEFT),RIGHT);


i_rec :=
RECORD
	STRING40 company_name := cleanco;
	STRING2  state		  := f.st;
	STRING25 city_name	  := f.v_city_name;
	unsigned1 pick := CASE(f.rec_source, 'own_1' => 1,
								'own_2' => 2,
								'reg_1' => 3,
								'reg_2' => 4, 0);
	f.seq_no;
END;


clean_co := TABLE(f,i_rec)(company_name<>'');

i_rec norm(i_rec le, INTEGER c) :=
TRANSFORM
	word1 := ut.Word(le.company_name,c);

	SELF.company_name := IF(LENGTH(TRIM(word1))<2,SKIP,ut.Word(le.company_name,c));
	SELF := le;
END;
n := NORMALIZE(clean_co,LENGTH(StringLib.StringFilter(TRIM(LEFT.company_name),' ')),norm(LEFT,COUNTER))+clean_co;


d := DEDUP(SORT(n,RECORD,EXCEPT pick),RECORD,EXCEPT pick);

export Key_Vehicle_coName := INDEX(d, 
                                   {d.company_name,d.state,d.city_name}, 
                                   {d.pick, d.seq_no}, 
                                   data_services.data_location.prefix() + 'thor_data400::key::'+doxie_build.buildstate+'vehicle_coName_'+doxie.Version_SuperKey);