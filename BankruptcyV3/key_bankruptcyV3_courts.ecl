
ds_courts := file_bankruptcyV3_courts(trim(active,left,right)='1');
key_name := BuildKeyName(,'courts');
							
export key_bankruptcyV3_courts := index(ds_courts, {moxie_court, recpos}, {ds_courts}, key_name);
