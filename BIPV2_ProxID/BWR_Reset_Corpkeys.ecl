#workunit('name','BIPV2 corpkey/duns/entnum overlinking research');
/*
foreign corp key fix -- measure problem
investigate the 1 domestic corpkey theory to see how many proxids this would affect, etc.
*/
//use alpha
pDataset := BIPV2_ProxID.files('20130330_29').base.logical;

	dslim := project(pDataset, transform(
	{pDataset.proxid,pDataset.company_name,pDataset.cnp_name
  ,pDataset.cnp_number
	,string address,pDataset.source,string duns_number,string enterprise_number
  ,string1 company_foreign_domestic,string domestic_corp_key,string foreign_corp_key

},
org_struct := left.company_org_structure_raw + left.company_org_structure_derived;

self.duns_number        := if(left.active_duns_number       != '',left.active_duns_number       ,left.hist_duns_number);
self.enterprise_number  := if(left.active_enterprise_number != '',left.active_enterprise_number ,left.hist_enterprise_number);
self.domestic_corp_key  := if(left.company_inc_state != '' and left.company_charter_number != '' and ~(left.company_foreign_domestic = 'F' or regexfind('foreign',org_struct,nocase)	),trim(left.company_inc_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');
self.foreign_corp_key   := if(left.company_inc_state != '' and left.company_charter_number != '' and  (left.company_foreign_domestic = 'F' or regexfind('foreign',org_struct,nocase)	),trim(left.company_inc_state,left,right) + '-' + trim(left.company_charter_number,left,right)	,'');

self.address	:= stringlib.stringcleanspaces(trim(left.prim_range,left,right) + ' ' + trim(left.prim_name,left,right) + ' ' + trim(left.sec_range,left,right) + ' ' + trim(left.v_city_name,left,right) + ' ' + trim(left.st,left,right) + ' ' + trim(left.zip));
self					:= left;	
));

dpost := tools.mac_AggregateFieldsPerID(dslim,proxid,,false);

dGT1domesticcorpkey       := dpost(count(domestic_corp_keys) > 1);
dGT1domesticcorpkeyWorst  := topn(dGT1domesticcorpkey,100,-count(domestic_corp_keys));

dGT1duns       := dpost(count(duns_numbers) > 1);
dGT1dunsWorst  := topn(dGT1duns,100,-count(duns_numbers));

dGT1entnum       := dpost(count(enterprise_numbers) > 1);
dGT1entnumWorst  := topn(dGT1entnum,100,-count(enterprise_numbers));

dGT1foreignCK       := dpost(count(foreign_corp_keys) > count(dedup(project(foreign_corp_keys,transform({string state},self.state := left.foreign_corp_key[1..2])),state,all)));
dGT1foreignCKWorst  := topn(dGT1foreignCK,100,-(count(foreign_corp_keys) - count(dedup(project(foreign_corp_keys,transform({string state},self.state := left.foreign_corp_key[1..2])),state,all))));

proxids2expode := table(dGT1foreignCK + dGT1domesticcorpkey,{proxid},proxid);

dexplode := join(
   pDataset
  ,proxids2expode
  ,left.proxid = right.proxid
  ,transform(
     {recordof(left),boolean changed}
    ,self.proxid := if(right.proxid != 0,left.dotid,left.proxid)
    ,self.changed := if(right.proxid != 0,true,false)
    ,self        := left
  )
  ,left outer
);

countchanged := dexplode(changed = true);

dproj := project(dexplode,recordof(pDataset));
output(dproj,,BIPV2_ProxID.filenames('20130330a_29').base.logical,__COMPRESSED__,OVERWRITE);

output(countchanged ,named('countchanged'));
output(dexplode(changed = true) ,named('changed'));
countdGT1domesticcorpkey  := count(dGT1domesticcorpkey);
countdGT1duns             := count(dGT1duns           );
countdGT1entnum           := count(dGT1entnum         );
countdGT1foreignCK        := count(dGT1foreignCK      );

output(countdGT1domesticcorpkey ,named('countdGT1domesticcorpkey'),all);
output(countdGT1duns            ,named('countdGT1duns'           ),all);
output(countdGT1entnum          ,named('countdGT1entnum'         ),all);
output(countdGT1foreignCK       ,named('countdGT1foreignCK'      ),all);

output(choosen(dGT1domesticcorpkey      ,300) ,named('dGT1domesticcorpkey'      ),all);
output(choosen(dGT1domesticcorpkeyWorst ,300) ,named('dGT1domesticcorpkeyWorst' ),all);
output(choosen(dGT1duns                 ,300) ,named('dGT1duns'                 ),all);
output(choosen(dGT1dunsWorst            ,300) ,named('dGT1dunsWorst'            ),all);
output(choosen(dGT1entnum               ,300) ,named('dGT1entnum'               ),all);
output(choosen(dGT1entnumWorst          ,300) ,named('dGT1entnumWorst'          ),all);
output(choosen(dGT1foreignCK            ,300) ,named('dGT1foreignCK'            ),all);
output(choosen(dGT1foreignCKWorst       ,300) ,named('dGT1foreignCKWorst'       ),all);