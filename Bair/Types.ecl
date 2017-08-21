IMPORT BAIR;
EXPORT Types := MODULE

// This module currently allows for more than a quadrillion rows with 9B features
// If your needs are lower that making these two smaller will improve performance
// In particular an unsigned4 for recordid allows 9B rows and an unsigned2 for number allows 64K features
EXPORT t_RecordID := UNSIGNED;
EXPORT t_FieldNumber := UNSIGNED4;
EXPORT t_FieldReal := REAL8;
EXPORT t_FieldStr := STRING50;
EXPORT t_FieldSign := INTEGER1;
EXPORT t_Discrete := INTEGER4; // The number of 'groups' a population may be divided into - negative to allow for classificaiton to 'undershoot'
EXPORT t_Item := UNSIGNED4; // Currently allows up to 9B different elements
EXPORT t_Count := t_RecordID; // Possible to count every record

EXPORT NumericField := RECORD
  t_RecordID id;
	t_FieldNumber number;
	t_FieldStr value;
  END;

EXPORT DiscreteField := RECORD
  t_RecordID id;
	t_FieldNumber number;
	t_FieldStr value;
  END;

END;