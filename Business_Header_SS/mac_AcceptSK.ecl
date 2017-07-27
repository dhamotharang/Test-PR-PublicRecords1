export mac_AcceptSK(movetype, movename) := macro

workingforseisint := 'cool';
ut.MAC_SK_Move('~thor_data400::key::business_header.Business_Relatives_Group',movetype,a)
ut.MAC_SK_Move('~thor_data400::key::business_header.BusinessRelatives',movetype,b)
ut.MAC_SK_Move('~thor_data400::key::business_header.Best',movetype,c)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.bdid',movetype,d)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.did',movetype,e)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.ssn',movetype,f)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.state.city.name',movetype,g)
ut.MAC_SK_Move('~thor_data400::key::business_contacts.state.lfname',movetype,h)
ut.MAC_SK_Move('~thor_data400::key::business_contacts_stat',movetype,i)
ut.MAC_SK_Move('~thor_data400::key::business_header.src',movetype,j)
ut.MAC_SK_Move('~thor_data400::key::business_header.Phone_2',movetype,k)
ut.MAC_SK_Move('~thor_data400::key::business_header.CoNameWords',movetype,l)
ut.MAC_SK_Move('~thor_data400::key::business_header.FEIN_2',movetype,m)
ut.MAC_SK_Move('~thor_data400::key::business_header.CompanyName_3',movetype,n)
ut.MAC_SK_Move('~thor_data400::key::business_header.CompanyName_Unlimited',movetype,nu)
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.bdid_NameVariations',movetype,nv)
ut.MAC_SK_Move('~thor_data400::key::business_header_bdid.city.zip.fein.phone',movetype,o)
ut.MAC_SK_Move('~thor_data400::key::business_header.BDID',movetype,p)
ut.MAC_SK_Move('~thor_data400::key::business_header.Addr_pr_pn_zip',movetype,q)
ut.MAC_SK_Move('~thor_data400::key::business_header.Addr_pr_pn_sr_st',movetype,r)
ut.MAC_SK_Move('~thor_Data400::key::bh_supergroup_bdid',movetype,aa);
ut.mac_sk_move('~thor_Data400::key::bh_supergroup_groupid',movetype,bb);
ut.mac_sk_move('~thor_Data400::key::business_header.SIC_Code',movetype,cc);
ut.MAC_SK_Move_v2('~thor_data400::key::groupid_cnt',movetype,dd);
ut.MAC_SK_Move('~thor_data400::key::cbrs.bdid_relsByContact',movetype,x)
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.addr_proflic',movetype, kap2);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.phone10_gong',movetype, kpg2);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.addr.bdid',movetype,kab2);


ut.MAC_SK_Move('~thor_data400::BASE::business_header.Best',movetype,s)
ut.MAC_SK_Move('~thor_data400::base::business_header',movetype,t)
ut.MAC_SK_Move('~thor_data400::base::business_contacts',movetype,u)
ut.MAC_SK_Move('~thor_data400::base::business_relatives',movetype,v)
ut.MAC_SK_Move('~thor_data400::base::business_relatives_group',movetype,w)




keys := sequential(
a,
b,
c,
d,
e,
f,
g,
h,
i,
j,
k,
l,
m,
n,
nu,
nv,
o,
p,
q,
r,
aa,
bb,
dd,
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
keys,
bases
);

/*  this does just the contacts stuff
movename := sequential(
d,e,f,g,h,i,
u);*/

endmacro;