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
import _control,std;
// #option('maxLength', 131072); // have to increase for the remote directory child datasets
//////////////////////////////////////////////////////////////////////////////////////////////
export get_WUGetGraph(

   string                    pWuid                  = ''      
  ,string                    pGraphName             = ''           
  ,string                    pSubGraphId            = ''
  ,string                    pesp                   = WsWorkunits._Config.LocalEsp  
) :=                           
function

  results := WsWorkunits.soapcall_WUGetGraph(pWuid  ,pGraphName ,pSubGraphId  ,pesp);
  
	export WUGetGraphRequest_Record :=
	record
  	string                      Wuid                  {xpath('Wuid'        )} := pWuid                 ;
		string                      GraphName             {xpath('GraphName'   )} := pGraphName            ;
		string                      SubGraphId            {xpath('SubGraphId'  )} := pSubGraphId           ;    
	end;

	export lECLGraphEx :=
	record
  	string                      Name              {xpath('Name'               )};
  	string                      Label             {xpath('Label'              )};
  	string                      Type              {xpath('Type'               )};
  	string                      GraphXml          {xpath('Graph'              )};
  	boolean                     Running           {xpath('Running'            )};
  	unsigned                    RunningId         {xpath('RunningId'          )};
  	boolean                     Complete          {xpath('Complete'           )};
  	boolean                     Failed            {xpath('Failed'             )};
  end;
  
	export lGraphs :=
	record
  	Dataset(lECLGraphEx)        ECLGraphEx          {xpath('ECLGraphEx'       )};
  end;                                                                                              

  dprep  := normalize(results,left.Graphs     ,transform(lGraphs    ,self := right));
  dprep2 := normalize(dprep  ,left.ECLGraphEx ,transform(lECLGraphEx,
    fix1 := STD.Str.FindReplace(right.GraphXml ,'&lt;'   ,'<' );
    fix2 := STD.Str.FindReplace(fix1        ,'&gt;'   ,'>' );
    fix3 := STD.Str.FindReplace(fix2        ,'&quot;' ,'"' );
    fix4 := STD.Str.FindReplace(fix3        ,'&amp;'  ,'&' );
    fix5 := STD.Str.FindReplace(fix4        ,'&apos;' ,'\'');
    fix6 := STD.Str.FindReplace(fix5        ,'&#10;'  ,'\\n');
    
    self.GraphXml  := fix6 ;
    self        := right;
  ));
  
  
	export subgraphatts :=
	record
  	string         definition   ;
  	string         _kind        ;
  	string         ecl          ;
  	string         recordSize   ;
  	string         recordCount  ;
  	boolean        _internal    ;
  end;

	export latts :=
	record
  	string         name         {xpath('@name'     )};
  	string         value        {xpath('@value'    )};
  end;

  export lsubgraphs := 
  record
  	string                  id           {xpath('@id'       )};
  	string                  label        {xpath('@label'    )};
    dataset(latts)          Attributes   {xpath('att'       )};
  end;

  export lEdges := 
  record
  	string                  id           {xpath('@id'       )};
  	string                  source       {xpath('@source'    )};
  	string                  target       {xpath('@target'    )};
    dataset(latts)          Attributes   {xpath('att'       )};
  end;

	export lNodes :=
	record
  	dataset(lsubgraphs)         subgraphs         {xpath('att/graph/node'          )};
  	dataset(latts     )         attributes        {xpath('att/graph/att'           )};
  	dataset(lEdges    )         Edges             {xpath('att/graph/edge'          )};
  end;
  
	export lGraphs2 :=
	record
  	Dataset(lNodes)        Nodes          {xpath('node'       )};
  	Dataset(lEdges)        Edges          {xpath('edge'       )};
  end;                                                                                              
  
	export lGraphExtra :=
	record	
  
 //   lECLGraphEx;
	  dataset(lGraphs2)   Graphinfo                {xpath('graph1'                        )};

	end;

//  dprep3 := PARSE(dprep2, GraphXml, lGraphExtra , XML( 'graph' ) );

  
  return dprep2;
  
