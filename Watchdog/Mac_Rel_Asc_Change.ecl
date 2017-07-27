import watchdog;

export Mac_Rel_Asc_Change(file_cur, file_pre, new_rel, new_asc) := macro

#uniquename(norm_rec)
%norm_rec% := record
	unsigned6 did;
	unsigned6 sub_did;
end;				  
		
#uniquename(norm_rel)		
%norm_rec% %norm_rel%(file_cur l, unsigned1 cnt) := transform
	self.did := l.did;
     self.sub_did := l.relatives[cnt].ra_did;
end;	

#uniquename(cur_rel_norm)		
#uniquename(cur_rel_sort)
%cur_rel_norm% := normalize(file_cur, count(left.relatives), %norm_rel%(left,counter));		
%cur_rel_sort% := sort(%cur_rel_norm%, record, local);

#uniquename(pre_rel_norm)
#uniquename(pre_rel_sort)
%pre_rel_norm% := normalize(file_pre, count(left.relatives), %norm_rel%(left,counter));		
%pre_rel_sort% := sort(%pre_rel_norm%, record, local);

#uniquename(rel_joined)
%rel_joined% := join(%cur_rel_sort%, %pre_rel_sort%, 
		  	      left.did=right.did and left.sub_did = right.sub_did,
                     left only, local);

new_rel := sort(%rel_joined%,record,local); 

#uniquename(norm_asc)		
%norm_rec% %norm_asc%(file_cur l, unsigned1 cnt) := transform
	self.did := l.did;
     self.sub_did := l.associates[cnt].ra_did;
end;	

#uniquename(cur_asc_norm)		
#uniquename(cur_asc_sort)
%cur_asc_norm% := normalize(file_cur, count(left.associates), %norm_asc%(left,counter));		
%cur_asc_sort% := sort(%cur_asc_norm%, record, local);

#uniquename(pre_asc_norm)
#uniquename(pre_asc_sort)
%pre_asc_norm% := normalize(file_pre, count(left.associates), %norm_asc%(left,counter));		
%pre_asc_sort% := sort(%pre_asc_norm%, record, local);

#uniquename(asc_joined)
%asc_joined% := join(%cur_asc_sort%, %pre_asc_sort%, 
		           left.did=right.did and left.sub_did = right.sub_did,
                     left only, local);
			    
new_asc := sort(%asc_joined%,record,local);
	
endmacro;