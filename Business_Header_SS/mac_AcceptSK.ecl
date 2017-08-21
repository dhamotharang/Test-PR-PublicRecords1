export mac_AcceptSK(movetype, movename, movekeys = 'true', movefiles = 'true') := macro

workingforseisint := 'cool';
ut.MAC_SK_Move('~thor_data400::key::business_header.Business_Relatives_Group',	movetype,a)
ut.MAC_SK_Move('~thor_data400::key::business_header.BusinessRelatives',			movetype,b)
ut.MAC_SK_Move('~thor_data400::key::business_header.Best',						movetype,c)
ut.MAC_SK_Move_v2('~thor_data400::key::business_contacts.fp',					movetype,cc)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.bdid',					movetype,d)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.did',						movetype,e)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.ssn',						movetype,f)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.state.city.name',			movetype,g)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.state.lfname',			movetype,h)
ut.MAC_SK_Move('~thor_data400::key::business_contacts_stat',					movetype,i)
ut.MAC_SK_Move('~thor_data400::key::company_title',								movetype,i2)
ut.MAC_SK_Move('~thor_data400::key::business_header.src',						movetype,j)
ut.MAC_SK_Move('~thor_data400::key::business_header.Phone_2',					movetype,k)
ut.MAC_SK_Move('~thor_data400::key::business_header.CoNameWords',				movetype,l)
ut.MAC_SK_Move('~thor_data400::key::business_header.FEIN_2',					movetype,m)
ut.MAC_SK_Move('~thor_data400::key::business_header.CompanyName_3',				movetype,n)
ut.MAC_SK_Move('~thor_data400::key::business_header.CompanyName_Unlimited',		movetype,nu)
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.bdid_NameVariations',				movetype,nv)
ut.MAC_SK_Move('~thor_data400::key::business_header_bdid.city.zip.fein.phone',	movetype,o)
ut.MAC_SK_Move('~thor_data400::key::business_header.BDID',						movetype,p)
ut.MAC_SK_Move('~thor_data400::key::business_header.BDID_pl',					movetype,p2)
ut.MAC_SK_Move('~thor_data400::key::business_header.Addr_pr_pn_zip',			movetype,q)
ut.MAC_SK_Move('~thor_data400::key::business_header.Addr_pr_pn_sr_st',			movetype,r)
ut.MAC_SK_Move('~thor_Data400::key::bh_supergroup_bdid',						movetype,aa);
ut.mac_sk_move('~thor_Data400::key::bh_supergroup_groupid',						movetype,bb);
ut.mac_sk_move('~thor_Data400::key::business_header.SIC_Code',					movetype,ff);
//ut.MAC_SK_Move_v2('~thor_data400::key::groupid_cnt',							movetype,dd);  // already done in business_risk.proc_accept_brisk_keys_to_QA
ut.MAC_SK_Move_v2('~thor_data400::key::business_header.BDID_pl',				movetype,ee);
ut.MAC_SK_Move('~thor_data400::key::cbrs.bdid_relsByContact',					movetype,x)
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.addr_proflic',						movetype,kap2);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.phone10_gong',						movetype,kpg2);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.addr.bdid',							movetype,kab2);


ut.MAC_SK_Move('~thor_data400::BASE::business_header.Best',						movetype,s)
ut.MAC_SK_Move('~thor_data400::base::business_header',							movetype,t)
//ut.MAC_SK_Move('~thor_data400::base::business_contacts',						movetype,u)
ut.MAC_SK_Move('~thor_data400::base::business_relatives',						movetype,v)
ut.MAC_SK_Move('~thor_data400::base::business_relatives_group',					movetype,w)

//contacts needs to go from building to qa to delete
u := 
	sequential(
			FileServices.StartSuperFileTransaction(),
				FileServices.AddSuperFile('~thor_data400::base::business_contacts_Delete', '~thor_data400::base::business_contacts_qa',, true),
				FileServices.ClearSuperFile('~thor_data400::base::business_contacts_qa'),
				FileServices.AddSuperFile('~thor_data400::base::business_contacts_qa', '~thor_data400::base::business_contacts_building',,true),
			FileServices.FinishSuperFileTransaction(),
			FileServices.ClearSuperFile('~thor_data400::base::business_contacts_Delete',true));

keys := sequential(
a,
b,
c,
cc,
d,
e,
f,
g,
h,
i,
i2,
j,
k,
l,
m,
n,
nu,
nv,
o,
p,
p2,
q,
r,
aa,
bb,
//dd,
ee,
ff,
x,
kap2,
kpg2,
kab2
);

bases := sequential(
s,
t,
u,
v,
w
);

movename := sequential(
#if(movekeys)
	keys,
#end
#if(movefiles)
	bases,
#end
output('done')
);

/*  this does just the contacts stuff
movename := sequential(
d,e,f,g,h,i,
u);*/

endmacro;