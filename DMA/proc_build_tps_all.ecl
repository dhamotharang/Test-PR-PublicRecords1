import	DMA, dx_dma, RoxieKeyBuild,ut, data_services, std;

EXPORT	proc_build_tps_all(string	fileDate, boolean build_full = false, dataset(DMA.layout_in_suppressionTPS_National) in_name, boolean old_files = false)	:=
module
	
    //eliminates duplicates while maintaining relevant data
    shared dx_dma.layouts.building isolate_relevant(dx_dma.layouts.building L, dx_dma.layouts.building R) :=
        TRANSFORM
            SELF.dt_effective_first := if(L.delta_ind = 3 and R.delta_ind != 3,  R.dt_effective_first, L.dt_effective_first);
            SELF.dt_effective_last := if(L.delta_ind = 3 and R.delta_ind = 3, L.dt_effective_last, R.dt_effective_last);
            SELF.delta_ind := if(build_full and R.delta_ind != 3, 0, R.delta_ind);
            SELF := R;
        END;
    EXPORT	proc_build_base	:=
	FUNCTION
        
		fileDMAIn := DMA.file_in_suppressionTPS_DMA(PhoneNumber	!=	'');
		dx_dma.layouts.building	filterDMAPhone(fileDMAIn l)	:=
		TRANSFORM
			SELF.source				:=	'DMA';
			SELF.phonenumber	:=	REGEXFIND('[0-9]{10}',l.AreaCode+l.PhoneNumber,0);
            SELF.dt_effective_first := (unsigned)filedate;
            SELF.dt_effective_last := 0;
            SELF.delta_ind:= 1;
		END;
        DMAPhone	:=	project(fileDMAIn,filterDMAPhone(left));
        fileNationalIn :=	in_name;
        /*dataset(data_services.foreign_prod +'thor_data400::in::suppression::TPS_National_'+fileDate,
																											DMA.layout_in_suppressionTPS_National,
																											csv(separator(','),terminator('\n'))
																										); */

        DMA.layout_in_suppressionTPS_National	filterNationalPhone(fileNationalIn	l)	:=
		TRANSFORM
			SELF.phonenumber	:=	REGEXFIND('[0-9]{10}',l.PhoneNumber,0);
            SELF := l;

		END;
        
        fileNationalIn_filtered	:=	project(distribute(fileNationalIn(PhoneNumber	!=	''),hash32(phonenumber)),filterNationalPhone(left));
        FISTPSN	:= fileNationalIn_filtered(phonenumber != '');
        
        //used for edge cases in which there are multiple records for the same number in one day
        DMA.layout_in_suppressionTPS_National	remove_same_day(dma.layout_in_suppressionTPS_National L, dma.layout_in_suppressionTPS_National R)	:=
        TRANSFORM
            SELF := R;
        END;
        sort_FISTPSN := sort(distribute(FISTPSN,hash32(phonenumber)), phonenumber, requestdate,local);
        new_data:= rollup(sort_FISTPSN,
                        left.phonenumber = right.phonenumber and 
                        left.RequestDate[1..10] = right.RequestDate[1..10],
                        remove_same_day(left,right)
                        );
        
        dx_dma.layouts.building	tReformat2Bldg(new_data L)	:=
        TRANSFORM
            SELF.source := 'NTL';
            SELF.phonenumber	:=	L.phonenumber;
            SELF.dt_effective_first := if(old_files, std.date.fromstringtodate(L.RequestDate[1..10],'%Y-%m-%d'),(unsigned)filedate);
            SELF.dt_effective_last :=   if( L.Indicator = 'A', 
                                            0, 
                                            if(old_files, 
                                                std.date.fromstringtodate(L.RequestDate[1..10],'%Y-%m-%d'),
                                                (unsigned)filedate)
                                        );
            SELF.delta_ind := if(L.Indicator = 'A', 1, 3);
        END;

        base_data :=  if (build_full, 
                            project(FISTPSN,tReformat2Bldg(left))+DMAPhone(PhoneNumber	!=	'') + DMA.file_suppressionTPS_delta.base,
                            project(FISTPSN,tReformat2Bldg(left))+DMAPhone(PhoneNumber	!=	'')
                            );
        base_data_dist := distribute(base_data,hash32(phonenumber));
        sorted_new_data := sort(base_data_dist((unsigned)phonenumber != 0), phonenumber, dt_effective_first, dt_effective_last, local);

        delta_base := rollup(sorted_new_data, left.phonenumber = right.phonenumber, isolate_relevant(left,right));
        //since rollups do not affect non-duplicate records the following transform must be applied during a full build
        dx_dma.layouts.building	delta_ind_to_0(sorted_new_data L) := transform
            SELF.delta_ind := 0;
            self := L;
        end;

        mvBase  := STD.File.PromoteSuperFileList([
                                                    dx_dma.names.base,
                                                    dx_dma.names.base_father,
                                                    dx_dma.names.base_grandfather,
                                                    dx_dma.names.base+'_delete'
                                                    ], dx_dma.names.base +'_'+filedate, true);
		RETURN	sequential(
                            output(if(build_full, project(delta_base(delta_ind != 3),delta_ind_to_0(left)), delta_base),, dx_dma.names.base +'_'+filedate),
                            if(build_full, mvBase, output('not full build'))
                            );
	END;

	EXPORT	proc_build_key	:=
	FUNCTION        
        full_base := DMA.file_suppressionTPS_delta.base;
        sorted_full_base := sort(distribute(full_base((unsigned)phonenumber != 0),hash32(phonenumber)), phonenumber, dt_effective_first, dt_effective_last, local);

        full_base_rollup := rollup(sorted_full_base, left.phonenumber = right.phonenumber, isolate_relevant(left,right), local);


        //Key_adds and Key_deletes are used to build the key in a delta build but only used for stats during a full build
        //during a delta build they ensure that records cannot be added nor deleted multiple times in a row
        delta_base := distribute(dma.File_SuppressionTPS_Delta.base_new(filedate),hash32(phonenumber));
        base_father := distribute(dma.File_SuppressionTPS_Delta.father(delta_ind = 1),hash32(phonenumber));
        key_adds := if(build_full = false, 
                        join(delta_base(delta_ind = 1), full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber, left only, local),
                        join( base_father, full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber, left only, local)
                        );       
        key_deletes := if(build_full = false, 
                        join(delta_base(delta_ind = 3), full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber,isolate_relevant(right,left), inner, local),       
                        join(base_father(delta_ind = 3), full_base_rollup(delta_ind != 3), left.phonenumber = right.phonenumber,isolate_relevant(right,left), inner, local)
                        ); 
        key_delta := if(build_full, full_base_rollup, key_adds + key_deletes);
        
        RoxieKeybuild.MAC_build_logical(dx_dma.key_DNC_Phone,key_delta,dx_dma.names.key_DNC,dx_dma.names.key_dnc_new(filedate),DNCPhoneKeyOut);
        mvKey				:= STD.File.PromoteSuperFileList([
                                                                dx_dma.names.key_DNC,
                                                                dx_dma.names.key_DNC_father,
                                                                dx_dma.names.key_DNC_grandfather,
                                                                dx_dma.names.key_DNC+'_delete'
                                                                ], dx_dma.names.key_dnc_new(filedate));		

		RETURN	sequential(
                            output(key_adds,, '~thor_data400::tps::key::delta_adds', overwrite),
                            output(key_deletes,, '~thor_data400::tps::key::delta_deletes', overwrite),
                            DNCPhoneKeyOut,
                            if(build_full, 
                                mvKey,
                                sequential(
                                    fileservices.addsuperfile(dx_dma.names.base, dx_dma.names.base +'_'+filedate), 
                                    fileservices.addsuperfile(dx_dma.names.key_DNC, dx_dma.names.key_dnc_new(filedate))
                                    )
                            )
                            );
	END;
	
END;