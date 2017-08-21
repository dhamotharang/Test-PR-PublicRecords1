/*
// in to base
layout_in := record
string32 hval_s;
string2	nl;
end;
in_ds := dataset('~thor_data400::in::md5::relative::supp_20071114',layout_in,flat);
output(in_ds);

layout_out := record
data16 	hval;
end;
layout_out in_to_out(layout_in l) := transform
self.hval := stringlib.string2data(l.hval_s);
end;


out_ds := project(in_ds, in_to_out(left));
output(out_ds,,'~thor_data400::base::md5::relative::20071114',overwrite);
*/

// key build

//fileservices.addsuperfile('~thor_data400::base::md5::qa::ssn','~thor_200::base::md5::ssn_unsigned::20071114');
//

#option('skipFileFormatCrcCheck', 1);

import doxie_files;

layout_md5_base := record 
	data16 hval; 
end; 

kf := dataset('~thor_data400::base::md5::qa::ssn',layout_md5_base,flat); 


Key_md5_val := index(kf,
			{hval}, {kf}, '~thor_data400::key::md5::20071114::ssn');

buildindex(key_md5_val,few);



