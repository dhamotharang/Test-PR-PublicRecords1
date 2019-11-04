import ConsumerFinancialProtectionBureau, RoxieKeyBuild, doxie_files, PromoteSupers;
export MAC_keybuild(key_type, filedate, pUseProd = false, isfcra = false, all_seq)  := macro
    #uniquename(base_rec);
    %base_rec% := ConsumerFinancialProtectionBureau.#expand('Build_'+ key_type +'(pUseProd, isfcra);');

    #uniquename(key_idx);
    %key_idx% := ConsumerFinancialProtectionBureau.create_index(key_type, %base_rec%, filedate, pUseProd, isfcra);
    
    #uniquename(seq_build);
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(%key_idx%, ConsumerFinancialProtectionBureau.Filenames(,pUseProd,isfcra).#expand('key'+key_type), ConsumerFinancialProtectionBureau.Filenames(filedate,pUseProd,isfcra).#expand('key'+key_type), %seq_build%);
    
    #uniquename(seq_move_built);
    Roxiekeybuild.Mac_SK_Move_to_Built_v2(ConsumerFinancialProtectionBureau.Filenames(,pUseProd,isfcra).#expand('key'+key_type), ConsumerFinancialProtectionBureau.Filenames(filedate,pUseProd,isfcra).#expand('key'+key_type), %seq_move_built%);
    
    #uniquename(seq_move);
    promotesupers.Mac_SK_Move_v2(ConsumerFinancialProtectionBureau.Filenames(, pUseProd, isfcra).#expand('key'+key_type), 'Q', %seq_move%, 2);
    all_seq := sequential(
                        output(%base_rec%,, ConsumerFinancialProtectionBureau.Filenames(filedate, pUseProd, isfcra).#expand('Base'+ key_type)),
                        %seq_build%,
                        %seq_move_built%,
                        ConsumerFinancialProtectionBureau.CheckSuperfiles(ConsumerFinancialProtectionBureau.Filenames(,pUseProd,isfcra).#expand('key'+key_type)),
                        %seq_move%
                        );
endmacro;