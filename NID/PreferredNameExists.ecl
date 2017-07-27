
boolean IsBName(SET OF STRING41 list, string20 name) := BEGINC++
#option pure
int static compare20x(const void *s1, const void *s2)	// #73922
{
		return memcmp(s1, s2, 20);
}
#body
	int entries = lenList/41;

	char *s = (char *)bsearch(name, list, entries, 41, compare20x); // #73922
	return (s != NULL);

ENDC++;

export boolean PreferredNameExists(string20 name) := 
	IsBName(Set_NamesNew, name) OR
	IsBName(Set_NamesV1, name);
	