program database;
uses crt;
type
  pembeli = record
    namap,idp,alm,notelp : string;
end;
var
  arsipp : file of pembeli;
  p : pembeli;
begin
  clrscr;
  assign(arsipp,'user.txt');
  rewrite(arsipp);
  p.idp         := 'cus001';
  p.namap       := 'Ahmad Badrun';
  p.alm         := 'Jln. Sukaesih Barat No.5 Cimahi Utara';
  p.notelp      := '022-6636789';
  write(arsipp,p);
  p.idp         := 'cus002';
  p.namap       := 'Asep Junaidi';
  p.alm         := 'Pesona Bali';
  p.notelp      := '087863657272';
  write(arsipp,p);
  p.idp         := 'cus003';
  p.namap       := 'Zulfikar Baharudin';
  p.alm         := 'Jln. Tulip No.6 Jakarta Barat';
  p.notelp      := '081223896172';
  write(arsipp,p);
  p.idp         := 'cus004';
  p.namap       := 'Kokom Markomah';
  p.alm         := 'Jl. Ciganitri';
  p.notelp      := '081939872516';
  write(arsipp,p);
  p.idp         := 'cus005';
  p.namap       := 'Jaka Sutaedi';
  p.alm         := 'Jl.Flamboyan No 13. Bandung';
  p.notelp      := '081237941286';
  write(arsipp,p);
  p.idp         := 'cus006';
  p.namap       := 'Akhmad Yunus Afif';
  p.alm         := 'BTN Kecicang Indah';
  p.notelp      := '08179760288';
  write(arsipp,p);
  p.idp         := 'cus007';
  p.namap       := 'Stephanus noviano';
  p.alm         := 'Jln. Jendral Sudirman No. 207 Bandung';
  p.notelp      := '0899182712';
  write(arsipp,p);
  p.idp         := 'cus008';
  p.namap       := 'Raja Ryan R.';
  p.alm         := 'Permata Buah Batu';
  p.notelp      := '08987465762';
  write(arsipp,p);
  p.idp         := 'cus009';
  p.namap       := 'Michel elvadiano';
  p.alm         := 'Jln. Haji Haris No. 104 Cimahi';
  p.notelp      := '082120162175';
  write(arsipp,p);
  p.idp         := 'cus010';
  p.namap       := 'Meytall Couhign';
  p.alm         := 'Jl. Antapani';
  p.notelp      := '08565827812';
  write(arsipp,p);
  close(arsipp);
end.
