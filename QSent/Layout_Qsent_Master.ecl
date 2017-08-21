export Layout_Qsent_Master := record
 string hash_key;
 string listing_name;
 string addr1;
 string city;
 string st;
 string zip9;
 string phone; //Might have 0000 for non-pubs
 string listing_type; //RS (residence), BG (Business / Government), BR (Business / Residential) 
 string listing_class; //NP (non-published), SL (Standard Listing), NL (Non-Listed) 
 string action_code; // I (in), O (out), B (Baseline)
 string action_date; 
 string line_type; //LL (Land Line) 
 string prev_hash_key;
 string prev_action_code;
 string prev_action_date;
 string match_code;
end;

/* match code:

Those that begin with P are from matching records that have the same phone while those with an A are from those 
with the same address. The number indicates how the name was matched

1 Exact Name
2 Fuzzy Name
3 Name Letters - All of the letters in the listing are sorted and the edit distance computed. 
	This make it easy to spot corrections of “JOHN RAUSCH” to “RAUSCH, JOHN”  or “JONES, JOHN & MARY” to 
	“JONES, MARY & JOHN”
4 Exact Last Name
5 Fuzzy Last Name
6 Exact First Name
7 Fuzzy First Name
8 Best Name - where there is more than one possibility
9 Best F & L Names - where there is more than one possibility

*/