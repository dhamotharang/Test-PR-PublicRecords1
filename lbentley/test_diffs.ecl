<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=utf-8"></meta><meta http-equiv="Refresh" content="100"></meta><link rel="stylesheet" type="text/css" href="/esp/files/default.css"></link><link rel="stylesheet" type="text/css" href="/esp/files/yui/build/fonts/fonts-min.css"></link><link rel="stylesheet" type="text/css" href="/esp/files/yui/build/menu/assets/skins/sam/menu.css"></link><link rel="stylesheet" type="text/css" href="/esp/files/yui/build/button/assets/skins/sam/button.css"></link><link rel="stylesheet" type="text/css" href="/esp/files/css/espdefault.css"></link><link rel="stylesheet" type="text/css" href="/esp/files/css/eclwatch.css"></link>
                    <script type="text/javascript" src="/esp/files/scripts/espdefault.js"></script>
                    <script type="text/javascript" src="/esp/files/yui/build/yahoo-dom-event/yahoo-dom-event.js"></script>
                    <script type="text/javascript" src="/esp/files/yui/build/container/container_core-min.js"></script>
                    <script type="text/javascript" src="/esp/files/yui/build/menu/menu-min.js"></script>
                <title>EclWatch</title><script type="text/javascript">
                    var chatUrl='';
                    var sortBy='';
                    var descending='0';
                    var showBannerflag='0';
                    var showChatURLflag='0';
                </script><script language="JavaScript1.2" id="menuhandlers">
                        function onLoad()
                        {
                            var selection = document.getElementById("sortClusters");
                            if (selection != NaN)
                            {
                                if (sortBy == 'Name' && descending == 1)
                                    selection.options[1].selected="selected";
                                else if (sortBy == 'Size' && descending == 0)
                                    selection.options[2].selected="selected";
                                else if (sortBy == 'Size' && descending == 1)
                                    selection.options[3].selected="selected";
                                else
                                    selection.options[0].selected="selected";
                            }

                            if (showBannerflag > 0)
                            {
                                if (document.getElementById("BannerContent") != NaN)
                                    document.getElementById("BannerContent").disabled = false;
                                if (document.getElementById("BannerColor") != NaN)
                                    document.getElementById("BannerColor").disabled = false;
                                if (document.getElementById("BannerSize") != NaN)
                                    document.getElementById("BannerSize").disabled = false;
                                if (document.getElementById("BannerScroll") != NaN)
                                    document.getElementById("BannerScroll").disabled = false;
                            }

                            if (document.getElementById("CB_BannerContent") != NaN)
                            {
                                if (showBannerflag > 0)
                                    document.getElementById("CB_BannerContent").checked = true;
                                else
                                    document.getElementById("CB_BannerContent").checked = false;
                            }

                            if ((showChatURLflag> 0) && (document.getElementById("ChatURL") != NaN))
                                document.getElementById("ChatURL").disabled = false;

                            if (document.getElementById("CB_ChatURL") != NaN)
                            {
                                if (showChatURLflag > 0)
                                    document.getElementById("CB_ChatURL").checked = true;
                                else
                                    document.getElementById("CB_ChatURL").checked = false;
                            }
                        }

                        function sortClustersChanged(sortClusterBy)
                        {
                            if (sortClusterBy == 2)
                                document.location.href = "/WsSmc/Activity?SortBy=Name&Descending=1";
                            else if (sortClusterBy == 3)
                                document.location.href = "/WsSmc/Activity?SortBy=Size";
                            else if (sortClusterBy == 4)
                                document.location.href = "/WsSmc/Activity?SortBy=Size&Descending=1";
                            else
                                document.location.href = "/WsSmc/Activity?SortBy=Name";
                        }

                        function commandQueue(action,cluster,clusterType,queue,wuid,serverType,ip,port)
                        {
                            document.getElementById("ClusterType").value=clusterType;
                            document.getElementById("Cluster").value=cluster;
                            document.getElementById("QueueName").value=queue;
                            document.getElementById("Wuid").value=wuid || '';
                            document.getElementById("ServerType").value=serverType;
                            document.getElementById("NetworkAddress").value=ip;
                            document.getElementById("Port").value=port;
                            document.forms["queue"].action='/WsSMC/'+action;
                            document.forms["queue"].submit();
                        }

                        var oMenu;

                        function queuePopup(cluster,clusterType,queue,serverType,ip,port,paused,stopped,q_rowid)
                        {
                            function clearQueue()
                            {
                                if(confirm('Do you want to clear the queue for cluster: '+cluster+'?'))
                                    commandQueue("ClearQueue",cluster,clusterType,queue,'',serverType,ip,port);
                            }
                            function pauseQueue()
                            {
                                commandQueue("PauseQueue",cluster,clusterType,queue,'',serverType,ip,port);
                            }
                            function resumeQueue()
                            {
                                commandQueue("ResumeQueue",cluster,clusterType,queue,'',serverType,ip,port);
                            }
                            function showUsage()
                            {
                                document.location.href='/WsWorkunits/WUJobList?form_&Cluster='+cluster+'&Range=30';
                            }
                            var xypos = YAHOO.util.Dom.getXY(q_rowid);
                            if (oMenu) {
                                oMenu.destroy();
                            }
                            oMenu = new YAHOO.widget.Menu("activitypagemenu", {position: "dynamic", xy: xypos} );
                            oMenu.clearContent();
                            oMenu.addItems([
                                { text: "Pause", onclick: { fn: pauseQueue }, disabled: !paused && !stopped ? false : true },
                                { text: "Resume", onclick: { fn: resumeQueue }, disabled: paused && !stopped ? false : true },
                                { text: "Clear", onclick: { fn: clearQueue } }
                            ]);
                            if (clusterType == 'THOR')
                                oMenu.addItems([
                                    { text: "Usage", onclick: { fn: showUsage } }
                                ]);

                            oMenu.render("rendertarget");
                            oMenu.show();
                            return false;
                        }

                        function activeWUPopup(type, cluster,clusterType,queue,wuid,highpriority)
                        {
                            function abortWuid()
                            {
                                if(confirm('Do you want to abort '+wuid+'?'))
                                {
                                    document.location="/WsWorkunits/WUAction?ActionType=Abort&Wuids_i1="+wuid;
                                }
                            }

                            function pauseWuid()
                            {
                                if(confirm('Do you want to pause '+wuid+'?'))
                                {
                                    document.location="/WsWorkunits/WUAction?ActionType=Pause&Wuids_i1="+wuid;
                                }
                            }

                            function pauseWuidNow()
                            {
                                if(confirm('Do you want to pause '+wuid+' now?'))
                                {
                                    document.location="/WsWorkunits/WUAction?ActionType=PauseNow&Wuids_i1="+wuid;
                                }
                            }

                            function resumeWuid()
                            {
                                if(confirm('Do you want to resume '+wuid+'?'))
                                {
                                    document.location="/WsWorkunits/WUAction?ActionType=Resume&Wuids_i1="+wuid;
                                }
                            }

                            function setHighPriority()
                            {
                                commandQueue("SetJobPriority?Priority=High",cluster,clusterType,queue,wuid);
                            }

                            function setNormalPriority()
                            {
                                commandQueue("SetJobPriority?Priority=Normal",cluster,clusterType,queue,wuid);
                            }
                            var xypos = YAHOO.util.Dom.getXY(cluster + '_' + wuid);
                            if (oMenu) {
                                oMenu.destroy();
                            }

                            oMenu = new YAHOO.widget.Menu("activitypagemenu", {position: "dynamic", xy: xypos} );
                            oMenu.clearContent();
                            oMenu.addItems([
                                { text: "Abort", onclick: { fn: abortWuid } },
                                { text: "High Priority", onclick: { fn: highpriority ? setNormalPriority : setHighPriority }, checked: highpriority ? true : false }
                                ]);

                            if (type == 'LCR')
                            {
                                oMenu.addItems([
                                    { text: "Pause", onclick: { fn: pauseWuid } },
                                    { text: "PauseNow", onclick: { fn: pauseWuidNow } }
                                ]);
                            }
                            else if (type == 'paused')
                            {
                                oMenu.addItems([
                                    { text: "Resume", onclick: { fn: resumeWuid } }
                                    ]);
                            }
                            oMenu.render("rendertarget");
                            oMenu.show();
                            return false;
                        }

                        function queuedWUPopup(cluster,clusterType,queue,eclAgentQueue, wuid,prev,next,highpriority)
                        {
                            function moveupWuid()
                            {
                                commandQueue("MoveJobUp",cluster,clusterType,queue,wuid);
                            }
                            function movedownWuid()
                            {
                                commandQueue("MoveJobDown",cluster,clusterType,queue,wuid);
                            }
                            function movefrontWuid()
                            {
                                commandQueue("MoveJobFront",cluster,clusterType,queue,wuid);
                            }
                            function movebackWuid()
                            {
                                commandQueue("MoveJobBack",cluster,clusterType,queue,wuid);
                            }
                            function removeWuid()
                            {
                                if(confirm('Do you want to remove '+wuid+'?'))
                                    commandQueue("RemoveJob",cluster,clusterType,queue,wuid);
                            }
                            function setHighPriority()
                            {
                                commandQueue("SetJobPriority?Priority=High",cluster,clusterType,queue,wuid);
                            }

                            function setNormalPriority()
                            {
                                commandQueue("SetJobPriority?Priority=Normal",cluster,clusterType,queue,wuid);
                            }

                            var xypos = YAHOO.util.Dom.getXY(cluster + '_' + wuid);
                            if (oMenu) {
                                oMenu.destroy();
                            }
                            oMenu = new YAHOO.widget.Menu("activitypagemenu", {position: "dynamic", xy: xypos} );
                            oMenu.clearContent();

                            if (eclAgentQueue == '') {
                                oMenu.addItems([
                                    { text: "Move Up", onclick: { fn: moveupWuid }, disabled: prev ? false : true },
                                    { text: "Move Down", onclick: { fn: movedownWuid }, disabled: next ? false : true },
                                    { text: "Move Top", onclick: { fn: movefrontWuid }, disabled: prev ? false : true },
                                    { text: "Move Bottom", onclick: { fn: movebackWuid }, disabled: next ? false : true },
                                    { text: "Remove", onclick: { fn: removeWuid } },
                                    { text: "High Priority", onclick: { fn: highpriority ? setNormalPriority : setHighPriority }, checked: highpriority ? true : false }
                                ]);
                            } else {
                                oMenu.addItems([
                                    { text: "Remove", onclick: { fn: removeWuid } }
                                ]);
                            }
                            oMenu.render("rendertarget");
                            oMenu.show();
                            return false;
                        }

                        function chatPopup()
                        {
                            mywindow = window.open (chatUrl, "mywindow", "location=0,status=1,scrollbars=1,resizable=1,width=400,height=200");
                            if (mywindow.opener == null)
                                mywindow.opener = window;
                            mywindow.focus();
                            return false;
                        }

                        var showSetBanner = 0;
                        function SetBanner()
                        {
                            obj = document.getElementById('SetBannerFrame');
                            if (obj)
                            {
                                showSetBanner = (showSetBanner > 0) ? 0: 1;
                                if (showSetBanner > 0)
                                {
                                    obj.style.display = 'inline';
                                    obj.style.visibility = 'visible';
                                }
                                else
                                {
                                    obj.style.display = 'none';
                                    obj.style.visibility = 'hidden';
                                }
                            }
                        }

                        function handleSetBannerForm(item, value)
                        {
                            if (item == 1)
                            {
                                obj = document.getElementById('ChatURL');
                                if (obj)
                                {
                                    if (value)
                                        obj.disabled = false;
                                    else
                                        obj.disabled = true;
                                }
                            }
                            else
                            {
                                obj = document.getElementById('BannerContent');
                                if (obj)
                                {
                                    if (value)
                                        obj.disabled = false;
                                    else
                                        obj.disabled = true;
                                }
                                obj = document.getElementById('BannerColor');
                                if (obj)
                                {
                                    if (value)
                                        obj.disabled = false;
                                    else
                                        obj.disabled = true;
                                }
                                obj = document.getElementById('BannerSize');
                                if (obj)
                                {
                                    if (value)
                                        obj.disabled = false;
                                    else
                                        obj.disabled = true;
                                }
                                obj = document.getElementById('BannerScroll');
                                if (obj)
                                {
                                    if (value)
                                        obj.disabled = false;
                                    else
                                        obj.disabled = true;
                                }
                            }
                        }

                        function checkSize(strString)
                        {
                            var strChar;
                            var strValidChars = "0123456789";
                            var bOK = true;

                            if (strString.length == 0) return false;

                            for (i = 0; i < strString.length && bOK == true; i++)
                            {
                                strChar = strString.charAt(i);
                                if (strValidChars.indexOf(strChar) == -1)
                                {
                                    bOK = false;
                                }
                                else if (i == 0 && strChar == '0')
                                {
                                    bOK = false;
                                }
                            }

                            return bOK;
                        }

                        function trimAll(sString)
                        {
                            while (sString.substring(0,1) == ' ')
                            {
                                sString = sString.substring(1, sString.length);
                            }
                            while (sString.substring(sString.length-1, sString.length) == ' ')
                            {
                                sString = sString.substring(0,sString.length-1);
                            }
                            return sString;
                        }

                        function handleSubmitBtn()
                        {
                            showBanner = 0;
                            banner = "";
                            bannerScroll = "2";
                            bannerSize = "12";
                            bannerColor = "red";
                            showChatLink = 0;
                            chatURL = "";

                            obj = document.getElementById("CB_BannerContent");
                            obj1 = document.getElementById("BannerContent");
                            obj2 = document.getElementById("BannerColor");
                            obj3 = document.getElementById("BannerSize");
                            obj4 = document.getElementById("BannerScroll");
                            if (obj)
                            {
                                if (obj.checked)
                                {
                                    if (obj1 && (obj1.value != ''))
                                    {
                                        showBanner = 1;
                                    }
                                    else
                                    {
                                        alert("Banner content should not be empty.");
                                        return false;
                                    }
                                }
                                if (obj1 && (obj1.value != ''))
                                {
                                    banner = trimAll(obj1.value);
                                }
                                if (obj2 && (obj2.value != ''))
                                {
                                    bannerColor = obj2.value;
                                }
                                if (obj3 && (obj3.value != ''))
                                {
                                    if (checkSize(obj3.value))
                                        bannerSize = obj3.value;
                                    else
                                    {
                                        alert("Incorrect size input!");
                                        return false;
                                    }
                                }
                                if (obj4 && (obj4.value != ''))
                                {
                                    if (checkSize(obj4.value))
                                        bannerScroll = obj4.value;
                                    else
                                    {
                                        alert("Incorrect scroll amount input!");
                                        return false;
                                    }
                                }
                            }

                            obj2 = document.getElementById("CB_ChatURL");
                            obj3 = document.getElementById("ChatURL");
                            if (obj2)
                            {
                                if (obj2.checked)
                                {
                                    chatURL0 = '';
                                    if (obj3 && (obj3.value != ''))
                                        chatURL0 = trimAll(obj3.value);

                                    if (chatURL0 != '')
                                    {
                                        showChatLink = 1;
                                        if (chatURL0.indexOf('http') == 0)
                                            chatURL = chatURL0;
                                        else
                                            chatURL = 'http://'+ chatURL0;
                                    }
                                    else
                                    {
                                        alert("Chat URL should not be empty.");
                                        return;
                                    }
                                }
                                else if (obj3 && (obj3.value != ''))
                                {
                                    chatURL = trimAll(obj3.value);
                                }
                            }
                            var href='/WsSMC/Activity?FromSubmitBtn=true&BannerAction='+showBanner + '&EnableChatURL='+showChatLink;
                            href += ('&ChatURL=' + chatURL);
                            href += ('&BannerContent=' + banner);
                            href += ('&BannerColor=' + bannerColor);
                            href += ('&BannerSize=' + bannerSize);
                            href += ('&BannerScroll=' + bannerScroll);
                            document.location.href=href;
                        }
                   </script></head><body class="yui-skin-sam" onload="nof5();onLoad()"><form><table></table></form><table width="100%"><tbody><tr><td align="left"><h3>Existing Activity on Servers:</h3></td><td align="right"><select id="sortClusters" name="sortClusters" onchange="sortClustersChanged(options[selectedIndex].value);"><option value="1">Sort clusters by name ascending</option><option value="2">Sort clusters by name descending</option><option value="3">Sort clusters by size ascending</option><option value="4">Sort clusters by size descending</option></select></td></tr></tbody></table><form id="queue" action="/WsSMC" method="post"><input type="hidden" name="ClusterType" id="ClusterType" value=""></input><input type="hidden" name="Cluster" id="Cluster" value=""></input><input type="hidden" name="QueueName" id="QueueName" value=""></input><input type="hidden" name="Wuid" id="Wuid" value=""></input><input type="hidden" name="ServerType" id="ServerType" value=""></input><input type="hidden" name="NetworkAddress" id="NetworkAddress" value=""></input><input type="hidden" name="Port" id="Port" value=""></input><table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_1" class="configurecontextmenu" title="Option" onclick="return queuePopup('pound_option_thor','THOR',
                            'pound_option_thor.thor','ThorMaster','','0',
                            false,false, 'mn_1_1');
                        "> </a><a class="thorrunning" title="pound_option_thor.thor: queue active; " href="javascript:go('/WsTopology/TpClusterInfo?Name=pound_option_thor')">ThorCluster - pound_option_thor</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tr>
