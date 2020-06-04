import ConsumerFinancialProtectionBureau as CFPB; //makes navigating macro easier in vscode
export MAC_build_key(key_type, filedate, pUseProd = false, isfcra = false, all_seq)  := macro
        import ConsumerFinancialProtectionBureau as CFPB; 
        import RoxieKeyBuild, dx_ConsumerFinancialProtectionBureau, std;
        #uniquename(key_data);
        %key_data% := dataset(CFPB.Filenames(pUseProd).#expand('base'+key_type),CFPB.layouts.#expand(key_type),THOR,__compressed__,OPT);     
        #uniquename(seq_build);
        RoxieKeybuild.MAC_build_logical(dx_ConsumerFinancialProtectionBureau.#expand('key_'+key_type+'(isfcra)'), 
                                                %key_data%, 
                                                dx_ConsumerFinancialProtectionBureau.Filenames(pUseProd, isfcra).#expand('key'+key_type),
                                                CFPB.filenames(pUseProd, isfcra).keyPrefix+ '::' + filedate + '::' +key_type,
                                                %seq_build%);
        #uniquename(seq_move);
        RoxieKeyBuild.Mac_SK_Move_v3(CFPB.filenames(pUseProd, isfcra).keyPrefix+'::@version@::'+ key_type, 'D', %seq_move%,filedate, 2);
        all_seq := if(STD.File.FileExists(CFPB.filenames(pUseProd, isfcra).keyPrefix+ '::' + filedate +'::' +key_type),
                        output(CFPB.filenames(pUseProd, isfcra).keyPrefix + '::' + filedate + '::' + key_type +' already exists, ceasing key operations.'),
                        sequential(
                                %seq_build%,
                                %seq_move%
                                )
                        );
endmacro;