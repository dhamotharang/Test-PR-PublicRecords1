import did_add;

export version := module

export roxie_url := 'http://roxiebatch.br.seisint.com:9856';

//header file
export unsigned header_file := 20101203; 
export unsigned header_file_real := (unsigned)did_add.get_EnvVariable('header_file_version', roxie_url);

//quick header file 
export unsigned quick_header_file := (unsigned)did_add.get_EnvVariable('quick_file_version', roxie_url);

//utility file
export unsigned utility_daily_file := (unsigned)did_add.get_EnvVariable('utility_file_version', roxie_url);

//phonesplus file
export unsigned phonesplus_file := (unsigned)did_add.get_EnvVariable('Phone_plus', roxie_url); 

//gong weekly file
export unsigned gong_weekly_file := (unsigned)did_add.get_EnvVariable('Gong_weekly', roxie_url);

//gong daily file
export unsigned gong_daily_file := (unsigned)did_add.get_EnvVariable('Gong_daily', roxie_url);

end;