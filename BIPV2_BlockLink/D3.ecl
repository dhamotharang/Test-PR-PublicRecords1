IMPORT BIPV2_BlockLink,STD;
prox_base:=BIPV2_Blocklink.ManualOverlinksPROXID.reducedlayout;
sele_base:=BIPV2_Blocklink.ManualOverlinksLGID3.reducedlayout;
//note, only interested in leafnode or singleton sele and takes only a single lgid3. 
//for seleid with multiple lgid3 in linking, another visualization page is needed (without sortable table)

EXPORT D3:=MODULE //both sele_spc and prox_spc takes the id="proxSpc"
  shared sele_spc:='<table id="proxSpc" border="1" style="font-size:small;word-wrap: break-word;"><tr><td>LGID3 _SPC</td></tr>'+
	'<tr><td>FIELD:sbfe_id:WEIGHT(2.0):27,476</td></tr>'+
	'<tr><td>FIELD:company_name:LIKE(multiword):LIKE(Noblanks):BAGOFWORDS(MOST):EDIT1(2):PROP:TYPE(string250):26,332</td></tr>'+
	'<tr><td>FIELD:cnp_number:PROP:FORCE(--,OR(sbfe_id)):13,1</td></tr>'+
	'<tr><td>FIELD:active_duns_number:PROP:SWITCH0:27,52</td></tr>'+
	'<tr><td>FIELD:duns_number:PROP:SWITCH0:27,62</td></tr>'+
	'<tr><td>FIELD:duns_number_concept:active_duns_number:duns_number:27,111</td></tr>'+
	'<tr><td>FIELD:company_fein:26,182</td></tr>'+
	'<tr><td>FIELD:company_inc_state:PROP:FORCE(+,OR(active_duns_number), OR(duns_number),OR(duns_number_concept),OR(company_fein),OR(sbfe_id)):6,33</td></tr>'+
	'<tr><td>FIELD:company_charter_number:PROP:CONTEXT(company_inc_state):26,105</td></tr>'+
	'<tr><td>FIELD:cnp_btype:3,56</td></tr></table>'+
	'</td></tr><tr><td>Match Detail</td></tr>'+
	'<tr><td><div id="divCompare">Here is the detail</div></td></tr></table></td></tr></table>';
	
  shared prox_spc:=	'<table id="proxSpc" border="1" style="font-size:small;word-wrap: break-word;"><tr><td>PROXID _SPC</td></tr>'+
	'<tr><td>FIELD:active_duns_number:PROP:25,26</td></tr>'+
	'<tr><td>FIELD:active_enterprise_number:FORCE(--):PROP:25,6</td></tr>'+
	'<tr><td>FIELD:active_domestic_corp_key:FORCE(--):PROP:25,5</td></tr>'+
	'<tr><td>FIELD:hist_enterprise_number:PROP:25,6</td></tr>'+
	'<tr><td>FIELD:hist_duns_number:PROP:25,21</td></tr>'+
	'<tr><td>FIELD:hist_domestic_corp_key:PROP:24,21</td></tr>'+
	'<tr><td>FIELD:foreign_corp_key:SWITCH0:PROP:24,104</td></tr>'+
	'<tr><td>FIELD:unk_corp_key:SWITCH0:PROP:25,34</td></tr>'+
	'<tr><td>FIELD:ebr_file_number:PROP:25,231</td></tr>'+
	'<tr><td>FIELD:company_fein:PROP:EDIT1:24,168</td></tr>'+
	'<tr><td>FIELD:cnp_name:TYPE(STRING250):BAGOFWORDS(MOST):EDIT1:FORCE(+6,'+
	'OR(active_domestic_corp_key), OR(active_duns_number),OR(company_fein)):ABBR(ACRONYM,INITIAL,MAXSPC(13)):HYPHEN1:TYPE(string250):15,166</td></tr>'+
	'<tr><td>FIELD:cnp_number:FORCE:PROP:13,0</td></tr>'+
  '<tr><td>FIELD:cnp_btype:4,59</td></tr>'+
	'<tr><td>FIELD:company_phone:SWITCH0:PROP:24,337</td></tr>'+
	'<tr><td>FIELD:prim_name_derived:BAGOFWORDS(MOST):EDIT1:FORCE(+5):ABBR(FIRST):HYPHEN1:12,3</td></tr>'+
	'<tr><td>FIELD:sec_range:HYPHEN1:PROP:11,78</td></tr>'+
	'<tr><td>FIELD:v_city_name:CONTEXT(st):8,9</td></tr>'+
  '<tr><td>FIELD:st:LIKE(alpha):FORCE(+):0,0</td></tr>'+
	'<tr><td>FIELD:zip:LIKE(number):10,4</td></tr>'+
	'<tr><td>FIELD:prim_range_derived:FORCE:SINGLEPRIMRANGE:14,3</td></tr>'+
	'<tr><td>CONCEPT:company_csz:v_city_name:st:zip:FORCE(+-2):10,19</td></tr>'+
  '<tr><td>CONCEPT:company_addr1:prim_range_derived:prim_name_derived:sec_range:22,124</td></tr>'+
	'<tr><td>CONCEPT:company_address:company_addr1:company_csz:FORCE(+):22,137</td></tr></table>'+
	'</td></tr><tr><td>Match Detail</td></tr>'+
	'<tr><td><div id="divCompare">Here is the detail</div></td></tr></table></td></tr></table>';
	
  shared LiTreeTemplate(string sData, string s_dict, string proxData, string the_spc):=''+ //need to modify the alert places
	'<!DOCTYPE html><html><head><title>Linking Detail</title>'+
	'<script type="text/javascript" src="//d3js.org/d3.v3.js"></script>'+
	'<style type="text/css">'+
	'table.sortable thead {background-color:#eee;color:#666666;font-weight: bold;font-size:9pt;cursor:default;}'+
	'table.sortable tbody{font-size: 8pt;}'+
	'table.sortable th{white-space: normal;}'+
	'table.sortable tr{background: white;height:20px;}'+
	'table.sortable tr:nth-child(odd){background:blanchedalmond;height:20px;}'+
	'table.sortable td{white-space: nowrap;}'+
	'table.formatTable tr{background:blanchedalmond;}'+
  'table.formatTable td{font-size:9pt;}'+
	'</style>'+
	'<style>.treeview ul{margin: 0;padding: 0;}'+
	'.treeview li{font-size: medium;list-style-type:square;color:olive;cursor:hand !important;cursor:pointer !important;padding-left: 6px;margin-bottom: 1px;}'+
	'.treeview li.submenu{font-size:medium;list-style-type:disc;color:chocolate;cursor:hand !important;cursor:pointer !important;}'+
	'.treeview li.submenu ul{display: none;}'+ 
  '.treeview .submenu ul li{cursor: default;}</style>'+
	
	'<script type="text/javascript">'+
	'window.onload=function(){'+
	'var previousSort = null;'+
	'var format = d3.time.format("%a %b %d %Y");'+
	'var jsonData ='+proxData+';'+
	'refreshTable(null);'+
	'function refreshTable(sortOn){'+
	'var thead = d3.select("#thread1").selectAll("th").data(d3.keys(jsonData[0])).enter().append("th").text(function(d){return d;}).on("click", function(d){ return refreshTable(d);});'+
	'var tr = d3.select("#tbody1").selectAll("tr").data(jsonData);'+
	'tr.enter().append("tr");'+
	'var td = tr.selectAll("td").data(function(d){return d3.values(d);});'+
	'td.enter().append("td").text(function(d) {return d;});'+
	'if(sortOn !== null) {'+
	'if(sortOn != previousSort){'+
	'tr.sort(function(a,b){return sort(a[sortOn], b[sortOn]);});'+
	'previousSort = sortOn;'+
	'}else{'+
	'tr.sort(function(a,b){return sort(b[sortOn], a[sortOn]);});'+
	'previousSort = null;}'+
	'td.text(function(d) {return d;});'+
	'}};'+
	'function sort(a,b){'+
	'if(typeof a == "string"){'+
	'var parseA = format.parse(a);'+
	'if(parseA){'+
	'var timeA = parseA.getTime();'+
	'var timeB = format.parse(b).getTime();'+
	'return timeA > timeB ? 1 : timeA == timeB ? 0 : -1;'+
	'}else'+
	'{return a.localeCompare(b);}'+
	'}else if(typeof a == "number"){'+
	'return a > b ? 1 : a == b ? 0 : -1;'+
	'}else if(typeof a == "boolean"){'+
	'return b ? 1 : a ? -1 : 0;'+
	'}}};'+
	'</script>'+
	
	'<script type="text/javascript">'+
	'var d_tree = new Object();'+
	'd_tree.createTree = function (treeid) {'+
	'var ultags = document.getElementById(treeid).getElementsByTagName("ul");'+
	'var lis = document.getElementById(treeid).getElementsByTagName("li");'+
	'for (var j = 0; j < lis.length; j++) {'+
	'lis[j].onclick = function (e) {'+
	'divCompare.innerHTML= ay[e.srcElement.getAttribute("pp")];'+
	'd_tree.preventpropagate(e);}}'+
	'for (var i = 0; i < ultags.length; i++)'+
	'd_tree.buildSubTree(treeid, ultags[i], i);};'+
	'd_tree.buildSubTree = function (treeid, ul_em, index) {'+
	'ul_em.parentNode.className = "submenu";'+
	'if (ul_em.getAttribute("list-style-type") == null || ul_em.getAttribute("list-style-type") == false) {'+
	'ul_em.setAttribute("list-style-type", "disc");'+
	'} else if (ul_em.getAttribute("list-style-type") == "circle") {d_tree.expandSubTree(treeid, ul_em);};'+
	'ul_em.parentNode.onclick = function (e) {'+
	'var submenu = this.getElementsByTagName("ul")[0];'+
	'divCompare.innerHTML= ay[e.srcElement.getAttribute("pp")];'+
	'if (submenu.getAttribute("list-style-type") == "disc") {'+
	'submenu.style.display = "block";'+
	'submenu.setAttribute("list-style-type", "circle");'+
	'ul_em.parentNode.style.listStyleType = "circle";'+
	'} else {'+
	'submenu.style.display = "none";'+
	'submenu.setAttribute("list-style-type", "disc");'+
	'ul_em.parentNode.style.listStyleType = "disc";}'+
	'd_tree.preventpropagate(e);};'+
	'ul_em.onclick = function (e) {'+
	'divCompare.innerHTML= ay[e.srcElement.getAttribute("pp")];'+
	'd_tree.preventpropagate(e);}};'+
	'd_tree.expandSubTree = function (treeid, ul_em) {'+
	'var rootnode = document.getElementById(treeid);'+
	'var cur_node = ul_em;'+
	'cur_node.style.display = "block";'+
	'cur_node.parentNode.style.listStyleType = "circle";'+
	'while (cur_node != rootnode) {'+
	'if (cur_node.tagName == "UL") {'+
	'cur_node.style.display = "block";'+
	'cur_node.setAttribute("list-style-type", "circle");'+
	'cur_node.parentNode.style.listStyleType = "circle";}'+
	'cur_node = cur_node.parentNode;}};'+
	'd_tree.flatten = function (treeid, action) {'+
	'var ultags = document.getElementById(treeid).getElementsByTagName("ul");'+
	'for (var i = 0; i < ultags.length; i++) {'+
	'ultags[i].style.display = (action == "expand") ? "block" : "none";'+
	'var relvalue = (action == "expand") ? "open" : "closed";'+
	'var rCSS = (action == "expand") ? "circle" : "disc";'+
	'ultags[i].setAttribute("list-style-type", rCSS);'+
	'ultags[i].parentNode.style.listStyleType = rCSS;}};'+
	'd_tree.preventpropagate = function (e) {'+
	'if (typeof e != "undefined")'+
	'e.stopPropagation();'+
	'else'+
	' event.cancelBubble = true;};'+  
	'function showSPC(ind){'+
	'if(ind==1){document.getElementById("proxSpc").style.display="block";}'+
	'else{document.getElementById("proxSpc").style.display="none";}};'+
	'</script></head><body>'+
	
  '<table border="1"><tr><td><table id="demo" class="sortable" cellspacing="1" >'+
	'<thead id="thread1"></thead><tbody id="tbody1"></tbody></table></td></tr></table>'+
	'<Br/><P>Link History Tree</P>'+
	
	'<table border="1" width="100%"><tr><td width="40%" valign="top">'+
  '<a href="javascript:d_tree.flatten(\'treemenu1\',\'expand\')">Expand All</a> | <a href="javascript:d_tree.flatten(\'treemenu1\',\'contact\')">Collapse All</a>'+ 
	'<br/><ul id="treemenu1" class="treeview"></ul></td><td valign="top"><table><tr><td>'+
	'<a href="javascript:void(0)" onclick="showSPC(1);">Show SPC</a> | <a href="javascript:void(0)" onclick="showSPC(0);">Hide SPC</a>'+
  the_spc +
	'<script type="text/javascript">'+
	'var Jsn ='+sData+';'+
	'function createNode(json) {'+
	'var node = document.createElement("LI");'+
	'var textnode = document.createTextNode(json.name);'+
	'node.appendChild(textnode);'+
	'node.setAttribute("pp", json.pp);'+
	'return node;}'+
	'function generateList(data, fromNode){'+
	'aa = createNode(data);'+
	'bb=fromNode.appendChild(aa);'+
	'subList(data, bb);}'+
	'function subList(data,fromNode){'+
	'if (data.children != null) {'+
	'var ss = fromNode.appendChild(document.createElement("UL"));'+
	'for (var i = 0; i < data.children.length; i++) {'+
	'var cd = data.children[i];'+
	'var yy = ss.appendChild(createNode(cd));'+
	'subList(cd, yy);}}};'+
	s_dict+
	'generateList(Jsn, treemenu1);'+
	'd_tree.createTree("treemenu1");'+
	'</script></body></html>';
	 
	EXPORT ConverToJScriptDict(inDS,inRec,inId,inFld,sep,array_name) := FUNCTIONMACRO
  outRec := RECORD
    STRING result;
  END;

  outRec T1(inRec L, outRec R) := TRANSFORM
    SELF.result := R.result + IF(R.result <> '',sep,'') + array_name +'["' + (string)L.inId + '"]="' + L.inFld + '"';
  END;

  outRec T2(outRec R1, outRec R2) := TRANSFORM
    SELF.result := R1.result + R2.result;
  END;

   qq:=AGGREGATE(inDS,outRec,T1(LEFT,RIGHT),T2(RIGHT1,RIGHT2));
	 //output(qq);
	 xyz:='"'+array_name+'["';
	 tuv:='";'+array_name+'["';
	RETURN STD.Str.FindReplace(STD.Str.FindReplace(qq[1].result,'}{','},{'),xyz,tuv);
