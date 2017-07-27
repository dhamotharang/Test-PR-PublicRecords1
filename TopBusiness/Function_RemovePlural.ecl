// This function takes the plural ending off of most English words correctly.  There are some exceptions that aren't
// accounted for here.

// xxxVXES -> xxxVX
// xxxVCES -> xxxVCE
// xxxDGES -> xxxDGE
// xxxCOES -> XXXCO
// xxxCIES -> xxxCY
// xxxCCES -> xxxCC
// xxxCS -> XXXC
// xxxVS -> XXXV

export Function_RemovePlural(string inword) := function

	vowels := ['A','E','I','O','U','Y'];
	tempword := stringlib.stringreverse(trim(inword));
	noplural := map(
		tempword[1] = 'S' => map(
			tempword[2] = 'E' => map(
				tempword[4] in vowels => map(
					tempword[3] = 'X' => tempword[3..],  // BOXES, FOXES, FAXES, MIXES, etc
					/* otherwise => */   tempword[2..]), // DATES, PLANES, CRATES, etc
				tempword[4] = 'D' and tempword[3] = 'G' => tempword[2..], // JUDGES, FUDGES, BADGES, GRUDGES, etc
				/* otherwise => */ map(
					tempword[3] = 'I' => 'Y' + tempword[4..], // CHERRIES, FERRIES, BELLIES, PARTIES, etc
					tempword[3] = 'O' => tempword[3..], // POTATOES, TOMATOES, etc
					tempword[3] in vowels => tempword[2..], // SUNDAES, BYES, DYES, etc
					tempword[3] in ['L','R'] => tempword[2..], // THEATRES, SEPLUCHRES, etc
					/* otherwise => */ tempword[3..])), // MISSES, KISSES, CATCHES, BATCHES, etc
			tempword[2] = 'U' => tempword, // non-plural (BUS, BONUS, PLUS, etc) - english words don't end in U
			tempword[2] in vowels => tempword[2..], // MINIS, SOLOS, BOYS, etc
			tempword[2] = 'S' => tempword, // non-plural (KISS, MISS, MISTRESS, DISTRESS, etc)
			length(tempword) = 1 => tempword, // the letter S
			/* otherwise => */ tempword[2..]), // CATS, DOGS, GIRLS, FATHERS, etc
		/* otherwise => */ tempword); // non-plural (?)
	
	return stringlib.stringreverse(noplural);

end;
