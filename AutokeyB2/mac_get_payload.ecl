export mac_get_payload(ids,t,datasetPL,outPL,did ='did',bdid ='bdid',typeStr='\'AK\'',FakeIDField = 'unsigned6 FakeID') := macro

#uniquename(b)
#uniquename(plk)
#uniquename(fids)


%b% := ids;//AutokeyB2.get_ids(t);

%fids% := %b%(AutokeyB2.isFakeID(id,typeStr)); //changed it from 'BC' to typestr

AutokeyB2.MAC_FID_Payload(datasetPL,'','','','','','','','','',did,bdid,t+'Payload',%plk%,'',,FakeIDField)



outPL := join(%fids% ,%plk%,keyed(left.id = right.FakeID), limit(ut.limits.default, skip));

endmacro;