ENDMACRO;

Export ConverSeledatasetToJson(inDS, inRec) := FUNCTIONMACRO //For the sortable table part
	outRec := RECORD
    STRING result;
  END;
	outRec T1(inRec L, outRec R) := TRANSFORM 
    SELF.result := R.result + IF(R.result <> '',',','') + '{"id":' + (string)L.id + ',"lgid3":' + (string)L.lgid3 +
				 ',"sbfe_id":' + '"'+TRIM(L.sbfe_id)+'","Lgid3IfHrchy":"'+ TRIM(L.Lgid3IfHrchy) + '","company_name":"'+
				 TRIM(L.company_name)+'","cnp_number":"' + TRIM(L.cnp_number)+'","active_duns_number":"' + TRIM(L.active_duns_number) +
				 '","duns_number":"' + TRIM(L.duns_number) +'","company_fein":"' + TRIM(L.company_fein) +'","company_inc_state":"' + L.company_inc_state +
				 '","company_charter_number":"' + TRIM(L.company_charter_number) +
				 '","cnp_btype":"' + TRIM(L.cnp_btype) + '","good":"' + (string)((integer)L.good) + '"}';
  END;

  outRec T2(outRec R1, outRec R2) := TRANSFORM
    SELF.result := R1.result + R2.result;
  END;

   qq:=AGGREGATE(inDS,outRec,T1(LEFT,RIGHT),T2(RIGHT1,RIGHT2));
	 //output(qq);
	RETURN STD.Str.FindReplace(qq[1].result,'}{','},{');
