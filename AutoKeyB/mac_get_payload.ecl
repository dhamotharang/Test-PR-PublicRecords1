export mac_get_payload(ids,t,datasetPL,outPL,did ='did',bdid ='bdid',typeStr='BC',FakeIDField = 'unsigned6 FakeID') := macro

#uniquename(b)
#uniquename(plk)
#uniquename(fids)


%b% := ids;//AutoKeyB.get_ids(t);

%fids% := %b%(autokeyb.isFakeID(id,typeStr)); //changed it from 'BC' to typestr

autokeyb.MAC_FID_Payload(datasetPL,'','','','','','','','','',did,bdid,t+'Payload',%plk%,'',,FakeIDField)



outPL := join(%fids% ,%plk%,keyed(left.id = right.FakeID), limit(ut.limits.default, skip));

endmacro;