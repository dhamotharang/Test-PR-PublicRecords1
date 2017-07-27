/*2014-03-28T14:09:02Z (Steven Stockton)
Initial offering, new address hierarchy
*/
EXPORT Layout_Header_Address := RECORD
  Layout_Header_v2;
	UNSIGNED8 	address_group_id;
	UNSIGNED4   segment;
	UNSIGNED4   src_cnt;
END;