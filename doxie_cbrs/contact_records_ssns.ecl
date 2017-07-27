f := doxie_cbrs.contact_records_raw;

filt := TABLE(f(ssn<>''), {ssn});
ddp := DEDUP(filt,ssn,ALL);

export contact_records_ssns := ddp;