ENDMACRO;

EXPORT ConverProxdatasetToJson(inDS, inRec) := FUNCTIONMACRO  //For the sortable table part
  outRec := RECORD
    STRING result;
  END;

  outRec T1(inRec L, outRec R) := TRANSFORM 
    SELF.result := R.result + IF(R.result <> '',',','') + '{"id":' + (string)L.id + ',"proxid":' + (string)L.proxid +
				 ',"cnp_name":' + '"'+TRIM(L.cnp_name)+'","cnp no":"'+ TRIM(L.cnp_number) + '","cnp btype":"' +
				 TRIM(L.cnp_btype)+'","prim range drvd":"' + TRIM(L.prim_range_derived)+'","prim name drvd":"' + TRIM(L.prim_name_derived) +
				 '","sec range":"' + TRIM(L.sec_range) +'","v_city_name":"' + TRIM(L.v_city_name) +'","st":"' + L.st +'","zip":"' + TRIM(L.zip) +
				 '","active duns no":"' + TRIM(L.active_duns_number) + '","hist duns no":"' + TRIM(L.hist_duns_number) +
				 '","active enterprise number":"' + TRIM(L.active_enterprise_number) +'","hist enterprise number":"'+ TRIM(L.hist_enterprise_number) +
				 '","ebr file no":"' + TRIM(L.ebr_file_number) +'","active domestic corp key":"' + TRIM(L.active_domestic_corp_key) +
				 '","hist domestic corp_key":"' + TRIM(L.hist_domestic_corp_key) +'","foreign corp key":"' + TRIM(L.foreign_corp_key) +
				 '","unk corp key":"'+ TRIM(L.unk_corp_key) + '","source":"' + TRIM(L.source) +'","company fein":"' + TRIM(L.company_fein) + 
				 '","company phone":"' + TRIM(L.company_phone) + '","good":"' + (string)((integer)L.good) + '"}';
  END;

  outRec T2(outRec R1, outRec R2) := TRANSFORM
    SELF.result := R1.result + R2.result;
  END;

   qq:=AGGREGATE(inDS,outRec,T1(LEFT,RIGHT),T2(RIGHT1,RIGHT2));
	 //output(qq);
	RETURN STD.Str.FindReplace(qq[1].result,'}{','},{');
