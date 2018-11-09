import PromoteSupers,ut,mdr,Data_Services,std,InsuranceHeader;
pairs:=distribute(dataset(Filename_iHeader_did_rid,header.Layout_LAB_Pairs,flat),hash(rid));
PromoteSupers.MAC_SF_BuildProcess(pairs,Data_Services.Data_Location.Prefix('Header')+'thor_data400::base::iheader_did_rid',copy_pairs,3,,true,pVersion:=Header.version_build);

hr:=distribute(file_header_raw(header.Blocked_data()),hash(rid));
droppedRids:=join(hr,File_LAB_Pairs
											,left.rid=right.rid
											,left only
											,local):persist('~thor_data400::persist::missing_header_rid');

maxAllowed:=200000;
droppedRidsNonBlankCnt:=count(droppedRids(lname<>'' OR fname<>''));
droppedRidsBlankCnt:=   count(droppedRids(lname ='' ,  fname =''));
duplicateRidsCount :=   count(table(Header.File_LAB_Pairs,{rid, rid_cnt := count(group)},rid,few,merge)(rid_cnt>1));

//post Alpharetta DID to Boca DID if LAB build
header_raw_syncd:=InsuranceHeader.File_InsuranceHeader_Payload;

r:={string17 eventstamp:='',string800 eventdesc:=''};

dt:=Std.Date.SecondsToString(Std.Date.CurrentSeconds(TRUE), '%F%H%M%S%u');

eventdesc:= nothor(fileservices.getsuperfilesubname(Header.Filename_iHeader_did_rid,1) + ' was applied to ' +
					fileservices.getsuperfilesubname('~thor_data400::base::header_raw',1) + ' to produce ' +
					fileservices.getsuperfilesubname('~thor_data400::base::header_raw_syncd',1));

d:=sort(
					 dataset([{dt,eventdesc}],r)
				 + dataset('~thor_data400::log::header_raw::lab_update',r,flat,opt)
			 ,-eventstamp);

pre := if(fileservices.getsuperfilesubcount('~thor_data400::base::header_raw_syncd_BUILDING')>0
    ,output('Nothing added to Base::header_raw_syncd_BUILDING')
    ,fileservices.addsuperfile('~thor_data400::base::header_raw_syncd_BUILDING','~thor_data400::base::header_raw',,true));

PromoteSupers.MAC_SF_BuildProcess(distribute(header_raw_syncd,hash(did)),'~thor_data400::base::header_raw_syncd',build_raw_syncd,3,,true,pVersion:=Header.version_build);
PromoteSupers.MAC_SF_BuildProcess(d,'~thor_data400::log::header_raw::lab_update',update_log,3,,true);

post := sequential(
		fileservices.clearsuperfile('~thor_data400::base::header_raw_syncd_BUILT')
		,fileservices.addsuperfile('~thor_data400::base::header_raw_syncd_BUILT','~thor_data400::base::header_raw_syncd_BUILDING',0,true)
		,fileservices.clearsuperfile('~thor_data400::base::header_raw_syncd_BUILDING'));

full_ := if ( fileservices.getsuperfilesubname('~thor_data400::base::header_raw_syncd_BUILT',1) = fileservices.getsuperfilesubname('~thor_data400::base::header_raw',1)
					 ,output('Both header_raw = header_syncd_BUILT. Nothing Done.')
					 ,sequential(
							copy_pairs
              ,if(duplicateRidsCount >  0,  fail('Error - '  +duplicateRidsCount+' Duplicate RIDs found in LAB pairs'))
							,if(droppedRidsNonBlankCnt >  maxAllowed,  fail('Error - '  +droppedRidsNonBlankCnt+' Non-Balnk RIDs missing in LAB pairs'))
							,if(droppedRidsNonBlankCnt <= maxAllowed,output('Warning - '+droppedRidsNonBlankCnt+' Non-Balnk RIDs missing in LAB pairs'))
							,if(droppedRidsBlankCnt >  0         ,output('Warning - '+droppedRidsBlankCnt+ ' Blank names RIDs missing in LAB pairs'))
							,pre
							,build_raw_syncd
							,update_log
							,post
							,header.build_LAB_keys(Header.version_build).buildk
							,header.build_LAB_keys(Header.version_build).mv2blt
							));

export build_header_raw_syncd := full_;