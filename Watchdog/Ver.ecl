import ut,header,aid;
export ver(string preffix, string sup, dataset(header.Layout_Header) inFile)
	:=
		module
					shared bname:='~thor_data400::VER::'+preffix+'_AID_reclean';
					shared vname:=nothor(FileServices.GetSuperFileSubName(sup,1));
					dsVer:=dataset(bname,{string200 text},flat,OPT);
					export Same := dsVer[1].text=vname;
					
					ds:=dataset([{vname}],{string200 text});
					ut.MAC_SF_BuildProcess(ds,bname,bing,2,,true);
					export update := bing;

					Header.macGetCleanAddr(inFile , RawAID, true, oFile);
					ut.MAC_SF_BuildProcess(oFile,'~thor_data400::BASE::'+preffix+'_AID_reclean',bing,2,,true);
					export reclean := bing;
		end
		;
