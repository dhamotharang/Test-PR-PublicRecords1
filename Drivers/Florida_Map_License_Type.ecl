export string1 Florida_Map_License_Type(string lt) := 
	map(lt[1..5] <> 'CLASS' => lt[1],
		lt[7] = 'O' => 'E',	//these two are the weird ones
		lt[7] = 'R' => 'L',
		lt[7]);				//or just take what class it was