ENDMACRO;




  EXPORT STRING ConvertToTree(DATASET(BIPV2_BlockLink.Types.GraphLabels) dLabels,DATASET(BIPV2_BlockLink.Types.GraphRelationships) dRelationships):=FUNCTION
    dParentLabels:=JOIN(dRelationships,TABLE(dLabels,{id;STRING parent:=label;}),LEFT.id=RIGHT.id);
    dChildLabels:=JOIN(dParentLabels,TABLE(dLabels,{id;STRING child:=label;}),LEFT.linkid=RIGHT.id);
    dWithJson:=TABLE(dChildLabels,{dChildLabels;UNSIGNED level:=0;STRING json:='';});

    RECORDOF(dWithJson) tGetLevels(DATASET(RECORDOF(dWithJson)) d,UNSIGNED i):=FUNCTION
      dTop:=PROJECT(JOIN(d(level=0),d(level=0),LEFT.id=RIGHT.linkid,TRANSFORM(LEFT),LEFT ONLY),TRANSFORM(RECORDOF(LEFT),SELF.level:=i;SELF:=LEFT;));
      RETURN IF(COUNT(d(level=0))=0,d,d(level>0)+dTop+JOIN(d(level=0),dTop,LEFT.id=RIGHT.id,LEFT ONLY));
    END;
    dWithLevels:=LOOP(dWithJson,100,tGetLevels(ROWS(LEFT),COUNTER));

    iLowestLevel:=MAX(dWithLevels,level);
    RECORDOF(dWithLevels) tConstructJson(DATASET(RECORDOF(dWithLevels)) d,UNSIGNED i):=FUNCTION
      //dLowest:=PROJECT(d(level=i),TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(LEFT.json='','{"name":"'+LEFT.child+'"}',LEFT.json);SELF:=LEFT;));
			dLowest:=PROJECT(d(level=i),TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(LEFT.json='','{"name":"'+LEFT.child+'","pp":"' + (string)Left.linkid+'"}',LEFT.json);SELF:=LEFT;));
      dRolled:=ROLLUP(SORT(dLowest,id),LEFT.id=RIGHT.id,TRANSFORM(RECORDOF(LEFT),SELF.json:=LEFT.json+','+RIGHT.json;SELF:=LEFT;));
      //dJoined:=JOIN(d(level<i),dRolled,LEFT.linkid=RIGHT.id,TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(RIGHT.json='','','{"name":"'+LEFT.child+'","children":['+RIGHT.json+']}');SELF:=LEFT;),LEFT OUTER);
      dJoined:=JOIN(d(level<i),dRolled,LEFT.linkid=RIGHT.id,TRANSFORM(RECORDOF(LEFT),SELF.json:=IF(RIGHT.json='','','{"name":"'+LEFT.child+'","pp":"' + (string)left.linkid+ '","children":['+RIGHT.json+']}');SELF:=LEFT;),LEFT OUTER);
			dFinal:=PROJECT(dRolled,TRANSFORM(RECORDOF(LEFT),SELF.json:='{"name":"'+LEFT.parent+'","pp":"'+(string)left.id+'","children":['+LEFT.json+']}';SELF:=LEFT;));
      RETURN IF(COUNT(dJoined)=0,dFinal,dJoined);
    END;
    dJson:=LOOP(dWithLevels,iLowestLevel,tConstructJson(ROWS(LEFT),iLowestLevel-COUNTER+1));
		//output(dJson); 
    RETURN dJson[1].json;
  END;
    
  
  EXPORT Graph(	STRING sChartType,STRING sChartName,string ProxOrSele='P',// take P or S
								DATASET(BIPV2_BlockLink.Types.GraphLabels) dLabels,
								DATASET(BIPV2_BlockLink.Types.GraphRelationships) dRelationships,
								DATASET(BIPV2_BlockLink.Types.Dict) dDet,
								dataset(prox_base) reducedProx=dataset([],prox_base),
								dataset(sele_base) reducedSele=dataset([],sele_base)			
								):=FUNCTION
		theDict:='var ay = {};' + ConverToJScriptDict(dDet,BIPV2_BlockLink.Types.Dict,id,det,';','ay') + ';';
		xx:=if(ProxOrSele='P', ConverProxdatasetToJson(reducedProx,prox_base), ConverSeledatasetToJson(reducedSele, sele_base));
		zz:=STD.Str.FindReplace((string)xx,'\r','');
		ww:=STD.Str.FindReplace(zz,'\n','');
		yy:='['+ww+']';
		//output(ww, named('ww'));
		spc:=if(ProxOrSele='P', prox_spc, sele_spc);
		theTemplate:=LiTreeTemplate(ConvertToTree(dLabels,dRelationships),theDict,yy,spc);
		RETURN MAP(
      sChartType='VerticalTree'=>OUTPUT(DATASET([{'CHARTCODE',theTemplate}],BIPV2_BlockLink.Types.ChartInterface),NAMED('CHART_VERTICALTREE_'+sChartName)),
      
			OUTPUT('Blah')
    );
  END;
END;