/*
output(wk_ut.get_WUGetGraph('W20140209-122304','graph5','737'));// powid iteration
output(wk_ut.get_WUGetGraph('W20140206-084814','graph47','1720'));

  get_WUGetGraph gets graphs for workunits
Can you be a little bit more specific, we have:
Ã¢â‚¬Â¢         Subgraphs (a group of activities)
Ã¢â‚¬Â¢         Activities (nodes/vertices)
Ã¢â‚¬Â¢         Edges (the lines joining two activities)

There are no counts associated with subgraphs, but there are timings associated with the top level subgraphs.

Activities will get a Ã¢â‚¬Å“recordCountÃ¢â‚¬Â property, which (in the example I am looking at) looks like this:  Ã¢â‚¬Å“500000..500000[memory]Ã¢â‚¬Â

Edges which do have a count property!

If you want to fetch the entire graph data (which includes subgraphs, activities and edges) you get it from (WsWorkunits/WUGetGraph):
http://10.241.3.241:8010/WsWorkunits/WUGetGraph?form

Just fill in Wuid and GraphName

You will then need to parse the XML response yourself.

*/
import Workman;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUGetGraph := Workman.get_WUGetGraph;