/*Compile a death list
Group by DID and fname, then count the occurrences.
Pick the most frequent only if it is 1.5x as frequent as the next.
If not, don't pick any -- we don't have a 'best' fname*/

import header, mdr;
export Death := WatchDog.DeathFunc(file_header_filtered, 0, false, false)
  : persist('persist::watchdog_death');
