import ConsumerFinancialProtectionBureau as CFPB;//makes navigating macro easier in vscode
export MAC_build_base(key_type, filedate, pUseProd = false, all_seq)  := macro
        import ConsumerFinancialProtectionBureau as CFPB; 
        import PromoteSupers;
        #uniquename(base_rec);
        %base_rec% := CFPB.MAC_build_base_data(key_type, pUseProd);
        #uniquename(seq_base);
        PromoteSupers.Mac_SF_BuildProcess(%base_rec%, 
                CFPB.Filenames(pUseProd).#expand('base'+key_type), %seq_base%,2,,true,filedate);
        all_seq := if(STD.File.FileExists(CFPB.Filenames(pUseProd).#expand('base'+key_type) +'_'+filedate),
                        output(CFPB.Filenames(pUseProd).#expand('base'+key_type) +'_'+filedate +' already exists, ceasing base file operations.'),        
                        sequential(
                                CFPB.CheckSuperfiles(CFPB.Filenames(pUseProd).#expand('base'+ key_type)),
                                %seq_base%
                                )
                        );
endmacro;