end;
/*
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:wsse="http://schemas.xmlsoap.org/ws/2002/04/secext">
 <soap:Body>
  <WUGetGraphResponse xmlns="urn:hpccsystems:ws:wsworkunits">
   <Graphs>
    <ECLGraphEx>
     <Name>graph1</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;1&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;2&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;3&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;4&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;5&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spillRU2T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spillRU2T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;2_0&quot; source=&quot;2&quot; target=&quot;3&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;3_0&quot; source=&quot;3&quot; target=&quot;4&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;4_0&quot; source=&quot;4&quot; target=&quot;5&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;6&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;7&quot; label=&quot;Store&amp;#10;Result #1&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(&amp;apos;W20131216-091607&amp;apos; + IF(REGEXFIND(&amp;apos;ing&amp;apos;, realstate, nocase), &amp;apos; is &amp;apos;, &amp;apos; has &amp;apos;) + getstate + ..., output);&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;5_7&quot; source=&quot;1&quot; target=&quot;6&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;5&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;7&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
     <Complete>1</Complete>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph2</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;8&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;9&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;10&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;11&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;12&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spillFL3T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spillFL3T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;9_0&quot; source=&quot;9&quot; target=&quot;10&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;10_0&quot; source=&quot;10&quot; target=&quot;11&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;11_0&quot; source=&quot;11&quot; target=&quot;12&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;13&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;14&quot; label=&quot;Store&amp;#10;Internal(&amp;apos;aNU2T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(IF(getstate[1..6] = &amp;apos;failed&amp;apos;, &amp;apos;failed&amp;apos;, getstate), named(&amp;apos;aNU2T8&amp;apos;));&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;12_14&quot; source=&quot;8&quot; target=&quot;13&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;12&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;14&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
     <Complete>1</Complete>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph3</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;15&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;16&quot; label=&quot;SOAP action&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.mac_notify(34,15)&quot;/&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.remote_notify(2,1)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;remote_notify&quot;/&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.remote_notify(17,9)&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;65&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits&amp;apos;, &amp;apos;WUPushEvent&amp;apos;, rwupushevent, { string eventname := &amp;apos;__workunitevent__205841__&amp;apos;, string eventtext := &amp;apos;*&amp;apos;, string junk := &amp;apos;&amp;apos; });&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
&lt;/graph&gt;
</Graph>
     <Complete>1</Complete>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph4</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;17&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;18&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;19&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;20&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;21&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spillCM3T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spillCM3T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;18_0&quot; source=&quot;18&quot; target=&quot;19&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;19_0&quot; source=&quot;19&quot; target=&quot;20&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
    &lt;edge id=&quot;20_0&quot; source=&quot;20&quot; target=&quot;21&quot;&gt;
     &lt;att name=&quot;count&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;started&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;stopped&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;slaves&quot; value=&quot;1&quot;/&gt;
    &lt;/edge&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;22&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;23&quot; label=&quot;Store&amp;#10;Internal(&amp;apos;aOU2T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(&amp;apos;Watcher stopped, Notify event has been triggered because wuid W20131216-091607 ...&amp;apos; + ..., named(&amp;apos;aOU2T8&amp;apos;));&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;21_23&quot; source=&quot;17&quot; target=&quot;22&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;21&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;23&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
     <Complete>1</Complete>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph5</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;24&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;25&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;26&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;27&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;28&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spill9N3T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spill9N3T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;25_0&quot; source=&quot;25&quot; target=&quot;26&quot;/&gt;
    &lt;edge id=&quot;26_0&quot; source=&quot;26&quot; target=&quot;27&quot;/&gt;
    &lt;edge id=&quot;27_0&quot; source=&quot;27&quot; target=&quot;28&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;29&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;30&quot; label=&quot;Store&amp;#10;Result #2&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(&amp;apos;W20131216-091607&amp;apos; + IF(REGEXFIND(&amp;apos;ing&amp;apos;, realstate, nocase), &amp;apos; is &amp;apos;, &amp;apos; has &amp;apos;) + getstate + ..., output);&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;28_30&quot; source=&quot;24&quot; target=&quot;29&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;28&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;30&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph6</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;31&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;32&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;33&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;34&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;35&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spill7O3T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spill7O3T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;32_0&quot; source=&quot;32&quot; target=&quot;33&quot;/&gt;
    &lt;edge id=&quot;33_0&quot; source=&quot;33&quot; target=&quot;34&quot;/&gt;
    &lt;edge id=&quot;34_0&quot; source=&quot;34&quot; target=&quot;35&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;36&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;37&quot; label=&quot;Store&amp;#10;Internal(&amp;apos;aPU2T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(IF(getstate[1..6] = &amp;apos;failed&amp;apos;, &amp;apos;failed&amp;apos;, getstate), named(&amp;apos;aPU2T8&amp;apos;));&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;35_37&quot; source=&quot;31&quot; target=&quot;36&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;35&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;37&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph7</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;38&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;39&quot; label=&quot;SOAP action&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.mac_notify(34,15)&quot;/&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.remote_notify(2,1)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;remote_notify&quot;/&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.remote_notify(17,9)&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;65&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits&amp;apos;, &amp;apos;WUPushEvent&amp;apos;, rwupushevent, { string eventname := &amp;apos;__workunitevent__205841__&amp;apos;, string eventtext := &amp;apos;*&amp;apos;, string junk := &amp;apos;&amp;apos; });&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
&lt;/graph&gt;
</Graph>
    </ECLGraphEx>
    <ECLGraphEx>
     <Name>graph8</Name>
     <Label/>
     <Type>activities</Type>
     <Graph>&lt;graph&gt;
 &lt;node id=&quot;40&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;41&quot; label=&quot;SOAP dataset&quot;&gt;
     &lt;att name=&quot;definition&quot; value=&quot;WorkMan.get_wuinfo(170,3)&quot;/&gt;
     &lt;att name=&quot;name&quot; value=&quot;results&quot;/&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;64&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;SOAPCALL(&amp;apos;http://10.241.3.240:8010/WsWorkunits?ver_=1.30&amp;apos;, &amp;apos;WUInfo&amp;apos;, wuinfoinrecord, { string eclworkunit := &amp;apos;W20131216-091607&amp;apos;, boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath(&amp;apos;WUInfoResponse&amp;apos;));&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;204..100000(7884)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;42&quot; label=&quot;Project&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;7&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state });&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;0..?[disk]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;43&quot; label=&quot;Select Nth&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;32&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;NEWTABLE({ string state := state })[1];&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
     &lt;att name=&quot;recordCount&quot; value=&quot;1..1[tiny]&quot;/&gt;
    &lt;/node&gt;
    &lt;node id=&quot;44&quot; label=&quot;Output&amp;#10;Internal(&amp;apos;spill3P3T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;21&quot;/&gt;
     &lt;att name=&quot;_internal&quot; value=&quot;1&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;OUTPUT(..., named(&amp;apos;spill3P3T8&amp;apos;), __compressed__);&amp;#10;&quot;/&gt;
     &lt;att name=&quot;recordSize&quot; value=&quot;4..?(260)&quot;/&gt;
    &lt;/node&gt;
    &lt;edge id=&quot;41_0&quot; source=&quot;41&quot; target=&quot;42&quot;/&gt;
    &lt;edge id=&quot;42_0&quot; source=&quot;42&quot; target=&quot;43&quot;/&gt;
    &lt;edge id=&quot;43_0&quot; source=&quot;43&quot; target=&quot;44&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;node id=&quot;45&quot;&gt;
  &lt;att&gt;
   &lt;graph&gt;
    &lt;node id=&quot;46&quot; label=&quot;Store&amp;#10;Internal(&amp;apos;aQU2T8&amp;apos;)&quot;&gt;
     &lt;att name=&quot;_kind&quot; value=&quot;114&quot;/&gt;
     &lt;att name=&quot;ecl&quot; value=&quot;setresult(&amp;apos;Watcher stopped, Notify event has been triggered because wuid W20131216-091607 ...&amp;apos; + ..., named(&amp;apos;aQU2T8&amp;apos;));&amp;#10;&quot;/&gt;
    &lt;/node&gt;
    &lt;att name=&quot;rootGraph&quot; value=&quot;1&quot;/&gt;
   &lt;/graph&gt;
  &lt;/att&gt;
 &lt;/node&gt;
 &lt;edge id=&quot;44_46&quot; source=&quot;40&quot; target=&quot;45&quot;&gt;
  &lt;att name=&quot;_dependsOn&quot; value=&quot;1&quot;/&gt;
  &lt;att name=&quot;_sourceActivity&quot; value=&quot;44&quot;/&gt;
  &lt;att name=&quot;_targetActivity&quot; value=&quot;46&quot;/&gt;
 &lt;/edge&gt;
&lt;/graph&gt;
</Graph>
    </ECLGraphEx>
   </Graphs>
  </WUGetGraphResponse>
 </soap:Body>
</soap:Envelope>

*/