<th style="background-color:#DDDDDD">Active workunit</th>
<th style="background-color:#DDDDDD">State</th>
<th style="background-color:#DDDDDD">Owner</th>
<th style="background-color:#DDDDDD">Job name</th>
</tr>
<tbody>
<tr style="border:solid 2 black">
<td class="active">
<a id="pound_option_thor_W20150723-133836" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'pound_option_thor','THOR',
                                'pound_option_thor.thor','W20150723-133836',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-133836')"><b>W20150723-133836</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-133836&amp;GraphName=graph1&amp;SubGraphId=1&amp;SubGraphOnly=1')">121 min</a>)
                    </td>
<td class="active">amckillip 
        </td>
<td class="active">FCRA Bocashell 5.0 Process, Wells2377</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="pound_option_thor_W20150723-142853" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'pound_option_thor','THOR',
                                'pound_option_thor.thor','W20150723-142853',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-142853')"><b>W20150723-142853</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-142853&amp;GraphName=graph1&amp;SubGraphId=1&amp;SubGraphOnly=1')">30 min</a>)
                    </td>
<td class="active">amckillip 
        </td>
<td class="active">FCRA Bocashell 5.0 Process, Regional5780</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-142918" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-142918',
                        false,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-142918')">W20150723-142918</a>
</td>
<td class="normalpriority">queued(1) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">amckillip 
        </td>
