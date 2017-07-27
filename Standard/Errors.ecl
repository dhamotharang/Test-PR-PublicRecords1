// an attempt to define possible error codes in a single place.
// These codes are generally for internal use, i.e. we can change them as long as they're internally integral.

// IMPORTANT: those are not for throwing an errors from queries (see doxie.ErrorCodes)

EXPORT Errors := module

  // so far looks like both header and autokey searches can fit into one set
  export SEARCH := module
		export unsigned NO_ERROR		 	 := 0;
    export unsigned DID_NOT_FOUND  := 1;
    export unsigned DID_TOO_MANY   := 2;
    export unsigned DID_TOO_BROAD  := 4;
    export unsigned DID_MULTIPLE   := 8; // informational: search succeeded, non-unique results (multiple DIDs)
    export unsigned DID_INPUT_DID  := 16; // informational: DID was in the input
    export unsigned DID_RI_INPUT   := 32; // FCRA-restriction imposed on input
    export unsigned DID_RI_OUTPUT  := 64; // informational: some results were omitted due to FCRA RI-restriction

    export unsigned DID_GENERAL    := 1024; // unknown
    export unsigned TIMEOUT        := 2048; // soapcall timeout
  end;  
end;