/*
<graph>
 <node id="1">
  <att>
   <graph>
    <node id="2" label="SOAP dataset">
     <att name="definition" value="WorkMan.get_wuinfo(170,3)"/>
     <att name="name" value="results"/>
     <att name="_kind" value="64"/>
     <att name="ecl" value="SOAPCALL('http://10.241.3.240:8010/WsWorkunits?ver_=1.30', 'WUInfo', wuinfoinrecord, { string eclworkunit := 'W20131216-091607', boolean includeexceptions := true, boolean includegraphs := true, boolean includesourcefiles := true, boolean includeresults := true, boolean includevariables := true, boolean includetimers := true, boolean includedebugvalues := true, boolean includeapplicationvalues := true, boolean includeworkflows := true, boolean suppressresultschemas := false }, wuinfooutrecord, xpath('WUInfoResponse'));\n"/>
     <att name="recordSize" value="204..100000(7884)"/>
     <att name="recordCount" value="0..?[disk]"/>
    </node>
    <node id="3" label="Project">
     <att name="_kind" value="7"/>
     <att name="ecl" value="NEWTABLE({ string state := state });\n"/>
     <att name="recordSize" value="4..?(260)"/>
     <att name="recordCount" value="0..?[disk]"/>
    </node>
    <node id="4" label="Select Nth">
     <att name="_kind" value="32"/>
     <att name="ecl" value="NEWTABLE({ string state := state })[1];\n"/>
     <att name="recordSize" value="4..?(260)"/>
     <att name="recordCount" value="1..1[tiny]"/>
    </node>
    <node id="5" label="Output\nInternal('spillRU2T8')">
     <att name="_kind" value="21"/>
     <att name="_internal" value="1"/>
     <att name="ecl" value="OUTPUT(..., named('spillRU2T8'), __compressed__);\n"/>
     <att name="recordSize" value="4..?(260)"/>
    </node>
    <edge id="2_0" source="2" target="3">
     <att name="count" value="1"/>
     <att name="started" value="1"/>
     <att name="stopped" value="1"/>
     <att name="slaves" value="1"/>
    </edge>
    <edge id="3_0" source="3" target="4">
     <att name="count" value="1"/>
     <att name="started" value="1"/>
     <att name="stopped" value="1"/>
     <att name="slaves" value="1"/>
    </edge>
    <edge id="4_0" source="4" target="5">
     <att name="count" value="1"/>
     <att name="started" value="1"/>
     <att name="stopped" value="1"/>
     <att name="slaves" value="1"/>
    </edge>
   </graph>
  </att>
 </node>
 <node id="6">
  <att>
   <graph>
    <node id="7" label="Store\nResult #1">
     <att name="_kind" value="114"/>
     <att name="ecl" value="setresult('W20131216-091607' + IF(REGEXFIND('ing', realstate, nocase), ' is ', ' has ') + getstate + ..., output);\n"/>
    </node>
    <att name="rootGraph" value="1"/>
   </graph>
  </att>
 </node>
 <edge id="5_7" source="1" target="6">
  <att name="_dependsOn" value="1"/>
  <att name="_sourceActivity" value="5"/>
  <att name="_targetActivity" value="7"/>
 </edge>
</graph>

*/
