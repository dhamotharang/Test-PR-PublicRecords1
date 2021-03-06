import ut,lssi;
//Merge the lssi update file to the base file, clean the update files, keys
//and build the new lssi keys. 

export Mac_Lssi_Weekly_Merge(email_target='\' \'') := macro

#workunit('name','lssi weekly merge')

#uniquename(base_in)
#uniquename(append_in)
#uniquename(remove_in)
%base_in% := distribute(lssi.file_hhid_did_lssi,hash(recid));
%append_in% := distribute(lssi.file_hhid_did_add,hash(recid));
%remove_in% := distribute(lssi.file_hhid_did_remove,hash(recid));

#uniquename(remove_from_base)
lssi.layout_hhid_did_lssi %remove_from_base%(%base_in% l) := transform
	self := l;
end;

#uniquename(refined_base)
%refined_base% := join(%base_in%, %remove_in%,
                       left.recid = right.recid,
	   		        %remove_from_base%(left), left only, local);
				 
#uniquename(base_new)
%base_new% := %refined_base% + %append_in%;

#uniquename(dist_new)
#uniquename(srt_base)
#uniquename(dep_base)
%dist_new% := distribute(%base_new%, hash(recid));
%srt_base% := sort(%dist_new%, recid, local);
%dep_base% := dedup(%srt_base%, local);

#uniquename(update_base)
ut.MAC_SF_BuildProcess(%dep_base%, '~thor_data400::base::lssi_main', %update_base%);

#uniquename(build_new_keys)
%build_new_keys% := lssi.proc_build_lssi_full_keys;

#uniquename(clear_add_base)
#uniquename(clear_remove_base)
ut.Mac_SF_Clear('~thor_data400::base::lssi_add', %clear_add_base%)
ut.Mac_SF_Clear('~thor_data400::base::lssi_remove', %clear_remove_base%)                         

#uniquename(clear_addr_add_key)
#uniquename(clear_did_add_key)
#uniquename(clear_hhid_add_key)
#uniquename(clear_remove_key)
ut.Mac_SK_Clear('~thor_data400::key::lssi_did_add',%clear_did_add_key%,4)
ut.Mac_SK_Clear('~thor_data400::key::lssi_hhid_add',%clear_hhid_add_key%,4)
ut.Mac_SK_Clear('~thor_data400::key::lssi_remove',%clear_remove_key%,4)

#if(ut.Weekday((unsigned) StringLib.GetDateYYYYMMDD())='SUNDAY')
   sequential(%update_base%,
              %build_new_keys%,
               parallel(%clear_add_base%,
                        %clear_remove_base%,
		              %clear_did_add_key%,
                        %clear_hhid_add_key%,
                        %clear_remove_key%)) : success(FileServices.sendemail(if(email_target<>' ',email_target,lssi.Notification_Email_Address),'LSSI Weekly Merge Succeeded',
                        'lssi base file has been updated, new keys have been built.')),
                        failure(FileServices.sendemail(if(email_target<>' ',email_target,lssi.Notification_Email_Address),'LSSI Weekly Merge Failure',
                        FAILMESSAGE));
#else
   output('This program runs on Sunday only');
#end				
endmacro;