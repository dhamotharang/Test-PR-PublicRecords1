//this program is to build the lssi_update file
import ut; 

prt_title := output('200 new lssi sample records ...');
prt_recs := output(choosen(enth(lssi.file_lssi_in(xcode = 'I', (unsigned)TELNO<>0),200),200));

prt_sample := sequential(prt_title, prt_recs,
                         FileServices.sendemail('qualityassurance@seisint.com;camaral@seisint.com','LSSI DAILY SAMPLE READY','at ' + thorlib.WUID()));

lssi_add := distribute(lssi.file_hhid_did_add, hash(recid));
lssi_remove := distribute(lssi.file_hhid_did_remove, hash(recid));

//the folling persists must be there, use as flow control
update_add := distribute(lssi.bwr_lssi_build_file, hash(recid)) : persist('per_update_add'); //don't remove
in_add := dedup(update_add, local);

update_remove := distribute(lssi.file_lssi_in(xcode = 'O'), hash(recid));			    
in_remove := dedup(update_remove, local) : persist('per_in_remove');

lssi.layout_hhid_did_lssi get_refined_add(lssi_add l) := transform
	self := l;
end;

lssi_add_ref := join(lssi_add, in_remove,
                     left.recid = right.recid, 
			      get_refined_add(left), left only, local) : persist('per_add_ref');
					
lssi.layout_in get_refined_remove(in_remove r) := transform
	self := r;
end;			

in_remove_ref := join(lssi_add, in_remove,  
                      left.recid = right.recid, 
			       get_refined_remove(right), right only, local) : persist('per_remove_ref');
				  
out_add := if(fileservices.getsuperfilesubcount('~thor_data400::base::lssi_add') = 0, 
              in_add, lssi_add_ref + in_add);

out_remove := if(fileservices.getsuperfilesubcount('~thor_data400::base::lssi_remove') = 0, 
                 in_remove, lssi_remove + in_remove_ref);
            
ut.MAC_SF_BuildProcess(out_add,'~thor_data400::base::lssi_add',build_add) 
ut.MAC_SF_BuildProcess(out_remove,'~thor_data400::base::lssi_remove',build_remove)

export proc_build_lssi_update_file := sequential(prt_sample, build_add, build_remove);