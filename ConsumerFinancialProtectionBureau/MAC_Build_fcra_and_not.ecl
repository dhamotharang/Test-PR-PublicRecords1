import ConsumerFinancialProtectionBureau;
//Note that this macro does not end in a semicolon
export MAC_Build_fcra_and_not(filedate, pUseProd = false) := macro
    sequential(
        ConsumerFinancialProtectionBureau.build_all(filedate,pUseProd,false),
        ConsumerFinancialProtectionBureau.build_all(filedate,pUseProd,true)
        )
endmacro;