<td class="normalpriority">FCRA Bocashell 5.0 Process, Regional5780</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-145423" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-145423',
                        true,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-145423')">W20150723-145423</a>
</td>
<td class="normalpriority">queued(2) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">amckillip 
        </td>
<td class="normalpriority">NonFCRA BocaShell 5.0, Axcess3339</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-145554" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-145554',
                        true,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-145554')">W20150723-145554</a>
</td>
<td class="normalpriority">queued(3) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">nmontpetit_prod 
        </td>
<td class="normalpriority">Consumer IID-FP Process</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-145703" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-145703',
                        true,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-145703')">W20150723-145703</a>
</td>
<td class="normalpriority">queued(4) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">nmontpetit_prod 
        </td>
<td class="normalpriority">Consumer IID-FP Process</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-145812" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-145812',
                        true,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-145812')">W20150723-145812</a>
</td>
<td class="normalpriority">queued(5) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">amckillip 
        </td>
<td class="normalpriority">NonFCRA BocaShell 5.0, Chase2581</td>
</tr>
<tr>
<td class="normalpriority">
<a id="pound_option_thor_W20150723-154027" class="configurecontextmenu" onclick="
                    return queuedWUPopup('pound_option_thor','THOR',
                        'pound_option_thor.thor','','W20150723-154027',
                        true,
                        true,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-154027')">W20150723-154027</a>
</td>
<td class="normalpriority">queued(6) [blocked on pound_option_thor.thor]</td>
<td class="normalpriority">amckillip 
        </td>
<td class="normalpriority">NonFCRA BocaShell 5.0, Chase2581</td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_2" class="configurecontextmenu" title="Option" onclick="return queuePopup('thor400_20','THOR',
                            'thor400_20.thor','ThorMaster','','0',
                            false,false, 'mn_1_2');
                        "> </a><a class="thorrunning" title="thor400_20.thor: queue active; " href="javascript:go('/WsTopology/TpClusterInfo?Name=thor400_20')">ThorCluster - thor400_20</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black">
<td class="active">
<a id="thor400_20_W20150723-101140-5" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-101140-5',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-101140-5')"><b>W20150723-101140-5</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-101140-5&amp;GraphName=graph15&amp;SubGraphId=7609&amp;SubGraphOnly=1')">304 min</a>)
                    </td>
