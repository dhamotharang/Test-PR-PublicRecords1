import sam, ut, address, NID;

EXPORT Fn_map_BIP(dataset(SAM.Layout_SAM) pInFile):=  function 

temp_clean_rec := record
SAM.Layout_SAM - Cage;
string name_clean;
string address1_clean;
string address2_clean;
string address_line1;
string address_line2;

end;

need_clean := pInFile(name <> '' and (country = 'USA' or country = ''));
no_need_clean := pInFile(~(name <> '' and (country = 'USA' or country = '')));

// clean name and address
temp_clean_rec preclean_addr(need_clean le) := transform

self.activedate := sam.fncleanfunction.clean_date(le.activedate);
self.TerminationDate := sam.fncleanfunction.clean_date(le.TerminationDate);
self.address1_clean := sam.fncleanfunction.clean_address(le.address_1);
self.address2_clean := sam.fncleanfunction.clean_address(le.address_2);

self.name_clean := stringlib.stringcleanspaces(trim(le.firstname,left,right) + ' ' + trim(le.middlename,left,right) +' ' + trim(le.lastname,left,right) + 
                                     ' ' + trim(le.Suffix,left,right));
self := le;
self := [];

end;		

preclean_name := project(need_clean, preclean_addr(left));

// clean and split multiple addresses

searchpattern := '(.*),(.*)';

infile_has_multi_addr := preclean_name((regexfind('P O BOX|P.O. BOX|PO BOX', address1_clean) and regexfind(searchpattern, address1_clean))

or (regexfind('P O BOX|P.O. BOX|PO BOX', address2_clean) and regexfind(searchpattern, address2_clean)));

infile_has_no_multi_addr := preclean_name(~((regexfind('P O BOX|P.O. BOX|PO BOX', address1_clean) and regexfind(searchpattern, address1_clean))

or (regexfind('P O BOX|P.O. BOX|PO BOX', address2_clean) and regexfind(searchpattern, address2_clean))));

temp_clean_rec clean_multi_addr(infile_has_multi_addr le) := transform

self.address1_clean := stringlib.stringcleanspaces(if(regexfind(searchpattern, le.address1_clean),
regexfind(searchpattern, le.address1_clean, 1), regexfind(searchpattern, le.address2_clean, 1)));
self.address2_clean := stringlib.stringcleanspaces(if(regexfind(searchpattern, le.address1_clean),
regexfind(searchpattern, le.address1_clean, 2),regexfind(searchpattern, le.address2_clean, 2)));
self := le;

end;

infile_multi_addr_clean := project(infile_has_multi_addr, clean_multi_addr(left));
		
//Normalize multiple addresses

infile_need_norm := infile_multi_addr_clean((regexfind('P O BOX|P.O. BOX|PO BOX', address1_clean) and regexfind('^[0-9]+', address2_clean) and regexfind('[A-Z]+', address2_clean))
or (regexfind('P O BOX|P.O. BOX|PO BOX', address2_clean) and regexfind('^[0-9]+', address1_clean) and regexfind('[A-Z]+', address1_clean)));

infile_no_norm := infile_multi_addr_clean(~((regexfind('P O BOX|P.O. BOX|PO BOX', address1_clean) and regexfind('^[0-9]+', address2_clean) and regexfind('[A-Z]+', address2_clean))
or (regexfind('P O BOX|P.O. BOX|PO BOX', address2_clean) and regexfind('^[0-9]+', address1_clean) and regexfind('[A-Z]+', address1_clean))));

temp_clean_rec norm_addr(infile_need_norm le, integer Cnt) := transform
		
			self.address1_clean := choose(Cnt, le.address1_clean, le.address2_clean);
			self.address2_clean := '';
		  self := le;
		END;		
		
		norm_multi_addr := dedup(normalize(infile_need_norm,2, norm_addr(left,counter)),all);

//combine all clean data

preclean_all := project(infile_has_no_multi_addr + infile_no_norm + norm_multi_addr, transform(temp_clean_rec,
self.address_line1 := if(left.address2_clean = '',trim(left.address1_clean, left, right), trim(left.address1_clean, left, right) + ' ' + trim(left.address2_clean, left,right)),
self.address_line2 :=  left.city +  if(left.City <> '',', ',' ') + left.state+ ' '+ left.ZipCode,
self := left));

NID.Mac_CleanFullNames(preclean_all, name_out, name_clean, includeInRepository:=true,normalizeDualNames:=true);

NID_sam := name_out;

SAM.layout_bip_linkid tcleanaddr(NID_sam le) := transform

clean_addr := Address.cleanaddress182(le.address_line1, le.address_line2);
self.title 			:= le.cln_title;
self.fname 			:= le.cln_fname;
self.mname 			:= le.cln_mname;
self.lname 			:= le.cln_lname;
self.name_suffix 	:= le.cln_suffix;
//self.name_flag :=  le.nametype;
	 self.prim_range  	:= clean_addr[1..10];
	 self.predir	 			:= clean_addr[11..12];
	 self.prim_name		:= clean_addr[13..40];
	 self.addr_suffix 	:= clean_addr[41..44];
	 self.postdir 			:= clean_addr[45..46];
	 self.unit_desig		:= clean_addr[47..56];
	 self.sec_range		:= clean_addr[57..64];
	 self.p_city_name	:= clean_addr[65..89];
	 self.v_city_name 	:= clean_addr[90..114];
	 self.st						:= clean_addr[115..116];
	 self.zip						:= clean_addr[117..121];
	 self.zip4					:= clean_addr[122..125];
	 self.cname := le.name;
	 self := le;
	 self := [];
	 
	 end;

clean_address := project(NID_sam, tcleanaddr(left));

outfile:= clean_address + project(no_need_clean, transform(SAM.layout_bip_linkid, self := left, self := []));

return outfile;

end;