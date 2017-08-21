EXPORT string NeustarToSeisintId(string id) := 
																CASE(REGEXFIND('_([A-Z])', id, 1),
										'A' => '1',
										'B' => '2',
										'C' => '3',
										'D' => '4',
										'E' => '5',
										'F' => '6',
										'G' => '7',
										'H' => '8',
										'0')
										+
								IntFormat((integer)REGEXFIND('^(\\d+)',id, 1), 12, 1);