<td class="active">ddehilster 
        </td>
<td class="active">HXMX Build All 201409</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="highpriority">
<a id="thor400_20_W20150723-182002" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-182002',true);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-182002')"><b>W20150723-182002</b></a>
</td>
<td class="highpriority">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-182002&amp;GraphName=graph2&amp;SubGraphId=89&amp;SubGraphOnly=1')">8 min</a>)
                    </td>
<td class="highpriority">skasavajjala_prod 
        </td>
<td class="highpriority">NtlCrash Build All 20150723b</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="thor400_20_W20150723-123430" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-123430',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-123430')"><b>W20150723-123430</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-123430&amp;GraphName=graph30&amp;SubGraphId=1776&amp;SubGraphOnly=1')">1 min</a>)
                    </td>
<td class="active">kreeder_prod 
        </td>
<td class="active">DNB Build All 20150723</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="thor400_20_W20150723-081443" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-081443',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-081443')"><b>W20150723-081443</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-081443&amp;GraphName=graph45&amp;SubGraphId=11802&amp;SubGraphOnly=1')">30 min</a>)
                    </td>
<td class="active">kreeder_prod 
        </td>
<td class="active">Enclarity Build 20150715</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="thor400_20_W20150723-190005" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-190005',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-190005')"><b>W20150723-190005</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-190005&amp;GraphName=graph1&amp;SubGraphId=649&amp;SubGraphOnly=1')">1 min</a>)
                    </td>
