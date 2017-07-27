import org_mast;
mydata := dataset('~thor400_data::base::org_master::org_master_Organization::20151109',org_mast.layouts.organization_base,thor);
count(mydata);		// 1561834
with_lnpid := mydata(lnpid > 0);
count(with_lnpid);	//1538418
// 1538418/1561834 = .985 i.e 98.5%