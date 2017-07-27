import OSHAIR;

city_code_rec := record,maxlength(40)
	string City_Code_ID;  
	string City_Name;
end;

export File_City_Lookup := dataset(OSHAIR.cluster + 'lookup::oshair::city_codes'
                                  ,city_code_rec
								  ,thor);