<td class="active">rreyes_prod 
        </td>
<td class="active">Yogurt:NPPES Build - 20150723</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="highpriority">
<a id="thor400_20_W20150723-150027" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_20','THOR',
                                'thor400_20.thor','W20150723-150027',true);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-150027')"><b>W20150723-150027</b></a>
</td>
<td class="highpriority">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-150027&amp;GraphName=graph75&amp;SubGraphId=2314&amp;SubGraphOnly=1')">2 min</a>)
                    </td>
<td class="highpriority">cbrodeur_prod 
        </td>
<td class="highpriority">Gong Neustar Spray &amp; Build 20150723</td>
</tr>
<tr>
<td class="normalpriority">
<a id="thor400_20_W20150723-192101" class="configurecontextmenu" onclick="
                    return queuedWUPopup('thor400_20','THOR',
                        'thor400_20.thor','','W20150723-192101',
                        true,
                        false,
                        false);
                ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-192101')">W20150723-192101</a>
</td>
<td class="normalpriority">queued(1) [blocked on thor400_20.thor]</td>
<td class="normalpriority">skasavajjala_prod 
        </td>
<td class="normalpriority">Yogurt:LiensV2 Non Hogan DID 20150723</td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_3" class="configurecontextmenu" title="Option" onclick="return queuePopup('thor400_30','THOR',
                            'thor400_30.thor','ThorMaster','','0',
                            false,false, 'mn_1_3');
                        "> </a><a class="thorrunning" title="thor400_30.thor: queue active; " href="javascript:go('/WsTopology/TpClusterInfo?Name=thor400_30')">ThorCluster - thor400_30</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black"></tr>
