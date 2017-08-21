EXPORT string CodeToEntryType(integer code) := CASE(code,
1	=> 'Individual',
2	=> 'Organization',
3	=> 'Vessel',
4	=> 'Country',
5	=> 'Bank',
6	=> 'City',
7	=> 'Aircraft',
FAIL(integer, 'Unexpected Entity Type: ' + (string)code));