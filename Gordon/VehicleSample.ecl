boolean plateStartsWithGAB := vehicle.PLATE_NUMBER[1..3] = 'GAB';
count(vehicle(plateStartsWithGAB));

boolean plateContainsGAB := stringlib.stringwildMatch(vehicle.PLATE_NUMBER, '*GAB*', false);
count(vehicle(plateContainsGAB));

boolean plateContainsGABAnd123 := stringlib.stringwildMatch(vehicle.PLATE_NUMBER, '*GAB*', false) and stringlib.stringwildMatch(vehicle.PLATE_NUMBER, '*123*', false);
count(vehicle(plateContainsGABAnd123));

boolean plateContainsCharsGAB123 := stringlib.stringContains(vehicle.PLATE_NUMBER, 'GAB123', false);
count(vehicle(plateContainsCharsGAB123));

boolean plateContainsKnownCharsGA123 := stringlib.stringContains(vehicle.PLATE_NUMBER, 'GA123', false);
boolean plateContains8orB := stringlib.stringContains(vehicle.PLATE_NUMBER, 'B', false) or stringlib.stringContains(vehicle.PLATE_NUMBER, '8', false);
boolean possibleColor := vehicle.MAJOR_COLOR_CODE in ['WHI', 'DBL', 'RED'];
output(vehicle(plateContainsKnownCharsGA123 and plateContains8orB and possibleColor));



//Hank.Count_Bankrupticies_by_month
//Hank.Address_USA