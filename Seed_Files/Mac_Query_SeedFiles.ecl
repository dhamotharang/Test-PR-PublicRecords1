export Mac_Query_SeedFiles(soc, outrec, inrec, pnum, outf) := macro

#uniquename(key)

#if (outrec = 'ct1o' and inrec = 'phni')
	%key% := seed_files.Key_ct1ophni;
#elseif (outrec = 'idpo' and inrec = 'idpi')
	%key% := seed_files.Key_idpoidpi;
#elseif (outrec = 'np2o' and inrec = 'pr2i')
	%key% := seed_files.Key_np2opr2i;
#elseif (outrec = 'np2o' and inrec = 'prii')
	%key% := seed_files.Key_np2oprii;
#elseif (outrec = 'npto' and inrec = 'prii')
	%key% := seed_files.Key_nptoprii;
#elseif (outrec = 'pb1o' and inrec = 'pb1i')
	%key% := seed_files.key_pb1opb1i;
#elseif (outrec = 'prio' and inrec = 'prii')
	%key% := seed_files.Key_prioprii;
#elseif (outrec = 'prwo' and inrec = 'prwi')
	%key% := seed_files.Key_prwoprwi;
#elseif (outrec = 'sc1o' and inrec = 'sd1i')
	%key% := seed_files.Key_sc1osd1i;
#elseif (outrec = 'sd1o' and inrec = 'sd1i')
	%key% := seed_files.Key_sd1osd1i;
#elseif (outrec = 'sd5o' and inrec = 'sd5i')
	%key% := seed_files.Key_sd5osd5i;
#elseif (outrec = 'sdbo' and inrec = 'sd2i')
	%key% := seed_files.Key_sdbosd2i;
#elseif (outrec = 'sdbo' and inrec = 'sd4i')
	%key% := seed_files.Key_sdbosd4i;
#elseif (outrec = 'cd1o' and inrec = 'cd2i')
	%key% := seed_files.key_cd1ocd2i;
#elseif (outrec = 'ef1o' and inrec = 'ef1i')
	%key% := seed_files.Key_ef1oef1i;
#elseif (outrec = 'it1o' and inrec = 'it1i')
	%key% := seed_files.Key_it1oit1i;
#elseif (outrec = 'fa2o' and inrec = 'nafi')
	%key% := seed_files.Key_fa2onafi;
#elseif (outrec = 'bc1o' and inrec = 'bc1i')
	%key% := seed_files.Key_bc1obc1i;		
#elseif (outrec = 'wf2o' and inrec = 'prii')
	%key% := seed_files.Key_wf2owf2i;		
#else
	%key% := seed_files.Key_Dummy;
#end


#if (outrec = 'ct1o' and inrec = 'phni')
	outf := choosen(%key%(keyed(prodnum = pnum), keyed(homephone = soc)), 10);
#elseif (outrec = 'pb1o' and inrec = 'pb1i')
	outf := choosen(%key%(keyed(prodnum = pnum), keyed(fein = soc)), 10);
#elseif (outrec = 'bc1o' and inrec = 'bc1i')
	outf := choosen(%key%(keyed(prodnum = pnum), keyed(fin = soc)), 10);		
#else
	outf := choosen(%key%(keyed(prodnum = pnum), keyed(social = soc)), 10);
#end

endmacro;