EXPORT Constants := MODULE

    //
    // iteration_seedval - For this project ... in order to support proper linking of
    // the extra large clusters that exist ... without unreasonable processing times ...
    // it is desirable to select a "repeatably random" group of records to consider
    // for matching. This value is used to vary which records are considered for
    // matching. Though a random value is defaulted here, the best practice would
    // be to "store" a workunit value for "iteration_seedval" in the top level code.
    //
    // For Example:
    //
    //     //
    //     // Best practice ... for the 24th iteration ... use something like
    //     // the following in the top level code that kicks off the iteration ...
    //     //
    //     #STORED('iteration_seedval', HASHCRC('24'));
    //
    // The actual value stored should be constant for each iteration in order to ensure
    // repeatable results, but vary between subsequent iterations in order to provide a
    // diverse selection of records over time.
    //
    EXPORT unsigned8 iteration_seedval := RANDOM() : STORED('iteration_seedval');
    
END;