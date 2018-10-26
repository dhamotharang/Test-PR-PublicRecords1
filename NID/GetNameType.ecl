/*
This returns the mostly like classification of the name.
Possible values are:
	P			Person
	D			Dual Name
	B			Business
	T			Trust/Estate
	I			Invalid Name
*/
import Address;

overrideTypes := DICTIONARY(Nid.Overrides(false), {name => nametype});

EXPORT string1 GetNameType(string name) := 
						IF(name in overrideTypes, overrideTypes[name].nametype,
								Address.Business.GetNameType(name));

