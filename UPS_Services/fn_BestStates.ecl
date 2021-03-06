import Address;

export SET OF STRING2 fn_BestStates(STRING inCity, UNSIGNED n = 5) := FUNCTION
	raw_states := LIMIT(Address.Key_CityStChance(KEYED(city_name = inCity)), 50, SKIP);
	srt_states := DEDUP(SORT(raw_states, -percent_chance, st), st);
	top_states := CHOOSEN(srt_states, n);
	states := SET(top_states, st);

	return states;
END;