export UNICODE FN_PartyName(UNICODE party, unsigned1 position) := FUNCTION
	theType := FN_GetPartyType(party);
	isMultiple := FN_MultipleNames(party);

	// For multiple names, get the position of the separator.
	pos1 :=
		IF(UnicodeLib.UnicodeFind(party,u' AND ',1)>0,
			 UnicodeLib.UnicodeFind(party,u' AND ',1),
			 UnicodeLib.UnicodeFind(party,u' ET AL',1));
	pos2 :=
		IF(pos1>0 AND party[pos1+1]=u'A',
			 pos1+5,
			 pos1);

	// For multiple names, split off the names.
	name1_notStripped :=
		IF(isMultiple,
			 party[1..pos1],
			 party);
	name2_notStripped :=
		IF(isMultiple,
			 party[pos2..],
			 u'');
	
	// Strip the names.
	name1 := IF(theType=MXD_MXDocket.Layouts_build.PartyType.ESTATE, name1_notStripped[10..], name1_notStripped);
	name2 := name2_notStripped;
		
	NameAtPosition :=
		MAP(position=1 => name1,
				position=2 => name2,
				u'');
	
	return NameAtPosition;
END;
