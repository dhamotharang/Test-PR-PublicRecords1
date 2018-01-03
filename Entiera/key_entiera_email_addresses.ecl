import doxie, data_services;

temp_ds := project(File_Entiera_Base_for_Keys(did>0),Layouts.Base_For_Indexes);

payload := project(Key_Payload,Layouts.Base_For_Indexes);


All_Entiera_Layouts.Entiera_email_address_fixed tFix_EmailAddr(temp_ds l) := transform
self.email_addr1 := l.orig_email[1..(stringlib.stringfind(l.orig_email,'@',1))-1];
self.email_addr2 := l.orig_email[(stringlib.stringfind(l.orig_email,'@',1))+1..];
self:=l;
end;

entiera_emailAddr_append := project(temp_ds + payload, tFix_EmailAddr(left));
		
//want to keep valid emails. Below is a very superficial check 
//1. keep email address where both the first part and the second part(domain name) are present
//2. keep email address where the first part is populated and the domain name (second part) without the @ sign

entiera_ValidemailAddr := distribute(entiera_emailAddr_append((email_addr1!='' and email_addr2!='') or
													 email_addr1!='' and stringlib.stringfind(email_addr2,'@',1)!=0),hash(email_addr1,
													 email_addr2,did));

dup_entiera_ValidemailAddr := dedup(sort(entiera_ValidemailAddr,email_addr1,email_addr2,did,local),email_addr1,
														email_addr2,did,local);



//enter the first part of emailaddr or enter the full email addr get the rest of the record back				   
export key_entiera_email_addresses := 
index(dup_entiera_ValidemailAddr
      ,{email_addr1,email_addr2}
			,{dup_entiera_ValidemailAddr}
			,data_services.data_location.prefix() + 'thor_200::key::entiera::'+doxie.Version_SuperKey+'::email_addresses');