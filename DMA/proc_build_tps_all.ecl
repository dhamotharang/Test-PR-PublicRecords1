import	DMA, dx_dma, RoxieKeyBuild,ut, data_services, std;

export	proc_build_tps_all(string	fileDate, boolean build_full = false)	:=
module
	
    shared dx_dma.layouts.building isolate_relevant(dx_dma.layouts.building L, dx_dma.layouts.building R) :=
        TRANSFORM
            SELF.dt_effective_first := if(L.delta_ind = 3 and R.delta_ind != 3,  R.dt_effective_first, L.dt_effective_first);
            SELF.dt_effective_last := if(L.delta_ind = 3 and R.delta_ind = 3, L.dt_effective_last, R.dt_effective_last);
            self.delta_ind := if(build_full and R.delta_ind != 3, 0, R.delta_ind);
            self := R;
        END;
    export	proc_build_base	:=
	function
        
		fileDMAIn := DMA.file_in_suppressionTPS_DMA(PhoneNumber	!=	'');
		dx_dma.layouts.building	filterDMAPhone(fileDMAIn l)	:=
		transform
			self.source				:=	'DMA';
			self.phonenumber	:=	REGEXFIND('[0-9]{10}',l.AreaCode+l.PhoneNumber,0);
            self.record_sid := (unsigned) REGEXFIND('[0-9]{10}',l.AreaCode+l.PhoneNumber,0);
            self.dt_effective_first := (unsigned)filedate;
            self.dt_effective_last := 0;
            self.delta_ind:= 1;
		end;
        DMAPhone	:=	project(fileDMAIn,filterDMAPhone(left));
        fileNationalIn :=	dataset(data_services.foreign_prod +'thor_data400::in::suppression::TPS_National_'+fileDate,
																											DMA.layout_in_suppressionTPS_National,
																											csv(separator(','),terminator('\n'))
																										);
        //DMA.File_In_SuppressionTPS_National(PhoneNumber	!=	'');
        //dataset([],DMA.layout_in_suppressionTPS_National);
        //dataset(data_services.foreign_prod +'thor_data400::in::suppression::tps_national_20210302',DMA.layout_in_suppressionTPS_National,csv(separator(','),terminator('\n')) );
        //dataset('~thor400::debug::in::suppression::tps_national_0223',DMA.layout_in_suppressionTPS_National,thor );

        DMA.layout_in_suppressionTPS_National	filterNationalPhone(fileNationalIn	l)	:=
		transform
			self.phonenumber	:=	REGEXFIND('[0-9]{10}',l.PhoneNumber,0);
            self := l;

		end;
        
        fileNationalIn_filtered	:=	project(distribute(fileNationalIn(PhoneNumber	!=	''),hash32(phonenumber)),filterNationalPhone(left));
        FISTPSN	:= fileNationalIn_filtered(phonenumber != '');
        

        DMA.layout_in_suppressionTPS_National	remove_same_day(dma.layout_in_suppressionTPS_National L, dma.layout_in_suppressionTPS_National R)	:=
        transform
            self := R;
        end;
        sort_FISTPSN := sort(distribute(FISTPSN,hash32(phonenumber)), phonenumber, requestdate);
        new_data:= rollup(sort_FISTPSN,
                        left.phonenumber = right.phonenumber and 
                        left.RequestDate[1..10] = right.RequestDate[1..10],
                        remove_same_day(left,right)
                        );
        
        dx_dma.layouts.building	tReformat2Bldg(sort_FISTPSN //new_data 
                                                    L)	:=
        transform
            self.source := 'NTL';
            self.phonenumber	:=	L.phonenumber;
            self.record_sid := (unsigned)L.phonenumber;
            self.dt_effective_first := (unsigned)filedate; //std.date.fromstringtodate(L.RequestDate[1..10],'%Y-%m-%d');
            self.dt_effective_last := if( L.Indicator = 'A', 0, std.date.fromstringtodate(L.RequestDate[1..10],'%Y-%m-%d'));
            self.delta_ind := if(L.Indicator = 'A', 1, 3);
        end;

        base_data :=  if (build_full, 
                            project(FISTPSN,tReformat2Bldg(left))+DMAPhone(PhoneNumber	!=	'') + DMA.file_suppressionTPS_delta.base,
                            project(FISTPSN,tReformat2Bldg(left))+DMAPhone(PhoneNumber	!=	'')
                            );
        sorted_new_data := sort(base_data(record_sid != 0), phonenumber, dt_effective_first, dt_effective_last);

        delta_base := rollup(sorted_new_data, left.phonenumber = right.phonenumber, isolate_relevant(left,right));
        mvBase  := STD.File.PromoteSuperFileList([
                                                    dx_dma.names.base,
                                                    dx_dma.names.base_father,
                                                    dx_dma.names.base_grandfather,
                                                    dx_dma.names.base+'_delete'
                                                    ], dx_dma.names.base +'_'+filedate, true);
		return	sequential(
                            output(if(build_full, delta_base(delta_ind != 3), delta_base),, dx_dma.names.base +'_'+filedate),
                            if(build_full, mvBase, output('not full build'))
                            );
	end;

	export	proc_build_key	:=
	function        
        full_base := DMA.file_suppressionTPS_delta.base;
        sorted_full_base := sort(distribute(full_base(record_sid != 0),hash32(phonenumber)), phonenumber, dt_effective_first, dt_effective_last, local);
        //iinner join for deletes

        full_base_rollup := rollup(sorted_full_base, left.phonenumber = right.phonenumber, isolate_relevant(left,right));

        delta_base := distribute(dma.File_SuppressionTPS_Delta.base_new(filedate),hash32(phonenumber));
        
        key_adds := join(delta_base(delta_ind = 1), full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber, left only, local);       
        key_deletes := join(delta_base(delta_ind = 3), full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber, inner, local);       

        key_delta := if(build_full, full_base, key_adds + key_deletes);
        
        RoxieKeybuild.MAC_build_logical(dx_dma.key_DNC_Phone,key_delta,dx_dma.names.key_DNC,dx_dma.names.key_dnc_new(filedate),DNCPhoneKeyOut);
        mvKey				:= STD.File.PromoteSuperFileList([
                                                                dx_dma.names.key_DNC,
                                                                dx_dma.names.key_DNC_father,
                                                                dx_dma.names.key_DNC_grandfather,
                                                                dx_dma.names.key_DNC+'_delete'
                                                                ], dx_dma.names.key_dnc_new(filedate));		

		return	sequential(
                            output(key_adds,, '~thor400::tps::key::delta_adds', overwrite),
                            output(key_deletes,, '~thor400::tps::key::delta_deletes', overwrite),
                            DNCPhoneKeyOut,
                            if(build_full, 
                                mvKey,
                                sequential(
                                    fileservices.addsuperfile(dx_dma.names.base, dx_dma.names.base +'_'+filedate), 
                                    fileservices.addsuperfile(dx_dma.names.key_DNC, dx_dma.names.key_dnc_new(filedate))
                                    )
                            )
                            );
	end;
	
end;