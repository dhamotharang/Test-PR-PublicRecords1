// This routine "blurs" input strings, so uppercase letters and numerals of
// similar shape will all be given the same code.  This can be used (in a
// manner similar to metaphone) to allow matching erroneous inputs when the
// errors occurred in the visual realm.  For example, vehicle tags viewed
// quickly or from afar may be misread in a manner matched by this technique.

export string blur(string s) := ut.tr(s, '8G6OQ0F31NRZ25V', 'BCCDDDEEIMPSSSU');

/*
The single-character routine below is useful as a form of documentation,
grouping the related characters and revealing similar shapes

string1 chr(string1 c) := map(
	c in ['A']							=> 'A',
	c in ['B','8']					=> 'B',
	c in ['C','G','6']			=> 'C',
	c in ['D','O','Q','0']	=> 'D',
	c in ['E','F','3']			=> 'E',
	c in ['H']							=> 'H',
	c in ['I','1']					=> 'I',
	c in ['J']							=> 'J',
	c in ['K']							=> 'K',
	c in ['L']							=> 'L',
	c in ['M','N']					=> 'M',
	c in ['P','R']					=> 'P',
	c in ['S','Z','2','5']	=> 'S',
	c in ['T']							=> 'T',
	c in ['U','V']					=> 'U',
	c in ['W']							=> 'W',
	c in ['X']							=> 'X',
	c in ['Y']							=> 'Y',
	c in ['4']							=> '4',
	c in ['7']							=> '7',
	c in ['9']							=> '9',
	c
);
*/