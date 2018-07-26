export Business_Header_mac_BDID_Roxie(inf, outf, append = '\'BEST_ALL,MAX_SSN\'', verify = '\'BEST_ALL\'', thresh = '\'1\'', threads = '40') := macro

#uniquename(insize)
#uniquename(outsize)

%insize% := sizeof(Business_Header_SS.Layout_BDID_InBatch);
%outsize% := sizeof(Business_Header.layout_BDID_OutBatch_Expanded);

#uniquename(options)
%options% := if (append != 'foo','<BestAppend>' + append + '</BestAppend>','') + 
		   if (verify != 'foo','<BestVerify>' + verify + '</BestVerify>','') +
		   if (thresh != '','<Threshold>' + thresh + '</Threshold>','');

outf := distribute(PIPE(distribute(inf,RANDOM() % 50), 'roxiepipe -iw '+%insize%+' -t '+threads+' -ow '+%outsize%+' -b 50 -mr 2 -q "<Business_Header.bh_bdid_batch_service format=\'raw\'>' + %options% + '<bdid_batch_in id=\'id\' format=\'raw\'></bdid_batch_in></Business_Header.bh_bdid_batch_service>" -h ' + did_add.roxie_ip + ' -vip -r Result', Business_Header.layout_BDID_OutBatch_Expanded)
				,random());

endmacro;