/*
output(WorkMan.get_WUGetGraph('W20140209-122304','graph5','737'));// powid iteration
output(WorkMan.get_WUGetGraph('W20140206-084814','graph47','1720'));

  get_WUGetGraph gets graphs for workunits
Can you be a little bit more specific, we have:
         Subgraphs (a group of activities)
         Activities (nodes/vertices)
         Edges (the lines joining two activities)

There are no counts associated with subgraphs, but there are timings associated with the top level subgraphs.

Activities will get a recordCount property, which (in the example I am looking at) looks like this:  500000..500000[memory]

Edges which do have a count property!

If you want to fetch the entire graph data (which includes subgraphs, activities and edges) you get it from (WsWorkunits/WUGetGraph):
http://10.241.3.241:8010/WsWorkunits/WUGetGraph?form

Just fill in Wuid and GraphName

You will then need to parse the XML response yourself.

*/
import WsWorkunits;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUGetGraph(

   string                    pWuid                  = ''      
  ,string                    pGraphName             = ''           
  ,string                    pSubGraphId            = ''
  ,string                    pesp                   = _Config.LocalEsp  
) :=                           
WsWorkunits.get_WUGetGraph(pWuid,pGraphName,pSubGraphId,pesp);
