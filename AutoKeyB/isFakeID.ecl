import autokey;
export isFakeID(unsigned8 ID, STRING10 typ):= ID > autokey.did_adder(typ);