<tr style="border:solid 2 black">
<td class="highpriority">
<a id="thor400_30_W20150723-193057" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_30','THOR',
                                'thor400_30.thor','W20150723-193057',true);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-193057')"><b>W20150723-193057</b></a>
</td>
<td class="highpriority">running [ECLagent on 10.241.60.204]</td>
<td class="highpriority">mgould_prod 
        </td>
<td class="highpriority">CORPS V2 DAILY PREPROCESS STATES - 20150...</td>
</tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_4" class="configurecontextmenu" title="Option" onclick="return queuePopup('thor400_31_store','THOR',
                            'thor400_31_store.thor','ThorMaster','','0',
                            true,false, 'mn_1_4');
                        "> </a><a class="thorrunningpausedqueuenojobs" title="thor400_31_store.thor: queue paused;  paused by &lt;ihammes&gt; at &lt;2015-03-29T03:23:58&gt; from &lt;10.176.156.27&gt;;" href="javascript:go('/WsTopology/TpClusterInfo?Name=thor400_31_store')">ThorCluster - thor400_31_store<span style="background: #C00">Queue paused or stopped</span></a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black"></tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150409-162505')">W20150409-162505</a></td>
<td class="normalpriority">Could not open workunit W20150409-162505</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150413-100001')">W20150413-100001</a></td>
<td class="normalpriority">Could not open workunit W20150413-100001</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150423-203927')">W20150423-203927</a></td>
<td class="normalpriority">Could not open workunit W20150423-203927</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150603-133538')">W20150603-133538</a></td>
<td class="normalpriority">Could not open workunit W20150603-133538</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150608-085838')">W20150608-085838</a></td>
<td class="normalpriority">Could not open workunit W20150608-085838</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150609-163723')">W20150609-163723</a></td>
<td class="normalpriority">Could not open workunit W20150609-163723</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150609-163808')">W20150609-163808</a></td>
<td class="normalpriority">Could not open workunit W20150609-163808</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150629-112230')">W20150629-112230</a></td>
<td class="normalpriority">Could not open workunit W20150629-112230</td>
<td class="normalpriority"> 
        </td>
<td class="normalpriority"></td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_5" class="configurecontextmenu" title="Option" onclick="return queuePopup('thor400_60','THOR',
                            'thor400_60.thor','ThorMaster','','0',
                            false,false, 'mn_1_5');
                        "> </a><a class="thorrunning" title="thor400_60.thor: queue active; " href="javascript:go('/WsTopology/TpClusterInfo?Name=thor400_60')">ThorCluster - thor400_60</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black">
<td class="active">
<a id="thor400_60_W20150723-155613" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_60','THOR',
                                'thor400_60.thor','W20150723-155613',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-155613')"><b>W20150723-155613</b></a>
</td>
<td class="active">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-155613&amp;GraphName=graph107&amp;SubGraphId=4189&amp;SubGraphOnly=1')">4 min</a>)
                    </td>
<td class="active">cpettola_prod 
        </td>
<td class="active">Vehicle Picker File</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="highpriority">
<a id="thor400_60_W20150723-184303" class="configurecontextmenu" onclick="
                            return activeWUPopup('LCR', 'thor400_60','THOR',
                                'thor400_60.thor','W20150723-184303',true);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-184303')"><b>W20150723-184303</b></a>
</td>
<td class="highpriority">running
                    (<a title="Graphview Control" href="javascript:go('/WsWorkunits/GVCAjaxGraph?Name=W20150723-184303&amp;GraphName=graph13&amp;SubGraphId=277&amp;SubGraphOnly=1')">8 min</a>)
                    </td>
