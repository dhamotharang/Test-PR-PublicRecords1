// This function takes in a SALT profile, the number of characters to show (-1 == show all)

IMPORT SALT38;

EXPORT SALT_Profile_Characters(DATASET(SALT38.MAC_Character_Counts.ResultLine_Layout) InputSALTProfile, INTEGER NumberOfCharactersToShow = -1) := FUNCTION
	SlimmedSALTProfile := PROJECT(InputSALTProfile, TRANSFORM({RECORDOF(LEFT) - cardinality - minval30 - maxval30 - asnumber_minval - asnumber_maxval - asnumber_mean - asnumber_var - len - words - patterns - frequent_terms}, SELF := LEFT));
	
	finalSALTProfile := PROJECT(SlimmedSALTProfile, TRANSFORM(RECORDOF(LEFT), SELF.Characters := IF(NumberOfCharactersToShow <= 0, LEFT.Characters, CHOOSEN(LEFT.Characters, NumberOfCharactersToShow)); SELF := LEFT));
									
	RETURN finalSALTProfile;
END;