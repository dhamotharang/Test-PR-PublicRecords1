/*BestSSNenhanced 
EQ confirmed unique SSN is reliable,
EQ confirmed multiple SSN, EQ non confirmed SSN and other sources need Pick best SSN
Group by SSN, then count the occurrences.
Pick the most frequent only if it is 2x as frequent as the next.
If not, don't pick any -- we don't have a 'best' SSN*/

import header, mdr, ut;

string20 var1 := '' : stored('watchtype');

get_best := watchdog.fn_best_ssn(file_header_filtered).concat_them;

export BestSSN := get_best : persist('persist::Watchdog_bestSSNenhanced');