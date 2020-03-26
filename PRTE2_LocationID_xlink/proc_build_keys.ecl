Import STD,PRTE2, _control, PRTE, Data_Services;  

EXPORT proc_build_keys(string filedate, boolean skipDOPS = FALSE, string emailTO = '' ) := function

dops_name := 'LocationIDKeys ';

// Build Keys
Key_refs       			:= index({files.refs},{},prte2.constants.prefix+'key::locationid_xlink::'+ filedate +'::locid::refs');
Key_meow  					:= index(files.meow,{LocId},{files.meow},prte2.constants.prefix+'key::locationid_xlink::'+ filedate+  '::locid::meow');
key_refs_statecity	:= index({files.refs_statecity},{},prte2.constants.prefix+'key::locationid_xlink::'+ filedate +'::locid::refs::statecity');
key_refs_zip				:= index({files.refs_zip}, {}, prte2.constants.prefix+'key::locationid_xlink::'+ filedate +'::locid::refs::zip');
key_words						:= index(files.words,{word},{files.words},prte2.constants.prefix+'key::locationid_xlink::'+ filedate +'::locid::words');
key_sup_rid					:= index(files.sup_rid,{rid},{files.sup_rid},prte2.constants.prefix+'key::locationid_xlink::'+ filedate +'::locid::sup::rid');

//---------- making DOPS optional -------------------------------
notifyEmail					:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it'); 
updatedops					:= PRTE.UpdateVersion(dops_name, filedate, notifyEmail,'B','N','N');


PerformUpdateOrNot	:= IF(not skipDops,updatedops,NoUpdate);

build_keys := sequential(parallel(build(Key_refs, update), 
                                  build(Key_meow, update), 
																	build(Key_refs_statecity, update), 
																	build(Key_refs_zip, update), 
																	build(Key_words, update), 
																	build(Key_sup_rid, update)), 
																	PerformUpdateOrNot
												);

return build_keys;                       
end;