<td class="highpriority">skasavajjala_prod 
        </td>
<td class="highpriority">Yogurt:ECrashV2 Build All 20150723b</td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_1_6" class="configurecontextmenu" title="Option" onclick="return queuePopup('thor400_92','THOR',
                            'thor400_92.thor','ThorMaster','','0',
                            true,false, 'mn_1_6');
                        "> </a><a class="thorrunningpausedqueuenojobs" title="thor400_92.thor: queue paused;  paused by &lt;ihammes&gt; at &lt;2015-07-21T14:55:19&gt; from &lt;10.176.156.27&gt;;" href="javascript:go('/WsTopology/TpClusterInfo?Name=thor400_92')">ThorCluster - thor400_92<span style="background: #C00">Queue paused or stopped</span></a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black"></tr>
<tr>
<td class="normalpriority"><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150723-153540')">W20150723-153540</a></td>
<td class="normalpriority">failed [ECLagent on 10.173.84.204]<a class="thorstoppedrunningqueue" title="More Information" onclick="alert('The job will ultimately not complete. Please check ECLAgent.')"> </a>
</td>
<td class="normalpriority">Jhabbu_prod 
        </td>
<td class="normalpriority"></td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_3_1" class="configurecontextmenu" title="Option" onclick="return queuePopup('hthor_pound_option','HTHOR',
                            'hthor_pound_option.agent','HThorServer','','0',
                            false,false, 'mn_3_1');
                        "> </a><a class="thorrunning" title="hthor_pound_option.agent: queue active; ">HThorCluster - hthor_pound_option</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_3_2" class="configurecontextmenu" title="Option" onclick="return queuePopup('hthor','HTHOR',
                            'hthor.agent','HThorServer','','0',
                            false,false, 'mn_3_2');
                        "> </a><a class="thorrunning" title="hthor.agent: queue active; ">HThorCluster - hthor</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black"></tr>
<tr style="border:solid 2 black">
<td class="active">
<a id="hthor_W20150722-101551" class="configurecontextmenu" onclick="
                            return activeWUPopup('noLCR', 'hthor','HTHOR',
                                'hthor.agent','W20150722-101551',false);
                        ">
                     
                </a><a href="javascript:go('/WsWorkunits/WUInfo?Wuid=W20150722-101551')"><b>W20150722-101551</b></a>
</td>
<td class="active">running [ECLagent on 10.173.85.205]</td>
<td class="active">ananth_prod 
        </td>
<td class="active"></td>
</tr>
</tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_3_3" class="configurecontextmenu" title="Option" onclick="return queuePopup('hthor_qa_roxie','HTHOR',
                            'hthor_qa_roxie.agent','HThorServer','','0',
                            false,false, 'mn_3_3');
                        "> </a><a class="thorrunning" title="hthor_qa_roxie.agent: queue active; ">HThorCluster - hthor_qa_roxie</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_3_4" class="configurecontextmenu" title="Option" onclick="return queuePopup('hthor_centos6','HTHOR',
                            'hthor_centos6.agent','HThorServer','','0',
                            false,false, 'mn_3_4');
                        "> </a><a class="thorrunning" title="hthor_centos6.agent: queue active; ">HThorCluster - hthor_centos6</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_1" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.84.205:7302','ECLserver',
                            'hthor_qa_roxie.eclserver','ECLserver','10.173.84.205','7302',
                            false,false, 'mn_6_1');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.84.205:7302</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_2" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.85.211:7469','ECLserver',
                            'thor400_20.eclserver','ECLserver','10.173.85.211','7469',
                            false,false, 'mn_6_2');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.85.211:7469</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_3" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.84.211:7174','ECLserver',
                            'thor400_92.eclserver,hthor.eclserver','ECLserver','10.173.84.211','7174',
                            false,false, 'mn_6_3');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.84.211:7174</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_4" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.84.207:7133','ECLserver',
                            'pound_option_thor.eclserver,hthor_pound_option.eclserver','ECLserver','10.173.84.207','7133',
                            false,false, 'mn_6_4');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.84.207:7133</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_5" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.84.210:7157','ECLserver',
                            'thor400_92.eclserver,hthor.eclserver','ECLserver','10.173.84.210','7157',
                            false,false, 'mn_6_5');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.84.210:7157</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_6" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.241.60.203:7423','ECLserver',
                            'hthor_centos6.eclserver,thor400_30.eclserver,thor400_60.eclserver','ECLserver','10.241.60.203','7423',
                            false,false, 'mn_6_6');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.241.60.203:7423</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_7" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.241.20.203:7327','ECLserver',
                            'thor400_20.eclserver','ECLserver','10.241.20.203','7327',
                            false,false, 'mn_6_7');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.241.20.203:7327</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_8" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.241.20.202:7433','ECLserver',
                            'thor400_20.eclserver','ECLserver','10.241.20.202','7433',
                            false,false, 'mn_6_8');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.241.20.202:7433</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_9" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.241.60.202:7149','ECLserver',
                            'hthor_centos6.eclserver,thor400_30.eclserver,thor400_60.eclserver','ECLserver','10.241.60.202','7149',
                            false,false, 'mn_6_9');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.241.60.202:7149</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_10" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.241.30.202:7443','ECLserver',
                            'hthor_centos6.eclserver,thor400_30.eclserver,thor400_60.eclserver','ECLserver','10.241.30.202','7443',
                            false,false, 'mn_6_10');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.241.30.202:7443</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_6_11" class="configurecontextmenu" title="Option" onclick="return queuePopup('ECLserver_on_10.173.85.210:7446','ECLserver',
                            'thor400_20.eclserver','ECLserver','10.173.85.210','7446',
                            false,false, 'mn_6_11');
                        "> </a><a class="thorrunning" title="queue running;">ECLserver - ECLserver_on_10.173.85.210:7446</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody><td width="1100" colspan="4">No active workunit</td></tbody>
