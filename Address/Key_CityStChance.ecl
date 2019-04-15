/*
ONE PART KEY 
Record Count: 42,691  

The idea of this key is to be able to make a reasonable guess at STATE, given the CITY
So, I am going to find the valid STATE occurences for each CITY, and I am going to 
count the zips to give me an idea of the strength of the association.

Keyed field {city_name}
Payload - st, percent_chance (that the city belongs to the state, computed by zip count)
*/

IMPORT dx_header;

EXPORT Key_CityStChance := dx_header.key_CityStChance();
