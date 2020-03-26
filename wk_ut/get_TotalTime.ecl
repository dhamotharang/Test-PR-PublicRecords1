/*
  when total thor time is zero, then add up the graphs, + any copies, sprays, desprays, etc.
  if total thor time is non-zero, then take that, and add to it any copies, sprays, desprays
  total of all subgraph timings != total thor time.  total thor time is usually a little more
*/
import Workman;

EXPORT get_TotalTime := Workman.get_TotalTime;