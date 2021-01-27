EXPORT enhanceTNT(boolean do_address_hierarchy, string1 original_tnt, string2 addr_ind, string2 best_addr_rank) := function

tnt := map( ~do_address_hierarchy => original_tnt,
            (unsigned)addr_ind = 1 and (unsigned)best_addr_rank = 1 => 'B', 
            (unsigned)addr_ind = 1 and (unsigned)best_addr_rank > 1 => 'C',
            original_tnt
           );

RETURN(tnt);
END;