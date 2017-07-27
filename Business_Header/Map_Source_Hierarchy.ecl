EXPORT INTEGER1 Map_Source_Hierarchy(STRING2 source) := MAP(
								source in ['GB', 'GG'] => 1,
                                source = 'Y' => 2,
                                source = 'C' => 3,
                                source in ['D','V','LJ'] => 4,
                                source = 'E' => 5,
                                source in ['I ','ST','SB','FD','FN','WC','IN','PL','FF','DE','SK', 'CU'] => 6,
                                source = 'BR' => 7,
                                source = 'F' => 8,
								source in ['ED','AT'] => 9,
                                source = 'U' => 10,
                                source = 'B' => 11,
                                source = 'W' => 12,
                                13);