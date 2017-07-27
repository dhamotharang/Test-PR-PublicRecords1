export fCheckNewCatEventClasses(STRING filedate) := function

ds_CatEvent := dataset('~thor_data400::in::banko::categoryevent',Banko.Layout_CategoryEvent,
								CSV(HEADING(0), SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));
ds_CatEventFather := dataset('~thor_data400::in::banko::categoryevent_father',Banko.Layout_CategoryEvent,
								CSV(HEADING(0), SEPARATOR('|~|'), TERMINATOR(['\n', '\r\n']),MAXLENGTH(100000)));
								
versionB := filedate+'b';
Banko.Layout_CategoryEvent RemoveDupV2(Banko.Layout_CategoryEvent L
										,Banko.Layout_CategoryEvent R) := TRANSFORM
	SELF := L;
END;

Rec_RemoveDup1 := JOIN(ds_CatEvent,
					ds_CatEventFather,
					LEFT.CategoryEventID = RIGHT.CategoryEventID AND
					LEFT.Description = RIGHT.Description,
					RemoveDupV2(LEFT,RIGHT));	


NonMatch := ds_CatEvent - Rec_RemoveDup1;

RETURN IF(count(NonMatch) != 0,Banko.fUpdateBaseFile(ds_CatEvent,versionB));    
                                                                                                                                         	

END;