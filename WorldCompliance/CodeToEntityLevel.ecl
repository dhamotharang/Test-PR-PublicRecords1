EXPORT string CodeToEntityLevel(integer code) := CASE(code,
1	=> 'National',
2	=> 'International',
3	=> 'State',
4	=> 'Local',
5	=> 'N/A',
FAIL(integer, 'Unexpected Entity Level: ' + (string)code));