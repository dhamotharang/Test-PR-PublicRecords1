 #workunit('name','GSA Samples')

export Sample_GSA := function

ds := dataset('~thor_data400::base::gsa',  GSA.Layouts_GSA.layout_Base, thor);
ds_father := dataset('~thor_data400::base::gsa_father',  GSA.Layouts_GSA.layout_Base, thor);

ds_dist := distribute(ds(bdid != 0),hash(bdid));
ds_father_dist := distribute(ds_father(bdid != 0),hash(bdid));

j_new_recs := join(ds_dist,ds_father_dist, left.name = right.name and left.street1=right.street1 and left.street2 = right.street2 and left.city=right.city, 
transform(recordof(ds_dist), self := left), left only, local);

return output(j_new_recs);
end;