</table></td></tr>
</table>
<table xmlns="" class="clusters" border="2" frame="box" rules="groups" style="margin-bottom:5px">
<tr><td valign="top">
<a id="mn_5_1" class="configurecontextmenu" title="Option" onclick="return queuePopup('dfuserver','DFUserver',
                            'dfuserver_queue','DFUserver','','0',
                            false,false, 'mn_5_1');
                        "> </a><a class="thorrunning" title="queue running;">DFUserver - dfuserver_queue</a>
</td></tr>
<tr><td><table class="clusters" border="1" frame="box" rules="all">
<colgroup><col width="250" class="cluster"></colgroup>
<colgroup><col width="300" class="cluster"></colgroup>
<colgroup><col width="150" class="cluster"></colgroup>
<colgroup><col width="400" class="cluster"></colgroup>
<tbody>
<tr style="border:solid 2 black">
<td class="active">
<a id="dfuserver_D20150722-002525" class="configurecontextmenu" onclick="
                            return activeWUPopup('noLCR', 'dfuserver','DFUserver',
                                'dfuserver_queue','D20150722-002525',false);
                        ">
                     
                </a><a href="javascript:go('/FileSpray/GetDFUWorkunit?wuid=D20150722-002525')"><b>D20150722-002525</b></a>
</td>
<td class="active">running</td>
<td class="active">tkirk_prod 
        </td>
<td class="active">XX_J1B_20150721_235959.dat</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="dfuserver_D20150723-002506" class="configurecontextmenu" onclick="
                            return activeWUPopup('noLCR', 'dfuserver','DFUserver',
                                'dfuserver_queue','D20150723-002506',false);
                        ">
                     
                </a><a href="javascript:go('/FileSpray/GetDFUWorkunit?wuid=D20150723-002506')"><b>D20150723-002506</b></a>
</td>
<td class="active">running</td>
<td class="active">tkirk_prod 
        </td>
<td class="active">XX_J1B_20150722_235959.dat</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="dfuserver_D20150723-160521-3" class="configurecontextmenu" onclick="
                            return activeWUPopup('noLCR', 'dfuserver','DFUserver',
                                'dfuserver_queue','D20150723-160521-3',false);
                        ">
                     
                </a><a href="javascript:go('/FileSpray/GetDFUWorkunit?wuid=D20150723-160521-3')"><b>D20150723-160521-3</b></a>
</td>
<td class="active">running</td>
<td class="active">vikaspareddy 
        </td>
<td class="active">insurview::ci::aim::rating::auto::quotes...</td>
                                            
                                                </tr>
                                                <tr>
                                            
                                        <td class="active">
<a id="dfuserver_D20150723-193850" class="configurecontextmenu" onclick="
                            return activeWUPopup('noLCR', 'dfuserver','DFUserver',
                                'dfuserver_queue','D20150723-193850',false);
                        ">
                     
                </a><a href="javascript:go('/FileSpray/GetDFUWorkunit?wuid=D20150723-193850')"><b>D20150723-193850</b></a>
</td>
<td class="active">running</td>
<td class="active">ananth_prod 
        </td>
<td class="active">thor::base::mylife::main_w20150220-05064...</td>
</tr>
<tr style="border:solid 2 black"></tr>
</tbody>
</table></td></tr>
</table></form><div id="rendertarget"></div></body></html>