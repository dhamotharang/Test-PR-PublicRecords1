import roxiekeybuild,seed_files;

export proc_build_seed_keys(string filedate) := 
function

#workunit('name','Seed Key Build' + filedate)

roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_cd1ocd2i,'abc','~thor_data400::key::seed::'+filedate+'::cd1ocd2i',a);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_ct1ophni,'abc','~thor_data400::key::seed::'+filedate+'::ct1ophni',b);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_ef1oef1i,'abc','~thor_data400::key::seed::'+filedate+'::ef1oef1i',c);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_idpoidpi,'abc','~thor_data400::key::seed::'+filedate+'::idpoidpi',d);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_np2opr2i,'abc','~thor_data400::key::seed::'+filedate+'::np2opr2i',p);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_np2oprii,'abc','~thor_data400::key::seed::'+filedate+'::np2oprii',e);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_nptoprii,'abc','~thor_data400::key::seed::'+filedate+'::nptoprii',f);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.key_pb1opb1i,'abc','~thor_data400::key::seed::'+filedate+'::pb1opb1i',g);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_prioprii,'abc','~thor_data400::key::seed::'+filedate+'::prioprii',h);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_prwoprwi,'abc','~thor_data400::key::seed::'+filedate+'::prwoprwi',i);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_sc1osd1i,'abc','~thor_data400::key::seed::'+filedate+'::sc1osd1i',j);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_sd1osd1i,'abc','~thor_data400::key::seed::'+filedate+'::sd1osd1i',k);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_sd5osd5i,'abc','~thor_data400::key::seed::'+filedate+'::sd5osd5i',l);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_sdbosd2i,'abc','~thor_data400::key::seed::'+filedate+'::sdbosd2i',m);
roxiekeybuild.mac_sk_buildprocess_v2_local(Seed_Files.Key_sdbosd4i,'abc','~thor_data400::key::seed::'+filedate+'::sdbosd4i',n);

roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::cd1ocd2i','~thor_data400::key::seed::'+filedate+'::cd1ocd2i',a1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::ct1ophni','~thor_data400::key::seed::'+filedate+'::ct1ophni',b1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::ef1oef1i','~thor_data400::key::seed::'+filedate+'::ef1oef1i',c1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::idpoidpi','~thor_data400::key::seed::'+filedate+'::idpoidpi',d1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::np2opr2i','~thor_data400::key::seed::'+filedate+'::np2opr2i',p1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::np2oprii','~thor_data400::key::seed::'+filedate+'::np2oprii',e1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::nptoprii','~thor_data400::key::seed::'+filedate+'::nptoprii',f1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::pb1opb1i','~thor_data400::key::seed::'+filedate+'::pb1opb1i',g1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::prioprii','~thor_data400::key::seed::'+filedate+'::prioprii',h1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::prwoprwi','~thor_data400::key::seed::'+filedate+'::prwoprwi',i1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::sc1osd1i','~thor_data400::key::seed::'+filedate+'::sc1osd1i',j1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::sd1osd1i','~thor_data400::key::seed::'+filedate+'::sd1osd1i',k1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::sd5osd5i','~thor_data400::key::seed::'+filedate+'::sd5osd5i',l1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::sdbosd2i','~thor_data400::key::seed::'+filedate+'::sdbosd2i',m1);
roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::seed::@version@::sdbosd4i','~thor_data400::key::seed::'+filedate+'::sdbosd4i',n1);

roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::cd1ocd2i','Q',a2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::ct1ophni','Q',b2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::ef1oef1i','Q',c2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::idpoidpi','Q',d2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::np2opr2i','Q',p2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::np2oprii','Q',e2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::nptoprii','Q',f2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::pb1opb1i','Q',g2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::prioprii','Q',h2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::prwoprwi','Q',i2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::sc1osd1i','Q',j2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::sd1osd1i','Q',k2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::sd5osd5i','Q',l2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::sdbosd2i','Q',m2);
roxiekeybuild.Mac_SK_Move('~thor_data400::key::seed::@version@::sdbosd4i','Q',n2);

buildkey := parallel(a,b,c,d,e,f,g,h,i,j,k,l,m,n,p);
movekey := sequential(a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,p1);
movetoqa := sequential(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,p2);

return sequential(buildkey,movekey,movetoqa);

end;