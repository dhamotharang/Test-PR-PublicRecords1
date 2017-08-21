
addr_out := output(ixi.files.f_address,, '~thor_data400::out::ixi_address',csv(terminator('\r\n'), separator(',')),overwrite);
assr_out := output(ixi.files.f_assessor,,'~thor_data400::out::ixi_tax',    csv(terminator('\r\n'), separator(',')),overwrite);
deed_out := output(ixi.files.f_deed,,    '~thor_data400::out::ixi_deed',   csv(terminator('\r\n'), separator(',')),overwrite);
peop_out := output(ixi.files.f_people,,  '~thor_data400::out::ixi_people', csv(terminator('\r\n'), separator(',')),overwrite);
raw_out  := output(ixi.files.f_raw,,     '~thor_data400::out::ixi_raw',    csv(terminator('\r\n'), separator(',')),overwrite);

export proc_build_ixi := sequential(
                          return_ixi_data,
						  //write base files
                          parallel(return_ixi_address,return_ixi_deed,return_ixi_people,return_ixi_tax),
						  //write out files
						  parallel(addr_out,assr_out,deed_out,peop_out,raw_out),
						  //
						  ixi.despray
						  );